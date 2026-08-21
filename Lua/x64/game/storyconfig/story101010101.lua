return {
	Play101011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101011001
		arg_1_1.duration_ = 22.77

		local var_1_0 = {
			ja = 19.1,
			ko = 16.9,
			zh = 13.266,
			en = 22.766
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
				arg_1_0:Play101011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

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

			local var_4_6 = "D02a"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = arg_1_1.bgs_.D02a
			local var_4_9 = 0

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				local var_4_10 = var_4_8:GetComponent("SpriteRenderer")

				if var_4_10 then
					arg_1_1.var_.alphaOldValueD02a = var_4_10.color.a
					arg_1_1.var_.alphaMatValueD02a = var_4_10
				end

				arg_1_1.var_.alphaOldValueD02a = 0
			end

			local var_4_11 = 1.5

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_11 then
				local var_4_12 = (arg_1_1.time_ - var_4_9) / var_4_11
				local var_4_13 = Mathf.Lerp(arg_1_1.var_.alphaOldValueD02a, 1, var_4_12)

				if arg_1_1.var_.alphaMatValueD02a then
					local var_4_14 = arg_1_1.var_.alphaMatValueD02a.color

					var_4_14.a = var_4_13
					arg_1_1.var_.alphaMatValueD02a.color = var_4_14
				end
			end

			if arg_1_1.time_ >= var_4_9 + var_4_11 and arg_1_1.time_ < var_4_9 + var_4_11 + arg_4_0 and arg_1_1.var_.alphaMatValueD02a then
				local var_4_15 = arg_1_1.var_.alphaMatValueD02a
				local var_4_16 = var_4_15.color

				var_4_16.a = 1
				var_4_15.color = var_4_16
			end

			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = manager.ui.mainCamera.transform.localPosition
				local var_4_19 = Vector3.New(0, 0, 10) + Vector3.New(var_4_18.x, var_4_18.y, 0)
				local var_4_20 = arg_1_1.bgs_.D02a

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
					if iter_4_0 ~= "D02a" then
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
			local var_4_34 = 1.475

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

				local var_4_36 = arg_1_1:FormatText(StoryNameCfg[14].name)

				arg_1_1.leftNameTxt_.text = var_4_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_37 = arg_1_1:GetWordFromCfg(101011001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 58
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

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011001", "story_v_out_101011.awb") ~= 0 then
					local var_4_42 = manager.audio:GetVoiceLength("story_v_out_101011", "101011001", "story_v_out_101011.awb") / 1000

					if var_4_42 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_33
					end

					if var_4_37.prefab_name ~= "" and arg_1_1.actors_[var_4_37.prefab_name] ~= nil then
						local var_4_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_37.prefab_name].transform, "story_v_out_101011", "101011001", "story_v_out_101011.awb")

						arg_1_1:RecordAudio("101011001", var_4_43)
						arg_1_1:RecordAudio("101011001", var_4_43)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_101011", "101011001", "story_v_out_101011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_101011", "101011001", "story_v_out_101011.awb")
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
	Play101011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101011002
		arg_8_1.duration_ = 4.6

		local var_8_0 = {
			ja = 2.866,
			ko = 3.1,
			zh = 4.6,
			en = 3.366
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
				arg_8_0:Play101011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1037ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1037ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1037ui_story == nil then
				arg_8_1.var_.characterEffect1037ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1037ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1037ui_story then
				arg_8_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["1037ui_story"].transform
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.var_.moveOldPos1037ui_story = var_11_9.localPosition
			end

			local var_11_11 = 0.001

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11
				local var_11_13 = Vector3.New(0, -1.09, -5.81)

				var_11_9.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1037ui_story, var_11_13, var_11_12)

				local var_11_14 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_14.x, var_11_14.y, var_11_14.z)

				local var_11_15 = var_11_9.localEulerAngles

				var_11_15.z = 0
				var_11_15.x = 0
				var_11_9.localEulerAngles = var_11_15
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 then
				var_11_9.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_11_16 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_16.x, var_11_16.y, var_11_16.z)

				local var_11_17 = var_11_9.localEulerAngles

				var_11_17.z = 0
				var_11_17.x = 0
				var_11_9.localEulerAngles = var_11_17
			end

			local var_11_18 = 0

			if var_11_18 < arg_8_1.time_ and arg_8_1.time_ <= var_11_18 + arg_11_0 then
				arg_8_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action8_2")
			end

			local var_11_19 = 0

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_11_20 = 0
			local var_11_21 = 0.175

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_22 = arg_8_1:FormatText(StoryNameCfg[15].name)

				arg_8_1.leftNameTxt_.text = var_11_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_23 = arg_8_1:GetWordFromCfg(101011002)
				local var_11_24 = arg_8_1:FormatText(var_11_23.content)

				arg_8_1.text_.text = var_11_24

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_25 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011002", "story_v_out_101011.awb") ~= 0 then
					local var_11_28 = manager.audio:GetVoiceLength("story_v_out_101011", "101011002", "story_v_out_101011.awb") / 1000

					if var_11_28 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_20
					end

					if var_11_23.prefab_name ~= "" and arg_8_1.actors_[var_11_23.prefab_name] ~= nil then
						local var_11_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_23.prefab_name].transform, "story_v_out_101011", "101011002", "story_v_out_101011.awb")

						arg_8_1:RecordAudio("101011002", var_11_29)
						arg_8_1:RecordAudio("101011002", var_11_29)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101011", "101011002", "story_v_out_101011.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101011", "101011002", "story_v_out_101011.awb")
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
				actorName = "1037ui_story",
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
	Play101011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101011003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play101011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1037ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1037ui_story == nil then
				arg_12_1.var_.characterEffect1037ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1037ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1037ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1037ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1037ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 0.475

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_8 = arg_12_1:GetWordFromCfg(101011003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_10 = 19
				local var_15_11 = utf8.len(var_15_9)
				local var_15_12 = var_15_10 <= 0 and var_15_7 or var_15_7 * (var_15_11 / var_15_10)

				if var_15_12 > 0 and var_15_7 < var_15_12 then
					arg_12_1.talkMaxDuration = var_15_12

					if var_15_12 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_9
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_13 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_13 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_13

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_13 and arg_12_1.time_ < var_15_6 + var_15_13 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play101011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101011004
		arg_16_1.duration_ = 5.4

		local var_16_0 = {
			ja = 3.566,
			ko = 2.466,
			zh = 3.733,
			en = 5.4
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
				arg_16_0:Play101011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1037ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1037ui_story == nil then
				arg_16_1.var_.characterEffect1037ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1037ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1037ui_story then
				arg_16_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_19_4 = arg_16_1.actors_["1037ui_story"].transform
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1.var_.moveOldPos1037ui_story = var_19_4.localPosition
			end

			local var_19_6 = 0.001

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 then
				local var_19_7 = (arg_16_1.time_ - var_19_5) / var_19_6
				local var_19_8 = Vector3.New(0, -1.09, -5.81)

				var_19_4.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1037ui_story, var_19_8, var_19_7)

				local var_19_9 = manager.ui.mainCamera.transform.position - var_19_4.position

				var_19_4.forward = Vector3.New(var_19_9.x, var_19_9.y, var_19_9.z)

				local var_19_10 = var_19_4.localEulerAngles

				var_19_10.z = 0
				var_19_10.x = 0
				var_19_4.localEulerAngles = var_19_10
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 then
				var_19_4.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_4.position

				var_19_4.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_4.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_4.localEulerAngles = var_19_12
			end

			local var_19_13 = 0

			if var_19_13 < arg_16_1.time_ and arg_16_1.time_ <= var_19_13 + arg_19_0 then
				arg_16_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_19_14 = 0
			local var_19_15 = 0.175

			if var_19_14 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_16 = arg_16_1:FormatText(StoryNameCfg[15].name)

				arg_16_1.leftNameTxt_.text = var_19_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_17 = arg_16_1:GetWordFromCfg(101011004)
				local var_19_18 = arg_16_1:FormatText(var_19_17.content)

				arg_16_1.text_.text = var_19_18

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_19 = 7
				local var_19_20 = utf8.len(var_19_18)
				local var_19_21 = var_19_19 <= 0 and var_19_15 or var_19_15 * (var_19_20 / var_19_19)

				if var_19_21 > 0 and var_19_15 < var_19_21 then
					arg_16_1.talkMaxDuration = var_19_21

					if var_19_21 + var_19_14 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_21 + var_19_14
					end
				end

				arg_16_1.text_.text = var_19_18
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011004", "story_v_out_101011.awb") ~= 0 then
					local var_19_22 = manager.audio:GetVoiceLength("story_v_out_101011", "101011004", "story_v_out_101011.awb") / 1000

					if var_19_22 + var_19_14 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_22 + var_19_14
					end

					if var_19_17.prefab_name ~= "" and arg_16_1.actors_[var_19_17.prefab_name] ~= nil then
						local var_19_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_17.prefab_name].transform, "story_v_out_101011", "101011004", "story_v_out_101011.awb")

						arg_16_1:RecordAudio("101011004", var_19_23)
						arg_16_1:RecordAudio("101011004", var_19_23)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_101011", "101011004", "story_v_out_101011.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_101011", "101011004", "story_v_out_101011.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_24 = math.max(var_19_15, arg_16_1.talkMaxDuration)

			if var_19_14 <= arg_16_1.time_ and arg_16_1.time_ < var_19_14 + var_19_24 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_14) / var_19_24

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_14 + var_19_24 and arg_16_1.time_ < var_19_14 + var_19_24 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play101011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 101011005
		arg_20_1.duration_ = 8.33

		local var_20_0 = {
			ja = 6.5,
			ko = 7.6,
			zh = 7.9,
			en = 8.333
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
				arg_20_0:Play101011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_23_1 = 0
			local var_23_2 = 0.675

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_3 = arg_20_1:FormatText(StoryNameCfg[15].name)

				arg_20_1.leftNameTxt_.text = var_23_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_4 = arg_20_1:GetWordFromCfg(101011005)
				local var_23_5 = arg_20_1:FormatText(var_23_4.content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_6 = 26
				local var_23_7 = utf8.len(var_23_5)
				local var_23_8 = var_23_6 <= 0 and var_23_2 or var_23_2 * (var_23_7 / var_23_6)

				if var_23_8 > 0 and var_23_2 < var_23_8 then
					arg_20_1.talkMaxDuration = var_23_8

					if var_23_8 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011005", "story_v_out_101011.awb") ~= 0 then
					local var_23_9 = manager.audio:GetVoiceLength("story_v_out_101011", "101011005", "story_v_out_101011.awb") / 1000

					if var_23_9 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_1
					end

					if var_23_4.prefab_name ~= "" and arg_20_1.actors_[var_23_4.prefab_name] ~= nil then
						local var_23_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_4.prefab_name].transform, "story_v_out_101011", "101011005", "story_v_out_101011.awb")

						arg_20_1:RecordAudio("101011005", var_23_10)
						arg_20_1:RecordAudio("101011005", var_23_10)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_101011", "101011005", "story_v_out_101011.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_101011", "101011005", "story_v_out_101011.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_11 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_11 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_11

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_11 and arg_20_1.time_ < var_23_1 + var_23_11 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play101011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 101011006
		arg_24_1.duration_ = 4.53

		local var_24_0 = {
			ja = 4.533,
			ko = 3.4,
			zh = 3.566,
			en = 3.8
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
				arg_24_0:Play101011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1037ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1037ui_story == nil then
				arg_24_1.var_.characterEffect1037ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1037ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1037ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1037ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1037ui_story.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 0.375

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_8 = arg_24_1:FormatText(StoryNameCfg[14].name)

				arg_24_1.leftNameTxt_.text = var_27_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_9 = arg_24_1:GetWordFromCfg(101011006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 15
				local var_27_12 = utf8.len(var_27_10)
				local var_27_13 = var_27_11 <= 0 and var_27_7 or var_27_7 * (var_27_12 / var_27_11)

				if var_27_13 > 0 and var_27_7 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_10
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011006", "story_v_out_101011.awb") ~= 0 then
					local var_27_14 = manager.audio:GetVoiceLength("story_v_out_101011", "101011006", "story_v_out_101011.awb") / 1000

					if var_27_14 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_6
					end

					if var_27_9.prefab_name ~= "" and arg_24_1.actors_[var_27_9.prefab_name] ~= nil then
						local var_27_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_9.prefab_name].transform, "story_v_out_101011", "101011006", "story_v_out_101011.awb")

						arg_24_1:RecordAudio("101011006", var_27_15)
						arg_24_1:RecordAudio("101011006", var_27_15)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_101011", "101011006", "story_v_out_101011.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_101011", "101011006", "story_v_out_101011.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_16 and arg_24_1.time_ < var_27_6 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play101011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 101011007
		arg_28_1.duration_ = 4.47

		local var_28_0 = {
			ja = 3.233,
			ko = 2.933,
			zh = 4.466,
			en = 3.933
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
				arg_28_0:Play101011008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1037ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1037ui_story == nil then
				arg_28_1.var_.characterEffect1037ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1037ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1037ui_story then
				arg_28_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_31_4 = 0

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_31_5 = 0
			local var_31_6 = 0.15

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_7 = arg_28_1:FormatText(StoryNameCfg[15].name)

				arg_28_1.leftNameTxt_.text = var_31_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_8 = arg_28_1:GetWordFromCfg(101011007)
				local var_31_9 = arg_28_1:FormatText(var_31_8.content)

				arg_28_1.text_.text = var_31_9

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_10 = 6
				local var_31_11 = utf8.len(var_31_9)
				local var_31_12 = var_31_10 <= 0 and var_31_6 or var_31_6 * (var_31_11 / var_31_10)

				if var_31_12 > 0 and var_31_6 < var_31_12 then
					arg_28_1.talkMaxDuration = var_31_12

					if var_31_12 + var_31_5 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_5
					end
				end

				arg_28_1.text_.text = var_31_9
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011007", "story_v_out_101011.awb") ~= 0 then
					local var_31_13 = manager.audio:GetVoiceLength("story_v_out_101011", "101011007", "story_v_out_101011.awb") / 1000

					if var_31_13 + var_31_5 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_5
					end

					if var_31_8.prefab_name ~= "" and arg_28_1.actors_[var_31_8.prefab_name] ~= nil then
						local var_31_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_8.prefab_name].transform, "story_v_out_101011", "101011007", "story_v_out_101011.awb")

						arg_28_1:RecordAudio("101011007", var_31_14)
						arg_28_1:RecordAudio("101011007", var_31_14)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_101011", "101011007", "story_v_out_101011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_101011", "101011007", "story_v_out_101011.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_15 = math.max(var_31_6, arg_28_1.talkMaxDuration)

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_15 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_5) / var_31_15

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_5 + var_31_15 and arg_28_1.time_ < var_31_5 + var_31_15 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play101011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 101011008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play101011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1037ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos1037ui_story = var_35_0.localPosition
			end

			local var_35_2 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2
				local var_35_4 = Vector3.New(0, 100, 0)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1037ui_story, var_35_4, var_35_3)

				local var_35_5 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_5.x, var_35_5.y, var_35_5.z)

				local var_35_6 = var_35_0.localEulerAngles

				var_35_6.z = 0
				var_35_6.x = 0
				var_35_0.localEulerAngles = var_35_6
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, 100, 0)

				local var_35_7 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_7.x, var_35_7.y, var_35_7.z)

				local var_35_8 = var_35_0.localEulerAngles

				var_35_8.z = 0
				var_35_8.x = 0
				var_35_0.localEulerAngles = var_35_8
			end

			local var_35_9 = 0
			local var_35_10 = 0.7

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_11 = arg_32_1:GetWordFromCfg(101011008)
				local var_35_12 = arg_32_1:FormatText(var_35_11.content)

				arg_32_1.text_.text = var_35_12

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 28
				local var_35_14 = utf8.len(var_35_12)
				local var_35_15 = var_35_13 <= 0 and var_35_10 or var_35_10 * (var_35_14 / var_35_13)

				if var_35_15 > 0 and var_35_10 < var_35_15 then
					arg_32_1.talkMaxDuration = var_35_15

					if var_35_15 + var_35_9 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_15 + var_35_9
					end
				end

				arg_32_1.text_.text = var_35_12
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_10, arg_32_1.talkMaxDuration)

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_9) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_9 + var_35_16 and arg_32_1.time_ < var_35_9 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play101011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 101011009
		arg_36_1.duration_ = 11.1

		local var_36_0 = {
			ja = 11.1,
			ko = 8,
			zh = 9.333,
			en = 9.366
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
				arg_36_0:Play101011010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 1.225

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[14].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(101011009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011009", "story_v_out_101011.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_101011", "101011009", "story_v_out_101011.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_101011", "101011009", "story_v_out_101011.awb")

						arg_36_1:RecordAudio("101011009", var_39_9)
						arg_36_1:RecordAudio("101011009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_101011", "101011009", "story_v_out_101011.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_101011", "101011009", "story_v_out_101011.awb")
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
	Play101011010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 101011010
		arg_40_1.duration_ = 4.23

		local var_40_0 = {
			ja = 4.233,
			ko = 3.666,
			zh = 4.166,
			en = 3.4
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
				arg_40_0:Play101011011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1037ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1037ui_story == nil then
				arg_40_1.var_.characterEffect1037ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1037ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1037ui_story then
				arg_40_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["1037ui_story"].transform
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.var_.moveOldPos1037ui_story = var_43_4.localPosition
			end

			local var_43_6 = 0.001

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6
				local var_43_8 = Vector3.New(0, -1.09, -5.81)

				var_43_4.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1037ui_story, var_43_8, var_43_7)

				local var_43_9 = manager.ui.mainCamera.transform.position - var_43_4.position

				var_43_4.forward = Vector3.New(var_43_9.x, var_43_9.y, var_43_9.z)

				local var_43_10 = var_43_4.localEulerAngles

				var_43_10.z = 0
				var_43_10.x = 0
				var_43_4.localEulerAngles = var_43_10
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 then
				var_43_4.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_43_11 = manager.ui.mainCamera.transform.position - var_43_4.position

				var_43_4.forward = Vector3.New(var_43_11.x, var_43_11.y, var_43_11.z)

				local var_43_12 = var_43_4.localEulerAngles

				var_43_12.z = 0
				var_43_12.x = 0
				var_43_4.localEulerAngles = var_43_12
			end

			local var_43_13 = 0

			if var_43_13 < arg_40_1.time_ and arg_40_1.time_ <= var_43_13 + arg_43_0 then
				arg_40_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_43_14 = 0

			if var_43_14 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 then
				arg_40_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_43_15 = 0
			local var_43_16 = 0.35

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_17 = arg_40_1:FormatText(StoryNameCfg[15].name)

				arg_40_1.leftNameTxt_.text = var_43_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_18 = arg_40_1:GetWordFromCfg(101011010)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 14
				local var_43_21 = utf8.len(var_43_19)
				local var_43_22 = var_43_20 <= 0 and var_43_16 or var_43_16 * (var_43_21 / var_43_20)

				if var_43_22 > 0 and var_43_16 < var_43_22 then
					arg_40_1.talkMaxDuration = var_43_22

					if var_43_22 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_22 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_19
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011010", "story_v_out_101011.awb") ~= 0 then
					local var_43_23 = manager.audio:GetVoiceLength("story_v_out_101011", "101011010", "story_v_out_101011.awb") / 1000

					if var_43_23 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_23 + var_43_15
					end

					if var_43_18.prefab_name ~= "" and arg_40_1.actors_[var_43_18.prefab_name] ~= nil then
						local var_43_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_18.prefab_name].transform, "story_v_out_101011", "101011010", "story_v_out_101011.awb")

						arg_40_1:RecordAudio("101011010", var_43_24)
						arg_40_1:RecordAudio("101011010", var_43_24)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_101011", "101011010", "story_v_out_101011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_101011", "101011010", "story_v_out_101011.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_25 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_25 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_25

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_25 and arg_40_1.time_ < var_43_15 + var_43_25 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play101011011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 101011011
		arg_44_1.duration_ = 7.37

		local var_44_0 = {
			ja = 7.366,
			ko = 7.233,
			zh = 4.9,
			en = 6.366
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
				arg_44_0:Play101011012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1037ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1037ui_story == nil then
				arg_44_1.var_.characterEffect1037ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1037ui_story and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1037ui_story.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1037ui_story then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1037ui_story.fillRatio = var_47_5
			end

			local var_47_6 = 0
			local var_47_7 = 0.6

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_8 = arg_44_1:FormatText(StoryNameCfg[14].name)

				arg_44_1.leftNameTxt_.text = var_47_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_9 = arg_44_1:GetWordFromCfg(101011011)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 24
				local var_47_12 = utf8.len(var_47_10)
				local var_47_13 = var_47_11 <= 0 and var_47_7 or var_47_7 * (var_47_12 / var_47_11)

				if var_47_13 > 0 and var_47_7 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011011", "story_v_out_101011.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_101011", "101011011", "story_v_out_101011.awb") / 1000

					if var_47_14 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_6
					end

					if var_47_9.prefab_name ~= "" and arg_44_1.actors_[var_47_9.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_9.prefab_name].transform, "story_v_out_101011", "101011011", "story_v_out_101011.awb")

						arg_44_1:RecordAudio("101011011", var_47_15)
						arg_44_1:RecordAudio("101011011", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_101011", "101011011", "story_v_out_101011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_101011", "101011011", "story_v_out_101011.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_16 and arg_44_1.time_ < var_47_6 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play101011012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 101011012
		arg_48_1.duration_ = 7.7

		local var_48_0 = {
			ja = 7.7,
			ko = 6,
			zh = 4.7,
			en = 7.166
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
				arg_48_0:Play101011013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1037ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1037ui_story == nil then
				arg_48_1.var_.characterEffect1037ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1037ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1037ui_story then
				arg_48_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_51_4 = 0

			if var_51_4 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_51_5 = 0
			local var_51_6 = 0.55

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_7 = arg_48_1:FormatText(StoryNameCfg[15].name)

				arg_48_1.leftNameTxt_.text = var_51_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_8 = arg_48_1:GetWordFromCfg(101011012)
				local var_51_9 = arg_48_1:FormatText(var_51_8.content)

				arg_48_1.text_.text = var_51_9

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_10 = 22
				local var_51_11 = utf8.len(var_51_9)
				local var_51_12 = var_51_10 <= 0 and var_51_6 or var_51_6 * (var_51_11 / var_51_10)

				if var_51_12 > 0 and var_51_6 < var_51_12 then
					arg_48_1.talkMaxDuration = var_51_12

					if var_51_12 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_5
					end
				end

				arg_48_1.text_.text = var_51_9
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011012", "story_v_out_101011.awb") ~= 0 then
					local var_51_13 = manager.audio:GetVoiceLength("story_v_out_101011", "101011012", "story_v_out_101011.awb") / 1000

					if var_51_13 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_5
					end

					if var_51_8.prefab_name ~= "" and arg_48_1.actors_[var_51_8.prefab_name] ~= nil then
						local var_51_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_8.prefab_name].transform, "story_v_out_101011", "101011012", "story_v_out_101011.awb")

						arg_48_1:RecordAudio("101011012", var_51_14)
						arg_48_1:RecordAudio("101011012", var_51_14)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_101011", "101011012", "story_v_out_101011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_101011", "101011012", "story_v_out_101011.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_15 = math.max(var_51_6, arg_48_1.talkMaxDuration)

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_15 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_5) / var_51_15

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_5 + var_51_15 and arg_48_1.time_ < var_51_5 + var_51_15 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play101011013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 101011013
		arg_52_1.duration_ = 2.7

		local var_52_0 = {
			ja = 1.7,
			ko = 2.533,
			zh = 1.9,
			en = 2.7
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
				arg_52_0:Play101011014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1037ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1037ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, 100, 0)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1037ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, 100, 0)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = arg_52_1.actors_["1037ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1037ui_story == nil then
				arg_52_1.var_.characterEffect1037ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.1

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect1037ui_story and not isNil(var_55_9) then
					local var_55_13 = Mathf.Lerp(0, 0.5, var_55_12)

					arg_52_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1037ui_story.fillRatio = var_55_13
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1037ui_story then
				local var_55_14 = 0.5

				arg_52_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1037ui_story.fillRatio = var_55_14
			end

			local var_55_15 = 0
			local var_55_16 = 0.2

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_17 = arg_52_1:FormatText(StoryNameCfg[14].name)

				arg_52_1.leftNameTxt_.text = var_55_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_18 = arg_52_1:GetWordFromCfg(101011013)
				local var_55_19 = arg_52_1:FormatText(var_55_18.content)

				arg_52_1.text_.text = var_55_19

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_20 = 8
				local var_55_21 = utf8.len(var_55_19)
				local var_55_22 = var_55_20 <= 0 and var_55_16 or var_55_16 * (var_55_21 / var_55_20)

				if var_55_22 > 0 and var_55_16 < var_55_22 then
					arg_52_1.talkMaxDuration = var_55_22

					if var_55_22 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_22 + var_55_15
					end
				end

				arg_52_1.text_.text = var_55_19
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011013", "story_v_out_101011.awb") ~= 0 then
					local var_55_23 = manager.audio:GetVoiceLength("story_v_out_101011", "101011013", "story_v_out_101011.awb") / 1000

					if var_55_23 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_15
					end

					if var_55_18.prefab_name ~= "" and arg_52_1.actors_[var_55_18.prefab_name] ~= nil then
						local var_55_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_18.prefab_name].transform, "story_v_out_101011", "101011013", "story_v_out_101011.awb")

						arg_52_1:RecordAudio("101011013", var_55_24)
						arg_52_1:RecordAudio("101011013", var_55_24)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_101011", "101011013", "story_v_out_101011.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_101011", "101011013", "story_v_out_101011.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_25 = math.max(var_55_16, arg_52_1.talkMaxDuration)

			if var_55_15 <= arg_52_1.time_ and arg_52_1.time_ < var_55_15 + var_55_25 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_15) / var_55_25

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_15 + var_55_25 and arg_52_1.time_ < var_55_15 + var_55_25 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play101011014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 101011014
		arg_56_1.duration_ = 3.9

		local var_56_0 = {
			ja = 3.666,
			ko = 3.4,
			zh = 3.4,
			en = 3.9
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
				arg_56_0:Play101011015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 1

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				local var_59_2 = "play"
				local var_59_3 = "effect"

				arg_56_1:AudioAction(var_59_2, var_59_3, "se_story_1", "se_story_1_count", "")
			end

			local var_59_4 = 0
			local var_59_5 = 0.175

			if var_59_4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_6 = arg_56_1:FormatText(StoryNameCfg[14].name)

				arg_56_1.leftNameTxt_.text = var_59_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_7 = arg_56_1:GetWordFromCfg(101011014)
				local var_59_8 = arg_56_1:FormatText(var_59_7.content)

				arg_56_1.text_.text = var_59_8

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 7
				local var_59_10 = utf8.len(var_59_8)
				local var_59_11 = var_59_9 <= 0 and var_59_5 or var_59_5 * (var_59_10 / var_59_9)

				if var_59_11 > 0 and var_59_5 < var_59_11 then
					arg_56_1.talkMaxDuration = var_59_11

					if var_59_11 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_11 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_8
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011014", "story_v_out_101011.awb") ~= 0 then
					local var_59_12 = manager.audio:GetVoiceLength("story_v_out_101011", "101011014", "story_v_out_101011.awb") / 1000

					if var_59_12 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_12 + var_59_4
					end

					if var_59_7.prefab_name ~= "" and arg_56_1.actors_[var_59_7.prefab_name] ~= nil then
						local var_59_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_7.prefab_name].transform, "story_v_out_101011", "101011014", "story_v_out_101011.awb")

						arg_56_1:RecordAudio("101011014", var_59_13)
						arg_56_1:RecordAudio("101011014", var_59_13)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_101011", "101011014", "story_v_out_101011.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_101011", "101011014", "story_v_out_101011.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_14 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_14 and arg_56_1.time_ < var_59_4 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play101011015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 101011015
		arg_60_1.duration_ = 1.5

		local var_60_0 = {
			ja = 1.3,
			ko = 1.5,
			zh = 1.333,
			en = 1.3
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
				arg_60_0:Play101011016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 1

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				local var_63_2 = "play"
				local var_63_3 = "effect"

				arg_60_1:AudioAction(var_63_2, var_63_3, "se_story", "se_story_gasgate_open", "")
			end

			local var_63_4 = 0
			local var_63_5 = 0.075

			if var_63_4 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_6 = arg_60_1:FormatText(StoryNameCfg[14].name)

				arg_60_1.leftNameTxt_.text = var_63_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_7 = arg_60_1:GetWordFromCfg(101011015)
				local var_63_8 = arg_60_1:FormatText(var_63_7.content)

				arg_60_1.text_.text = var_63_8

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 3
				local var_63_10 = utf8.len(var_63_8)
				local var_63_11 = var_63_9 <= 0 and var_63_5 or var_63_5 * (var_63_10 / var_63_9)

				if var_63_11 > 0 and var_63_5 < var_63_11 then
					arg_60_1.talkMaxDuration = var_63_11

					if var_63_11 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_11 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_8
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011015", "story_v_out_101011.awb") ~= 0 then
					local var_63_12 = manager.audio:GetVoiceLength("story_v_out_101011", "101011015", "story_v_out_101011.awb") / 1000

					if var_63_12 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_12 + var_63_4
					end

					if var_63_7.prefab_name ~= "" and arg_60_1.actors_[var_63_7.prefab_name] ~= nil then
						local var_63_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_7.prefab_name].transform, "story_v_out_101011", "101011015", "story_v_out_101011.awb")

						arg_60_1:RecordAudio("101011015", var_63_13)
						arg_60_1:RecordAudio("101011015", var_63_13)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_101011", "101011015", "story_v_out_101011.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_101011", "101011015", "story_v_out_101011.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_14 and arg_60_1.time_ < var_63_4 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play101011016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 101011016
		arg_64_1.duration_ = 5.6

		local var_64_0 = {
			ja = 4.766,
			ko = 5.6,
			zh = 3.333,
			en = 4.4
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
				arg_64_0:Play101011017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 1

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				local var_67_2 = "play"
				local var_67_3 = "effect"

				arg_64_1:AudioAction(var_67_2, var_67_3, "se_story", "se_story_footsteps_in", "")
			end

			local var_67_4 = 0
			local var_67_5 = 0.5

			if var_67_4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_6 = arg_64_1:FormatText(StoryNameCfg[14].name)

				arg_64_1.leftNameTxt_.text = var_67_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_7 = arg_64_1:GetWordFromCfg(101011016)
				local var_67_8 = arg_64_1:FormatText(var_67_7.content)

				arg_64_1.text_.text = var_67_8

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 19
				local var_67_10 = utf8.len(var_67_8)
				local var_67_11 = var_67_9 <= 0 and var_67_5 or var_67_5 * (var_67_10 / var_67_9)

				if var_67_11 > 0 and var_67_5 < var_67_11 then
					arg_64_1.talkMaxDuration = var_67_11

					if var_67_11 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_11 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_8
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011016", "story_v_out_101011.awb") ~= 0 then
					local var_67_12 = manager.audio:GetVoiceLength("story_v_out_101011", "101011016", "story_v_out_101011.awb") / 1000

					if var_67_12 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_12 + var_67_4
					end

					if var_67_7.prefab_name ~= "" and arg_64_1.actors_[var_67_7.prefab_name] ~= nil then
						local var_67_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_7.prefab_name].transform, "story_v_out_101011", "101011016", "story_v_out_101011.awb")

						arg_64_1:RecordAudio("101011016", var_67_13)
						arg_64_1:RecordAudio("101011016", var_67_13)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_101011", "101011016", "story_v_out_101011.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_101011", "101011016", "story_v_out_101011.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_14 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_14 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_14

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_14 and arg_64_1.time_ < var_67_4 + var_67_14 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play101011017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 101011017
		arg_68_1.duration_ = 2.5

		local var_68_0 = {
			ja = 2.433,
			ko = 2.5,
			zh = 2.2,
			en = 1.999999999999
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
				arg_68_0:Play101011018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = "1036ui_story"

			if arg_68_1.actors_[var_71_0] == nil then
				local var_71_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_71_1) then
					local var_71_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_68_1.stage_.transform)

					var_71_2.name = var_71_0
					var_71_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_68_1.actors_[var_71_0] = var_71_2

					local var_71_3 = var_71_2:GetComponentInChildren(typeof(CharacterEffect))

					var_71_3.enabled = true

					local var_71_4 = GameObjectTools.GetOrAddComponent(var_71_2, typeof(DynamicBoneHelper))

					if var_71_4 then
						var_71_4:EnableDynamicBone(false)
					end

					arg_68_1:ShowWeapon(var_71_3.transform, false)

					arg_68_1.var_[var_71_0 .. "Animator"] = var_71_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_68_1.var_[var_71_0 .. "Animator"].applyRootMotion = true
					arg_68_1.var_[var_71_0 .. "LipSync"] = var_71_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_71_5 = arg_68_1.actors_["1036ui_story"]
			local var_71_6 = 0

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 and not isNil(var_71_5) and arg_68_1.var_.characterEffect1036ui_story == nil then
				arg_68_1.var_.characterEffect1036ui_story = var_71_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_7 = 0.1

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_7 and not isNil(var_71_5) then
				local var_71_8 = (arg_68_1.time_ - var_71_6) / var_71_7

				if arg_68_1.var_.characterEffect1036ui_story and not isNil(var_71_5) then
					arg_68_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_6 + var_71_7 and arg_68_1.time_ < var_71_6 + var_71_7 + arg_71_0 and not isNil(var_71_5) and arg_68_1.var_.characterEffect1036ui_story then
				arg_68_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_71_9 = arg_68_1.actors_["1036ui_story"].transform
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1.var_.moveOldPos1036ui_story = var_71_9.localPosition
			end

			local var_71_11 = 0.001

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11
				local var_71_13 = Vector3.New(-0.7, -1.09, -5.78)

				var_71_9.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1036ui_story, var_71_13, var_71_12)

				local var_71_14 = manager.ui.mainCamera.transform.position - var_71_9.position

				var_71_9.forward = Vector3.New(var_71_14.x, var_71_14.y, var_71_14.z)

				local var_71_15 = var_71_9.localEulerAngles

				var_71_15.z = 0
				var_71_15.x = 0
				var_71_9.localEulerAngles = var_71_15
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 then
				var_71_9.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_71_16 = manager.ui.mainCamera.transform.position - var_71_9.position

				var_71_9.forward = Vector3.New(var_71_16.x, var_71_16.y, var_71_16.z)

				local var_71_17 = var_71_9.localEulerAngles

				var_71_17.z = 0
				var_71_17.x = 0
				var_71_9.localEulerAngles = var_71_17
			end

			local var_71_18 = 0

			if var_71_18 < arg_68_1.time_ and arg_68_1.time_ <= var_71_18 + arg_71_0 then
				arg_68_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_71_19 = 0

			if var_71_19 < arg_68_1.time_ and arg_68_1.time_ <= var_71_19 + arg_71_0 then
				arg_68_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_71_20 = arg_68_1.actors_["1037ui_story"].transform
			local var_71_21 = 0

			if var_71_21 < arg_68_1.time_ and arg_68_1.time_ <= var_71_21 + arg_71_0 then
				arg_68_1.var_.moveOldPos1037ui_story = var_71_20.localPosition
			end

			local var_71_22 = 0.001

			if var_71_21 <= arg_68_1.time_ and arg_68_1.time_ < var_71_21 + var_71_22 then
				local var_71_23 = (arg_68_1.time_ - var_71_21) / var_71_22
				local var_71_24 = Vector3.New(0.7, -1.09, -5.81)

				var_71_20.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1037ui_story, var_71_24, var_71_23)

				local var_71_25 = manager.ui.mainCamera.transform.position - var_71_20.position

				var_71_20.forward = Vector3.New(var_71_25.x, var_71_25.y, var_71_25.z)

				local var_71_26 = var_71_20.localEulerAngles

				var_71_26.z = 0
				var_71_26.x = 0
				var_71_20.localEulerAngles = var_71_26
			end

			if arg_68_1.time_ >= var_71_21 + var_71_22 and arg_68_1.time_ < var_71_21 + var_71_22 + arg_71_0 then
				var_71_20.localPosition = Vector3.New(0.7, -1.09, -5.81)

				local var_71_27 = manager.ui.mainCamera.transform.position - var_71_20.position

				var_71_20.forward = Vector3.New(var_71_27.x, var_71_27.y, var_71_27.z)

				local var_71_28 = var_71_20.localEulerAngles

				var_71_28.z = 0
				var_71_28.x = 0
				var_71_20.localEulerAngles = var_71_28
			end

			local var_71_29 = 0
			local var_71_30 = 0.2

			if var_71_29 < arg_68_1.time_ and arg_68_1.time_ <= var_71_29 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_31 = arg_68_1:FormatText(StoryNameCfg[5].name)

				arg_68_1.leftNameTxt_.text = var_71_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_32 = arg_68_1:GetWordFromCfg(101011017)
				local var_71_33 = arg_68_1:FormatText(var_71_32.content)

				arg_68_1.text_.text = var_71_33

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_34 = 8
				local var_71_35 = utf8.len(var_71_33)
				local var_71_36 = var_71_34 <= 0 and var_71_30 or var_71_30 * (var_71_35 / var_71_34)

				if var_71_36 > 0 and var_71_30 < var_71_36 then
					arg_68_1.talkMaxDuration = var_71_36

					if var_71_36 + var_71_29 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_36 + var_71_29
					end
				end

				arg_68_1.text_.text = var_71_33
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011017", "story_v_out_101011.awb") ~= 0 then
					local var_71_37 = manager.audio:GetVoiceLength("story_v_out_101011", "101011017", "story_v_out_101011.awb") / 1000

					if var_71_37 + var_71_29 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_37 + var_71_29
					end

					if var_71_32.prefab_name ~= "" and arg_68_1.actors_[var_71_32.prefab_name] ~= nil then
						local var_71_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_32.prefab_name].transform, "story_v_out_101011", "101011017", "story_v_out_101011.awb")

						arg_68_1:RecordAudio("101011017", var_71_38)
						arg_68_1:RecordAudio("101011017", var_71_38)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_101011", "101011017", "story_v_out_101011.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_101011", "101011017", "story_v_out_101011.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_39 = math.max(var_71_30, arg_68_1.talkMaxDuration)

			if var_71_29 <= arg_68_1.time_ and arg_68_1.time_ < var_71_29 + var_71_39 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_29) / var_71_39

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_29 + var_71_39 and arg_68_1.time_ < var_71_29 + var_71_39 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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
				actorName = "1037ui_story",
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
	Play101011018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 101011018
		arg_72_1.duration_ = 2.4

		local var_72_0 = {
			ja = 1.999999999999,
			ko = 2.4,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_72_0:Play101011019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1037ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1037ui_story == nil then
				arg_72_1.var_.characterEffect1037ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1037ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1037ui_story then
				arg_72_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_75_4 = arg_72_1.actors_["1036ui_story"]
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect1036ui_story == nil then
				arg_72_1.var_.characterEffect1036ui_story = var_75_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.1

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 and not isNil(var_75_4) then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6

				if arg_72_1.var_.characterEffect1036ui_story and not isNil(var_75_4) then
					local var_75_8 = Mathf.Lerp(0, 0.5, var_75_7)

					arg_72_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1036ui_story.fillRatio = var_75_8
				end
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect1036ui_story then
				local var_75_9 = 0.5

				arg_72_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1036ui_story.fillRatio = var_75_9
			end

			local var_75_10 = arg_72_1.actors_["1037ui_story"].transform
			local var_75_11 = 0

			if var_75_11 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1.var_.moveOldPos1037ui_story = var_75_10.localPosition
			end

			local var_75_12 = 0.001

			if var_75_11 <= arg_72_1.time_ and arg_72_1.time_ < var_75_11 + var_75_12 then
				local var_75_13 = (arg_72_1.time_ - var_75_11) / var_75_12
				local var_75_14 = Vector3.New(0.7, -1.09, -5.81)

				var_75_10.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1037ui_story, var_75_14, var_75_13)

				local var_75_15 = manager.ui.mainCamera.transform.position - var_75_10.position

				var_75_10.forward = Vector3.New(var_75_15.x, var_75_15.y, var_75_15.z)

				local var_75_16 = var_75_10.localEulerAngles

				var_75_16.z = 0
				var_75_16.x = 0
				var_75_10.localEulerAngles = var_75_16
			end

			if arg_72_1.time_ >= var_75_11 + var_75_12 and arg_72_1.time_ < var_75_11 + var_75_12 + arg_75_0 then
				var_75_10.localPosition = Vector3.New(0.7, -1.09, -5.81)

				local var_75_17 = manager.ui.mainCamera.transform.position - var_75_10.position

				var_75_10.forward = Vector3.New(var_75_17.x, var_75_17.y, var_75_17.z)

				local var_75_18 = var_75_10.localEulerAngles

				var_75_18.z = 0
				var_75_18.x = 0
				var_75_10.localEulerAngles = var_75_18
			end

			local var_75_19 = 0

			if var_75_19 < arg_72_1.time_ and arg_72_1.time_ <= var_75_19 + arg_75_0 then
				arg_72_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_75_20 = 0

			if var_75_20 < arg_72_1.time_ and arg_72_1.time_ <= var_75_20 + arg_75_0 then
				arg_72_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_75_21 = 0
			local var_75_22 = 0.125

			if var_75_21 < arg_72_1.time_ and arg_72_1.time_ <= var_75_21 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_23 = arg_72_1:FormatText(StoryNameCfg[15].name)

				arg_72_1.leftNameTxt_.text = var_75_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_24 = arg_72_1:GetWordFromCfg(101011018)
				local var_75_25 = arg_72_1:FormatText(var_75_24.content)

				arg_72_1.text_.text = var_75_25

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_26 = 5
				local var_75_27 = utf8.len(var_75_25)
				local var_75_28 = var_75_26 <= 0 and var_75_22 or var_75_22 * (var_75_27 / var_75_26)

				if var_75_28 > 0 and var_75_22 < var_75_28 then
					arg_72_1.talkMaxDuration = var_75_28

					if var_75_28 + var_75_21 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_28 + var_75_21
					end
				end

				arg_72_1.text_.text = var_75_25
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011018", "story_v_out_101011.awb") ~= 0 then
					local var_75_29 = manager.audio:GetVoiceLength("story_v_out_101011", "101011018", "story_v_out_101011.awb") / 1000

					if var_75_29 + var_75_21 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_29 + var_75_21
					end

					if var_75_24.prefab_name ~= "" and arg_72_1.actors_[var_75_24.prefab_name] ~= nil then
						local var_75_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_24.prefab_name].transform, "story_v_out_101011", "101011018", "story_v_out_101011.awb")

						arg_72_1:RecordAudio("101011018", var_75_30)
						arg_72_1:RecordAudio("101011018", var_75_30)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_101011", "101011018", "story_v_out_101011.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_101011", "101011018", "story_v_out_101011.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_31 = math.max(var_75_22, arg_72_1.talkMaxDuration)

			if var_75_21 <= arg_72_1.time_ and arg_72_1.time_ < var_75_21 + var_75_31 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_21) / var_75_31

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_21 + var_75_31 and arg_72_1.time_ < var_75_21 + var_75_31 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play101011019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 101011019
		arg_76_1.duration_ = 3.4

		local var_76_0 = {
			ja = 2.833,
			ko = 2.5,
			zh = 3.4,
			en = 1.7
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
				arg_76_0:Play101011020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_79_1 = 0
			local var_79_2 = 0.225

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_3 = arg_76_1:FormatText(StoryNameCfg[15].name)

				arg_76_1.leftNameTxt_.text = var_79_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_4 = arg_76_1:GetWordFromCfg(101011019)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_6 = 9
				local var_79_7 = utf8.len(var_79_5)
				local var_79_8 = var_79_6 <= 0 and var_79_2 or var_79_2 * (var_79_7 / var_79_6)

				if var_79_8 > 0 and var_79_2 < var_79_8 then
					arg_76_1.talkMaxDuration = var_79_8

					if var_79_8 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011019", "story_v_out_101011.awb") ~= 0 then
					local var_79_9 = manager.audio:GetVoiceLength("story_v_out_101011", "101011019", "story_v_out_101011.awb") / 1000

					if var_79_9 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_1
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_out_101011", "101011019", "story_v_out_101011.awb")

						arg_76_1:RecordAudio("101011019", var_79_10)
						arg_76_1:RecordAudio("101011019", var_79_10)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_101011", "101011019", "story_v_out_101011.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_101011", "101011019", "story_v_out_101011.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_11 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_11 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_11

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_11 and arg_76_1.time_ < var_79_1 + var_79_11 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play101011020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 101011020
		arg_80_1.duration_ = 4.5

		local var_80_0 = {
			ja = 4.5,
			ko = 4,
			zh = 3.9,
			en = 3.2
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
				arg_80_0:Play101011021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1036ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1036ui_story == nil then
				arg_80_1.var_.characterEffect1036ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1036ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1036ui_story then
				arg_80_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["1037ui_story"]
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1037ui_story == nil then
				arg_80_1.var_.characterEffect1037ui_story = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.1

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 and not isNil(var_83_4) then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6

				if arg_80_1.var_.characterEffect1037ui_story and not isNil(var_83_4) then
					local var_83_8 = Mathf.Lerp(0, 0.5, var_83_7)

					arg_80_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1037ui_story.fillRatio = var_83_8
				end
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1037ui_story then
				local var_83_9 = 0.5

				arg_80_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1037ui_story.fillRatio = var_83_9
			end

			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_83_11 = 0
			local var_83_12 = 0.45

			if var_83_11 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_13 = arg_80_1:FormatText(StoryNameCfg[5].name)

				arg_80_1.leftNameTxt_.text = var_83_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_14 = arg_80_1:GetWordFromCfg(101011020)
				local var_83_15 = arg_80_1:FormatText(var_83_14.content)

				arg_80_1.text_.text = var_83_15

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_16 = 18
				local var_83_17 = utf8.len(var_83_15)
				local var_83_18 = var_83_16 <= 0 and var_83_12 or var_83_12 * (var_83_17 / var_83_16)

				if var_83_18 > 0 and var_83_12 < var_83_18 then
					arg_80_1.talkMaxDuration = var_83_18

					if var_83_18 + var_83_11 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_18 + var_83_11
					end
				end

				arg_80_1.text_.text = var_83_15
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011020", "story_v_out_101011.awb") ~= 0 then
					local var_83_19 = manager.audio:GetVoiceLength("story_v_out_101011", "101011020", "story_v_out_101011.awb") / 1000

					if var_83_19 + var_83_11 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_19 + var_83_11
					end

					if var_83_14.prefab_name ~= "" and arg_80_1.actors_[var_83_14.prefab_name] ~= nil then
						local var_83_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_14.prefab_name].transform, "story_v_out_101011", "101011020", "story_v_out_101011.awb")

						arg_80_1:RecordAudio("101011020", var_83_20)
						arg_80_1:RecordAudio("101011020", var_83_20)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_101011", "101011020", "story_v_out_101011.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_101011", "101011020", "story_v_out_101011.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_21 = math.max(var_83_12, arg_80_1.talkMaxDuration)

			if var_83_11 <= arg_80_1.time_ and arg_80_1.time_ < var_83_11 + var_83_21 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_11) / var_83_21

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_11 + var_83_21 and arg_80_1.time_ < var_83_11 + var_83_21 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play101011021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 101011021
		arg_84_1.duration_ = 4.03

		local var_84_0 = {
			ja = 3.666,
			ko = 4.033,
			zh = 2.766,
			en = 3.933
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
				arg_84_0:Play101011022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action454")
			end

			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_87_2 = 0
			local var_87_3 = 0.375

			if var_87_2 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_4 = arg_84_1:FormatText(StoryNameCfg[5].name)

				arg_84_1.leftNameTxt_.text = var_87_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_5 = arg_84_1:GetWordFromCfg(101011021)
				local var_87_6 = arg_84_1:FormatText(var_87_5.content)

				arg_84_1.text_.text = var_87_6

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 15
				local var_87_8 = utf8.len(var_87_6)
				local var_87_9 = var_87_7 <= 0 and var_87_3 or var_87_3 * (var_87_8 / var_87_7)

				if var_87_9 > 0 and var_87_3 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_6
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011021", "story_v_out_101011.awb") ~= 0 then
					local var_87_10 = manager.audio:GetVoiceLength("story_v_out_101011", "101011021", "story_v_out_101011.awb") / 1000

					if var_87_10 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_2
					end

					if var_87_5.prefab_name ~= "" and arg_84_1.actors_[var_87_5.prefab_name] ~= nil then
						local var_87_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_5.prefab_name].transform, "story_v_out_101011", "101011021", "story_v_out_101011.awb")

						arg_84_1:RecordAudio("101011021", var_87_11)
						arg_84_1:RecordAudio("101011021", var_87_11)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_101011", "101011021", "story_v_out_101011.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_101011", "101011021", "story_v_out_101011.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_12 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_12 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_12

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_12 and arg_84_1.time_ < var_87_2 + var_87_12 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play101011022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 101011022
		arg_88_1.duration_ = 13.23

		local var_88_0 = {
			ja = 13.233,
			ko = 9.166,
			zh = 6.9,
			en = 7.133
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
				arg_88_0:Play101011023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1037ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1037ui_story == nil then
				arg_88_1.var_.characterEffect1037ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1037ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1037ui_story then
				arg_88_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_91_4 = arg_88_1.actors_["1036ui_story"]
			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1036ui_story == nil then
				arg_88_1.var_.characterEffect1036ui_story = var_91_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.1

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 and not isNil(var_91_4) then
				local var_91_7 = (arg_88_1.time_ - var_91_5) / var_91_6

				if arg_88_1.var_.characterEffect1036ui_story and not isNil(var_91_4) then
					local var_91_8 = Mathf.Lerp(0, 0.5, var_91_7)

					arg_88_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1036ui_story.fillRatio = var_91_8
				end
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1036ui_story then
				local var_91_9 = 0.5

				arg_88_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1036ui_story.fillRatio = var_91_9
			end

			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			local var_91_11 = 0

			if var_91_11 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_91_12 = 0
			local var_91_13 = 0.8

			if var_91_12 < arg_88_1.time_ and arg_88_1.time_ <= var_91_12 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_14 = arg_88_1:FormatText(StoryNameCfg[15].name)

				arg_88_1.leftNameTxt_.text = var_91_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_15 = arg_88_1:GetWordFromCfg(101011022)
				local var_91_16 = arg_88_1:FormatText(var_91_15.content)

				arg_88_1.text_.text = var_91_16

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_17 = 32
				local var_91_18 = utf8.len(var_91_16)
				local var_91_19 = var_91_17 <= 0 and var_91_13 or var_91_13 * (var_91_18 / var_91_17)

				if var_91_19 > 0 and var_91_13 < var_91_19 then
					arg_88_1.talkMaxDuration = var_91_19

					if var_91_19 + var_91_12 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_19 + var_91_12
					end
				end

				arg_88_1.text_.text = var_91_16
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011022", "story_v_out_101011.awb") ~= 0 then
					local var_91_20 = manager.audio:GetVoiceLength("story_v_out_101011", "101011022", "story_v_out_101011.awb") / 1000

					if var_91_20 + var_91_12 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_20 + var_91_12
					end

					if var_91_15.prefab_name ~= "" and arg_88_1.actors_[var_91_15.prefab_name] ~= nil then
						local var_91_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_15.prefab_name].transform, "story_v_out_101011", "101011022", "story_v_out_101011.awb")

						arg_88_1:RecordAudio("101011022", var_91_21)
						arg_88_1:RecordAudio("101011022", var_91_21)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_101011", "101011022", "story_v_out_101011.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_101011", "101011022", "story_v_out_101011.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_22 = math.max(var_91_13, arg_88_1.talkMaxDuration)

			if var_91_12 <= arg_88_1.time_ and arg_88_1.time_ < var_91_12 + var_91_22 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_12) / var_91_22

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_12 + var_91_22 and arg_88_1.time_ < var_91_12 + var_91_22 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play101011023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 101011023
		arg_92_1.duration_ = 5.9

		local var_92_0 = {
			ja = 5.9,
			ko = 2.4,
			zh = 2.366,
			en = 1.933
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
				arg_92_0:Play101011024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_95_1 = 0
			local var_95_2 = 0.3

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_3 = arg_92_1:FormatText(StoryNameCfg[15].name)

				arg_92_1.leftNameTxt_.text = var_95_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_4 = arg_92_1:GetWordFromCfg(101011023)
				local var_95_5 = arg_92_1:FormatText(var_95_4.content)

				arg_92_1.text_.text = var_95_5

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_6 = 11
				local var_95_7 = utf8.len(var_95_5)
				local var_95_8 = var_95_6 <= 0 and var_95_2 or var_95_2 * (var_95_7 / var_95_6)

				if var_95_8 > 0 and var_95_2 < var_95_8 then
					arg_92_1.talkMaxDuration = var_95_8

					if var_95_8 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_5
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011023", "story_v_out_101011.awb") ~= 0 then
					local var_95_9 = manager.audio:GetVoiceLength("story_v_out_101011", "101011023", "story_v_out_101011.awb") / 1000

					if var_95_9 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_1
					end

					if var_95_4.prefab_name ~= "" and arg_92_1.actors_[var_95_4.prefab_name] ~= nil then
						local var_95_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_4.prefab_name].transform, "story_v_out_101011", "101011023", "story_v_out_101011.awb")

						arg_92_1:RecordAudio("101011023", var_95_10)
						arg_92_1:RecordAudio("101011023", var_95_10)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_101011", "101011023", "story_v_out_101011.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_101011", "101011023", "story_v_out_101011.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_11 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_11 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_11

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_11 and arg_92_1.time_ < var_95_1 + var_95_11 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play101011024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 101011024
		arg_96_1.duration_ = 5.87

		local var_96_0 = {
			ja = 4.634999999999,
			ko = 5.866,
			zh = 5.1,
			en = 4.634999999999
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
				arg_96_0:Play101011025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1036ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1036ui_story == nil then
				arg_96_1.var_.characterEffect1036ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1036ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1036ui_story then
				arg_96_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_99_4 = arg_96_1.actors_["1037ui_story"]
			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1037ui_story == nil then
				arg_96_1.var_.characterEffect1037ui_story = var_99_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.1

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 and not isNil(var_99_4) then
				local var_99_7 = (arg_96_1.time_ - var_99_5) / var_99_6

				if arg_96_1.var_.characterEffect1037ui_story and not isNil(var_99_4) then
					local var_99_8 = Mathf.Lerp(0, 0.5, var_99_7)

					arg_96_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1037ui_story.fillRatio = var_99_8
				end
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1037ui_story then
				local var_99_9 = 0.5

				arg_96_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1037ui_story.fillRatio = var_99_9
			end

			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_2")
			end

			local var_99_11 = 0

			if var_99_11 < arg_96_1.time_ and arg_96_1.time_ <= var_99_11 + arg_99_0 then
				arg_96_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_99_12 = 0
			local var_99_13 = 0.525

			if var_99_12 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_14 = arg_96_1:FormatText(StoryNameCfg[5].name)

				arg_96_1.leftNameTxt_.text = var_99_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_15 = arg_96_1:GetWordFromCfg(101011024)
				local var_99_16 = arg_96_1:FormatText(var_99_15.content)

				arg_96_1.text_.text = var_99_16

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_17 = 21
				local var_99_18 = utf8.len(var_99_16)
				local var_99_19 = var_99_17 <= 0 and var_99_13 or var_99_13 * (var_99_18 / var_99_17)

				if var_99_19 > 0 and var_99_13 < var_99_19 then
					arg_96_1.talkMaxDuration = var_99_19

					if var_99_19 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_19 + var_99_12
					end
				end

				arg_96_1.text_.text = var_99_16
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011024", "story_v_out_101011.awb") ~= 0 then
					local var_99_20 = manager.audio:GetVoiceLength("story_v_out_101011", "101011024", "story_v_out_101011.awb") / 1000

					if var_99_20 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_20 + var_99_12
					end

					if var_99_15.prefab_name ~= "" and arg_96_1.actors_[var_99_15.prefab_name] ~= nil then
						local var_99_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_15.prefab_name].transform, "story_v_out_101011", "101011024", "story_v_out_101011.awb")

						arg_96_1:RecordAudio("101011024", var_99_21)
						arg_96_1:RecordAudio("101011024", var_99_21)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_101011", "101011024", "story_v_out_101011.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_101011", "101011024", "story_v_out_101011.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_22 = math.max(var_99_13, arg_96_1.talkMaxDuration)

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_22 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_12) / var_99_22

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_12 + var_99_22 and arg_96_1.time_ < var_99_12 + var_99_22 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play101011025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 101011025
		arg_100_1.duration_ = 14.53

		local var_100_0 = {
			ja = 14.533,
			ko = 9.1,
			zh = 9.266,
			en = 9.566
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
				arg_100_0:Play101011026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1037ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1037ui_story == nil then
				arg_100_1.var_.characterEffect1037ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.1

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1037ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1037ui_story then
				arg_100_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["1036ui_story"]
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect1036ui_story == nil then
				arg_100_1.var_.characterEffect1036ui_story = var_103_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.1

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 and not isNil(var_103_4) then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6

				if arg_100_1.var_.characterEffect1036ui_story and not isNil(var_103_4) then
					local var_103_8 = Mathf.Lerp(0, 0.5, var_103_7)

					arg_100_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1036ui_story.fillRatio = var_103_8
				end
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect1036ui_story then
				local var_103_9 = 0.5

				arg_100_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1036ui_story.fillRatio = var_103_9
			end

			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			local var_103_11 = 0

			if var_103_11 < arg_100_1.time_ and arg_100_1.time_ <= var_103_11 + arg_103_0 then
				arg_100_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_103_12 = 0
			local var_103_13 = 0.95

			if var_103_12 < arg_100_1.time_ and arg_100_1.time_ <= var_103_12 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_14 = arg_100_1:FormatText(StoryNameCfg[15].name)

				arg_100_1.leftNameTxt_.text = var_103_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_15 = arg_100_1:GetWordFromCfg(101011025)
				local var_103_16 = arg_100_1:FormatText(var_103_15.content)

				arg_100_1.text_.text = var_103_16

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_17 = 38
				local var_103_18 = utf8.len(var_103_16)
				local var_103_19 = var_103_17 <= 0 and var_103_13 or var_103_13 * (var_103_18 / var_103_17)

				if var_103_19 > 0 and var_103_13 < var_103_19 then
					arg_100_1.talkMaxDuration = var_103_19

					if var_103_19 + var_103_12 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_19 + var_103_12
					end
				end

				arg_100_1.text_.text = var_103_16
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011025", "story_v_out_101011.awb") ~= 0 then
					local var_103_20 = manager.audio:GetVoiceLength("story_v_out_101011", "101011025", "story_v_out_101011.awb") / 1000

					if var_103_20 + var_103_12 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_20 + var_103_12
					end

					if var_103_15.prefab_name ~= "" and arg_100_1.actors_[var_103_15.prefab_name] ~= nil then
						local var_103_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_15.prefab_name].transform, "story_v_out_101011", "101011025", "story_v_out_101011.awb")

						arg_100_1:RecordAudio("101011025", var_103_21)
						arg_100_1:RecordAudio("101011025", var_103_21)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_101011", "101011025", "story_v_out_101011.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_101011", "101011025", "story_v_out_101011.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_22 = math.max(var_103_13, arg_100_1.talkMaxDuration)

			if var_103_12 <= arg_100_1.time_ and arg_100_1.time_ < var_103_12 + var_103_22 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_12) / var_103_22

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_12 + var_103_22 and arg_100_1.time_ < var_103_12 + var_103_22 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play101011026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 101011026
		arg_104_1.duration_ = 4.9

		local var_104_0 = {
			ja = 4.9,
			ko = 1.7,
			zh = 2.166,
			en = 1.833
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
				arg_104_0:Play101011027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1036ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1036ui_story == nil then
				arg_104_1.var_.characterEffect1036ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.1

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1036ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1036ui_story then
				arg_104_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_107_4 = arg_104_1.actors_["1037ui_story"]
			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect1037ui_story == nil then
				arg_104_1.var_.characterEffect1037ui_story = var_107_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_6 = 0.1

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_6 and not isNil(var_107_4) then
				local var_107_7 = (arg_104_1.time_ - var_107_5) / var_107_6

				if arg_104_1.var_.characterEffect1037ui_story and not isNil(var_107_4) then
					local var_107_8 = Mathf.Lerp(0, 0.5, var_107_7)

					arg_104_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1037ui_story.fillRatio = var_107_8
				end
			end

			if arg_104_1.time_ >= var_107_5 + var_107_6 and arg_104_1.time_ < var_107_5 + var_107_6 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect1037ui_story then
				local var_107_9 = 0.5

				arg_104_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1037ui_story.fillRatio = var_107_9
			end

			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 then
				arg_104_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_107_11 = 0
			local var_107_12 = 0.2

			if var_107_11 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_13 = arg_104_1:FormatText(StoryNameCfg[5].name)

				arg_104_1.leftNameTxt_.text = var_107_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_14 = arg_104_1:GetWordFromCfg(101011026)
				local var_107_15 = arg_104_1:FormatText(var_107_14.content)

				arg_104_1.text_.text = var_107_15

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_16 = 8
				local var_107_17 = utf8.len(var_107_15)
				local var_107_18 = var_107_16 <= 0 and var_107_12 or var_107_12 * (var_107_17 / var_107_16)

				if var_107_18 > 0 and var_107_12 < var_107_18 then
					arg_104_1.talkMaxDuration = var_107_18

					if var_107_18 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_18 + var_107_11
					end
				end

				arg_104_1.text_.text = var_107_15
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011026", "story_v_out_101011.awb") ~= 0 then
					local var_107_19 = manager.audio:GetVoiceLength("story_v_out_101011", "101011026", "story_v_out_101011.awb") / 1000

					if var_107_19 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_19 + var_107_11
					end

					if var_107_14.prefab_name ~= "" and arg_104_1.actors_[var_107_14.prefab_name] ~= nil then
						local var_107_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_14.prefab_name].transform, "story_v_out_101011", "101011026", "story_v_out_101011.awb")

						arg_104_1:RecordAudio("101011026", var_107_20)
						arg_104_1:RecordAudio("101011026", var_107_20)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_101011", "101011026", "story_v_out_101011.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_101011", "101011026", "story_v_out_101011.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_21 = math.max(var_107_12, arg_104_1.talkMaxDuration)

			if var_107_11 <= arg_104_1.time_ and arg_104_1.time_ < var_107_11 + var_107_21 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_11) / var_107_21

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_11 + var_107_21 and arg_104_1.time_ < var_107_11 + var_107_21 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play101011027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 101011027
		arg_108_1.duration_ = 2.07

		local var_108_0 = {
			ja = 1.066,
			ko = 2.066,
			zh = 1.166,
			en = 0.999999999999
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
				arg_108_0:Play101011028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1037ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1037ui_story == nil then
				arg_108_1.var_.characterEffect1037ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.1

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1037ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1037ui_story then
				arg_108_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_111_4 = arg_108_1.actors_["1036ui_story"]
			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect1036ui_story == nil then
				arg_108_1.var_.characterEffect1036ui_story = var_111_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_6 = 0.1

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_6 and not isNil(var_111_4) then
				local var_111_7 = (arg_108_1.time_ - var_111_5) / var_111_6

				if arg_108_1.var_.characterEffect1036ui_story and not isNil(var_111_4) then
					local var_111_8 = Mathf.Lerp(0, 0.5, var_111_7)

					arg_108_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1036ui_story.fillRatio = var_111_8
				end
			end

			if arg_108_1.time_ >= var_111_5 + var_111_6 and arg_108_1.time_ < var_111_5 + var_111_6 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect1036ui_story then
				local var_111_9 = 0.5

				arg_108_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1036ui_story.fillRatio = var_111_9
			end

			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 then
				arg_108_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action434")
			end

			local var_111_11 = 0

			if var_111_11 < arg_108_1.time_ and arg_108_1.time_ <= var_111_11 + arg_111_0 then
				arg_108_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_111_12 = 0
			local var_111_13 = 0.05

			if var_111_12 < arg_108_1.time_ and arg_108_1.time_ <= var_111_12 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_14 = arg_108_1:FormatText(StoryNameCfg[15].name)

				arg_108_1.leftNameTxt_.text = var_111_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_15 = arg_108_1:GetWordFromCfg(101011027)
				local var_111_16 = arg_108_1:FormatText(var_111_15.content)

				arg_108_1.text_.text = var_111_16

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_17 = 2
				local var_111_18 = utf8.len(var_111_16)
				local var_111_19 = var_111_17 <= 0 and var_111_13 or var_111_13 * (var_111_18 / var_111_17)

				if var_111_19 > 0 and var_111_13 < var_111_19 then
					arg_108_1.talkMaxDuration = var_111_19

					if var_111_19 + var_111_12 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_19 + var_111_12
					end
				end

				arg_108_1.text_.text = var_111_16
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011027", "story_v_out_101011.awb") ~= 0 then
					local var_111_20 = manager.audio:GetVoiceLength("story_v_out_101011", "101011027", "story_v_out_101011.awb") / 1000

					if var_111_20 + var_111_12 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_20 + var_111_12
					end

					if var_111_15.prefab_name ~= "" and arg_108_1.actors_[var_111_15.prefab_name] ~= nil then
						local var_111_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_15.prefab_name].transform, "story_v_out_101011", "101011027", "story_v_out_101011.awb")

						arg_108_1:RecordAudio("101011027", var_111_21)
						arg_108_1:RecordAudio("101011027", var_111_21)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_101011", "101011027", "story_v_out_101011.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_101011", "101011027", "story_v_out_101011.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_22 = math.max(var_111_13, arg_108_1.talkMaxDuration)

			if var_111_12 <= arg_108_1.time_ and arg_108_1.time_ < var_111_12 + var_111_22 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_12) / var_111_22

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_12 + var_111_22 and arg_108_1.time_ < var_111_12 + var_111_22 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play101011028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 101011028
		arg_112_1.duration_ = 11.3

		local var_112_0 = {
			ja = 11.3,
			ko = 7.433,
			zh = 6.666,
			en = 6.237999999999
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
				arg_112_0:Play101011029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action443")
			end

			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_115_2 = 0
			local var_115_3 = 0.55

			if var_115_2 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_4 = arg_112_1:FormatText(StoryNameCfg[15].name)

				arg_112_1.leftNameTxt_.text = var_115_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_5 = arg_112_1:GetWordFromCfg(101011028)
				local var_115_6 = arg_112_1:FormatText(var_115_5.content)

				arg_112_1.text_.text = var_115_6

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 22
				local var_115_8 = utf8.len(var_115_6)
				local var_115_9 = var_115_7 <= 0 and var_115_3 or var_115_3 * (var_115_8 / var_115_7)

				if var_115_9 > 0 and var_115_3 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_6
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011028", "story_v_out_101011.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_out_101011", "101011028", "story_v_out_101011.awb") / 1000

					if var_115_10 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_2
					end

					if var_115_5.prefab_name ~= "" and arg_112_1.actors_[var_115_5.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_5.prefab_name].transform, "story_v_out_101011", "101011028", "story_v_out_101011.awb")

						arg_112_1:RecordAudio("101011028", var_115_11)
						arg_112_1:RecordAudio("101011028", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_101011", "101011028", "story_v_out_101011.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_101011", "101011028", "story_v_out_101011.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_12 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_12 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_12

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_12 and arg_112_1.time_ < var_115_2 + var_115_12 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play101011029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 101011029
		arg_116_1.duration_ = 3.87

		local var_116_0 = {
			ja = 3.866,
			ko = 3.1,
			zh = 3.533,
			en = 3.028999999999
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
				arg_116_0:Play101011030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1036ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1036ui_story == nil then
				arg_116_1.var_.characterEffect1036ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.1

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1036ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1036ui_story then
				arg_116_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_119_4 = arg_116_1.actors_["1037ui_story"]
			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect1037ui_story == nil then
				arg_116_1.var_.characterEffect1037ui_story = var_119_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_6 = 0.1

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_6 and not isNil(var_119_4) then
				local var_119_7 = (arg_116_1.time_ - var_119_5) / var_119_6

				if arg_116_1.var_.characterEffect1037ui_story and not isNil(var_119_4) then
					local var_119_8 = Mathf.Lerp(0, 0.5, var_119_7)

					arg_116_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1037ui_story.fillRatio = var_119_8
				end
			end

			if arg_116_1.time_ >= var_119_5 + var_119_6 and arg_116_1.time_ < var_119_5 + var_119_6 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect1037ui_story then
				local var_119_9 = 0.5

				arg_116_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1037ui_story.fillRatio = var_119_9
			end

			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_119_11 = 0

			if var_119_11 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_119_12 = 0
			local var_119_13 = 0.425

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_14 = arg_116_1:FormatText(StoryNameCfg[5].name)

				arg_116_1.leftNameTxt_.text = var_119_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_15 = arg_116_1:GetWordFromCfg(101011029)
				local var_119_16 = arg_116_1:FormatText(var_119_15.content)

				arg_116_1.text_.text = var_119_16

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_17 = 17
				local var_119_18 = utf8.len(var_119_16)
				local var_119_19 = var_119_17 <= 0 and var_119_13 or var_119_13 * (var_119_18 / var_119_17)

				if var_119_19 > 0 and var_119_13 < var_119_19 then
					arg_116_1.talkMaxDuration = var_119_19

					if var_119_19 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_19 + var_119_12
					end
				end

				arg_116_1.text_.text = var_119_16
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011029", "story_v_out_101011.awb") ~= 0 then
					local var_119_20 = manager.audio:GetVoiceLength("story_v_out_101011", "101011029", "story_v_out_101011.awb") / 1000

					if var_119_20 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_20 + var_119_12
					end

					if var_119_15.prefab_name ~= "" and arg_116_1.actors_[var_119_15.prefab_name] ~= nil then
						local var_119_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_15.prefab_name].transform, "story_v_out_101011", "101011029", "story_v_out_101011.awb")

						arg_116_1:RecordAudio("101011029", var_119_21)
						arg_116_1:RecordAudio("101011029", var_119_21)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_101011", "101011029", "story_v_out_101011.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_101011", "101011029", "story_v_out_101011.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_22 = math.max(var_119_13, arg_116_1.talkMaxDuration)

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_22 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_12) / var_119_22

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_12 + var_119_22 and arg_116_1.time_ < var_119_12 + var_119_22 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play101011030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 101011030
		arg_120_1.duration_ = 4.57

		local var_120_0 = {
			ja = 4.566,
			ko = 2.9,
			zh = 2.6,
			en = 3.566
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
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play101011031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1037ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1037ui_story == nil then
				arg_120_1.var_.characterEffect1037ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.1

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1037ui_story and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1037ui_story then
				arg_120_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_123_4 = arg_120_1.actors_["1036ui_story"]
			local var_123_5 = 0

			if var_123_5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect1036ui_story == nil then
				arg_120_1.var_.characterEffect1036ui_story = var_123_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_6 = 0.1

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_6 and not isNil(var_123_4) then
				local var_123_7 = (arg_120_1.time_ - var_123_5) / var_123_6

				if arg_120_1.var_.characterEffect1036ui_story and not isNil(var_123_4) then
					local var_123_8 = Mathf.Lerp(0, 0.5, var_123_7)

					arg_120_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1036ui_story.fillRatio = var_123_8
				end
			end

			if arg_120_1.time_ >= var_123_5 + var_123_6 and arg_120_1.time_ < var_123_5 + var_123_6 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect1036ui_story then
				local var_123_9 = 0.5

				arg_120_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1036ui_story.fillRatio = var_123_9
			end

			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_2")
			end

			local var_123_11 = 0

			if var_123_11 < arg_120_1.time_ and arg_120_1.time_ <= var_123_11 + arg_123_0 then
				arg_120_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_123_12 = 0
			local var_123_13 = 0.3

			if var_123_12 < arg_120_1.time_ and arg_120_1.time_ <= var_123_12 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_14 = arg_120_1:FormatText(StoryNameCfg[15].name)

				arg_120_1.leftNameTxt_.text = var_123_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_15 = arg_120_1:GetWordFromCfg(101011030)
				local var_123_16 = arg_120_1:FormatText(var_123_15.content)

				arg_120_1.text_.text = var_123_16

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_17 = 11
				local var_123_18 = utf8.len(var_123_16)
				local var_123_19 = var_123_17 <= 0 and var_123_13 or var_123_13 * (var_123_18 / var_123_17)

				if var_123_19 > 0 and var_123_13 < var_123_19 then
					arg_120_1.talkMaxDuration = var_123_19

					if var_123_19 + var_123_12 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_19 + var_123_12
					end
				end

				arg_120_1.text_.text = var_123_16
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011030", "story_v_out_101011.awb") ~= 0 then
					local var_123_20 = manager.audio:GetVoiceLength("story_v_out_101011", "101011030", "story_v_out_101011.awb") / 1000

					if var_123_20 + var_123_12 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_20 + var_123_12
					end

					if var_123_15.prefab_name ~= "" and arg_120_1.actors_[var_123_15.prefab_name] ~= nil then
						local var_123_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_15.prefab_name].transform, "story_v_out_101011", "101011030", "story_v_out_101011.awb")

						arg_120_1:RecordAudio("101011030", var_123_21)
						arg_120_1:RecordAudio("101011030", var_123_21)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_101011", "101011030", "story_v_out_101011.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_101011", "101011030", "story_v_out_101011.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_22 = math.max(var_123_13, arg_120_1.talkMaxDuration)

			if var_123_12 <= arg_120_1.time_ and arg_120_1.time_ < var_123_12 + var_123_22 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_12) / var_123_22

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_12 + var_123_22 and arg_120_1.time_ < var_123_12 + var_123_22 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play101011031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 101011031
		arg_124_1.duration_ = 8.03

		local var_124_0 = {
			ja = 8.033,
			ko = 7.033,
			zh = 6.033,
			en = 6.733
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play101011032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_127_1 = 0
			local var_127_2 = 0.7

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_3 = arg_124_1:FormatText(StoryNameCfg[15].name)

				arg_124_1.leftNameTxt_.text = var_127_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_4 = arg_124_1:GetWordFromCfg(101011031)
				local var_127_5 = arg_124_1:FormatText(var_127_4.content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_6 = 28
				local var_127_7 = utf8.len(var_127_5)
				local var_127_8 = var_127_6 <= 0 and var_127_2 or var_127_2 * (var_127_7 / var_127_6)

				if var_127_8 > 0 and var_127_2 < var_127_8 then
					arg_124_1.talkMaxDuration = var_127_8

					if var_127_8 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_1
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011031", "story_v_out_101011.awb") ~= 0 then
					local var_127_9 = manager.audio:GetVoiceLength("story_v_out_101011", "101011031", "story_v_out_101011.awb") / 1000

					if var_127_9 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_1
					end

					if var_127_4.prefab_name ~= "" and arg_124_1.actors_[var_127_4.prefab_name] ~= nil then
						local var_127_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_4.prefab_name].transform, "story_v_out_101011", "101011031", "story_v_out_101011.awb")

						arg_124_1:RecordAudio("101011031", var_127_10)
						arg_124_1:RecordAudio("101011031", var_127_10)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_101011", "101011031", "story_v_out_101011.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_101011", "101011031", "story_v_out_101011.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_11 = math.max(var_127_2, arg_124_1.talkMaxDuration)

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_11 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_1) / var_127_11

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_1 + var_127_11 and arg_124_1.time_ < var_127_1 + var_127_11 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play101011032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 101011032
		arg_128_1.duration_ = 7.4

		local var_128_0 = {
			ja = 7.4,
			ko = 6.266,
			zh = 5.8,
			en = 7.266
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play101011033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1036ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1036ui_story == nil then
				arg_128_1.var_.characterEffect1036ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.1

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1036ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1036ui_story then
				arg_128_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["1037ui_story"]
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect1037ui_story == nil then
				arg_128_1.var_.characterEffect1037ui_story = var_131_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_6 = 0.1

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 and not isNil(var_131_4) then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6

				if arg_128_1.var_.characterEffect1037ui_story and not isNil(var_131_4) then
					local var_131_8 = Mathf.Lerp(0, 0.5, var_131_7)

					arg_128_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1037ui_story.fillRatio = var_131_8
				end
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect1037ui_story then
				local var_131_9 = 0.5

				arg_128_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1037ui_story.fillRatio = var_131_9
			end

			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_131_11 = 0
			local var_131_12 = 0.75

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_13 = arg_128_1:FormatText(StoryNameCfg[5].name)

				arg_128_1.leftNameTxt_.text = var_131_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_14 = arg_128_1:GetWordFromCfg(101011032)
				local var_131_15 = arg_128_1:FormatText(var_131_14.content)

				arg_128_1.text_.text = var_131_15

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_16 = 29
				local var_131_17 = utf8.len(var_131_15)
				local var_131_18 = var_131_16 <= 0 and var_131_12 or var_131_12 * (var_131_17 / var_131_16)

				if var_131_18 > 0 and var_131_12 < var_131_18 then
					arg_128_1.talkMaxDuration = var_131_18

					if var_131_18 + var_131_11 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_18 + var_131_11
					end
				end

				arg_128_1.text_.text = var_131_15
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011032", "story_v_out_101011.awb") ~= 0 then
					local var_131_19 = manager.audio:GetVoiceLength("story_v_out_101011", "101011032", "story_v_out_101011.awb") / 1000

					if var_131_19 + var_131_11 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_19 + var_131_11
					end

					if var_131_14.prefab_name ~= "" and arg_128_1.actors_[var_131_14.prefab_name] ~= nil then
						local var_131_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_14.prefab_name].transform, "story_v_out_101011", "101011032", "story_v_out_101011.awb")

						arg_128_1:RecordAudio("101011032", var_131_20)
						arg_128_1:RecordAudio("101011032", var_131_20)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_101011", "101011032", "story_v_out_101011.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_101011", "101011032", "story_v_out_101011.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_21 = math.max(var_131_12, arg_128_1.talkMaxDuration)

			if var_131_11 <= arg_128_1.time_ and arg_128_1.time_ < var_131_11 + var_131_21 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_11) / var_131_21

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_11 + var_131_21 and arg_128_1.time_ < var_131_11 + var_131_21 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play101011033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 101011033
		arg_132_1.duration_ = 2.39

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play101011034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1037ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1037ui_story == nil then
				arg_132_1.var_.characterEffect1037ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.1

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1037ui_story and not isNil(var_135_0) then
					arg_132_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1037ui_story then
				arg_132_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_135_4 = arg_132_1.actors_["1036ui_story"]
			local var_135_5 = 0

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.characterEffect1036ui_story == nil then
				arg_132_1.var_.characterEffect1036ui_story = var_135_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_6 = 0.1

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_6 and not isNil(var_135_4) then
				local var_135_7 = (arg_132_1.time_ - var_135_5) / var_135_6

				if arg_132_1.var_.characterEffect1036ui_story and not isNil(var_135_4) then
					local var_135_8 = Mathf.Lerp(0, 0.5, var_135_7)

					arg_132_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1036ui_story.fillRatio = var_135_8
				end
			end

			if arg_132_1.time_ >= var_135_5 + var_135_6 and arg_132_1.time_ < var_135_5 + var_135_6 + arg_135_0 and not isNil(var_135_4) and arg_132_1.var_.characterEffect1036ui_story then
				local var_135_9 = 0.5

				arg_132_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1036ui_story.fillRatio = var_135_9
			end

			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_135_11 = 0

			if var_135_11 < arg_132_1.time_ and arg_132_1.time_ <= var_135_11 + arg_135_0 then
				arg_132_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_135_12 = 0
			local var_135_13 = 0.1

			if var_135_12 < arg_132_1.time_ and arg_132_1.time_ <= var_135_12 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_14 = arg_132_1:FormatText(StoryNameCfg[15].name)

				arg_132_1.leftNameTxt_.text = var_135_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_15 = arg_132_1:GetWordFromCfg(101011033)
				local var_135_16 = arg_132_1:FormatText(var_135_15.content)

				arg_132_1.text_.text = var_135_16

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_17 = 4
				local var_135_18 = utf8.len(var_135_16)
				local var_135_19 = var_135_17 <= 0 and var_135_13 or var_135_13 * (var_135_18 / var_135_17)

				if var_135_19 > 0 and var_135_13 < var_135_19 then
					arg_132_1.talkMaxDuration = var_135_19

					if var_135_19 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_19 + var_135_12
					end
				end

				arg_132_1.text_.text = var_135_16
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011033", "story_v_out_101011.awb") ~= 0 then
					local var_135_20 = manager.audio:GetVoiceLength("story_v_out_101011", "101011033", "story_v_out_101011.awb") / 1000

					if var_135_20 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_20 + var_135_12
					end

					if var_135_15.prefab_name ~= "" and arg_132_1.actors_[var_135_15.prefab_name] ~= nil then
						local var_135_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_15.prefab_name].transform, "story_v_out_101011", "101011033", "story_v_out_101011.awb")

						arg_132_1:RecordAudio("101011033", var_135_21)
						arg_132_1:RecordAudio("101011033", var_135_21)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_101011", "101011033", "story_v_out_101011.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_101011", "101011033", "story_v_out_101011.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_22 = math.max(var_135_13, arg_132_1.talkMaxDuration)

			if var_135_12 <= arg_132_1.time_ and arg_132_1.time_ < var_135_12 + var_135_22 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_12) / var_135_22

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_12 + var_135_22 and arg_132_1.time_ < var_135_12 + var_135_22 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play101011034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 101011034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play101011035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1036ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1036ui_story == nil then
				arg_136_1.var_.characterEffect1036ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.1

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1036ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1036ui_story then
				arg_136_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_139_4 = arg_136_1.actors_["1037ui_story"]
			local var_139_5 = 0

			if var_139_5 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1037ui_story == nil then
				arg_136_1.var_.characterEffect1037ui_story = var_139_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.1

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 and not isNil(var_139_4) then
				local var_139_7 = (arg_136_1.time_ - var_139_5) / var_139_6

				if arg_136_1.var_.characterEffect1037ui_story and not isNil(var_139_4) then
					local var_139_8 = Mathf.Lerp(0, 0.5, var_139_7)

					arg_136_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1037ui_story.fillRatio = var_139_8
				end
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1037ui_story then
				local var_139_9 = 0.5

				arg_136_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1037ui_story.fillRatio = var_139_9
			end

			local var_139_10 = 0
			local var_139_11 = 0.7

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_12 = arg_136_1:GetWordFromCfg(101011034)
				local var_139_13 = arg_136_1:FormatText(var_139_12.content)

				arg_136_1.text_.text = var_139_13

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_14 = 28
				local var_139_15 = utf8.len(var_139_13)
				local var_139_16 = var_139_14 <= 0 and var_139_11 or var_139_11 * (var_139_15 / var_139_14)

				if var_139_16 > 0 and var_139_11 < var_139_16 then
					arg_136_1.talkMaxDuration = var_139_16

					if var_139_16 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_16 + var_139_10
					end
				end

				arg_136_1.text_.text = var_139_13
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_17 = math.max(var_139_11, arg_136_1.talkMaxDuration)

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_17 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_10) / var_139_17

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_10 + var_139_17 and arg_136_1.time_ < var_139_10 + var_139_17 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play101011035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 101011035
		arg_140_1.duration_ = 14.1

		local var_140_0 = {
			ja = 14.1,
			ko = 9.6,
			zh = 9.1,
			en = 11.5
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play101011036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action456")
			end

			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_143_2 = 0
			local var_143_3 = 1.075

			if var_143_2 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_4 = arg_140_1:FormatText(StoryNameCfg[5].name)

				arg_140_1.leftNameTxt_.text = var_143_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_5 = arg_140_1:GetWordFromCfg(101011035)
				local var_143_6 = arg_140_1:FormatText(var_143_5.content)

				arg_140_1.text_.text = var_143_6

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 43
				local var_143_8 = utf8.len(var_143_6)
				local var_143_9 = var_143_7 <= 0 and var_143_3 or var_143_3 * (var_143_8 / var_143_7)

				if var_143_9 > 0 and var_143_3 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_6
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011035", "story_v_out_101011.awb") ~= 0 then
					local var_143_10 = manager.audio:GetVoiceLength("story_v_out_101011", "101011035", "story_v_out_101011.awb") / 1000

					if var_143_10 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_10 + var_143_2
					end

					if var_143_5.prefab_name ~= "" and arg_140_1.actors_[var_143_5.prefab_name] ~= nil then
						local var_143_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_5.prefab_name].transform, "story_v_out_101011", "101011035", "story_v_out_101011.awb")

						arg_140_1:RecordAudio("101011035", var_143_11)
						arg_140_1:RecordAudio("101011035", var_143_11)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_101011", "101011035", "story_v_out_101011.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_101011", "101011035", "story_v_out_101011.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_12 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_12 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_12

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_12 and arg_140_1.time_ < var_143_2 + var_143_12 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play101011036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 101011036
		arg_144_1.duration_ = 9.57

		local var_144_0 = {
			ja = 9.566,
			ko = 7.933,
			zh = 8.6,
			en = 8.266
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play101011037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1037ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1037ui_story == nil then
				arg_144_1.var_.characterEffect1037ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.1

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1037ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1037ui_story then
				arg_144_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_147_4 = arg_144_1.actors_["1036ui_story"]
			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect1036ui_story == nil then
				arg_144_1.var_.characterEffect1036ui_story = var_147_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_6 = 0.1

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_6 and not isNil(var_147_4) then
				local var_147_7 = (arg_144_1.time_ - var_147_5) / var_147_6

				if arg_144_1.var_.characterEffect1036ui_story and not isNil(var_147_4) then
					local var_147_8 = Mathf.Lerp(0, 0.5, var_147_7)

					arg_144_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1036ui_story.fillRatio = var_147_8
				end
			end

			if arg_144_1.time_ >= var_147_5 + var_147_6 and arg_144_1.time_ < var_147_5 + var_147_6 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect1036ui_story then
				local var_147_9 = 0.5

				arg_144_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1036ui_story.fillRatio = var_147_9
			end

			local var_147_10 = 0

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 then
				arg_144_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action424")
			end

			local var_147_11 = 0

			if var_147_11 < arg_144_1.time_ and arg_144_1.time_ <= var_147_11 + arg_147_0 then
				arg_144_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_147_12 = 0
			local var_147_13 = 0.825

			if var_147_12 < arg_144_1.time_ and arg_144_1.time_ <= var_147_12 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_14 = arg_144_1:FormatText(StoryNameCfg[15].name)

				arg_144_1.leftNameTxt_.text = var_147_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_15 = arg_144_1:GetWordFromCfg(101011036)
				local var_147_16 = arg_144_1:FormatText(var_147_15.content)

				arg_144_1.text_.text = var_147_16

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_17 = 32
				local var_147_18 = utf8.len(var_147_16)
				local var_147_19 = var_147_17 <= 0 and var_147_13 or var_147_13 * (var_147_18 / var_147_17)

				if var_147_19 > 0 and var_147_13 < var_147_19 then
					arg_144_1.talkMaxDuration = var_147_19

					if var_147_19 + var_147_12 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_19 + var_147_12
					end
				end

				arg_144_1.text_.text = var_147_16
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011036", "story_v_out_101011.awb") ~= 0 then
					local var_147_20 = manager.audio:GetVoiceLength("story_v_out_101011", "101011036", "story_v_out_101011.awb") / 1000

					if var_147_20 + var_147_12 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_20 + var_147_12
					end

					if var_147_15.prefab_name ~= "" and arg_144_1.actors_[var_147_15.prefab_name] ~= nil then
						local var_147_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_15.prefab_name].transform, "story_v_out_101011", "101011036", "story_v_out_101011.awb")

						arg_144_1:RecordAudio("101011036", var_147_21)
						arg_144_1:RecordAudio("101011036", var_147_21)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_101011", "101011036", "story_v_out_101011.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_101011", "101011036", "story_v_out_101011.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_22 = math.max(var_147_13, arg_144_1.talkMaxDuration)

			if var_147_12 <= arg_144_1.time_ and arg_144_1.time_ < var_147_12 + var_147_22 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_12) / var_147_22

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_12 + var_147_22 and arg_144_1.time_ < var_147_12 + var_147_22 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play101011037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 101011037
		arg_148_1.duration_ = 7.1

		local var_148_0 = {
			ja = 7.1,
			ko = 5.663999999999,
			zh = 5.966,
			en = 5.663999999999
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play101011038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1036ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1036ui_story == nil then
				arg_148_1.var_.characterEffect1036ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.1

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect1036ui_story and not isNil(var_151_0) then
					arg_148_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1036ui_story then
				arg_148_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_151_4 = arg_148_1.actors_["1037ui_story"]
			local var_151_5 = 0

			if var_151_5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect1037ui_story == nil then
				arg_148_1.var_.characterEffect1037ui_story = var_151_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_6 = 0.1

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_6 and not isNil(var_151_4) then
				local var_151_7 = (arg_148_1.time_ - var_151_5) / var_151_6

				if arg_148_1.var_.characterEffect1037ui_story and not isNil(var_151_4) then
					local var_151_8 = Mathf.Lerp(0, 0.5, var_151_7)

					arg_148_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1037ui_story.fillRatio = var_151_8
				end
			end

			if arg_148_1.time_ >= var_151_5 + var_151_6 and arg_148_1.time_ < var_151_5 + var_151_6 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect1037ui_story then
				local var_151_9 = 0.5

				arg_148_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1037ui_story.fillRatio = var_151_9
			end

			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 then
				arg_148_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action464")
			end

			local var_151_11 = 0

			if var_151_11 < arg_148_1.time_ and arg_148_1.time_ <= var_151_11 + arg_151_0 then
				arg_148_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_151_12 = 0
			local var_151_13 = 0.675

			if var_151_12 < arg_148_1.time_ and arg_148_1.time_ <= var_151_12 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_14 = arg_148_1:FormatText(StoryNameCfg[5].name)

				arg_148_1.leftNameTxt_.text = var_151_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_15 = arg_148_1:GetWordFromCfg(101011037)
				local var_151_16 = arg_148_1:FormatText(var_151_15.content)

				arg_148_1.text_.text = var_151_16

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_17 = 27
				local var_151_18 = utf8.len(var_151_16)
				local var_151_19 = var_151_17 <= 0 and var_151_13 or var_151_13 * (var_151_18 / var_151_17)

				if var_151_19 > 0 and var_151_13 < var_151_19 then
					arg_148_1.talkMaxDuration = var_151_19

					if var_151_19 + var_151_12 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_19 + var_151_12
					end
				end

				arg_148_1.text_.text = var_151_16
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011037", "story_v_out_101011.awb") ~= 0 then
					local var_151_20 = manager.audio:GetVoiceLength("story_v_out_101011", "101011037", "story_v_out_101011.awb") / 1000

					if var_151_20 + var_151_12 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_20 + var_151_12
					end

					if var_151_15.prefab_name ~= "" and arg_148_1.actors_[var_151_15.prefab_name] ~= nil then
						local var_151_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_15.prefab_name].transform, "story_v_out_101011", "101011037", "story_v_out_101011.awb")

						arg_148_1:RecordAudio("101011037", var_151_21)
						arg_148_1:RecordAudio("101011037", var_151_21)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_101011", "101011037", "story_v_out_101011.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_101011", "101011037", "story_v_out_101011.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_22 = math.max(var_151_13, arg_148_1.talkMaxDuration)

			if var_151_12 <= arg_148_1.time_ and arg_148_1.time_ < var_151_12 + var_151_22 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_12) / var_151_22

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_12 + var_151_22 and arg_148_1.time_ < var_151_12 + var_151_22 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play101011038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 101011038
		arg_152_1.duration_ = 10.27

		local var_152_0 = {
			ja = 10.266,
			ko = 6.079999999999,
			zh = 6.5,
			en = 6.566
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play101011039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_2")
			end

			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_155_2 = 0
			local var_155_3 = 0.8

			if var_155_2 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_4 = arg_152_1:FormatText(StoryNameCfg[5].name)

				arg_152_1.leftNameTxt_.text = var_155_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_5 = arg_152_1:GetWordFromCfg(101011038)
				local var_155_6 = arg_152_1:FormatText(var_155_5.content)

				arg_152_1.text_.text = var_155_6

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_7 = 32
				local var_155_8 = utf8.len(var_155_6)
				local var_155_9 = var_155_7 <= 0 and var_155_3 or var_155_3 * (var_155_8 / var_155_7)

				if var_155_9 > 0 and var_155_3 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_2
					end
				end

				arg_152_1.text_.text = var_155_6
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011038", "story_v_out_101011.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_101011", "101011038", "story_v_out_101011.awb") / 1000

					if var_155_10 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_2
					end

					if var_155_5.prefab_name ~= "" and arg_152_1.actors_[var_155_5.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_5.prefab_name].transform, "story_v_out_101011", "101011038", "story_v_out_101011.awb")

						arg_152_1:RecordAudio("101011038", var_155_11)
						arg_152_1:RecordAudio("101011038", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_101011", "101011038", "story_v_out_101011.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_101011", "101011038", "story_v_out_101011.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_3, arg_152_1.talkMaxDuration)

			if var_155_2 <= arg_152_1.time_ and arg_152_1.time_ < var_155_2 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_2) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_2 + var_155_12 and arg_152_1.time_ < var_155_2 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play101011039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 101011039
		arg_156_1.duration_ = 2

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play101011040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1037ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1037ui_story == nil then
				arg_156_1.var_.characterEffect1037ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.1

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1037ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1037ui_story then
				arg_156_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_159_4 = arg_156_1.actors_["1036ui_story"]
			local var_159_5 = 0

			if var_159_5 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect1036ui_story == nil then
				arg_156_1.var_.characterEffect1036ui_story = var_159_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_6 = 0.1

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_6 and not isNil(var_159_4) then
				local var_159_7 = (arg_156_1.time_ - var_159_5) / var_159_6

				if arg_156_1.var_.characterEffect1036ui_story and not isNil(var_159_4) then
					local var_159_8 = Mathf.Lerp(0, 0.5, var_159_7)

					arg_156_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1036ui_story.fillRatio = var_159_8
				end
			end

			if arg_156_1.time_ >= var_159_5 + var_159_6 and arg_156_1.time_ < var_159_5 + var_159_6 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect1036ui_story then
				local var_159_9 = 0.5

				arg_156_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1036ui_story.fillRatio = var_159_9
			end

			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 then
				arg_156_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action442")
			end

			local var_159_11 = 0

			if var_159_11 < arg_156_1.time_ and arg_156_1.time_ <= var_159_11 + arg_159_0 then
				arg_156_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_159_12 = 0
			local var_159_13 = 0.05

			if var_159_12 < arg_156_1.time_ and arg_156_1.time_ <= var_159_12 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_14 = arg_156_1:FormatText(StoryNameCfg[15].name)

				arg_156_1.leftNameTxt_.text = var_159_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_15 = arg_156_1:GetWordFromCfg(101011039)
				local var_159_16 = arg_156_1:FormatText(var_159_15.content)

				arg_156_1.text_.text = var_159_16

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_17 = 2
				local var_159_18 = utf8.len(var_159_16)
				local var_159_19 = var_159_17 <= 0 and var_159_13 or var_159_13 * (var_159_18 / var_159_17)

				if var_159_19 > 0 and var_159_13 < var_159_19 then
					arg_156_1.talkMaxDuration = var_159_19

					if var_159_19 + var_159_12 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_19 + var_159_12
					end
				end

				arg_156_1.text_.text = var_159_16
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011039", "story_v_out_101011.awb") ~= 0 then
					local var_159_20 = manager.audio:GetVoiceLength("story_v_out_101011", "101011039", "story_v_out_101011.awb") / 1000

					if var_159_20 + var_159_12 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_20 + var_159_12
					end

					if var_159_15.prefab_name ~= "" and arg_156_1.actors_[var_159_15.prefab_name] ~= nil then
						local var_159_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_15.prefab_name].transform, "story_v_out_101011", "101011039", "story_v_out_101011.awb")

						arg_156_1:RecordAudio("101011039", var_159_21)
						arg_156_1:RecordAudio("101011039", var_159_21)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_101011", "101011039", "story_v_out_101011.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_101011", "101011039", "story_v_out_101011.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_22 = math.max(var_159_13, arg_156_1.talkMaxDuration)

			if var_159_12 <= arg_156_1.time_ and arg_156_1.time_ < var_159_12 + var_159_22 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_12) / var_159_22

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_12 + var_159_22 and arg_156_1.time_ < var_159_12 + var_159_22 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play101011040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 101011040
		arg_160_1.duration_ = 11.5

		local var_160_0 = {
			ja = 11.5,
			ko = 9.666,
			zh = 8.3,
			en = 10.133
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play101011041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1036ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1036ui_story == nil then
				arg_160_1.var_.characterEffect1036ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.1

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1036ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1036ui_story then
				arg_160_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_163_4 = arg_160_1.actors_["1037ui_story"]
			local var_163_5 = 0

			if var_163_5 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 and not isNil(var_163_4) and arg_160_1.var_.characterEffect1037ui_story == nil then
				arg_160_1.var_.characterEffect1037ui_story = var_163_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_6 = 0.1

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_6 and not isNil(var_163_4) then
				local var_163_7 = (arg_160_1.time_ - var_163_5) / var_163_6

				if arg_160_1.var_.characterEffect1037ui_story and not isNil(var_163_4) then
					local var_163_8 = Mathf.Lerp(0, 0.5, var_163_7)

					arg_160_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1037ui_story.fillRatio = var_163_8
				end
			end

			if arg_160_1.time_ >= var_163_5 + var_163_6 and arg_160_1.time_ < var_163_5 + var_163_6 + arg_163_0 and not isNil(var_163_4) and arg_160_1.var_.characterEffect1037ui_story then
				local var_163_9 = 0.5

				arg_160_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1037ui_story.fillRatio = var_163_9
			end

			local var_163_10 = 0

			if var_163_10 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				arg_160_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_163_11 = 0

			if var_163_11 < arg_160_1.time_ and arg_160_1.time_ <= var_163_11 + arg_163_0 then
				arg_160_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_163_12 = 0
			local var_163_13 = 0.85

			if var_163_12 < arg_160_1.time_ and arg_160_1.time_ <= var_163_12 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_14 = arg_160_1:FormatText(StoryNameCfg[5].name)

				arg_160_1.leftNameTxt_.text = var_163_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_15 = arg_160_1:GetWordFromCfg(101011040)
				local var_163_16 = arg_160_1:FormatText(var_163_15.content)

				arg_160_1.text_.text = var_163_16

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_17 = 34
				local var_163_18 = utf8.len(var_163_16)
				local var_163_19 = var_163_17 <= 0 and var_163_13 or var_163_13 * (var_163_18 / var_163_17)

				if var_163_19 > 0 and var_163_13 < var_163_19 then
					arg_160_1.talkMaxDuration = var_163_19

					if var_163_19 + var_163_12 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_19 + var_163_12
					end
				end

				arg_160_1.text_.text = var_163_16
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011040", "story_v_out_101011.awb") ~= 0 then
					local var_163_20 = manager.audio:GetVoiceLength("story_v_out_101011", "101011040", "story_v_out_101011.awb") / 1000

					if var_163_20 + var_163_12 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_20 + var_163_12
					end

					if var_163_15.prefab_name ~= "" and arg_160_1.actors_[var_163_15.prefab_name] ~= nil then
						local var_163_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_15.prefab_name].transform, "story_v_out_101011", "101011040", "story_v_out_101011.awb")

						arg_160_1:RecordAudio("101011040", var_163_21)
						arg_160_1:RecordAudio("101011040", var_163_21)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_101011", "101011040", "story_v_out_101011.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_101011", "101011040", "story_v_out_101011.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_22 = math.max(var_163_13, arg_160_1.talkMaxDuration)

			if var_163_12 <= arg_160_1.time_ and arg_160_1.time_ < var_163_12 + var_163_22 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_12) / var_163_22

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_12 + var_163_22 and arg_160_1.time_ < var_163_12 + var_163_22 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play101011041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 101011041
		arg_164_1.duration_ = 4.7

		local var_164_0 = {
			ja = 3.5,
			ko = 2.466,
			zh = 4.3,
			en = 4.7
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play101011042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1037ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1037ui_story == nil then
				arg_164_1.var_.characterEffect1037ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.1

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1037ui_story and not isNil(var_167_0) then
					arg_164_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1037ui_story then
				arg_164_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_167_4 = arg_164_1.actors_["1036ui_story"]
			local var_167_5 = 0

			if var_167_5 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 and not isNil(var_167_4) and arg_164_1.var_.characterEffect1036ui_story == nil then
				arg_164_1.var_.characterEffect1036ui_story = var_167_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_6 = 0.1

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_6 and not isNil(var_167_4) then
				local var_167_7 = (arg_164_1.time_ - var_167_5) / var_167_6

				if arg_164_1.var_.characterEffect1036ui_story and not isNil(var_167_4) then
					local var_167_8 = Mathf.Lerp(0, 0.5, var_167_7)

					arg_164_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1036ui_story.fillRatio = var_167_8
				end
			end

			if arg_164_1.time_ >= var_167_5 + var_167_6 and arg_164_1.time_ < var_167_5 + var_167_6 + arg_167_0 and not isNil(var_167_4) and arg_164_1.var_.characterEffect1036ui_story then
				local var_167_9 = 0.5

				arg_164_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1036ui_story.fillRatio = var_167_9
			end

			local var_167_10 = arg_164_1.actors_["1036ui_story"].transform
			local var_167_11 = 0

			if var_167_11 < arg_164_1.time_ and arg_164_1.time_ <= var_167_11 + arg_167_0 then
				arg_164_1.var_.moveOldPos1036ui_story = var_167_10.localPosition
			end

			local var_167_12 = 0.001

			if var_167_11 <= arg_164_1.time_ and arg_164_1.time_ < var_167_11 + var_167_12 then
				local var_167_13 = (arg_164_1.time_ - var_167_11) / var_167_12
				local var_167_14 = Vector3.New(0, 100, 0)

				var_167_10.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1036ui_story, var_167_14, var_167_13)

				local var_167_15 = manager.ui.mainCamera.transform.position - var_167_10.position

				var_167_10.forward = Vector3.New(var_167_15.x, var_167_15.y, var_167_15.z)

				local var_167_16 = var_167_10.localEulerAngles

				var_167_16.z = 0
				var_167_16.x = 0
				var_167_10.localEulerAngles = var_167_16
			end

			if arg_164_1.time_ >= var_167_11 + var_167_12 and arg_164_1.time_ < var_167_11 + var_167_12 + arg_167_0 then
				var_167_10.localPosition = Vector3.New(0, 100, 0)

				local var_167_17 = manager.ui.mainCamera.transform.position - var_167_10.position

				var_167_10.forward = Vector3.New(var_167_17.x, var_167_17.y, var_167_17.z)

				local var_167_18 = var_167_10.localEulerAngles

				var_167_18.z = 0
				var_167_18.x = 0
				var_167_10.localEulerAngles = var_167_18
			end

			local var_167_19 = arg_164_1.actors_["1037ui_story"].transform
			local var_167_20 = 0

			if var_167_20 < arg_164_1.time_ and arg_164_1.time_ <= var_167_20 + arg_167_0 then
				arg_164_1.var_.moveOldPos1037ui_story = var_167_19.localPosition
			end

			local var_167_21 = 0.001

			if var_167_20 <= arg_164_1.time_ and arg_164_1.time_ < var_167_20 + var_167_21 then
				local var_167_22 = (arg_164_1.time_ - var_167_20) / var_167_21
				local var_167_23 = Vector3.New(0, 100, 0)

				var_167_19.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1037ui_story, var_167_23, var_167_22)

				local var_167_24 = manager.ui.mainCamera.transform.position - var_167_19.position

				var_167_19.forward = Vector3.New(var_167_24.x, var_167_24.y, var_167_24.z)

				local var_167_25 = var_167_19.localEulerAngles

				var_167_25.z = 0
				var_167_25.x = 0
				var_167_19.localEulerAngles = var_167_25
			end

			if arg_164_1.time_ >= var_167_20 + var_167_21 and arg_164_1.time_ < var_167_20 + var_167_21 + arg_167_0 then
				var_167_19.localPosition = Vector3.New(0, 100, 0)

				local var_167_26 = manager.ui.mainCamera.transform.position - var_167_19.position

				var_167_19.forward = Vector3.New(var_167_26.x, var_167_26.y, var_167_26.z)

				local var_167_27 = var_167_19.localEulerAngles

				var_167_27.z = 0
				var_167_27.x = 0
				var_167_19.localEulerAngles = var_167_27
			end

			local var_167_28 = 0
			local var_167_29 = 0.275

			if var_167_28 < arg_164_1.time_ and arg_164_1.time_ <= var_167_28 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_30 = arg_164_1:FormatText(StoryNameCfg[15].name)

				arg_164_1.leftNameTxt_.text = var_167_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_31 = arg_164_1:GetWordFromCfg(101011041)
				local var_167_32 = arg_164_1:FormatText(var_167_31.content)

				arg_164_1.text_.text = var_167_32

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_33 = 11
				local var_167_34 = utf8.len(var_167_32)
				local var_167_35 = var_167_33 <= 0 and var_167_29 or var_167_29 * (var_167_34 / var_167_33)

				if var_167_35 > 0 and var_167_29 < var_167_35 then
					arg_164_1.talkMaxDuration = var_167_35

					if var_167_35 + var_167_28 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_35 + var_167_28
					end
				end

				arg_164_1.text_.text = var_167_32
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011041", "story_v_out_101011.awb") ~= 0 then
					local var_167_36 = manager.audio:GetVoiceLength("story_v_out_101011", "101011041", "story_v_out_101011.awb") / 1000

					if var_167_36 + var_167_28 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_36 + var_167_28
					end

					if var_167_31.prefab_name ~= "" and arg_164_1.actors_[var_167_31.prefab_name] ~= nil then
						local var_167_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_31.prefab_name].transform, "story_v_out_101011", "101011041", "story_v_out_101011.awb")

						arg_164_1:RecordAudio("101011041", var_167_37)
						arg_164_1:RecordAudio("101011041", var_167_37)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_101011", "101011041", "story_v_out_101011.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_101011", "101011041", "story_v_out_101011.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_38 = math.max(var_167_29, arg_164_1.talkMaxDuration)

			if var_167_28 <= arg_164_1.time_ and arg_164_1.time_ < var_167_28 + var_167_38 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_28) / var_167_38

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_28 + var_167_38 and arg_164_1.time_ < var_167_28 + var_167_38 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
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
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play101011042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 101011042
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play101011043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 0.525

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_2 = arg_168_1:GetWordFromCfg(101011042)
				local var_171_3 = arg_168_1:FormatText(var_171_2.content)

				arg_168_1.text_.text = var_171_3

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 21
				local var_171_5 = utf8.len(var_171_3)
				local var_171_6 = var_171_4 <= 0 and var_171_1 or var_171_1 * (var_171_5 / var_171_4)

				if var_171_6 > 0 and var_171_1 < var_171_6 then
					arg_168_1.talkMaxDuration = var_171_6

					if var_171_6 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_6 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_3
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_7 and arg_168_1.time_ < var_171_0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play101011043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 101011043
		arg_172_1.duration_ = 5.47

		local var_172_0 = {
			ja = 5.261999999999,
			ko = 5.261999999999,
			zh = 5.466,
			en = 5.261999999999
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play101011044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1037ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1037ui_story == nil then
				arg_172_1.var_.characterEffect1037ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.1

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1037ui_story and not isNil(var_175_0) then
					arg_172_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1037ui_story then
				arg_172_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_175_4 = arg_172_1.actors_["1037ui_story"].transform
			local var_175_5 = 0

			if var_175_5 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 then
				arg_172_1.var_.moveOldPos1037ui_story = var_175_4.localPosition
			end

			local var_175_6 = 0.001

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_6 then
				local var_175_7 = (arg_172_1.time_ - var_175_5) / var_175_6
				local var_175_8 = Vector3.New(0, -1.09, -5.81)

				var_175_4.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1037ui_story, var_175_8, var_175_7)

				local var_175_9 = manager.ui.mainCamera.transform.position - var_175_4.position

				var_175_4.forward = Vector3.New(var_175_9.x, var_175_9.y, var_175_9.z)

				local var_175_10 = var_175_4.localEulerAngles

				var_175_10.z = 0
				var_175_10.x = 0
				var_175_4.localEulerAngles = var_175_10
			end

			if arg_172_1.time_ >= var_175_5 + var_175_6 and arg_172_1.time_ < var_175_5 + var_175_6 + arg_175_0 then
				var_175_4.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_175_11 = manager.ui.mainCamera.transform.position - var_175_4.position

				var_175_4.forward = Vector3.New(var_175_11.x, var_175_11.y, var_175_11.z)

				local var_175_12 = var_175_4.localEulerAngles

				var_175_12.z = 0
				var_175_12.x = 0
				var_175_4.localEulerAngles = var_175_12
			end

			local var_175_13 = 0

			if var_175_13 < arg_172_1.time_ and arg_172_1.time_ <= var_175_13 + arg_175_0 then
				arg_172_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_175_14 = 0

			if var_175_14 < arg_172_1.time_ and arg_172_1.time_ <= var_175_14 + arg_175_0 then
				arg_172_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_175_15 = 0
			local var_175_16 = 0.4

			if var_175_15 < arg_172_1.time_ and arg_172_1.time_ <= var_175_15 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_17 = arg_172_1:FormatText(StoryNameCfg[15].name)

				arg_172_1.leftNameTxt_.text = var_175_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_18 = arg_172_1:GetWordFromCfg(101011043)
				local var_175_19 = arg_172_1:FormatText(var_175_18.content)

				arg_172_1.text_.text = var_175_19

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_20 = 16
				local var_175_21 = utf8.len(var_175_19)
				local var_175_22 = var_175_20 <= 0 and var_175_16 or var_175_16 * (var_175_21 / var_175_20)

				if var_175_22 > 0 and var_175_16 < var_175_22 then
					arg_172_1.talkMaxDuration = var_175_22

					if var_175_22 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_22 + var_175_15
					end
				end

				arg_172_1.text_.text = var_175_19
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011043", "story_v_out_101011.awb") ~= 0 then
					local var_175_23 = manager.audio:GetVoiceLength("story_v_out_101011", "101011043", "story_v_out_101011.awb") / 1000

					if var_175_23 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_23 + var_175_15
					end

					if var_175_18.prefab_name ~= "" and arg_172_1.actors_[var_175_18.prefab_name] ~= nil then
						local var_175_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_18.prefab_name].transform, "story_v_out_101011", "101011043", "story_v_out_101011.awb")

						arg_172_1:RecordAudio("101011043", var_175_24)
						arg_172_1:RecordAudio("101011043", var_175_24)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_101011", "101011043", "story_v_out_101011.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_101011", "101011043", "story_v_out_101011.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_25 = math.max(var_175_16, arg_172_1.talkMaxDuration)

			if var_175_15 <= arg_172_1.time_ and arg_172_1.time_ < var_175_15 + var_175_25 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_15) / var_175_25

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_15 + var_175_25 and arg_172_1.time_ < var_175_15 + var_175_25 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play101011044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 101011044
		arg_176_1.duration_ = 3.27

		local var_176_0 = {
			ja = 2.733,
			ko = 3.033,
			zh = 2.833,
			en = 3.266
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play101011045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1036ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1036ui_story == nil then
				arg_176_1.var_.characterEffect1036ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.1

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1036ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1036ui_story then
				arg_176_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_179_4 = arg_176_1.actors_["1037ui_story"]
			local var_179_5 = 0

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 and not isNil(var_179_4) and arg_176_1.var_.characterEffect1037ui_story == nil then
				arg_176_1.var_.characterEffect1037ui_story = var_179_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_6 = 0.1

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_6 and not isNil(var_179_4) then
				local var_179_7 = (arg_176_1.time_ - var_179_5) / var_179_6

				if arg_176_1.var_.characterEffect1037ui_story and not isNil(var_179_4) then
					local var_179_8 = Mathf.Lerp(0, 0.5, var_179_7)

					arg_176_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1037ui_story.fillRatio = var_179_8
				end
			end

			if arg_176_1.time_ >= var_179_5 + var_179_6 and arg_176_1.time_ < var_179_5 + var_179_6 + arg_179_0 and not isNil(var_179_4) and arg_176_1.var_.characterEffect1037ui_story then
				local var_179_9 = 0.5

				arg_176_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1037ui_story.fillRatio = var_179_9
			end

			local var_179_10 = arg_176_1.actors_["1037ui_story"].transform
			local var_179_11 = 0

			if var_179_11 < arg_176_1.time_ and arg_176_1.time_ <= var_179_11 + arg_179_0 then
				arg_176_1.var_.moveOldPos1037ui_story = var_179_10.localPosition
			end

			local var_179_12 = 0.001

			if var_179_11 <= arg_176_1.time_ and arg_176_1.time_ < var_179_11 + var_179_12 then
				local var_179_13 = (arg_176_1.time_ - var_179_11) / var_179_12
				local var_179_14 = Vector3.New(-0.7, -1.09, -5.81)

				var_179_10.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1037ui_story, var_179_14, var_179_13)

				local var_179_15 = manager.ui.mainCamera.transform.position - var_179_10.position

				var_179_10.forward = Vector3.New(var_179_15.x, var_179_15.y, var_179_15.z)

				local var_179_16 = var_179_10.localEulerAngles

				var_179_16.z = 0
				var_179_16.x = 0
				var_179_10.localEulerAngles = var_179_16
			end

			if arg_176_1.time_ >= var_179_11 + var_179_12 and arg_176_1.time_ < var_179_11 + var_179_12 + arg_179_0 then
				var_179_10.localPosition = Vector3.New(-0.7, -1.09, -5.81)

				local var_179_17 = manager.ui.mainCamera.transform.position - var_179_10.position

				var_179_10.forward = Vector3.New(var_179_17.x, var_179_17.y, var_179_17.z)

				local var_179_18 = var_179_10.localEulerAngles

				var_179_18.z = 0
				var_179_18.x = 0
				var_179_10.localEulerAngles = var_179_18
			end

			local var_179_19 = arg_176_1.actors_["1036ui_story"].transform
			local var_179_20 = 0

			if var_179_20 < arg_176_1.time_ and arg_176_1.time_ <= var_179_20 + arg_179_0 then
				arg_176_1.var_.moveOldPos1036ui_story = var_179_19.localPosition
			end

			local var_179_21 = 0.001

			if var_179_20 <= arg_176_1.time_ and arg_176_1.time_ < var_179_20 + var_179_21 then
				local var_179_22 = (arg_176_1.time_ - var_179_20) / var_179_21
				local var_179_23 = Vector3.New(0.7, -1.09, -5.78)

				var_179_19.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1036ui_story, var_179_23, var_179_22)

				local var_179_24 = manager.ui.mainCamera.transform.position - var_179_19.position

				var_179_19.forward = Vector3.New(var_179_24.x, var_179_24.y, var_179_24.z)

				local var_179_25 = var_179_19.localEulerAngles

				var_179_25.z = 0
				var_179_25.x = 0
				var_179_19.localEulerAngles = var_179_25
			end

			if arg_176_1.time_ >= var_179_20 + var_179_21 and arg_176_1.time_ < var_179_20 + var_179_21 + arg_179_0 then
				var_179_19.localPosition = Vector3.New(0.7, -1.09, -5.78)

				local var_179_26 = manager.ui.mainCamera.transform.position - var_179_19.position

				var_179_19.forward = Vector3.New(var_179_26.x, var_179_26.y, var_179_26.z)

				local var_179_27 = var_179_19.localEulerAngles

				var_179_27.z = 0
				var_179_27.x = 0
				var_179_19.localEulerAngles = var_179_27
			end

			local var_179_28 = 0

			if var_179_28 < arg_176_1.time_ and arg_176_1.time_ <= var_179_28 + arg_179_0 then
				arg_176_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action1_1")
			end

			local var_179_29 = 0

			if var_179_29 < arg_176_1.time_ and arg_176_1.time_ <= var_179_29 + arg_179_0 then
				arg_176_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_179_30 = 0
			local var_179_31 = 0.225

			if var_179_30 < arg_176_1.time_ and arg_176_1.time_ <= var_179_30 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_32 = arg_176_1:FormatText(StoryNameCfg[5].name)

				arg_176_1.leftNameTxt_.text = var_179_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_33 = arg_176_1:GetWordFromCfg(101011044)
				local var_179_34 = arg_176_1:FormatText(var_179_33.content)

				arg_176_1.text_.text = var_179_34

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_35 = 9
				local var_179_36 = utf8.len(var_179_34)
				local var_179_37 = var_179_35 <= 0 and var_179_31 or var_179_31 * (var_179_36 / var_179_35)

				if var_179_37 > 0 and var_179_31 < var_179_37 then
					arg_176_1.talkMaxDuration = var_179_37

					if var_179_37 + var_179_30 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_37 + var_179_30
					end
				end

				arg_176_1.text_.text = var_179_34
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011044", "story_v_out_101011.awb") ~= 0 then
					local var_179_38 = manager.audio:GetVoiceLength("story_v_out_101011", "101011044", "story_v_out_101011.awb") / 1000

					if var_179_38 + var_179_30 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_38 + var_179_30
					end

					if var_179_33.prefab_name ~= "" and arg_176_1.actors_[var_179_33.prefab_name] ~= nil then
						local var_179_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_33.prefab_name].transform, "story_v_out_101011", "101011044", "story_v_out_101011.awb")

						arg_176_1:RecordAudio("101011044", var_179_39)
						arg_176_1:RecordAudio("101011044", var_179_39)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_101011", "101011044", "story_v_out_101011.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_101011", "101011044", "story_v_out_101011.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_40 = math.max(var_179_31, arg_176_1.talkMaxDuration)

			if var_179_30 <= arg_176_1.time_ and arg_176_1.time_ < var_179_30 + var_179_40 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_30) / var_179_40

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_30 + var_179_40 and arg_176_1.time_ < var_179_30 + var_179_40 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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

		arg_176_1:InitPlayNodeList()
	end,
	Play101011045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 101011045
		arg_180_1.duration_ = 10.93

		local var_180_0 = {
			ja = 10.933,
			ko = 6.333,
			zh = 6.033,
			en = 6.833
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play101011046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1037ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1037ui_story == nil then
				arg_180_1.var_.characterEffect1037ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.1

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1037ui_story and not isNil(var_183_0) then
					arg_180_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1037ui_story then
				arg_180_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_183_4 = arg_180_1.actors_["1036ui_story"]
			local var_183_5 = 0

			if var_183_5 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 and not isNil(var_183_4) and arg_180_1.var_.characterEffect1036ui_story == nil then
				arg_180_1.var_.characterEffect1036ui_story = var_183_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_6 = 0.1

			if var_183_5 <= arg_180_1.time_ and arg_180_1.time_ < var_183_5 + var_183_6 and not isNil(var_183_4) then
				local var_183_7 = (arg_180_1.time_ - var_183_5) / var_183_6

				if arg_180_1.var_.characterEffect1036ui_story and not isNil(var_183_4) then
					local var_183_8 = Mathf.Lerp(0, 0.5, var_183_7)

					arg_180_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1036ui_story.fillRatio = var_183_8
				end
			end

			if arg_180_1.time_ >= var_183_5 + var_183_6 and arg_180_1.time_ < var_183_5 + var_183_6 + arg_183_0 and not isNil(var_183_4) and arg_180_1.var_.characterEffect1036ui_story then
				local var_183_9 = 0.5

				arg_180_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1036ui_story.fillRatio = var_183_9
			end

			local var_183_10 = 0

			if var_183_10 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 then
				arg_180_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_183_11 = 0

			if var_183_11 < arg_180_1.time_ and arg_180_1.time_ <= var_183_11 + arg_183_0 then
				arg_180_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_183_12 = 0
			local var_183_13 = 0.7

			if var_183_12 < arg_180_1.time_ and arg_180_1.time_ <= var_183_12 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_14 = arg_180_1:FormatText(StoryNameCfg[15].name)

				arg_180_1.leftNameTxt_.text = var_183_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_15 = arg_180_1:GetWordFromCfg(101011045)
				local var_183_16 = arg_180_1:FormatText(var_183_15.content)

				arg_180_1.text_.text = var_183_16

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_17 = 28
				local var_183_18 = utf8.len(var_183_16)
				local var_183_19 = var_183_17 <= 0 and var_183_13 or var_183_13 * (var_183_18 / var_183_17)

				if var_183_19 > 0 and var_183_13 < var_183_19 then
					arg_180_1.talkMaxDuration = var_183_19

					if var_183_19 + var_183_12 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_19 + var_183_12
					end
				end

				arg_180_1.text_.text = var_183_16
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011045", "story_v_out_101011.awb") ~= 0 then
					local var_183_20 = manager.audio:GetVoiceLength("story_v_out_101011", "101011045", "story_v_out_101011.awb") / 1000

					if var_183_20 + var_183_12 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_20 + var_183_12
					end

					if var_183_15.prefab_name ~= "" and arg_180_1.actors_[var_183_15.prefab_name] ~= nil then
						local var_183_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_15.prefab_name].transform, "story_v_out_101011", "101011045", "story_v_out_101011.awb")

						arg_180_1:RecordAudio("101011045", var_183_21)
						arg_180_1:RecordAudio("101011045", var_183_21)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_101011", "101011045", "story_v_out_101011.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_101011", "101011045", "story_v_out_101011.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_22 = math.max(var_183_13, arg_180_1.talkMaxDuration)

			if var_183_12 <= arg_180_1.time_ and arg_180_1.time_ < var_183_12 + var_183_22 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_12) / var_183_22

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_12 + var_183_22 and arg_180_1.time_ < var_183_12 + var_183_22 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play101011046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 101011046
		arg_184_1.duration_ = 1.53

		local var_184_0 = {
			ja = 0.999999999999,
			ko = 1.233,
			zh = 1.033,
			en = 1.533
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play101011047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1036ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1036ui_story == nil then
				arg_184_1.var_.characterEffect1036ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.1

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1036ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1036ui_story then
				arg_184_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_187_4 = arg_184_1.actors_["1037ui_story"]
			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 and not isNil(var_187_4) and arg_184_1.var_.characterEffect1037ui_story == nil then
				arg_184_1.var_.characterEffect1037ui_story = var_187_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_6 = 0.1

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_6 and not isNil(var_187_4) then
				local var_187_7 = (arg_184_1.time_ - var_187_5) / var_187_6

				if arg_184_1.var_.characterEffect1037ui_story and not isNil(var_187_4) then
					local var_187_8 = Mathf.Lerp(0, 0.5, var_187_7)

					arg_184_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1037ui_story.fillRatio = var_187_8
				end
			end

			if arg_184_1.time_ >= var_187_5 + var_187_6 and arg_184_1.time_ < var_187_5 + var_187_6 + arg_187_0 and not isNil(var_187_4) and arg_184_1.var_.characterEffect1037ui_story then
				local var_187_9 = 0.5

				arg_184_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1037ui_story.fillRatio = var_187_9
			end

			local var_187_10 = 0

			if var_187_10 < arg_184_1.time_ and arg_184_1.time_ <= var_187_10 + arg_187_0 then
				arg_184_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_187_11 = 0
			local var_187_12 = 0.1

			if var_187_11 < arg_184_1.time_ and arg_184_1.time_ <= var_187_11 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_13 = arg_184_1:FormatText(StoryNameCfg[5].name)

				arg_184_1.leftNameTxt_.text = var_187_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_14 = arg_184_1:GetWordFromCfg(101011046)
				local var_187_15 = arg_184_1:FormatText(var_187_14.content)

				arg_184_1.text_.text = var_187_15

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_16 = 4
				local var_187_17 = utf8.len(var_187_15)
				local var_187_18 = var_187_16 <= 0 and var_187_12 or var_187_12 * (var_187_17 / var_187_16)

				if var_187_18 > 0 and var_187_12 < var_187_18 then
					arg_184_1.talkMaxDuration = var_187_18

					if var_187_18 + var_187_11 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_18 + var_187_11
					end
				end

				arg_184_1.text_.text = var_187_15
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011046", "story_v_out_101011.awb") ~= 0 then
					local var_187_19 = manager.audio:GetVoiceLength("story_v_out_101011", "101011046", "story_v_out_101011.awb") / 1000

					if var_187_19 + var_187_11 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_19 + var_187_11
					end

					if var_187_14.prefab_name ~= "" and arg_184_1.actors_[var_187_14.prefab_name] ~= nil then
						local var_187_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_14.prefab_name].transform, "story_v_out_101011", "101011046", "story_v_out_101011.awb")

						arg_184_1:RecordAudio("101011046", var_187_20)
						arg_184_1:RecordAudio("101011046", var_187_20)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_101011", "101011046", "story_v_out_101011.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_101011", "101011046", "story_v_out_101011.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_21 = math.max(var_187_12, arg_184_1.talkMaxDuration)

			if var_187_11 <= arg_184_1.time_ and arg_184_1.time_ < var_187_11 + var_187_21 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_11) / var_187_21

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_11 + var_187_21 and arg_184_1.time_ < var_187_11 + var_187_21 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play101011047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 101011047
		arg_188_1.duration_ = 8.93

		local var_188_0 = {
			ja = 8.933,
			ko = 5.7,
			zh = 5.1,
			en = 4.577999999999
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play101011048(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action6_1")
			end

			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_191_2 = 0
			local var_191_3 = 0.525

			if var_191_2 < arg_188_1.time_ and arg_188_1.time_ <= var_191_2 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_4 = arg_188_1:FormatText(StoryNameCfg[5].name)

				arg_188_1.leftNameTxt_.text = var_191_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_5 = arg_188_1:GetWordFromCfg(101011047)
				local var_191_6 = arg_188_1:FormatText(var_191_5.content)

				arg_188_1.text_.text = var_191_6

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_7 = 20
				local var_191_8 = utf8.len(var_191_6)
				local var_191_9 = var_191_7 <= 0 and var_191_3 or var_191_3 * (var_191_8 / var_191_7)

				if var_191_9 > 0 and var_191_3 < var_191_9 then
					arg_188_1.talkMaxDuration = var_191_9

					if var_191_9 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_9 + var_191_2
					end
				end

				arg_188_1.text_.text = var_191_6
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011047", "story_v_out_101011.awb") ~= 0 then
					local var_191_10 = manager.audio:GetVoiceLength("story_v_out_101011", "101011047", "story_v_out_101011.awb") / 1000

					if var_191_10 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_10 + var_191_2
					end

					if var_191_5.prefab_name ~= "" and arg_188_1.actors_[var_191_5.prefab_name] ~= nil then
						local var_191_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_5.prefab_name].transform, "story_v_out_101011", "101011047", "story_v_out_101011.awb")

						arg_188_1:RecordAudio("101011047", var_191_11)
						arg_188_1:RecordAudio("101011047", var_191_11)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_101011", "101011047", "story_v_out_101011.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_101011", "101011047", "story_v_out_101011.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_12 = math.max(var_191_3, arg_188_1.talkMaxDuration)

			if var_191_2 <= arg_188_1.time_ and arg_188_1.time_ < var_191_2 + var_191_12 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_2) / var_191_12

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_2 + var_191_12 and arg_188_1.time_ < var_191_2 + var_191_12 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play101011048 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 101011048
		arg_192_1.duration_ = 4

		local var_192_0 = {
			ja = 4,
			ko = 2.733,
			zh = 2.2,
			en = 2.6
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
			arg_192_1.auto_ = false
		end

		function arg_192_1.playNext_(arg_194_0)
			arg_192_1.onStoryFinished_()
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1037ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1037ui_story == nil then
				arg_192_1.var_.characterEffect1037ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.1

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect1037ui_story and not isNil(var_195_0) then
					arg_192_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1037ui_story then
				arg_192_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_195_4 = arg_192_1.actors_["1036ui_story"]
			local var_195_5 = 0

			if var_195_5 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect1036ui_story == nil then
				arg_192_1.var_.characterEffect1036ui_story = var_195_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_6 = 0.1

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_6 and not isNil(var_195_4) then
				local var_195_7 = (arg_192_1.time_ - var_195_5) / var_195_6

				if arg_192_1.var_.characterEffect1036ui_story and not isNil(var_195_4) then
					local var_195_8 = Mathf.Lerp(0, 0.5, var_195_7)

					arg_192_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1036ui_story.fillRatio = var_195_8
				end
			end

			if arg_192_1.time_ >= var_195_5 + var_195_6 and arg_192_1.time_ < var_195_5 + var_195_6 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect1036ui_story then
				local var_195_9 = 0.5

				arg_192_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1036ui_story.fillRatio = var_195_9
			end

			local var_195_10 = 0

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 then
				arg_192_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action423")
			end

			local var_195_11 = 0

			if var_195_11 < arg_192_1.time_ and arg_192_1.time_ <= var_195_11 + arg_195_0 then
				arg_192_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_195_12 = 0
			local var_195_13 = 0.175

			if var_195_12 < arg_192_1.time_ and arg_192_1.time_ <= var_195_12 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_14 = arg_192_1:FormatText(StoryNameCfg[15].name)

				arg_192_1.leftNameTxt_.text = var_195_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_15 = arg_192_1:GetWordFromCfg(101011048)
				local var_195_16 = arg_192_1:FormatText(var_195_15.content)

				arg_192_1.text_.text = var_195_16

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_17 = 7
				local var_195_18 = utf8.len(var_195_16)
				local var_195_19 = var_195_17 <= 0 and var_195_13 or var_195_13 * (var_195_18 / var_195_17)

				if var_195_19 > 0 and var_195_13 < var_195_19 then
					arg_192_1.talkMaxDuration = var_195_19

					if var_195_19 + var_195_12 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_19 + var_195_12
					end
				end

				arg_192_1.text_.text = var_195_16
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101011", "101011048", "story_v_out_101011.awb") ~= 0 then
					local var_195_20 = manager.audio:GetVoiceLength("story_v_out_101011", "101011048", "story_v_out_101011.awb") / 1000

					if var_195_20 + var_195_12 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_20 + var_195_12
					end

					if var_195_15.prefab_name ~= "" and arg_192_1.actors_[var_195_15.prefab_name] ~= nil then
						local var_195_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_15.prefab_name].transform, "story_v_out_101011", "101011048", "story_v_out_101011.awb")

						arg_192_1:RecordAudio("101011048", var_195_21)
						arg_192_1:RecordAudio("101011048", var_195_21)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_101011", "101011048", "story_v_out_101011.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_101011", "101011048", "story_v_out_101011.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_22 = math.max(var_195_13, arg_192_1.talkMaxDuration)

			if var_195_12 <= arg_192_1.time_ and arg_192_1.time_ < var_195_12 + var_195_22 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_12) / var_195_22

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_12 + var_195_22 and arg_192_1.time_ < var_195_12 + var_195_22 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D02a"
	},
	voices = {
		"story_v_out_101011.awb"
	}
}
