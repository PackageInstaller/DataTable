return {
	Play325111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325111001
		arg_1_1.duration_ = 7.23

		local var_1_0 = {
			zh = 5.265999999999,
			ja = 7.232999999999
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
				arg_1_0:Play325111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST41"

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
				local var_4_5 = arg_1_1.bgs_.ST41

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
					if iter_4_0 ~= "ST41" then
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

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan")

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

			local var_4_34 = 1.499999999999
			local var_4_35 = 0.5

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[1527].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(325111001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 20
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111001", "story_v_out_325111.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_325111", "325111001", "story_v_out_325111.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_325111", "325111001", "story_v_out_325111.awb")

						arg_1_1:RecordAudio("325111001", var_4_44)
						arg_1_1:RecordAudio("325111001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325111", "325111001", "story_v_out_325111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325111", "325111001", "story_v_out_325111.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_34 + 0.3
			local var_4_46 = math.max(var_4_35, arg_1_1.talkMaxDuration)

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
	Play325111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325111002
		arg_8_1.duration_ = 2

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325111003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1075ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1075ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos1075ui_story = var_11_5.localPosition
			end

			local var_11_7 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7
				local var_11_9 = Vector3.New(0, -1.055, -6.16)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1075ui_story, var_11_9, var_11_8)

				local var_11_10 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_10.x, var_11_10.y, var_11_10.z)

				local var_11_11 = var_11_5.localEulerAngles

				var_11_11.z = 0
				var_11_11.x = 0
				var_11_5.localEulerAngles = var_11_11
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_11_12 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_12.x, var_11_12.y, var_11_12.z)

				local var_11_13 = var_11_5.localEulerAngles

				var_11_13.z = 0
				var_11_13.x = 0
				var_11_5.localEulerAngles = var_11_13
			end

			local var_11_14 = arg_8_1.actors_["1075ui_story"]
			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect1075ui_story == nil then
				arg_8_1.var_.characterEffect1075ui_story = var_11_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_16 = 0.200000002980232

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_16 and not isNil(var_11_14) then
				local var_11_17 = (arg_8_1.time_ - var_11_15) / var_11_16

				if arg_8_1.var_.characterEffect1075ui_story and not isNil(var_11_14) then
					arg_8_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_15 + var_11_16 and arg_8_1.time_ < var_11_15 + var_11_16 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect1075ui_story then
				arg_8_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_11_18 = 0

			if var_11_18 < arg_8_1.time_ and arg_8_1.time_ <= var_11_18 + arg_11_0 then
				arg_8_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_11_19 = 0

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_11_20 = 0
			local var_11_21 = 0.175

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_22 = arg_8_1:FormatText(StoryNameCfg[381].name)

				arg_8_1.leftNameTxt_.text = var_11_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_23 = arg_8_1:GetWordFromCfg(325111002)
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

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111002", "story_v_out_325111.awb") ~= 0 then
					local var_11_28 = manager.audio:GetVoiceLength("story_v_out_325111", "325111002", "story_v_out_325111.awb") / 1000

					if var_11_28 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_20
					end

					if var_11_23.prefab_name ~= "" and arg_8_1.actors_[var_11_23.prefab_name] ~= nil then
						local var_11_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_23.prefab_name].transform, "story_v_out_325111", "325111002", "story_v_out_325111.awb")

						arg_8_1:RecordAudio("325111002", var_11_29)
						arg_8_1:RecordAudio("325111002", var_11_29)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_325111", "325111002", "story_v_out_325111.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_325111", "325111002", "story_v_out_325111.awb")
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
				actorName = "1075ui_story",
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
	Play325111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325111003
		arg_12_1.duration_ = 8.73

		local var_12_0 = {
			zh = 6.6,
			ja = 8.733
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
				arg_12_0:Play325111004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1075ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1075ui_story == nil then
				arg_12_1.var_.characterEffect1075ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1075ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1075ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1075ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1075ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 0.95

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[1527].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_9 = arg_12_1:GetWordFromCfg(325111003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 38
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111003", "story_v_out_325111.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_325111", "325111003", "story_v_out_325111.awb") / 1000

					if var_15_14 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_6
					end

					if var_15_9.prefab_name ~= "" and arg_12_1.actors_[var_15_9.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_9.prefab_name].transform, "story_v_out_325111", "325111003", "story_v_out_325111.awb")

						arg_12_1:RecordAudio("325111003", var_15_15)
						arg_12_1:RecordAudio("325111003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325111", "325111003", "story_v_out_325111.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325111", "325111003", "story_v_out_325111.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_16 and arg_12_1.time_ < var_15_6 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325111004
		arg_16_1.duration_ = 7.77

		local var_16_0 = {
			zh = 3.866,
			ja = 7.766
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
				arg_16_0:Play325111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1075ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1075ui_story == nil then
				arg_16_1.var_.characterEffect1075ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1075ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1075ui_story then
				arg_16_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_19_4 = 0
			local var_19_5 = 0.525

			if var_19_4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_6 = arg_16_1:FormatText(StoryNameCfg[381].name)

				arg_16_1.leftNameTxt_.text = var_19_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_7 = arg_16_1:GetWordFromCfg(325111004)
				local var_19_8 = arg_16_1:FormatText(var_19_7.content)

				arg_16_1.text_.text = var_19_8

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 21
				local var_19_10 = utf8.len(var_19_8)
				local var_19_11 = var_19_9 <= 0 and var_19_5 or var_19_5 * (var_19_10 / var_19_9)

				if var_19_11 > 0 and var_19_5 < var_19_11 then
					arg_16_1.talkMaxDuration = var_19_11

					if var_19_11 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_11 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_8
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111004", "story_v_out_325111.awb") ~= 0 then
					local var_19_12 = manager.audio:GetVoiceLength("story_v_out_325111", "325111004", "story_v_out_325111.awb") / 1000

					if var_19_12 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_4
					end

					if var_19_7.prefab_name ~= "" and arg_16_1.actors_[var_19_7.prefab_name] ~= nil then
						local var_19_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_7.prefab_name].transform, "story_v_out_325111", "325111004", "story_v_out_325111.awb")

						arg_16_1:RecordAudio("325111004", var_19_13)
						arg_16_1:RecordAudio("325111004", var_19_13)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325111", "325111004", "story_v_out_325111.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325111", "325111004", "story_v_out_325111.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_14 and arg_16_1.time_ < var_19_4 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play325111005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325111005
		arg_20_1.duration_ = 6.57

		local var_20_0 = {
			zh = 4.6,
			ja = 6.566
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
				arg_20_0:Play325111006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1075ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1075ui_story == nil then
				arg_20_1.var_.characterEffect1075ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1075ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1075ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1075ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1075ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.525

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[1527].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_9 = arg_20_1:GetWordFromCfg(325111005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 21
				local var_23_12 = utf8.len(var_23_10)
				local var_23_13 = var_23_11 <= 0 and var_23_7 or var_23_7 * (var_23_12 / var_23_11)

				if var_23_13 > 0 and var_23_7 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111005", "story_v_out_325111.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_325111", "325111005", "story_v_out_325111.awb") / 1000

					if var_23_14 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_6
					end

					if var_23_9.prefab_name ~= "" and arg_20_1.actors_[var_23_9.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_9.prefab_name].transform, "story_v_out_325111", "325111005", "story_v_out_325111.awb")

						arg_20_1:RecordAudio("325111005", var_23_15)
						arg_20_1:RecordAudio("325111005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325111", "325111005", "story_v_out_325111.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325111", "325111005", "story_v_out_325111.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_16 and arg_20_1.time_ < var_23_6 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325111006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325111006
		arg_24_1.duration_ = 3.93

		local var_24_0 = {
			zh = 1.999999999999,
			ja = 3.933
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
				arg_24_0:Play325111007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1075ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1075ui_story == nil then
				arg_24_1.var_.characterEffect1075ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1075ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1075ui_story then
				arg_24_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_27_4 = 0

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_27_5 = 0
			local var_27_6 = 0.125

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_7 = arg_24_1:FormatText(StoryNameCfg[381].name)

				arg_24_1.leftNameTxt_.text = var_27_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_8 = arg_24_1:GetWordFromCfg(325111006)
				local var_27_9 = arg_24_1:FormatText(var_27_8.content)

				arg_24_1.text_.text = var_27_9

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_10 = 5
				local var_27_11 = utf8.len(var_27_9)
				local var_27_12 = var_27_10 <= 0 and var_27_6 or var_27_6 * (var_27_11 / var_27_10)

				if var_27_12 > 0 and var_27_6 < var_27_12 then
					arg_24_1.talkMaxDuration = var_27_12

					if var_27_12 + var_27_5 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_5
					end
				end

				arg_24_1.text_.text = var_27_9
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111006", "story_v_out_325111.awb") ~= 0 then
					local var_27_13 = manager.audio:GetVoiceLength("story_v_out_325111", "325111006", "story_v_out_325111.awb") / 1000

					if var_27_13 + var_27_5 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_5
					end

					if var_27_8.prefab_name ~= "" and arg_24_1.actors_[var_27_8.prefab_name] ~= nil then
						local var_27_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_8.prefab_name].transform, "story_v_out_325111", "325111006", "story_v_out_325111.awb")

						arg_24_1:RecordAudio("325111006", var_27_14)
						arg_24_1:RecordAudio("325111006", var_27_14)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325111", "325111006", "story_v_out_325111.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325111", "325111006", "story_v_out_325111.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_15 = math.max(var_27_6, arg_24_1.talkMaxDuration)

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_15 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_5) / var_27_15

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_5 + var_27_15 and arg_24_1.time_ < var_27_5 + var_27_15 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325111007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325111007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325111008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1075ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos1075ui_story = var_31_0.localPosition
			end

			local var_31_2 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2
				local var_31_4 = Vector3.New(0, 100, 0)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1075ui_story, var_31_4, var_31_3)

				local var_31_5 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_5.x, var_31_5.y, var_31_5.z)

				local var_31_6 = var_31_0.localEulerAngles

				var_31_6.z = 0
				var_31_6.x = 0
				var_31_0.localEulerAngles = var_31_6
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0, 100, 0)

				local var_31_7 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_7.x, var_31_7.y, var_31_7.z)

				local var_31_8 = var_31_0.localEulerAngles

				var_31_8.z = 0
				var_31_8.x = 0
				var_31_0.localEulerAngles = var_31_8
			end

			local var_31_9 = arg_28_1.actors_["1075ui_story"]
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1075ui_story == nil then
				arg_28_1.var_.characterEffect1075ui_story = var_31_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_11 = 0.200000002980232

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 and not isNil(var_31_9) then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11

				if arg_28_1.var_.characterEffect1075ui_story and not isNil(var_31_9) then
					local var_31_13 = Mathf.Lerp(0, 0.5, var_31_12)

					arg_28_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1075ui_story.fillRatio = var_31_13
				end
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1075ui_story then
				local var_31_14 = 0.5

				arg_28_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1075ui_story.fillRatio = var_31_14
			end

			local var_31_15 = 0
			local var_31_16 = 0.75

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_17 = arg_28_1:GetWordFromCfg(325111007)
				local var_31_18 = arg_28_1:FormatText(var_31_17.content)

				arg_28_1.text_.text = var_31_18

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_19 = 30
				local var_31_20 = utf8.len(var_31_18)
				local var_31_21 = var_31_19 <= 0 and var_31_16 or var_31_16 * (var_31_20 / var_31_19)

				if var_31_21 > 0 and var_31_16 < var_31_21 then
					arg_28_1.talkMaxDuration = var_31_21

					if var_31_21 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_21 + var_31_15
					end
				end

				arg_28_1.text_.text = var_31_18
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_22 = math.max(var_31_16, arg_28_1.talkMaxDuration)

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_22 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_15) / var_31_22

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_15 + var_31_22 and arg_28_1.time_ < var_31_15 + var_31_22 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play325111008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325111008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325111009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.1
			local var_35_1 = 1

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				local var_35_2 = "play"
				local var_35_3 = "effect"

				arg_32_1:AudioAction(var_35_2, var_35_3, "se_story_145", "se_story_145_amb_battle_phone", "")
			end

			local var_35_4 = 0
			local var_35_5 = 1.325

			if var_35_4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(325111008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_8 = 53
				local var_35_9 = utf8.len(var_35_7)
				local var_35_10 = var_35_8 <= 0 and var_35_5 or var_35_5 * (var_35_9 / var_35_8)

				if var_35_10 > 0 and var_35_5 < var_35_10 then
					arg_32_1.talkMaxDuration = var_35_10

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_11 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_11 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_11

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_11 and arg_32_1.time_ < var_35_4 + var_35_11 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325111009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325111009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325111010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.1
			local var_39_1 = 1

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				local var_39_2 = "stop"
				local var_39_3 = "effect"

				arg_36_1:AudioAction(var_39_2, var_39_3, "se_story_145", "se_story_145_amb_battle_phone", "")
			end

			local var_39_4 = 0
			local var_39_5 = 1.175

			if var_39_4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(325111009)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_8 = 47
				local var_39_9 = utf8.len(var_39_7)
				local var_39_10 = var_39_8 <= 0 and var_39_5 or var_39_5 * (var_39_9 / var_39_8)

				if var_39_10 > 0 and var_39_5 < var_39_10 then
					arg_36_1.talkMaxDuration = var_39_10

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_11 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_11 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_11

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_11 and arg_36_1.time_ < var_39_4 + var_39_11 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play325111010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325111010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325111011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.675

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_2 = arg_40_1:GetWordFromCfg(325111010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 27
				local var_43_5 = utf8.len(var_43_3)
				local var_43_6 = var_43_4 <= 0 and var_43_1 or var_43_1 * (var_43_5 / var_43_4)

				if var_43_6 > 0 and var_43_1 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_7 and arg_40_1.time_ < var_43_0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325111011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325111011
		arg_44_1.duration_ = 2.13

		local var_44_0 = {
			zh = 2.133,
			ja = 1.999999999999
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
				arg_44_0:Play325111012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1075ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1075ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, -1.055, -6.16)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1075ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["1075ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1075ui_story == nil then
				arg_44_1.var_.characterEffect1075ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect1075ui_story and not isNil(var_47_9) then
					arg_44_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1075ui_story then
				arg_44_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_47_13 = 0

			if var_47_13 < arg_44_1.time_ and arg_44_1.time_ <= var_47_13 + arg_47_0 then
				arg_44_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_47_14 = 0

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_47_15 = 0
			local var_47_16 = 1

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				local var_47_17 = "play"
				local var_47_18 = "effect"

				arg_44_1:AudioAction(var_47_17, var_47_18, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_47_19 = 0
			local var_47_20 = 0.1

			if var_47_19 < arg_44_1.time_ and arg_44_1.time_ <= var_47_19 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_21 = arg_44_1:FormatText(StoryNameCfg[381].name)

				arg_44_1.leftNameTxt_.text = var_47_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_22 = arg_44_1:GetWordFromCfg(325111011)
				local var_47_23 = arg_44_1:FormatText(var_47_22.content)

				arg_44_1.text_.text = var_47_23

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_24 = 4
				local var_47_25 = utf8.len(var_47_23)
				local var_47_26 = var_47_24 <= 0 and var_47_20 or var_47_20 * (var_47_25 / var_47_24)

				if var_47_26 > 0 and var_47_20 < var_47_26 then
					arg_44_1.talkMaxDuration = var_47_26

					if var_47_26 + var_47_19 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_26 + var_47_19
					end
				end

				arg_44_1.text_.text = var_47_23
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111011", "story_v_out_325111.awb") ~= 0 then
					local var_47_27 = manager.audio:GetVoiceLength("story_v_out_325111", "325111011", "story_v_out_325111.awb") / 1000

					if var_47_27 + var_47_19 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_27 + var_47_19
					end

					if var_47_22.prefab_name ~= "" and arg_44_1.actors_[var_47_22.prefab_name] ~= nil then
						local var_47_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_22.prefab_name].transform, "story_v_out_325111", "325111011", "story_v_out_325111.awb")

						arg_44_1:RecordAudio("325111011", var_47_28)
						arg_44_1:RecordAudio("325111011", var_47_28)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325111", "325111011", "story_v_out_325111.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325111", "325111011", "story_v_out_325111.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_29 = math.max(var_47_20, arg_44_1.talkMaxDuration)

			if var_47_19 <= arg_44_1.time_ and arg_44_1.time_ < var_47_19 + var_47_29 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_19) / var_47_29

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_19 + var_47_29 and arg_44_1.time_ < var_47_19 + var_47_29 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play325111012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325111012
		arg_48_1.duration_ = 6.24

		local var_48_0 = {
			zh = 5.24166666666667,
			ja = 6.24166666666667
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
				arg_48_0:Play325111013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = "J23g"

			if arg_48_1.bgs_[var_51_0] == nil then
				local var_51_1 = Object.Instantiate(arg_48_1.paintGo_)

				var_51_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_51_0)
				var_51_1.name = var_51_0
				var_51_1.transform.parent = arg_48_1.stage_.transform
				var_51_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.bgs_[var_51_0] = var_51_1
			end

			local var_51_2 = 1.56666666666667

			if var_51_2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				local var_51_3 = manager.ui.mainCamera.transform.localPosition
				local var_51_4 = Vector3.New(0, 0, 10) + Vector3.New(var_51_3.x, var_51_3.y, 0)
				local var_51_5 = arg_48_1.bgs_.J23g

				var_51_5.transform.localPosition = var_51_4
				var_51_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_51_6 = var_51_5:GetComponent("SpriteRenderer")

				if var_51_6 and var_51_6.sprite then
					local var_51_7 = (var_51_5.transform.localPosition - var_51_3).z
					local var_51_8 = manager.ui.mainCameraCom_
					local var_51_9 = 2 * var_51_7 * Mathf.Tan(var_51_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_51_10 = var_51_9 * var_51_8.aspect
					local var_51_11 = var_51_6.sprite.bounds.size.x
					local var_51_12 = var_51_6.sprite.bounds.size.y
					local var_51_13 = var_51_10 / var_51_11
					local var_51_14 = var_51_9 / var_51_12
					local var_51_15 = var_51_14 < var_51_13 and var_51_13 or var_51_14

					var_51_5.transform.localScale = Vector3.New(var_51_15, var_51_15, 0)
				end

				for iter_51_0, iter_51_1 in pairs(arg_48_1.bgs_) do
					if iter_51_0 ~= "J23g" then
						iter_51_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_51_16 = 0

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				arg_48_1.allBtn_.enabled = false
			end

			local var_51_17 = 0.3

			if arg_48_1.time_ >= var_51_16 + var_51_17 and arg_48_1.time_ < var_51_16 + var_51_17 + arg_51_0 then
				arg_48_1.allBtn_.enabled = true
			end

			local var_51_18 = 0

			if var_51_18 < arg_48_1.time_ and arg_48_1.time_ <= var_51_18 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_19 = 1.56666666666667

			if var_51_18 <= arg_48_1.time_ and arg_48_1.time_ < var_51_18 + var_51_19 then
				local var_51_20 = (arg_48_1.time_ - var_51_18) / var_51_19
				local var_51_21 = Color.New(0, 0, 0)

				var_51_21.a = Mathf.Lerp(0, 1, var_51_20)
				arg_48_1.mask_.color = var_51_21
			end

			if arg_48_1.time_ >= var_51_18 + var_51_19 and arg_48_1.time_ < var_51_18 + var_51_19 + arg_51_0 then
				local var_51_22 = Color.New(0, 0, 0)

				var_51_22.a = 1
				arg_48_1.mask_.color = var_51_22
			end

			local var_51_23 = 1.56666666666667

			if var_51_23 < arg_48_1.time_ and arg_48_1.time_ <= var_51_23 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_24 = 1.56666666666533

			if var_51_23 <= arg_48_1.time_ and arg_48_1.time_ < var_51_23 + var_51_24 then
				local var_51_25 = (arg_48_1.time_ - var_51_23) / var_51_24
				local var_51_26 = Color.New(0, 0, 0)

				var_51_26.a = Mathf.Lerp(1, 0, var_51_25)
				arg_48_1.mask_.color = var_51_26
			end

			if arg_48_1.time_ >= var_51_23 + var_51_24 and arg_48_1.time_ < var_51_23 + var_51_24 + arg_51_0 then
				local var_51_27 = Color.New(0, 0, 0)
				local var_51_28 = 0

				arg_48_1.mask_.enabled = false
				var_51_27.a = var_51_28
				arg_48_1.mask_.color = var_51_27
			end

			local var_51_29 = arg_48_1.actors_["1075ui_story"].transform
			local var_51_30 = 1.56666666666667

			if var_51_30 < arg_48_1.time_ and arg_48_1.time_ <= var_51_30 + arg_51_0 then
				arg_48_1.var_.moveOldPos1075ui_story = var_51_29.localPosition
			end

			local var_51_31 = 0.001

			if var_51_30 <= arg_48_1.time_ and arg_48_1.time_ < var_51_30 + var_51_31 then
				local var_51_32 = (arg_48_1.time_ - var_51_30) / var_51_31
				local var_51_33 = Vector3.New(0, 100, 0)

				var_51_29.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1075ui_story, var_51_33, var_51_32)

				local var_51_34 = manager.ui.mainCamera.transform.position - var_51_29.position

				var_51_29.forward = Vector3.New(var_51_34.x, var_51_34.y, var_51_34.z)

				local var_51_35 = var_51_29.localEulerAngles

				var_51_35.z = 0
				var_51_35.x = 0
				var_51_29.localEulerAngles = var_51_35
			end

			if arg_48_1.time_ >= var_51_30 + var_51_31 and arg_48_1.time_ < var_51_30 + var_51_31 + arg_51_0 then
				var_51_29.localPosition = Vector3.New(0, 100, 0)

				local var_51_36 = manager.ui.mainCamera.transform.position - var_51_29.position

				var_51_29.forward = Vector3.New(var_51_36.x, var_51_36.y, var_51_36.z)

				local var_51_37 = var_51_29.localEulerAngles

				var_51_37.z = 0
				var_51_37.x = 0
				var_51_29.localEulerAngles = var_51_37
			end

			local var_51_38 = "1077ui_story"

			if arg_48_1.actors_[var_51_38] == nil then
				local var_51_39 = Asset.Load("Char/" .. "1077ui_story")

				if not isNil(var_51_39) then
					local var_51_40 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_48_1.stage_.transform)

					var_51_40.name = var_51_38
					var_51_40.transform.localPosition = Vector3.New(0, 100, 0)
					arg_48_1.actors_[var_51_38] = var_51_40

					local var_51_41 = var_51_40:GetComponentInChildren(typeof(CharacterEffect))

					var_51_41.enabled = true

					local var_51_42 = GameObjectTools.GetOrAddComponent(var_51_40, typeof(DynamicBoneHelper))

					if var_51_42 then
						var_51_42:EnableDynamicBone(false)
					end

					arg_48_1:ShowWeapon(var_51_41.transform, false)

					arg_48_1.var_[var_51_38 .. "Animator"] = var_51_41.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_48_1.var_[var_51_38 .. "Animator"].applyRootMotion = true
					arg_48_1.var_[var_51_38 .. "LipSync"] = var_51_41.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_51_43 = arg_48_1.actors_["1077ui_story"].transform
			local var_51_44 = 2.96666666666667

			if var_51_44 < arg_48_1.time_ and arg_48_1.time_ <= var_51_44 + arg_51_0 then
				arg_48_1.var_.moveOldPos1077ui_story = var_51_43.localPosition

				local var_51_45 = GameObjectTools.GetOrAddComponent(var_51_43.gameObject, typeof(DynamicBoneHelper))

				if var_51_45 then
					var_51_45:EnableDynamicBone(false)
				end
			end

			local var_51_46 = 0.001

			if var_51_44 <= arg_48_1.time_ and arg_48_1.time_ < var_51_44 + var_51_46 then
				local var_51_47 = (arg_48_1.time_ - var_51_44) / var_51_46
				local var_51_48 = Vector3.New(-0.03, -1.02, -5.92)

				var_51_43.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1077ui_story, var_51_48, var_51_47)

				local var_51_49 = manager.ui.mainCamera.transform.position - var_51_43.position

				var_51_43.forward = Vector3.New(var_51_49.x, var_51_49.y, var_51_49.z)

				local var_51_50 = var_51_43.localEulerAngles

				var_51_50.z = 0
				var_51_50.x = 0
				var_51_43.localEulerAngles = var_51_50
			end

			if arg_48_1.time_ >= var_51_44 + var_51_46 and arg_48_1.time_ < var_51_44 + var_51_46 + arg_51_0 then
				var_51_43.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_51_51 = manager.ui.mainCamera.transform.position - var_51_43.position

				var_51_43.forward = Vector3.New(var_51_51.x, var_51_51.y, var_51_51.z)

				local var_51_52 = var_51_43.localEulerAngles

				var_51_52.z = 0
				var_51_52.x = 0
				var_51_43.localEulerAngles = var_51_52

				local var_51_53 = GameObjectTools.GetOrAddComponent(var_51_43.gameObject, typeof(DynamicBoneHelper))

				if var_51_53 then
					var_51_53:EnableDynamicBone(true)
				end
			end

			local var_51_54 = arg_48_1.actors_["1077ui_story"]
			local var_51_55 = 2.96666666666667

			if var_51_55 < arg_48_1.time_ and arg_48_1.time_ <= var_51_55 + arg_51_0 and not isNil(var_51_54) and arg_48_1.var_.characterEffect1077ui_story == nil then
				arg_48_1.var_.characterEffect1077ui_story = var_51_54:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_56 = 0.200000002980232

			if var_51_55 <= arg_48_1.time_ and arg_48_1.time_ < var_51_55 + var_51_56 and not isNil(var_51_54) then
				local var_51_57 = (arg_48_1.time_ - var_51_55) / var_51_56

				if arg_48_1.var_.characterEffect1077ui_story and not isNil(var_51_54) then
					arg_48_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_55 + var_51_56 and arg_48_1.time_ < var_51_55 + var_51_56 + arg_51_0 and not isNil(var_51_54) and arg_48_1.var_.characterEffect1077ui_story then
				arg_48_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_51_58 = arg_48_1.actors_["1075ui_story"]
			local var_51_59 = 1.56666666666667

			if var_51_59 < arg_48_1.time_ and arg_48_1.time_ <= var_51_59 + arg_51_0 and not isNil(var_51_58) and arg_48_1.var_.characterEffect1075ui_story == nil then
				arg_48_1.var_.characterEffect1075ui_story = var_51_58:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_60 = 0.200000002980232

			if var_51_59 <= arg_48_1.time_ and arg_48_1.time_ < var_51_59 + var_51_60 and not isNil(var_51_58) then
				local var_51_61 = (arg_48_1.time_ - var_51_59) / var_51_60

				if arg_48_1.var_.characterEffect1075ui_story and not isNil(var_51_58) then
					local var_51_62 = Mathf.Lerp(0, 0.5, var_51_61)

					arg_48_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1075ui_story.fillRatio = var_51_62
				end
			end

			if arg_48_1.time_ >= var_51_59 + var_51_60 and arg_48_1.time_ < var_51_59 + var_51_60 + arg_51_0 and not isNil(var_51_58) and arg_48_1.var_.characterEffect1075ui_story then
				local var_51_63 = 0.5

				arg_48_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1075ui_story.fillRatio = var_51_63
			end

			local var_51_64 = 2.96666666666667

			if var_51_64 < arg_48_1.time_ and arg_48_1.time_ <= var_51_64 + arg_51_0 then
				arg_48_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_51_65 = 2.96666666666667

			if var_51_65 < arg_48_1.time_ and arg_48_1.time_ <= var_51_65 + arg_51_0 then
				arg_48_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_51_66 = 1.2
			local var_51_67 = 1

			if var_51_66 < arg_48_1.time_ and arg_48_1.time_ <= var_51_66 + arg_51_0 then
				local var_51_68 = "play"
				local var_51_69 = "effect"

				arg_48_1:AudioAction(var_51_68, var_51_69, "se_story_148", "se_story_148_amb_workshop", "")
			end

			local var_51_70 = 0.1
			local var_51_71 = 1

			if var_51_70 < arg_48_1.time_ and arg_48_1.time_ <= var_51_70 + arg_51_0 then
				local var_51_72 = "stop"
				local var_51_73 = "effect"

				arg_48_1:AudioAction(var_51_72, var_51_73, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			local var_51_74 = 0
			local var_51_75 = 1

			if var_51_74 < arg_48_1.time_ and arg_48_1.time_ <= var_51_74 + arg_51_0 then
				local var_51_76 = "play"
				local var_51_77 = "music"

				arg_48_1:AudioAction(var_51_76, var_51_77, "bgm_activity_5_1_story_zhujianlu", "bgm_activity_5_1_story_zhujianlu", "bgm_activity_5_1_story_zhujianlu.awb")

				local var_51_78 = ""
				local var_51_79 = manager.audio:GetAudioName("bgm_activity_5_1_story_zhujianlu", "bgm_activity_5_1_story_zhujianlu")

				if var_51_79 ~= "" then
					if arg_48_1.bgmTxt_.text ~= var_51_79 and arg_48_1.bgmTxt_.text ~= "" then
						if arg_48_1.bgmTxt2_.text ~= "" then
							arg_48_1.bgmTxt_.text = arg_48_1.bgmTxt2_.text
						end

						arg_48_1.bgmTxt2_.text = var_51_79

						arg_48_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_48_1.bgmTxt_.text = var_51_79
						arg_48_1.bgmTxt2_.text = var_51_79
					end

					if arg_48_1.bgmTimer then
						arg_48_1.bgmTimer:Stop()

						arg_48_1.bgmTimer = nil
					end

					if arg_48_1.settingData.show_music_name == 1 then
						arg_48_1.musicController:SetSelectedState("show")
						arg_48_1.musicAnimator_:Play("open", 0, 0)

						if arg_48_1.settingData.music_time ~= 0 then
							arg_48_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_48_1.settingData.music_time), function()
								if arg_48_1 == nil or isNil(arg_48_1.bgmTxt_) then
									return
								end

								arg_48_1.musicController:SetSelectedState("hide")
								arg_48_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_48_1.frameCnt_ <= 1 then
				arg_48_1.dialog_:SetActive(false)
			end

			local var_51_80 = 3.34166666666667
			local var_51_81 = 0.225

			if var_51_80 < arg_48_1.time_ and arg_48_1.time_ <= var_51_80 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0

				arg_48_1.dialog_:SetActive(true)

				arg_48_1.dialogCg_.alpha = 0

				local var_51_82 = LeanTween.value(arg_48_1.dialog_, 0, 1, 0.3)

				var_51_82:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_48_1.dialogCg_.alpha = arg_53_0
				end))
				var_51_82:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_48_1.dialog_)
					var_51_82:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_48_1.duration_ = arg_48_1.duration_ + 0.3

				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_83 = arg_48_1:FormatText(StoryNameCfg[1467].name)

				arg_48_1.leftNameTxt_.text = var_51_83

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_84 = arg_48_1:GetWordFromCfg(325111012)
				local var_51_85 = arg_48_1:FormatText(var_51_84.content)

				arg_48_1.text_.text = var_51_85

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_86 = 9
				local var_51_87 = utf8.len(var_51_85)
				local var_51_88 = var_51_86 <= 0 and var_51_81 or var_51_81 * (var_51_87 / var_51_86)

				if var_51_88 > 0 and var_51_81 < var_51_88 then
					arg_48_1.talkMaxDuration = var_51_88
					var_51_80 = var_51_80 + 0.3

					if var_51_88 + var_51_80 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_88 + var_51_80
					end
				end

				arg_48_1.text_.text = var_51_85
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111012", "story_v_out_325111.awb") ~= 0 then
					local var_51_89 = manager.audio:GetVoiceLength("story_v_out_325111", "325111012", "story_v_out_325111.awb") / 1000

					if var_51_89 + var_51_80 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_89 + var_51_80
					end

					if var_51_84.prefab_name ~= "" and arg_48_1.actors_[var_51_84.prefab_name] ~= nil then
						local var_51_90 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_84.prefab_name].transform, "story_v_out_325111", "325111012", "story_v_out_325111.awb")

						arg_48_1:RecordAudio("325111012", var_51_90)
						arg_48_1:RecordAudio("325111012", var_51_90)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325111", "325111012", "story_v_out_325111.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325111", "325111012", "story_v_out_325111.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_91 = var_51_80 + 0.3
			local var_51_92 = math.max(var_51_81, arg_48_1.talkMaxDuration)

			if var_51_91 <= arg_48_1.time_ and arg_48_1.time_ < var_51_91 + var_51_92 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_91) / var_51_92

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_91 + var_51_92 and arg_48_1.time_ < var_51_91 + var_51_92 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play325111013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 325111013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play325111014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1077ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1077ui_story = var_58_0.localPosition

				local var_58_2 = GameObjectTools.GetOrAddComponent(var_58_0.gameObject, typeof(DynamicBoneHelper))

				if var_58_2 then
					var_58_2:EnableDynamicBone(false)
				end
			end

			local var_58_3 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_3 then
				local var_58_4 = (arg_55_1.time_ - var_58_1) / var_58_3
				local var_58_5 = Vector3.New(0, 100, 0)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1077ui_story, var_58_5, var_58_4)

				local var_58_6 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_6.x, var_58_6.y, var_58_6.z)

				local var_58_7 = var_58_0.localEulerAngles

				var_58_7.z = 0
				var_58_7.x = 0
				var_58_0.localEulerAngles = var_58_7
			end

			if arg_55_1.time_ >= var_58_1 + var_58_3 and arg_55_1.time_ < var_58_1 + var_58_3 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, 100, 0)

				local var_58_8 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_8.x, var_58_8.y, var_58_8.z)

				local var_58_9 = var_58_0.localEulerAngles

				var_58_9.z = 0
				var_58_9.x = 0
				var_58_0.localEulerAngles = var_58_9

				local var_58_10 = GameObjectTools.GetOrAddComponent(var_58_0.gameObject, typeof(DynamicBoneHelper))

				if var_58_10 then
					var_58_10:EnableDynamicBone(true)
				end
			end

			local var_58_11 = arg_55_1.actors_["1077ui_story"]
			local var_58_12 = 0

			if var_58_12 < arg_55_1.time_ and arg_55_1.time_ <= var_58_12 + arg_58_0 and not isNil(var_58_11) and arg_55_1.var_.characterEffect1077ui_story == nil then
				arg_55_1.var_.characterEffect1077ui_story = var_58_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_13 = 0.200000002980232

			if var_58_12 <= arg_55_1.time_ and arg_55_1.time_ < var_58_12 + var_58_13 and not isNil(var_58_11) then
				local var_58_14 = (arg_55_1.time_ - var_58_12) / var_58_13

				if arg_55_1.var_.characterEffect1077ui_story and not isNil(var_58_11) then
					local var_58_15 = Mathf.Lerp(0, 0.5, var_58_14)

					arg_55_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1077ui_story.fillRatio = var_58_15
				end
			end

			if arg_55_1.time_ >= var_58_12 + var_58_13 and arg_55_1.time_ < var_58_12 + var_58_13 + arg_58_0 and not isNil(var_58_11) and arg_55_1.var_.characterEffect1077ui_story then
				local var_58_16 = 0.5

				arg_55_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1077ui_story.fillRatio = var_58_16
			end

			local var_58_17 = 1
			local var_58_18 = 1

			if var_58_17 < arg_55_1.time_ and arg_55_1.time_ <= var_58_17 + arg_58_0 then
				local var_58_19 = "play"
				local var_58_20 = "effect"

				arg_55_1:AudioAction(var_58_19, var_58_20, "se_story_151", "se_story_151_footstep05", "")
			end

			local var_58_21 = 0
			local var_58_22 = 1.45

			if var_58_21 < arg_55_1.time_ and arg_55_1.time_ <= var_58_21 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_23 = arg_55_1:GetWordFromCfg(325111013)
				local var_58_24 = arg_55_1:FormatText(var_58_23.content)

				arg_55_1.text_.text = var_58_24

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_25 = 58
				local var_58_26 = utf8.len(var_58_24)
				local var_58_27 = var_58_25 <= 0 and var_58_22 or var_58_22 * (var_58_26 / var_58_25)

				if var_58_27 > 0 and var_58_22 < var_58_27 then
					arg_55_1.talkMaxDuration = var_58_27

					if var_58_27 + var_58_21 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_27 + var_58_21
					end
				end

				arg_55_1.text_.text = var_58_24
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_28 = math.max(var_58_22, arg_55_1.talkMaxDuration)

			if var_58_21 <= arg_55_1.time_ and arg_55_1.time_ < var_58_21 + var_58_28 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_21) / var_58_28

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_21 + var_58_28 and arg_55_1.time_ < var_58_21 + var_58_28 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play325111014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 325111014
		arg_59_1.duration_ = 7.93

		local var_59_0 = {
			zh = 6.466,
			ja = 7.933
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
				arg_59_0:Play325111015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = "J23h"

			if arg_59_1.bgs_[var_62_0] == nil then
				local var_62_1 = Object.Instantiate(arg_59_1.paintGo_)

				var_62_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_62_0)
				var_62_1.name = var_62_0
				var_62_1.transform.parent = arg_59_1.stage_.transform
				var_62_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.bgs_[var_62_0] = var_62_1
			end

			local var_62_2 = 1

			if var_62_2 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				local var_62_3 = manager.ui.mainCamera.transform.localPosition
				local var_62_4 = Vector3.New(0, 0, 10) + Vector3.New(var_62_3.x, var_62_3.y, 0)
				local var_62_5 = arg_59_1.bgs_.J23h

				var_62_5.transform.localPosition = var_62_4
				var_62_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_62_6 = var_62_5:GetComponent("SpriteRenderer")

				if var_62_6 and var_62_6.sprite then
					local var_62_7 = (var_62_5.transform.localPosition - var_62_3).z
					local var_62_8 = manager.ui.mainCameraCom_
					local var_62_9 = 2 * var_62_7 * Mathf.Tan(var_62_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_62_10 = var_62_9 * var_62_8.aspect
					local var_62_11 = var_62_6.sprite.bounds.size.x
					local var_62_12 = var_62_6.sprite.bounds.size.y
					local var_62_13 = var_62_10 / var_62_11
					local var_62_14 = var_62_9 / var_62_12
					local var_62_15 = var_62_14 < var_62_13 and var_62_13 or var_62_14

					var_62_5.transform.localScale = Vector3.New(var_62_15, var_62_15, 0)
				end

				for iter_62_0, iter_62_1 in pairs(arg_59_1.bgs_) do
					if iter_62_0 ~= "J23h" then
						iter_62_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_62_16 = 0

			if var_62_16 < arg_59_1.time_ and arg_59_1.time_ <= var_62_16 + arg_62_0 then
				arg_59_1.allBtn_.enabled = false
			end

			local var_62_17 = 0.3

			if arg_59_1.time_ >= var_62_16 + var_62_17 and arg_59_1.time_ < var_62_16 + var_62_17 + arg_62_0 then
				arg_59_1.allBtn_.enabled = true
			end

			local var_62_18 = 0

			if var_62_18 < arg_59_1.time_ and arg_59_1.time_ <= var_62_18 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_19 = 1

			if var_62_18 <= arg_59_1.time_ and arg_59_1.time_ < var_62_18 + var_62_19 then
				local var_62_20 = (arg_59_1.time_ - var_62_18) / var_62_19
				local var_62_21 = Color.New(0, 0, 0)

				var_62_21.a = Mathf.Lerp(0, 1, var_62_20)
				arg_59_1.mask_.color = var_62_21
			end

			if arg_59_1.time_ >= var_62_18 + var_62_19 and arg_59_1.time_ < var_62_18 + var_62_19 + arg_62_0 then
				local var_62_22 = Color.New(0, 0, 0)

				var_62_22.a = 1
				arg_59_1.mask_.color = var_62_22
			end

			local var_62_23 = 1

			if var_62_23 < arg_59_1.time_ and arg_59_1.time_ <= var_62_23 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_24 = 1.36666666666667

			if var_62_23 <= arg_59_1.time_ and arg_59_1.time_ < var_62_23 + var_62_24 then
				local var_62_25 = (arg_59_1.time_ - var_62_23) / var_62_24
				local var_62_26 = Color.New(0, 0, 0)

				var_62_26.a = Mathf.Lerp(1, 0, var_62_25)
				arg_59_1.mask_.color = var_62_26
			end

			if arg_59_1.time_ >= var_62_23 + var_62_24 and arg_59_1.time_ < var_62_23 + var_62_24 + arg_62_0 then
				local var_62_27 = Color.New(0, 0, 0)
				local var_62_28 = 0

				arg_59_1.mask_.enabled = false
				var_62_27.a = var_62_28
				arg_59_1.mask_.color = var_62_27
			end

			local var_62_29 = 1.2
			local var_62_30 = 1

			if var_62_29 < arg_59_1.time_ and arg_59_1.time_ <= var_62_29 + arg_62_0 then
				local var_62_31 = "play"
				local var_62_32 = "effect"

				arg_59_1:AudioAction(var_62_31, var_62_32, "se_story_148", "se_story_148_amb_drone02", "")
			end

			local var_62_33 = 0.1
			local var_62_34 = 1

			if var_62_33 < arg_59_1.time_ and arg_59_1.time_ <= var_62_33 + arg_62_0 then
				local var_62_35 = "stop"
				local var_62_36 = "effect"

				arg_59_1:AudioAction(var_62_35, var_62_36, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_59_1.frameCnt_ <= 1 then
				arg_59_1.dialog_:SetActive(false)
			end

			local var_62_37 = 2
			local var_62_38 = 0.6

			if var_62_37 < arg_59_1.time_ and arg_59_1.time_ <= var_62_37 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_39 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_39:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_40 = arg_59_1:FormatText(StoryNameCfg[1467].name)

				arg_59_1.leftNameTxt_.text = var_62_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_41 = arg_59_1:GetWordFromCfg(325111014)
				local var_62_42 = arg_59_1:FormatText(var_62_41.content)

				arg_59_1.text_.text = var_62_42

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_43 = 24
				local var_62_44 = utf8.len(var_62_42)
				local var_62_45 = var_62_43 <= 0 and var_62_38 or var_62_38 * (var_62_44 / var_62_43)

				if var_62_45 > 0 and var_62_38 < var_62_45 then
					arg_59_1.talkMaxDuration = var_62_45
					var_62_37 = var_62_37 + 0.3

					if var_62_45 + var_62_37 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_45 + var_62_37
					end
				end

				arg_59_1.text_.text = var_62_42
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111014", "story_v_out_325111.awb") ~= 0 then
					local var_62_46 = manager.audio:GetVoiceLength("story_v_out_325111", "325111014", "story_v_out_325111.awb") / 1000

					if var_62_46 + var_62_37 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_46 + var_62_37
					end

					if var_62_41.prefab_name ~= "" and arg_59_1.actors_[var_62_41.prefab_name] ~= nil then
						local var_62_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_41.prefab_name].transform, "story_v_out_325111", "325111014", "story_v_out_325111.awb")

						arg_59_1:RecordAudio("325111014", var_62_47)
						arg_59_1:RecordAudio("325111014", var_62_47)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_325111", "325111014", "story_v_out_325111.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_325111", "325111014", "story_v_out_325111.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_48 = var_62_37 + 0.3
			local var_62_49 = math.max(var_62_38, arg_59_1.talkMaxDuration)

			if var_62_48 <= arg_59_1.time_ and arg_59_1.time_ < var_62_48 + var_62_49 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_48) / var_62_49

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_48 + var_62_49 and arg_59_1.time_ < var_62_48 + var_62_49 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play325111015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 325111015
		arg_65_1.duration_ = 7.47

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play325111016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				local var_68_1 = manager.ui.mainCamera.transform.localPosition
				local var_68_2 = Vector3.New(0, 0, 10) + Vector3.New(var_68_1.x, var_68_1.y, 0)
				local var_68_3 = arg_65_1.bgs_.J23h

				var_68_3.transform.localPosition = var_68_2
				var_68_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_4 = var_68_3:GetComponent("SpriteRenderer")

				if var_68_4 and var_68_4.sprite then
					local var_68_5 = (var_68_3.transform.localPosition - var_68_1).z
					local var_68_6 = manager.ui.mainCameraCom_
					local var_68_7 = 2 * var_68_5 * Mathf.Tan(var_68_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_68_8 = var_68_7 * var_68_6.aspect
					local var_68_9 = var_68_4.sprite.bounds.size.x
					local var_68_10 = var_68_4.sprite.bounds.size.y
					local var_68_11 = var_68_8 / var_68_9
					local var_68_12 = var_68_7 / var_68_10
					local var_68_13 = var_68_12 < var_68_11 and var_68_11 or var_68_12

					var_68_3.transform.localScale = Vector3.New(var_68_13, var_68_13, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "J23h" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_14 = "ST2010"

			if arg_65_1.bgs_[var_68_14] == nil then
				local var_68_15 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_68_14)
				var_68_15.name = var_68_14
				var_68_15.transform.parent = arg_65_1.stage_.transform
				var_68_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_[var_68_14] = var_68_15
			end

			local var_68_16 = 1.025

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				local var_68_17 = manager.ui.mainCamera.transform.localPosition
				local var_68_18 = Vector3.New(0, 0, 10) + Vector3.New(var_68_17.x, var_68_17.y, 0)
				local var_68_19 = arg_65_1.bgs_.ST2010

				var_68_19.transform.localPosition = var_68_18
				var_68_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_20 = var_68_19:GetComponent("SpriteRenderer")

				if var_68_20 and var_68_20.sprite then
					local var_68_21 = (var_68_19.transform.localPosition - var_68_17).z
					local var_68_22 = manager.ui.mainCameraCom_
					local var_68_23 = 2 * var_68_21 * Mathf.Tan(var_68_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_68_24 = var_68_23 * var_68_22.aspect
					local var_68_25 = var_68_20.sprite.bounds.size.x
					local var_68_26 = var_68_20.sprite.bounds.size.y
					local var_68_27 = var_68_24 / var_68_25
					local var_68_28 = var_68_23 / var_68_26
					local var_68_29 = var_68_28 < var_68_27 and var_68_27 or var_68_28

					var_68_19.transform.localScale = Vector3.New(var_68_29, var_68_29, 0)
				end

				for iter_68_2, iter_68_3 in pairs(arg_65_1.bgs_) do
					if iter_68_2 ~= "ST2010" then
						iter_68_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_30 = 0

			if var_68_30 < arg_65_1.time_ and arg_65_1.time_ <= var_68_30 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			local var_68_31 = 0.3

			if arg_65_1.time_ >= var_68_30 + var_68_31 and arg_65_1.time_ < var_68_30 + var_68_31 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			local var_68_32 = manager.ui.mainCamera.transform
			local var_68_33 = 0.666666666666667

			if var_68_33 < arg_65_1.time_ and arg_65_1.time_ <= var_68_33 + arg_68_0 then
				local var_68_34 = arg_65_1.var_.effect132131
				local var_68_35
				local var_68_36 = var_68_32

				if not var_68_34 then
					var_68_34 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_68_36)
					var_68_34.name = "132131"
					arg_65_1.var_.effect132131 = var_68_34
				else
					var_68_34.transform:SetParent(var_68_36)
				end

				var_68_34.transform.localPosition = Vector3.New(0, 0, -0.91)
				var_68_34.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_68_37 = 1.7777777777777777
				local var_68_38 = Screen.width / Screen.height
				local var_68_39 = var_68_38 / var_68_37
				local var_68_40 = Mathf.Max(var_68_37 / var_68_38, 1)

				var_68_34.transform.localScale = Vector3.New(var_68_34.transform.localScale.x * var_68_39, var_68_34.transform.localScale.y * var_68_40, var_68_34.transform.localScale.z)
			end

			local var_68_41 = 1
			local var_68_42 = 1

			if var_68_41 < arg_65_1.time_ and arg_65_1.time_ <= var_68_41 + arg_68_0 then
				local var_68_43 = "play"
				local var_68_44 = "effect"

				arg_65_1:AudioAction(var_68_43, var_68_44, "se_story_151", "se_story_151_footstep05", "")
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_45 = 2.46666666666667
			local var_68_46 = 1.025

			if var_68_45 < arg_65_1.time_ and arg_65_1.time_ <= var_68_45 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_47 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_47:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_48 = arg_65_1:GetWordFromCfg(325111015)
				local var_68_49 = arg_65_1:FormatText(var_68_48.content)

				arg_65_1.text_.text = var_68_49

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_50 = 41
				local var_68_51 = utf8.len(var_68_49)
				local var_68_52 = var_68_50 <= 0 and var_68_46 or var_68_46 * (var_68_51 / var_68_50)

				if var_68_52 > 0 and var_68_46 < var_68_52 then
					arg_65_1.talkMaxDuration = var_68_52
					var_68_45 = var_68_45 + 0.3

					if var_68_52 + var_68_45 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_52 + var_68_45
					end
				end

				arg_65_1.text_.text = var_68_49
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_53 = var_68_45 + 0.3
			local var_68_54 = math.max(var_68_46, arg_65_1.talkMaxDuration)

			if var_68_53 <= arg_65_1.time_ and arg_65_1.time_ < var_68_53 + var_68_54 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_53) / var_68_54

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_53 + var_68_54 and arg_65_1.time_ < var_68_53 + var_68_54 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play325111016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 325111016
		arg_71_1.duration_ = 7.1

		local var_71_0 = {
			zh = 4.533,
			ja = 7.1
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play325111017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1077ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1077ui_story = var_74_0.localPosition

				local var_74_2 = GameObjectTools.GetOrAddComponent(var_74_0.gameObject, typeof(DynamicBoneHelper))

				if var_74_2 then
					var_74_2:EnableDynamicBone(false)
				end
			end

			local var_74_3 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_3 then
				local var_74_4 = (arg_71_1.time_ - var_74_1) / var_74_3
				local var_74_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1077ui_story, var_74_5, var_74_4)

				local var_74_6 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_6.x, var_74_6.y, var_74_6.z)

				local var_74_7 = var_74_0.localEulerAngles

				var_74_7.z = 0
				var_74_7.x = 0
				var_74_0.localEulerAngles = var_74_7
			end

			if arg_71_1.time_ >= var_74_1 + var_74_3 and arg_71_1.time_ < var_74_1 + var_74_3 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_74_8 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_8.x, var_74_8.y, var_74_8.z)

				local var_74_9 = var_74_0.localEulerAngles

				var_74_9.z = 0
				var_74_9.x = 0
				var_74_0.localEulerAngles = var_74_9

				local var_74_10 = GameObjectTools.GetOrAddComponent(var_74_0.gameObject, typeof(DynamicBoneHelper))

				if var_74_10 then
					var_74_10:EnableDynamicBone(true)
				end
			end

			local var_74_11 = arg_71_1.actors_["1077ui_story"]
			local var_74_12 = 0

			if var_74_12 < arg_71_1.time_ and arg_71_1.time_ <= var_74_12 + arg_74_0 and not isNil(var_74_11) and arg_71_1.var_.characterEffect1077ui_story == nil then
				arg_71_1.var_.characterEffect1077ui_story = var_74_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_13 = 0.200000002980232

			if var_74_12 <= arg_71_1.time_ and arg_71_1.time_ < var_74_12 + var_74_13 and not isNil(var_74_11) then
				local var_74_14 = (arg_71_1.time_ - var_74_12) / var_74_13

				if arg_71_1.var_.characterEffect1077ui_story and not isNil(var_74_11) then
					arg_71_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_12 + var_74_13 and arg_71_1.time_ < var_74_12 + var_74_13 + arg_74_0 and not isNil(var_74_11) and arg_71_1.var_.characterEffect1077ui_story then
				arg_71_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_74_15 = 0

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_74_16 = 0

			if var_74_16 < arg_71_1.time_ and arg_71_1.time_ <= var_74_16 + arg_74_0 then
				arg_71_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_74_17 = 0
			local var_74_18 = 0.5

			if var_74_17 < arg_71_1.time_ and arg_71_1.time_ <= var_74_17 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_19 = arg_71_1:FormatText(StoryNameCfg[1467].name)

				arg_71_1.leftNameTxt_.text = var_74_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_20 = arg_71_1:GetWordFromCfg(325111016)
				local var_74_21 = arg_71_1:FormatText(var_74_20.content)

				arg_71_1.text_.text = var_74_21

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_22 = 20
				local var_74_23 = utf8.len(var_74_21)
				local var_74_24 = var_74_22 <= 0 and var_74_18 or var_74_18 * (var_74_23 / var_74_22)

				if var_74_24 > 0 and var_74_18 < var_74_24 then
					arg_71_1.talkMaxDuration = var_74_24

					if var_74_24 + var_74_17 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_24 + var_74_17
					end
				end

				arg_71_1.text_.text = var_74_21
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111016", "story_v_out_325111.awb") ~= 0 then
					local var_74_25 = manager.audio:GetVoiceLength("story_v_out_325111", "325111016", "story_v_out_325111.awb") / 1000

					if var_74_25 + var_74_17 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_25 + var_74_17
					end

					if var_74_20.prefab_name ~= "" and arg_71_1.actors_[var_74_20.prefab_name] ~= nil then
						local var_74_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_20.prefab_name].transform, "story_v_out_325111", "325111016", "story_v_out_325111.awb")

						arg_71_1:RecordAudio("325111016", var_74_26)
						arg_71_1:RecordAudio("325111016", var_74_26)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_325111", "325111016", "story_v_out_325111.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_325111", "325111016", "story_v_out_325111.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_27 = math.max(var_74_18, arg_71_1.talkMaxDuration)

			if var_74_17 <= arg_71_1.time_ and arg_71_1.time_ < var_74_17 + var_74_27 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_17) / var_74_27

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_17 + var_74_27 and arg_71_1.time_ < var_74_17 + var_74_27 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325111017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 325111017
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play325111018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1077ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1077ui_story = var_78_0.localPosition

				local var_78_2 = GameObjectTools.GetOrAddComponent(var_78_0.gameObject, typeof(DynamicBoneHelper))

				if var_78_2 then
					var_78_2:EnableDynamicBone(false)
				end
			end

			local var_78_3 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_3 then
				local var_78_4 = (arg_75_1.time_ - var_78_1) / var_78_3
				local var_78_5 = Vector3.New(0, 100, 0)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1077ui_story, var_78_5, var_78_4)

				local var_78_6 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_6.x, var_78_6.y, var_78_6.z)

				local var_78_7 = var_78_0.localEulerAngles

				var_78_7.z = 0
				var_78_7.x = 0
				var_78_0.localEulerAngles = var_78_7
			end

			if arg_75_1.time_ >= var_78_1 + var_78_3 and arg_75_1.time_ < var_78_1 + var_78_3 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, 100, 0)

				local var_78_8 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_8.x, var_78_8.y, var_78_8.z)

				local var_78_9 = var_78_0.localEulerAngles

				var_78_9.z = 0
				var_78_9.x = 0
				var_78_0.localEulerAngles = var_78_9

				local var_78_10 = GameObjectTools.GetOrAddComponent(var_78_0.gameObject, typeof(DynamicBoneHelper))

				if var_78_10 then
					var_78_10:EnableDynamicBone(true)
				end
			end

			local var_78_11 = arg_75_1.actors_["1077ui_story"]
			local var_78_12 = 0

			if var_78_12 < arg_75_1.time_ and arg_75_1.time_ <= var_78_12 + arg_78_0 and not isNil(var_78_11) and arg_75_1.var_.characterEffect1077ui_story == nil then
				arg_75_1.var_.characterEffect1077ui_story = var_78_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_13 = 0.200000002980232

			if var_78_12 <= arg_75_1.time_ and arg_75_1.time_ < var_78_12 + var_78_13 and not isNil(var_78_11) then
				local var_78_14 = (arg_75_1.time_ - var_78_12) / var_78_13

				if arg_75_1.var_.characterEffect1077ui_story and not isNil(var_78_11) then
					local var_78_15 = Mathf.Lerp(0, 0.5, var_78_14)

					arg_75_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1077ui_story.fillRatio = var_78_15
				end
			end

			if arg_75_1.time_ >= var_78_12 + var_78_13 and arg_75_1.time_ < var_78_12 + var_78_13 + arg_78_0 and not isNil(var_78_11) and arg_75_1.var_.characterEffect1077ui_story then
				local var_78_16 = 0.5

				arg_75_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1077ui_story.fillRatio = var_78_16
			end

			local var_78_17 = 0
			local var_78_18 = 1.175

			if var_78_17 < arg_75_1.time_ and arg_75_1.time_ <= var_78_17 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_19 = arg_75_1:GetWordFromCfg(325111017)
				local var_78_20 = arg_75_1:FormatText(var_78_19.content)

				arg_75_1.text_.text = var_78_20

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_21 = 47
				local var_78_22 = utf8.len(var_78_20)
				local var_78_23 = var_78_21 <= 0 and var_78_18 or var_78_18 * (var_78_22 / var_78_21)

				if var_78_23 > 0 and var_78_18 < var_78_23 then
					arg_75_1.talkMaxDuration = var_78_23

					if var_78_23 + var_78_17 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_23 + var_78_17
					end
				end

				arg_75_1.text_.text = var_78_20
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_24 = math.max(var_78_18, arg_75_1.talkMaxDuration)

			if var_78_17 <= arg_75_1.time_ and arg_75_1.time_ < var_78_17 + var_78_24 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_17) / var_78_24

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_17 + var_78_24 and arg_75_1.time_ < var_78_17 + var_78_24 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play325111018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 325111018
		arg_79_1.duration_ = 4.6

		local var_79_0 = {
			zh = 2.8,
			ja = 4.6
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
				arg_79_0:Play325111019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1077ui_story"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos1077ui_story = var_82_0.localPosition

				local var_82_2 = GameObjectTools.GetOrAddComponent(var_82_0.gameObject, typeof(DynamicBoneHelper))

				if var_82_2 then
					var_82_2:EnableDynamicBone(false)
				end
			end

			local var_82_3 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_3 then
				local var_82_4 = (arg_79_1.time_ - var_82_1) / var_82_3
				local var_82_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1077ui_story, var_82_5, var_82_4)

				local var_82_6 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_6.x, var_82_6.y, var_82_6.z)

				local var_82_7 = var_82_0.localEulerAngles

				var_82_7.z = 0
				var_82_7.x = 0
				var_82_0.localEulerAngles = var_82_7
			end

			if arg_79_1.time_ >= var_82_1 + var_82_3 and arg_79_1.time_ < var_82_1 + var_82_3 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_82_8 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_8.x, var_82_8.y, var_82_8.z)

				local var_82_9 = var_82_0.localEulerAngles

				var_82_9.z = 0
				var_82_9.x = 0
				var_82_0.localEulerAngles = var_82_9

				local var_82_10 = GameObjectTools.GetOrAddComponent(var_82_0.gameObject, typeof(DynamicBoneHelper))

				if var_82_10 then
					var_82_10:EnableDynamicBone(true)
				end
			end

			local var_82_11 = arg_79_1.actors_["1077ui_story"]
			local var_82_12 = 0

			if var_82_12 < arg_79_1.time_ and arg_79_1.time_ <= var_82_12 + arg_82_0 and not isNil(var_82_11) and arg_79_1.var_.characterEffect1077ui_story == nil then
				arg_79_1.var_.characterEffect1077ui_story = var_82_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_13 = 0.200000002980232

			if var_82_12 <= arg_79_1.time_ and arg_79_1.time_ < var_82_12 + var_82_13 and not isNil(var_82_11) then
				local var_82_14 = (arg_79_1.time_ - var_82_12) / var_82_13

				if arg_79_1.var_.characterEffect1077ui_story and not isNil(var_82_11) then
					arg_79_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_12 + var_82_13 and arg_79_1.time_ < var_82_12 + var_82_13 + arg_82_0 and not isNil(var_82_11) and arg_79_1.var_.characterEffect1077ui_story then
				arg_79_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_82_15 = 0
			local var_82_16 = 0.4

			if var_82_15 < arg_79_1.time_ and arg_79_1.time_ <= var_82_15 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_17 = arg_79_1:FormatText(StoryNameCfg[1467].name)

				arg_79_1.leftNameTxt_.text = var_82_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_18 = arg_79_1:GetWordFromCfg(325111018)
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

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111018", "story_v_out_325111.awb") ~= 0 then
					local var_82_23 = manager.audio:GetVoiceLength("story_v_out_325111", "325111018", "story_v_out_325111.awb") / 1000

					if var_82_23 + var_82_15 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_23 + var_82_15
					end

					if var_82_18.prefab_name ~= "" and arg_79_1.actors_[var_82_18.prefab_name] ~= nil then
						local var_82_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_18.prefab_name].transform, "story_v_out_325111", "325111018", "story_v_out_325111.awb")

						arg_79_1:RecordAudio("325111018", var_82_24)
						arg_79_1:RecordAudio("325111018", var_82_24)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_325111", "325111018", "story_v_out_325111.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_325111", "325111018", "story_v_out_325111.awb")
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
				actorName = "1077ui_story",
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
	Play325111019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 325111019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play325111020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1077ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1077ui_story = var_86_0.localPosition

				local var_86_2 = GameObjectTools.GetOrAddComponent(var_86_0.gameObject, typeof(DynamicBoneHelper))

				if var_86_2 then
					var_86_2:EnableDynamicBone(false)
				end
			end

			local var_86_3 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_3 then
				local var_86_4 = (arg_83_1.time_ - var_86_1) / var_86_3
				local var_86_5 = Vector3.New(0, 100, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1077ui_story, var_86_5, var_86_4)

				local var_86_6 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_6.x, var_86_6.y, var_86_6.z)

				local var_86_7 = var_86_0.localEulerAngles

				var_86_7.z = 0
				var_86_7.x = 0
				var_86_0.localEulerAngles = var_86_7
			end

			if arg_83_1.time_ >= var_86_1 + var_86_3 and arg_83_1.time_ < var_86_1 + var_86_3 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, 100, 0)

				local var_86_8 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_8.x, var_86_8.y, var_86_8.z)

				local var_86_9 = var_86_0.localEulerAngles

				var_86_9.z = 0
				var_86_9.x = 0
				var_86_0.localEulerAngles = var_86_9

				local var_86_10 = GameObjectTools.GetOrAddComponent(var_86_0.gameObject, typeof(DynamicBoneHelper))

				if var_86_10 then
					var_86_10:EnableDynamicBone(true)
				end
			end

			local var_86_11 = arg_83_1.actors_["1077ui_story"]
			local var_86_12 = 0

			if var_86_12 < arg_83_1.time_ and arg_83_1.time_ <= var_86_12 + arg_86_0 and not isNil(var_86_11) and arg_83_1.var_.characterEffect1077ui_story == nil then
				arg_83_1.var_.characterEffect1077ui_story = var_86_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_13 = 0.200000002980232

			if var_86_12 <= arg_83_1.time_ and arg_83_1.time_ < var_86_12 + var_86_13 and not isNil(var_86_11) then
				local var_86_14 = (arg_83_1.time_ - var_86_12) / var_86_13

				if arg_83_1.var_.characterEffect1077ui_story and not isNil(var_86_11) then
					local var_86_15 = Mathf.Lerp(0, 0.5, var_86_14)

					arg_83_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1077ui_story.fillRatio = var_86_15
				end
			end

			if arg_83_1.time_ >= var_86_12 + var_86_13 and arg_83_1.time_ < var_86_12 + var_86_13 + arg_86_0 and not isNil(var_86_11) and arg_83_1.var_.characterEffect1077ui_story then
				local var_86_16 = 0.5

				arg_83_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1077ui_story.fillRatio = var_86_16
			end

			local var_86_17 = 1
			local var_86_18 = 1

			if var_86_17 < arg_83_1.time_ and arg_83_1.time_ <= var_86_17 + arg_86_0 then
				local var_86_19 = "play"
				local var_86_20 = "effect"

				arg_83_1:AudioAction(var_86_19, var_86_20, "se_story_activity_1_4_3", "se_story_activity_1_4_3_rock", "")
			end

			local var_86_21 = 0
			local var_86_22 = 1.275

			if var_86_21 < arg_83_1.time_ and arg_83_1.time_ <= var_86_21 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_23 = arg_83_1:GetWordFromCfg(325111019)
				local var_86_24 = arg_83_1:FormatText(var_86_23.content)

				arg_83_1.text_.text = var_86_24

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_25 = 51
				local var_86_26 = utf8.len(var_86_24)
				local var_86_27 = var_86_25 <= 0 and var_86_22 or var_86_22 * (var_86_26 / var_86_25)

				if var_86_27 > 0 and var_86_22 < var_86_27 then
					arg_83_1.talkMaxDuration = var_86_27

					if var_86_27 + var_86_21 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_27 + var_86_21
					end
				end

				arg_83_1.text_.text = var_86_24
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_28 = math.max(var_86_22, arg_83_1.talkMaxDuration)

			if var_86_21 <= arg_83_1.time_ and arg_83_1.time_ < var_86_21 + var_86_28 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_21) / var_86_28

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_21 + var_86_28 and arg_83_1.time_ < var_86_21 + var_86_28 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play325111020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 325111020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play325111021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 1.3

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

				local var_90_2 = arg_87_1:GetWordFromCfg(325111020)
				local var_90_3 = arg_87_1:FormatText(var_90_2.content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 52
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
	Play325111021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 325111021
		arg_91_1.duration_ = 11.13

		local var_91_0 = {
			zh = 7.366,
			ja = 11.133
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
				arg_91_0:Play325111022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1077ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1077ui_story = var_94_0.localPosition

				local var_94_2 = GameObjectTools.GetOrAddComponent(var_94_0.gameObject, typeof(DynamicBoneHelper))

				if var_94_2 then
					var_94_2:EnableDynamicBone(false)
				end
			end

			local var_94_3 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_3 then
				local var_94_4 = (arg_91_1.time_ - var_94_1) / var_94_3
				local var_94_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1077ui_story, var_94_5, var_94_4)

				local var_94_6 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_6.x, var_94_6.y, var_94_6.z)

				local var_94_7 = var_94_0.localEulerAngles

				var_94_7.z = 0
				var_94_7.x = 0
				var_94_0.localEulerAngles = var_94_7
			end

			if arg_91_1.time_ >= var_94_1 + var_94_3 and arg_91_1.time_ < var_94_1 + var_94_3 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_94_8 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_8.x, var_94_8.y, var_94_8.z)

				local var_94_9 = var_94_0.localEulerAngles

				var_94_9.z = 0
				var_94_9.x = 0
				var_94_0.localEulerAngles = var_94_9

				local var_94_10 = GameObjectTools.GetOrAddComponent(var_94_0.gameObject, typeof(DynamicBoneHelper))

				if var_94_10 then
					var_94_10:EnableDynamicBone(true)
				end
			end

			local var_94_11 = arg_91_1.actors_["1077ui_story"]
			local var_94_12 = 0

			if var_94_12 < arg_91_1.time_ and arg_91_1.time_ <= var_94_12 + arg_94_0 and not isNil(var_94_11) and arg_91_1.var_.characterEffect1077ui_story == nil then
				arg_91_1.var_.characterEffect1077ui_story = var_94_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_13 = 0.200000002980232

			if var_94_12 <= arg_91_1.time_ and arg_91_1.time_ < var_94_12 + var_94_13 and not isNil(var_94_11) then
				local var_94_14 = (arg_91_1.time_ - var_94_12) / var_94_13

				if arg_91_1.var_.characterEffect1077ui_story and not isNil(var_94_11) then
					arg_91_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_12 + var_94_13 and arg_91_1.time_ < var_94_12 + var_94_13 + arg_94_0 and not isNil(var_94_11) and arg_91_1.var_.characterEffect1077ui_story then
				arg_91_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_94_15 = 0

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_1")
			end

			local var_94_16 = 0

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 then
				arg_91_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_94_17 = 0
			local var_94_18 = 0.75

			if var_94_17 < arg_91_1.time_ and arg_91_1.time_ <= var_94_17 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_19 = arg_91_1:FormatText(StoryNameCfg[1467].name)

				arg_91_1.leftNameTxt_.text = var_94_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_20 = arg_91_1:GetWordFromCfg(325111021)
				local var_94_21 = arg_91_1:FormatText(var_94_20.content)

				arg_91_1.text_.text = var_94_21

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_22 = 30
				local var_94_23 = utf8.len(var_94_21)
				local var_94_24 = var_94_22 <= 0 and var_94_18 or var_94_18 * (var_94_23 / var_94_22)

				if var_94_24 > 0 and var_94_18 < var_94_24 then
					arg_91_1.talkMaxDuration = var_94_24

					if var_94_24 + var_94_17 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_24 + var_94_17
					end
				end

				arg_91_1.text_.text = var_94_21
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111021", "story_v_out_325111.awb") ~= 0 then
					local var_94_25 = manager.audio:GetVoiceLength("story_v_out_325111", "325111021", "story_v_out_325111.awb") / 1000

					if var_94_25 + var_94_17 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_25 + var_94_17
					end

					if var_94_20.prefab_name ~= "" and arg_91_1.actors_[var_94_20.prefab_name] ~= nil then
						local var_94_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_20.prefab_name].transform, "story_v_out_325111", "325111021", "story_v_out_325111.awb")

						arg_91_1:RecordAudio("325111021", var_94_26)
						arg_91_1:RecordAudio("325111021", var_94_26)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_325111", "325111021", "story_v_out_325111.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_325111", "325111021", "story_v_out_325111.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_27 = math.max(var_94_18, arg_91_1.talkMaxDuration)

			if var_94_17 <= arg_91_1.time_ and arg_91_1.time_ < var_94_17 + var_94_27 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_17) / var_94_27

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_17 + var_94_27 and arg_91_1.time_ < var_94_17 + var_94_27 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325111022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 325111022
		arg_95_1.duration_ = 12.97

		local var_95_0 = {
			zh = 7.133,
			ja = 12.966
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
				arg_95_0:Play325111023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.775

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[1467].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:GetWordFromCfg(325111022)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111022", "story_v_out_325111.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_325111", "325111022", "story_v_out_325111.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_325111", "325111022", "story_v_out_325111.awb")

						arg_95_1:RecordAudio("325111022", var_98_9)
						arg_95_1:RecordAudio("325111022", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_325111", "325111022", "story_v_out_325111.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_325111", "325111022", "story_v_out_325111.awb")
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
	Play325111023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 325111023
		arg_99_1.duration_ = 6.93

		local var_99_0 = {
			zh = 4.9,
			ja = 6.933
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
				arg_99_0:Play325111024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.725

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[1467].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:GetWordFromCfg(325111023)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111023", "story_v_out_325111.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_325111", "325111023", "story_v_out_325111.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_325111", "325111023", "story_v_out_325111.awb")

						arg_99_1:RecordAudio("325111023", var_102_9)
						arg_99_1:RecordAudio("325111023", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_325111", "325111023", "story_v_out_325111.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_325111", "325111023", "story_v_out_325111.awb")
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
	Play325111024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 325111024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play325111025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1077ui_story"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos1077ui_story = var_106_0.localPosition

				local var_106_2 = GameObjectTools.GetOrAddComponent(var_106_0.gameObject, typeof(DynamicBoneHelper))

				if var_106_2 then
					var_106_2:EnableDynamicBone(false)
				end
			end

			local var_106_3 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_3 then
				local var_106_4 = (arg_103_1.time_ - var_106_1) / var_106_3
				local var_106_5 = Vector3.New(0, 100, 0)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1077ui_story, var_106_5, var_106_4)

				local var_106_6 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_6.x, var_106_6.y, var_106_6.z)

				local var_106_7 = var_106_0.localEulerAngles

				var_106_7.z = 0
				var_106_7.x = 0
				var_106_0.localEulerAngles = var_106_7
			end

			if arg_103_1.time_ >= var_106_1 + var_106_3 and arg_103_1.time_ < var_106_1 + var_106_3 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0, 100, 0)

				local var_106_8 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_8.x, var_106_8.y, var_106_8.z)

				local var_106_9 = var_106_0.localEulerAngles

				var_106_9.z = 0
				var_106_9.x = 0
				var_106_0.localEulerAngles = var_106_9

				local var_106_10 = GameObjectTools.GetOrAddComponent(var_106_0.gameObject, typeof(DynamicBoneHelper))

				if var_106_10 then
					var_106_10:EnableDynamicBone(true)
				end
			end

			local var_106_11 = arg_103_1.actors_["1077ui_story"]
			local var_106_12 = 0

			if var_106_12 < arg_103_1.time_ and arg_103_1.time_ <= var_106_12 + arg_106_0 and not isNil(var_106_11) and arg_103_1.var_.characterEffect1077ui_story == nil then
				arg_103_1.var_.characterEffect1077ui_story = var_106_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_13 = 0.200000002980232

			if var_106_12 <= arg_103_1.time_ and arg_103_1.time_ < var_106_12 + var_106_13 and not isNil(var_106_11) then
				local var_106_14 = (arg_103_1.time_ - var_106_12) / var_106_13

				if arg_103_1.var_.characterEffect1077ui_story and not isNil(var_106_11) then
					local var_106_15 = Mathf.Lerp(0, 0.5, var_106_14)

					arg_103_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1077ui_story.fillRatio = var_106_15
				end
			end

			if arg_103_1.time_ >= var_106_12 + var_106_13 and arg_103_1.time_ < var_106_12 + var_106_13 + arg_106_0 and not isNil(var_106_11) and arg_103_1.var_.characterEffect1077ui_story then
				local var_106_16 = 0.5

				arg_103_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1077ui_story.fillRatio = var_106_16
			end

			local var_106_17 = 0.4
			local var_106_18 = 1

			if var_106_17 < arg_103_1.time_ and arg_103_1.time_ <= var_106_17 + arg_106_0 then
				local var_106_19 = "play"
				local var_106_20 = "effect"

				arg_103_1:AudioAction(var_106_19, var_106_20, "se_story_150", "se_story_150_monster_growl", "")
			end

			local var_106_21 = 0
			local var_106_22 = 1.65

			if var_106_21 < arg_103_1.time_ and arg_103_1.time_ <= var_106_21 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_23 = arg_103_1:GetWordFromCfg(325111024)
				local var_106_24 = arg_103_1:FormatText(var_106_23.content)

				arg_103_1.text_.text = var_106_24

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_25 = 66
				local var_106_26 = utf8.len(var_106_24)
				local var_106_27 = var_106_25 <= 0 and var_106_22 or var_106_22 * (var_106_26 / var_106_25)

				if var_106_27 > 0 and var_106_22 < var_106_27 then
					arg_103_1.talkMaxDuration = var_106_27

					if var_106_27 + var_106_21 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_27 + var_106_21
					end
				end

				arg_103_1.text_.text = var_106_24
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_28 = math.max(var_106_22, arg_103_1.talkMaxDuration)

			if var_106_21 <= arg_103_1.time_ and arg_103_1.time_ < var_106_21 + var_106_28 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_21) / var_106_28

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_21 + var_106_28 and arg_103_1.time_ < var_106_21 + var_106_28 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play325111025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 325111025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play325111026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 1.4

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(325111025)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 56
				local var_110_5 = utf8.len(var_110_3)
				local var_110_6 = var_110_4 <= 0 and var_110_1 or var_110_1 * (var_110_5 / var_110_4)

				if var_110_6 > 0 and var_110_1 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_7 and arg_107_1.time_ < var_110_0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play325111026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 325111026
		arg_111_1.duration_ = 6.83

		local var_111_0 = {
			zh = 3.2,
			ja = 6.833
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
				arg_111_0:Play325111027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1077ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos1077ui_story = var_114_0.localPosition

				local var_114_2 = GameObjectTools.GetOrAddComponent(var_114_0.gameObject, typeof(DynamicBoneHelper))

				if var_114_2 then
					var_114_2:EnableDynamicBone(false)
				end
			end

			local var_114_3 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_3 then
				local var_114_4 = (arg_111_1.time_ - var_114_1) / var_114_3
				local var_114_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1077ui_story, var_114_5, var_114_4)

				local var_114_6 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_6.x, var_114_6.y, var_114_6.z)

				local var_114_7 = var_114_0.localEulerAngles

				var_114_7.z = 0
				var_114_7.x = 0
				var_114_0.localEulerAngles = var_114_7
			end

			if arg_111_1.time_ >= var_114_1 + var_114_3 and arg_111_1.time_ < var_114_1 + var_114_3 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_114_8 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_8.x, var_114_8.y, var_114_8.z)

				local var_114_9 = var_114_0.localEulerAngles

				var_114_9.z = 0
				var_114_9.x = 0
				var_114_0.localEulerAngles = var_114_9

				local var_114_10 = GameObjectTools.GetOrAddComponent(var_114_0.gameObject, typeof(DynamicBoneHelper))

				if var_114_10 then
					var_114_10:EnableDynamicBone(true)
				end
			end

			local var_114_11 = arg_111_1.actors_["1077ui_story"]
			local var_114_12 = 0

			if var_114_12 < arg_111_1.time_ and arg_111_1.time_ <= var_114_12 + arg_114_0 and not isNil(var_114_11) and arg_111_1.var_.characterEffect1077ui_story == nil then
				arg_111_1.var_.characterEffect1077ui_story = var_114_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_13 = 0.200000002980232

			if var_114_12 <= arg_111_1.time_ and arg_111_1.time_ < var_114_12 + var_114_13 and not isNil(var_114_11) then
				local var_114_14 = (arg_111_1.time_ - var_114_12) / var_114_13

				if arg_111_1.var_.characterEffect1077ui_story and not isNil(var_114_11) then
					arg_111_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_12 + var_114_13 and arg_111_1.time_ < var_114_12 + var_114_13 + arg_114_0 and not isNil(var_114_11) and arg_111_1.var_.characterEffect1077ui_story then
				arg_111_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_114_15 = 0

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 then
				arg_111_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077actionlink/1077action438")
			end

			local var_114_16 = 0

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_114_17 = 0
			local var_114_18 = 0.775

			if var_114_17 < arg_111_1.time_ and arg_111_1.time_ <= var_114_17 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_19 = arg_111_1:FormatText(StoryNameCfg[1467].name)

				arg_111_1.leftNameTxt_.text = var_114_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_20 = arg_111_1:GetWordFromCfg(325111026)
				local var_114_21 = arg_111_1:FormatText(var_114_20.content)

				arg_111_1.text_.text = var_114_21

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_22 = 31
				local var_114_23 = utf8.len(var_114_21)
				local var_114_24 = var_114_22 <= 0 and var_114_18 or var_114_18 * (var_114_23 / var_114_22)

				if var_114_24 > 0 and var_114_18 < var_114_24 then
					arg_111_1.talkMaxDuration = var_114_24

					if var_114_24 + var_114_17 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_24 + var_114_17
					end
				end

				arg_111_1.text_.text = var_114_21
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111026", "story_v_out_325111.awb") ~= 0 then
					local var_114_25 = manager.audio:GetVoiceLength("story_v_out_325111", "325111026", "story_v_out_325111.awb") / 1000

					if var_114_25 + var_114_17 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_25 + var_114_17
					end

					if var_114_20.prefab_name ~= "" and arg_111_1.actors_[var_114_20.prefab_name] ~= nil then
						local var_114_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_20.prefab_name].transform, "story_v_out_325111", "325111026", "story_v_out_325111.awb")

						arg_111_1:RecordAudio("325111026", var_114_26)
						arg_111_1:RecordAudio("325111026", var_114_26)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_325111", "325111026", "story_v_out_325111.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_325111", "325111026", "story_v_out_325111.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_27 = math.max(var_114_18, arg_111_1.talkMaxDuration)

			if var_114_17 <= arg_111_1.time_ and arg_111_1.time_ < var_114_17 + var_114_27 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_17) / var_114_27

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_17 + var_114_27 and arg_111_1.time_ < var_114_17 + var_114_27 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325111027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 325111027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play325111028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1077ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1077ui_story = var_118_0.localPosition

				local var_118_2 = GameObjectTools.GetOrAddComponent(var_118_0.gameObject, typeof(DynamicBoneHelper))

				if var_118_2 then
					var_118_2:EnableDynamicBone(false)
				end
			end

			local var_118_3 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_3 then
				local var_118_4 = (arg_115_1.time_ - var_118_1) / var_118_3
				local var_118_5 = Vector3.New(0, 100, 0)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1077ui_story, var_118_5, var_118_4)

				local var_118_6 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_6.x, var_118_6.y, var_118_6.z)

				local var_118_7 = var_118_0.localEulerAngles

				var_118_7.z = 0
				var_118_7.x = 0
				var_118_0.localEulerAngles = var_118_7
			end

			if arg_115_1.time_ >= var_118_1 + var_118_3 and arg_115_1.time_ < var_118_1 + var_118_3 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0, 100, 0)

				local var_118_8 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_8.x, var_118_8.y, var_118_8.z)

				local var_118_9 = var_118_0.localEulerAngles

				var_118_9.z = 0
				var_118_9.x = 0
				var_118_0.localEulerAngles = var_118_9

				local var_118_10 = GameObjectTools.GetOrAddComponent(var_118_0.gameObject, typeof(DynamicBoneHelper))

				if var_118_10 then
					var_118_10:EnableDynamicBone(true)
				end
			end

			local var_118_11 = arg_115_1.actors_["1077ui_story"]
			local var_118_12 = 0

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 and not isNil(var_118_11) and arg_115_1.var_.characterEffect1077ui_story == nil then
				arg_115_1.var_.characterEffect1077ui_story = var_118_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_13 = 0.200000002980232

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_13 and not isNil(var_118_11) then
				local var_118_14 = (arg_115_1.time_ - var_118_12) / var_118_13

				if arg_115_1.var_.characterEffect1077ui_story and not isNil(var_118_11) then
					local var_118_15 = Mathf.Lerp(0, 0.5, var_118_14)

					arg_115_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1077ui_story.fillRatio = var_118_15
				end
			end

			if arg_115_1.time_ >= var_118_12 + var_118_13 and arg_115_1.time_ < var_118_12 + var_118_13 + arg_118_0 and not isNil(var_118_11) and arg_115_1.var_.characterEffect1077ui_story then
				local var_118_16 = 0.5

				arg_115_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1077ui_story.fillRatio = var_118_16
			end

			local var_118_17 = 0
			local var_118_18 = 1.075

			if var_118_17 < arg_115_1.time_ and arg_115_1.time_ <= var_118_17 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_19 = arg_115_1:GetWordFromCfg(325111027)
				local var_118_20 = arg_115_1:FormatText(var_118_19.content)

				arg_115_1.text_.text = var_118_20

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_21 = 43
				local var_118_22 = utf8.len(var_118_20)
				local var_118_23 = var_118_21 <= 0 and var_118_18 or var_118_18 * (var_118_22 / var_118_21)

				if var_118_23 > 0 and var_118_18 < var_118_23 then
					arg_115_1.talkMaxDuration = var_118_23

					if var_118_23 + var_118_17 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_23 + var_118_17
					end
				end

				arg_115_1.text_.text = var_118_20
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_24 = math.max(var_118_18, arg_115_1.talkMaxDuration)

			if var_118_17 <= arg_115_1.time_ and arg_115_1.time_ < var_118_17 + var_118_24 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_17) / var_118_24

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_17 + var_118_24 and arg_115_1.time_ < var_118_17 + var_118_24 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play325111028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 325111028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play325111029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.4
			local var_122_1 = 1

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				local var_122_2 = "play"
				local var_122_3 = "effect"

				arg_119_1:AudioAction(var_122_2, var_122_3, "se_story_148", "se_story_148_helmet_hit", "")
			end

			local var_122_4 = 0
			local var_122_5 = 1.625

			if var_122_4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(325111028)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_8 = 65
				local var_122_9 = utf8.len(var_122_7)
				local var_122_10 = var_122_8 <= 0 and var_122_5 or var_122_5 * (var_122_9 / var_122_8)

				if var_122_10 > 0 and var_122_5 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_11 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_11 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_11

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_11 and arg_119_1.time_ < var_122_4 + var_122_11 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play325111029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 325111029
		arg_123_1.duration_ = 4.2

		local var_123_0 = {
			zh = 3.833,
			ja = 4.2
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
				arg_123_0:Play325111030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1077ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1077ui_story = var_126_0.localPosition

				local var_126_2 = GameObjectTools.GetOrAddComponent(var_126_0.gameObject, typeof(DynamicBoneHelper))

				if var_126_2 then
					var_126_2:EnableDynamicBone(false)
				end
			end

			local var_126_3 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_3 then
				local var_126_4 = (arg_123_1.time_ - var_126_1) / var_126_3
				local var_126_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1077ui_story, var_126_5, var_126_4)

				local var_126_6 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_6.x, var_126_6.y, var_126_6.z)

				local var_126_7 = var_126_0.localEulerAngles

				var_126_7.z = 0
				var_126_7.x = 0
				var_126_0.localEulerAngles = var_126_7
			end

			if arg_123_1.time_ >= var_126_1 + var_126_3 and arg_123_1.time_ < var_126_1 + var_126_3 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_126_8 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_8.x, var_126_8.y, var_126_8.z)

				local var_126_9 = var_126_0.localEulerAngles

				var_126_9.z = 0
				var_126_9.x = 0
				var_126_0.localEulerAngles = var_126_9

				local var_126_10 = GameObjectTools.GetOrAddComponent(var_126_0.gameObject, typeof(DynamicBoneHelper))

				if var_126_10 then
					var_126_10:EnableDynamicBone(true)
				end
			end

			local var_126_11 = arg_123_1.actors_["1077ui_story"]
			local var_126_12 = 0

			if var_126_12 < arg_123_1.time_ and arg_123_1.time_ <= var_126_12 + arg_126_0 and not isNil(var_126_11) and arg_123_1.var_.characterEffect1077ui_story == nil then
				arg_123_1.var_.characterEffect1077ui_story = var_126_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_13 = 0.200000002980232

			if var_126_12 <= arg_123_1.time_ and arg_123_1.time_ < var_126_12 + var_126_13 and not isNil(var_126_11) then
				local var_126_14 = (arg_123_1.time_ - var_126_12) / var_126_13

				if arg_123_1.var_.characterEffect1077ui_story and not isNil(var_126_11) then
					arg_123_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_12 + var_126_13 and arg_123_1.time_ < var_126_12 + var_126_13 + arg_126_0 and not isNil(var_126_11) and arg_123_1.var_.characterEffect1077ui_story then
				arg_123_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_126_15 = 0

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 then
				arg_123_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			local var_126_16 = 0
			local var_126_17 = 0.3

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_18 = arg_123_1:FormatText(StoryNameCfg[1467].name)

				arg_123_1.leftNameTxt_.text = var_126_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_19 = arg_123_1:GetWordFromCfg(325111029)
				local var_126_20 = arg_123_1:FormatText(var_126_19.content)

				arg_123_1.text_.text = var_126_20

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_21 = 12
				local var_126_22 = utf8.len(var_126_20)
				local var_126_23 = var_126_21 <= 0 and var_126_17 or var_126_17 * (var_126_22 / var_126_21)

				if var_126_23 > 0 and var_126_17 < var_126_23 then
					arg_123_1.talkMaxDuration = var_126_23

					if var_126_23 + var_126_16 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_23 + var_126_16
					end
				end

				arg_123_1.text_.text = var_126_20
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111029", "story_v_out_325111.awb") ~= 0 then
					local var_126_24 = manager.audio:GetVoiceLength("story_v_out_325111", "325111029", "story_v_out_325111.awb") / 1000

					if var_126_24 + var_126_16 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_24 + var_126_16
					end

					if var_126_19.prefab_name ~= "" and arg_123_1.actors_[var_126_19.prefab_name] ~= nil then
						local var_126_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_19.prefab_name].transform, "story_v_out_325111", "325111029", "story_v_out_325111.awb")

						arg_123_1:RecordAudio("325111029", var_126_25)
						arg_123_1:RecordAudio("325111029", var_126_25)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_325111", "325111029", "story_v_out_325111.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_325111", "325111029", "story_v_out_325111.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_26 = math.max(var_126_17, arg_123_1.talkMaxDuration)

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_26 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_16) / var_126_26

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_16 + var_126_26 and arg_123_1.time_ < var_126_16 + var_126_26 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play325111030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 325111030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play325111031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1077ui_story"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos1077ui_story = var_130_0.localPosition

				local var_130_2 = GameObjectTools.GetOrAddComponent(var_130_0.gameObject, typeof(DynamicBoneHelper))

				if var_130_2 then
					var_130_2:EnableDynamicBone(false)
				end
			end

			local var_130_3 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_3 then
				local var_130_4 = (arg_127_1.time_ - var_130_1) / var_130_3
				local var_130_5 = Vector3.New(0, 100, 0)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1077ui_story, var_130_5, var_130_4)

				local var_130_6 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_6.x, var_130_6.y, var_130_6.z)

				local var_130_7 = var_130_0.localEulerAngles

				var_130_7.z = 0
				var_130_7.x = 0
				var_130_0.localEulerAngles = var_130_7
			end

			if arg_127_1.time_ >= var_130_1 + var_130_3 and arg_127_1.time_ < var_130_1 + var_130_3 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, 100, 0)

				local var_130_8 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_8.x, var_130_8.y, var_130_8.z)

				local var_130_9 = var_130_0.localEulerAngles

				var_130_9.z = 0
				var_130_9.x = 0
				var_130_0.localEulerAngles = var_130_9

				local var_130_10 = GameObjectTools.GetOrAddComponent(var_130_0.gameObject, typeof(DynamicBoneHelper))

				if var_130_10 then
					var_130_10:EnableDynamicBone(true)
				end
			end

			local var_130_11 = arg_127_1.actors_["1077ui_story"]
			local var_130_12 = 0

			if var_130_12 < arg_127_1.time_ and arg_127_1.time_ <= var_130_12 + arg_130_0 and not isNil(var_130_11) and arg_127_1.var_.characterEffect1077ui_story == nil then
				arg_127_1.var_.characterEffect1077ui_story = var_130_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_13 = 0.200000002980232

			if var_130_12 <= arg_127_1.time_ and arg_127_1.time_ < var_130_12 + var_130_13 and not isNil(var_130_11) then
				local var_130_14 = (arg_127_1.time_ - var_130_12) / var_130_13

				if arg_127_1.var_.characterEffect1077ui_story and not isNil(var_130_11) then
					local var_130_15 = Mathf.Lerp(0, 0.5, var_130_14)

					arg_127_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1077ui_story.fillRatio = var_130_15
				end
			end

			if arg_127_1.time_ >= var_130_12 + var_130_13 and arg_127_1.time_ < var_130_12 + var_130_13 + arg_130_0 and not isNil(var_130_11) and arg_127_1.var_.characterEffect1077ui_story then
				local var_130_16 = 0.5

				arg_127_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1077ui_story.fillRatio = var_130_16
			end

			local var_130_17 = 0.4
			local var_130_18 = 1

			if var_130_17 < arg_127_1.time_ and arg_127_1.time_ <= var_130_17 + arg_130_0 then
				local var_130_19 = "play"
				local var_130_20 = "effect"

				arg_127_1:AudioAction(var_130_19, var_130_20, "se_story_122_02", "se_story_122_02_punch", "")
			end

			local var_130_21 = 0
			local var_130_22 = 1.15

			if var_130_21 < arg_127_1.time_ and arg_127_1.time_ <= var_130_21 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_23 = arg_127_1:GetWordFromCfg(325111030)
				local var_130_24 = arg_127_1:FormatText(var_130_23.content)

				arg_127_1.text_.text = var_130_24

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_25 = 46
				local var_130_26 = utf8.len(var_130_24)
				local var_130_27 = var_130_25 <= 0 and var_130_22 or var_130_22 * (var_130_26 / var_130_25)

				if var_130_27 > 0 and var_130_22 < var_130_27 then
					arg_127_1.talkMaxDuration = var_130_27

					if var_130_27 + var_130_21 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_27 + var_130_21
					end
				end

				arg_127_1.text_.text = var_130_24
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_28 = math.max(var_130_22, arg_127_1.talkMaxDuration)

			if var_130_21 <= arg_127_1.time_ and arg_127_1.time_ < var_130_21 + var_130_28 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_21) / var_130_28

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_21 + var_130_28 and arg_127_1.time_ < var_130_21 + var_130_28 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play325111031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 325111031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play325111032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.7

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(325111031)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 28
				local var_134_5 = utf8.len(var_134_3)
				local var_134_6 = var_134_4 <= 0 and var_134_1 or var_134_1 * (var_134_5 / var_134_4)

				if var_134_6 > 0 and var_134_1 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_7 and arg_131_1.time_ < var_134_0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play325111032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 325111032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play325111033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 1.225

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:GetWordFromCfg(325111032)
				local var_138_3 = arg_135_1:FormatText(var_138_2.content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 49
				local var_138_5 = utf8.len(var_138_3)
				local var_138_6 = var_138_4 <= 0 and var_138_1 or var_138_1 * (var_138_5 / var_138_4)

				if var_138_6 > 0 and var_138_1 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_7 and arg_135_1.time_ < var_138_0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play325111033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 325111033
		arg_139_1.duration_ = 4.23

		local var_139_0 = {
			zh = 3.533,
			ja = 4.233
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
				arg_139_0:Play325111034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1077ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1077ui_story = var_142_0.localPosition

				local var_142_2 = GameObjectTools.GetOrAddComponent(var_142_0.gameObject, typeof(DynamicBoneHelper))

				if var_142_2 then
					var_142_2:EnableDynamicBone(false)
				end
			end

			local var_142_3 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_3 then
				local var_142_4 = (arg_139_1.time_ - var_142_1) / var_142_3
				local var_142_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1077ui_story, var_142_5, var_142_4)

				local var_142_6 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_6.x, var_142_6.y, var_142_6.z)

				local var_142_7 = var_142_0.localEulerAngles

				var_142_7.z = 0
				var_142_7.x = 0
				var_142_0.localEulerAngles = var_142_7
			end

			if arg_139_1.time_ >= var_142_1 + var_142_3 and arg_139_1.time_ < var_142_1 + var_142_3 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_142_8 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_8.x, var_142_8.y, var_142_8.z)

				local var_142_9 = var_142_0.localEulerAngles

				var_142_9.z = 0
				var_142_9.x = 0
				var_142_0.localEulerAngles = var_142_9

				local var_142_10 = GameObjectTools.GetOrAddComponent(var_142_0.gameObject, typeof(DynamicBoneHelper))

				if var_142_10 then
					var_142_10:EnableDynamicBone(true)
				end
			end

			local var_142_11 = arg_139_1.actors_["1077ui_story"]
			local var_142_12 = 0

			if var_142_12 < arg_139_1.time_ and arg_139_1.time_ <= var_142_12 + arg_142_0 and not isNil(var_142_11) and arg_139_1.var_.characterEffect1077ui_story == nil then
				arg_139_1.var_.characterEffect1077ui_story = var_142_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_13 = 0.200000002980232

			if var_142_12 <= arg_139_1.time_ and arg_139_1.time_ < var_142_12 + var_142_13 and not isNil(var_142_11) then
				local var_142_14 = (arg_139_1.time_ - var_142_12) / var_142_13

				if arg_139_1.var_.characterEffect1077ui_story and not isNil(var_142_11) then
					arg_139_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_12 + var_142_13 and arg_139_1.time_ < var_142_12 + var_142_13 + arg_142_0 and not isNil(var_142_11) and arg_139_1.var_.characterEffect1077ui_story then
				arg_139_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_142_15 = 0
			local var_142_16 = 0.3

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_17 = arg_139_1:FormatText(StoryNameCfg[1467].name)

				arg_139_1.leftNameTxt_.text = var_142_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_18 = arg_139_1:GetWordFromCfg(325111033)
				local var_142_19 = arg_139_1:FormatText(var_142_18.content)

				arg_139_1.text_.text = var_142_19

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_20 = 12
				local var_142_21 = utf8.len(var_142_19)
				local var_142_22 = var_142_20 <= 0 and var_142_16 or var_142_16 * (var_142_21 / var_142_20)

				if var_142_22 > 0 and var_142_16 < var_142_22 then
					arg_139_1.talkMaxDuration = var_142_22

					if var_142_22 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_22 + var_142_15
					end
				end

				arg_139_1.text_.text = var_142_19
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111033", "story_v_out_325111.awb") ~= 0 then
					local var_142_23 = manager.audio:GetVoiceLength("story_v_out_325111", "325111033", "story_v_out_325111.awb") / 1000

					if var_142_23 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_15
					end

					if var_142_18.prefab_name ~= "" and arg_139_1.actors_[var_142_18.prefab_name] ~= nil then
						local var_142_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_18.prefab_name].transform, "story_v_out_325111", "325111033", "story_v_out_325111.awb")

						arg_139_1:RecordAudio("325111033", var_142_24)
						arg_139_1:RecordAudio("325111033", var_142_24)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_325111", "325111033", "story_v_out_325111.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_325111", "325111033", "story_v_out_325111.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_25 = math.max(var_142_16, arg_139_1.talkMaxDuration)

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_25 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_15) / var_142_25

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_15 + var_142_25 and arg_139_1.time_ < var_142_15 + var_142_25 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325111034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 325111034
		arg_143_1.duration_ = 7.93

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play325111035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = "ST42"

			if arg_143_1.bgs_[var_146_0] == nil then
				local var_146_1 = Object.Instantiate(arg_143_1.paintGo_)

				var_146_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_146_0)
				var_146_1.name = var_146_0
				var_146_1.transform.parent = arg_143_1.stage_.transform
				var_146_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.bgs_[var_146_0] = var_146_1
			end

			local var_146_2 = 1.63333333333333

			if var_146_2 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				local var_146_3 = manager.ui.mainCamera.transform.localPosition
				local var_146_4 = Vector3.New(0, 0, 10) + Vector3.New(var_146_3.x, var_146_3.y, 0)
				local var_146_5 = arg_143_1.bgs_.ST42

				var_146_5.transform.localPosition = var_146_4
				var_146_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_146_6 = var_146_5:GetComponent("SpriteRenderer")

				if var_146_6 and var_146_6.sprite then
					local var_146_7 = (var_146_5.transform.localPosition - var_146_3).z
					local var_146_8 = manager.ui.mainCameraCom_
					local var_146_9 = 2 * var_146_7 * Mathf.Tan(var_146_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_146_10 = var_146_9 * var_146_8.aspect
					local var_146_11 = var_146_6.sprite.bounds.size.x
					local var_146_12 = var_146_6.sprite.bounds.size.y
					local var_146_13 = var_146_10 / var_146_11
					local var_146_14 = var_146_9 / var_146_12
					local var_146_15 = var_146_14 < var_146_13 and var_146_13 or var_146_14

					var_146_5.transform.localScale = Vector3.New(var_146_15, var_146_15, 0)
				end

				for iter_146_0, iter_146_1 in pairs(arg_143_1.bgs_) do
					if iter_146_0 ~= "ST42" then
						iter_146_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_146_16 = 1.63333333333333

			if var_146_16 < arg_143_1.time_ and arg_143_1.time_ <= var_146_16 + arg_146_0 then
				arg_143_1.allBtn_.enabled = false
			end

			local var_146_17 = 0.3

			if arg_143_1.time_ >= var_146_16 + var_146_17 and arg_143_1.time_ < var_146_16 + var_146_17 + arg_146_0 then
				arg_143_1.allBtn_.enabled = true
			end

			local var_146_18 = 0

			if var_146_18 < arg_143_1.time_ and arg_143_1.time_ <= var_146_18 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = true

				arg_143_1:SetGaussion(false)
			end

			local var_146_19 = 1.63333333333333

			if var_146_18 <= arg_143_1.time_ and arg_143_1.time_ < var_146_18 + var_146_19 then
				local var_146_20 = (arg_143_1.time_ - var_146_18) / var_146_19
				local var_146_21 = Color.New(0, 0, 0)

				var_146_21.a = Mathf.Lerp(0, 1, var_146_20)
				arg_143_1.mask_.color = var_146_21
			end

			if arg_143_1.time_ >= var_146_18 + var_146_19 and arg_143_1.time_ < var_146_18 + var_146_19 + arg_146_0 then
				local var_146_22 = Color.New(0, 0, 0)

				var_146_22.a = 1
				arg_143_1.mask_.color = var_146_22
			end

			local var_146_23 = 1.63333333333333

			if var_146_23 < arg_143_1.time_ and arg_143_1.time_ <= var_146_23 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = true

				arg_143_1:SetGaussion(false)
			end

			local var_146_24 = 1.88414250034839

			if var_146_23 <= arg_143_1.time_ and arg_143_1.time_ < var_146_23 + var_146_24 then
				local var_146_25 = (arg_143_1.time_ - var_146_23) / var_146_24
				local var_146_26 = Color.New(0, 0, 0)

				var_146_26.a = Mathf.Lerp(1, 0, var_146_25)
				arg_143_1.mask_.color = var_146_26
			end

			if arg_143_1.time_ >= var_146_23 + var_146_24 and arg_143_1.time_ < var_146_23 + var_146_24 + arg_146_0 then
				local var_146_27 = Color.New(0, 0, 0)
				local var_146_28 = 0

				arg_143_1.mask_.enabled = false
				var_146_27.a = var_146_28
				arg_143_1.mask_.color = var_146_27
			end

			local var_146_29 = arg_143_1.actors_["1077ui_story"].transform
			local var_146_30 = 1.63333333333333

			if var_146_30 < arg_143_1.time_ and arg_143_1.time_ <= var_146_30 + arg_146_0 then
				arg_143_1.var_.moveOldPos1077ui_story = var_146_29.localPosition

				local var_146_31 = GameObjectTools.GetOrAddComponent(var_146_29.gameObject, typeof(DynamicBoneHelper))

				if var_146_31 then
					var_146_31:EnableDynamicBone(false)
				end
			end

			local var_146_32 = 0.001

			if var_146_30 <= arg_143_1.time_ and arg_143_1.time_ < var_146_30 + var_146_32 then
				local var_146_33 = (arg_143_1.time_ - var_146_30) / var_146_32
				local var_146_34 = Vector3.New(0, 100, 0)

				var_146_29.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1077ui_story, var_146_34, var_146_33)

				local var_146_35 = manager.ui.mainCamera.transform.position - var_146_29.position

				var_146_29.forward = Vector3.New(var_146_35.x, var_146_35.y, var_146_35.z)

				local var_146_36 = var_146_29.localEulerAngles

				var_146_36.z = 0
				var_146_36.x = 0
				var_146_29.localEulerAngles = var_146_36
			end

			if arg_143_1.time_ >= var_146_30 + var_146_32 and arg_143_1.time_ < var_146_30 + var_146_32 + arg_146_0 then
				var_146_29.localPosition = Vector3.New(0, 100, 0)

				local var_146_37 = manager.ui.mainCamera.transform.position - var_146_29.position

				var_146_29.forward = Vector3.New(var_146_37.x, var_146_37.y, var_146_37.z)

				local var_146_38 = var_146_29.localEulerAngles

				var_146_38.z = 0
				var_146_38.x = 0
				var_146_29.localEulerAngles = var_146_38

				local var_146_39 = GameObjectTools.GetOrAddComponent(var_146_29.gameObject, typeof(DynamicBoneHelper))

				if var_146_39 then
					var_146_39:EnableDynamicBone(true)
				end
			end

			local var_146_40 = arg_143_1.actors_["1077ui_story"]
			local var_146_41 = 1.63333333333333

			if var_146_41 < arg_143_1.time_ and arg_143_1.time_ <= var_146_41 + arg_146_0 and not isNil(var_146_40) and arg_143_1.var_.characterEffect1077ui_story == nil then
				arg_143_1.var_.characterEffect1077ui_story = var_146_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_42 = 0.200000002980232

			if var_146_41 <= arg_143_1.time_ and arg_143_1.time_ < var_146_41 + var_146_42 and not isNil(var_146_40) then
				local var_146_43 = (arg_143_1.time_ - var_146_41) / var_146_42

				if arg_143_1.var_.characterEffect1077ui_story and not isNil(var_146_40) then
					local var_146_44 = Mathf.Lerp(0, 0.5, var_146_43)

					arg_143_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1077ui_story.fillRatio = var_146_44
				end
			end

			if arg_143_1.time_ >= var_146_41 + var_146_42 and arg_143_1.time_ < var_146_41 + var_146_42 + arg_146_0 and not isNil(var_146_40) and arg_143_1.var_.characterEffect1077ui_story then
				local var_146_45 = 0.5

				arg_143_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1077ui_story.fillRatio = var_146_45
			end

			if arg_143_1.frameCnt_ <= 1 then
				arg_143_1.dialog_:SetActive(false)
			end

			local var_146_46 = 2.93333333333333
			local var_146_47 = 1.45

			if var_146_46 < arg_143_1.time_ and arg_143_1.time_ <= var_146_46 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				arg_143_1.dialog_:SetActive(true)

				arg_143_1.dialogCg_.alpha = 0

				local var_146_48 = LeanTween.value(arg_143_1.dialog_, 0, 1, 0.3)

				var_146_48:setOnUpdate(LuaHelper.FloatAction(function(arg_147_0)
					arg_143_1.dialogCg_.alpha = arg_147_0
				end))
				var_146_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_143_1.dialog_)
					var_146_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_143_1.duration_ = arg_143_1.duration_ + 0.3

				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_49 = arg_143_1:GetWordFromCfg(325111034)
				local var_146_50 = arg_143_1:FormatText(var_146_49.content)

				arg_143_1.text_.text = var_146_50

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_51 = 58
				local var_146_52 = utf8.len(var_146_50)
				local var_146_53 = var_146_51 <= 0 and var_146_47 or var_146_47 * (var_146_52 / var_146_51)

				if var_146_53 > 0 and var_146_47 < var_146_53 then
					arg_143_1.talkMaxDuration = var_146_53
					var_146_46 = var_146_46 + 0.3

					if var_146_53 + var_146_46 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_53 + var_146_46
					end
				end

				arg_143_1.text_.text = var_146_50
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_54 = var_146_46 + 0.3
			local var_146_55 = math.max(var_146_47, arg_143_1.talkMaxDuration)

			if var_146_54 <= arg_143_1.time_ and arg_143_1.time_ < var_146_54 + var_146_55 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_54) / var_146_55

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_54 + var_146_55 and arg_143_1.time_ < var_146_54 + var_146_55 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play325111035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 325111035
		arg_149_1.duration_ = 2.23

		local var_149_0 = {
			zh = 2.233,
			ja = 1.999999999999
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
				arg_149_0:Play325111036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1075ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1075ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(0, -1.055, -6.16)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1075ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["1075ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1075ui_story == nil then
				arg_149_1.var_.characterEffect1075ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect1075ui_story and not isNil(var_152_9) then
					arg_149_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1075ui_story then
				arg_149_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_152_13 = 0

			if var_152_13 < arg_149_1.time_ and arg_149_1.time_ <= var_152_13 + arg_152_0 then
				arg_149_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_152_14 = 0

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				arg_149_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_152_15 = 0
			local var_152_16 = 0.125

			if var_152_15 < arg_149_1.time_ and arg_149_1.time_ <= var_152_15 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_17 = arg_149_1:FormatText(StoryNameCfg[381].name)

				arg_149_1.leftNameTxt_.text = var_152_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_18 = arg_149_1:GetWordFromCfg(325111035)
				local var_152_19 = arg_149_1:FormatText(var_152_18.content)

				arg_149_1.text_.text = var_152_19

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_20 = 5
				local var_152_21 = utf8.len(var_152_19)
				local var_152_22 = var_152_20 <= 0 and var_152_16 or var_152_16 * (var_152_21 / var_152_20)

				if var_152_22 > 0 and var_152_16 < var_152_22 then
					arg_149_1.talkMaxDuration = var_152_22

					if var_152_22 + var_152_15 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_22 + var_152_15
					end
				end

				arg_149_1.text_.text = var_152_19
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111035", "story_v_out_325111.awb") ~= 0 then
					local var_152_23 = manager.audio:GetVoiceLength("story_v_out_325111", "325111035", "story_v_out_325111.awb") / 1000

					if var_152_23 + var_152_15 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_23 + var_152_15
					end

					if var_152_18.prefab_name ~= "" and arg_149_1.actors_[var_152_18.prefab_name] ~= nil then
						local var_152_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_18.prefab_name].transform, "story_v_out_325111", "325111035", "story_v_out_325111.awb")

						arg_149_1:RecordAudio("325111035", var_152_24)
						arg_149_1:RecordAudio("325111035", var_152_24)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_325111", "325111035", "story_v_out_325111.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_325111", "325111035", "story_v_out_325111.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_25 = math.max(var_152_16, arg_149_1.talkMaxDuration)

			if var_152_15 <= arg_149_1.time_ and arg_149_1.time_ < var_152_15 + var_152_25 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_15) / var_152_25

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_15 + var_152_25 and arg_149_1.time_ < var_152_15 + var_152_25 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play325111036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 325111036
		arg_153_1.duration_ = 3.53

		local var_153_0 = {
			zh = 2.2,
			ja = 3.533
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play325111037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1075ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1075ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(-0.7, -1.055, -6.16)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1075ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = "1053ui_story"

			if arg_153_1.actors_[var_156_9] == nil then
				local var_156_10 = Asset.Load("Char/" .. "1053ui_story")

				if not isNil(var_156_10) then
					local var_156_11 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_153_1.stage_.transform)

					var_156_11.name = var_156_9
					var_156_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_153_1.actors_[var_156_9] = var_156_11

					local var_156_12 = var_156_11:GetComponentInChildren(typeof(CharacterEffect))

					var_156_12.enabled = true

					local var_156_13 = GameObjectTools.GetOrAddComponent(var_156_11, typeof(DynamicBoneHelper))

					if var_156_13 then
						var_156_13:EnableDynamicBone(false)
					end

					arg_153_1:ShowWeapon(var_156_12.transform, false)

					arg_153_1.var_[var_156_9 .. "Animator"] = var_156_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_153_1.var_[var_156_9 .. "Animator"].applyRootMotion = true
					arg_153_1.var_[var_156_9 .. "LipSync"] = var_156_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_156_14 = arg_153_1.actors_["1053ui_story"].transform
			local var_156_15 = 0

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.var_.moveOldPos1053ui_story = var_156_14.localPosition

				local var_156_16 = GameObjectTools.GetOrAddComponent(var_156_14.gameObject, typeof(DynamicBoneHelper))

				if var_156_16 then
					var_156_16:EnableDynamicBone(false)
				end
			end

			local var_156_17 = 0.001

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_17 then
				local var_156_18 = (arg_153_1.time_ - var_156_15) / var_156_17
				local var_156_19 = Vector3.New(0.7, -1.08, -6)

				var_156_14.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1053ui_story, var_156_19, var_156_18)

				local var_156_20 = manager.ui.mainCamera.transform.position - var_156_14.position

				var_156_14.forward = Vector3.New(var_156_20.x, var_156_20.y, var_156_20.z)

				local var_156_21 = var_156_14.localEulerAngles

				var_156_21.z = 0
				var_156_21.x = 0
				var_156_14.localEulerAngles = var_156_21
			end

			if arg_153_1.time_ >= var_156_15 + var_156_17 and arg_153_1.time_ < var_156_15 + var_156_17 + arg_156_0 then
				var_156_14.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_156_22 = manager.ui.mainCamera.transform.position - var_156_14.position

				var_156_14.forward = Vector3.New(var_156_22.x, var_156_22.y, var_156_22.z)

				local var_156_23 = var_156_14.localEulerAngles

				var_156_23.z = 0
				var_156_23.x = 0
				var_156_14.localEulerAngles = var_156_23

				local var_156_24 = GameObjectTools.GetOrAddComponent(var_156_14.gameObject, typeof(DynamicBoneHelper))

				if var_156_24 then
					var_156_24:EnableDynamicBone(true)
				end
			end

			local var_156_25 = arg_153_1.actors_["1053ui_story"]
			local var_156_26 = 0

			if var_156_26 < arg_153_1.time_ and arg_153_1.time_ <= var_156_26 + arg_156_0 and not isNil(var_156_25) and arg_153_1.var_.characterEffect1053ui_story == nil then
				arg_153_1.var_.characterEffect1053ui_story = var_156_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_27 = 0.200000002980232

			if var_156_26 <= arg_153_1.time_ and arg_153_1.time_ < var_156_26 + var_156_27 and not isNil(var_156_25) then
				local var_156_28 = (arg_153_1.time_ - var_156_26) / var_156_27

				if arg_153_1.var_.characterEffect1053ui_story and not isNil(var_156_25) then
					arg_153_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_26 + var_156_27 and arg_153_1.time_ < var_156_26 + var_156_27 + arg_156_0 and not isNil(var_156_25) and arg_153_1.var_.characterEffect1053ui_story then
				arg_153_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_156_29 = arg_153_1.actors_["1075ui_story"]
			local var_156_30 = 0

			if var_156_30 < arg_153_1.time_ and arg_153_1.time_ <= var_156_30 + arg_156_0 and not isNil(var_156_29) and arg_153_1.var_.characterEffect1075ui_story == nil then
				arg_153_1.var_.characterEffect1075ui_story = var_156_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_31 = 0.200000002980232

			if var_156_30 <= arg_153_1.time_ and arg_153_1.time_ < var_156_30 + var_156_31 and not isNil(var_156_29) then
				local var_156_32 = (arg_153_1.time_ - var_156_30) / var_156_31

				if arg_153_1.var_.characterEffect1075ui_story and not isNil(var_156_29) then
					local var_156_33 = Mathf.Lerp(0, 0.5, var_156_32)

					arg_153_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1075ui_story.fillRatio = var_156_33
				end
			end

			if arg_153_1.time_ >= var_156_30 + var_156_31 and arg_153_1.time_ < var_156_30 + var_156_31 + arg_156_0 and not isNil(var_156_29) and arg_153_1.var_.characterEffect1075ui_story then
				local var_156_34 = 0.5

				arg_153_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1075ui_story.fillRatio = var_156_34
			end

			local var_156_35 = 0

			if var_156_35 < arg_153_1.time_ and arg_153_1.time_ <= var_156_35 + arg_156_0 then
				arg_153_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			local var_156_36 = 0

			if var_156_36 < arg_153_1.time_ and arg_153_1.time_ <= var_156_36 + arg_156_0 then
				arg_153_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_156_37 = 0
			local var_156_38 = 0.225

			if var_156_37 < arg_153_1.time_ and arg_153_1.time_ <= var_156_37 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_39 = arg_153_1:FormatText(StoryNameCfg[472].name)

				arg_153_1.leftNameTxt_.text = var_156_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_40 = arg_153_1:GetWordFromCfg(325111036)
				local var_156_41 = arg_153_1:FormatText(var_156_40.content)

				arg_153_1.text_.text = var_156_41

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_42 = 9
				local var_156_43 = utf8.len(var_156_41)
				local var_156_44 = var_156_42 <= 0 and var_156_38 or var_156_38 * (var_156_43 / var_156_42)

				if var_156_44 > 0 and var_156_38 < var_156_44 then
					arg_153_1.talkMaxDuration = var_156_44

					if var_156_44 + var_156_37 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_44 + var_156_37
					end
				end

				arg_153_1.text_.text = var_156_41
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111036", "story_v_out_325111.awb") ~= 0 then
					local var_156_45 = manager.audio:GetVoiceLength("story_v_out_325111", "325111036", "story_v_out_325111.awb") / 1000

					if var_156_45 + var_156_37 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_45 + var_156_37
					end

					if var_156_40.prefab_name ~= "" and arg_153_1.actors_[var_156_40.prefab_name] ~= nil then
						local var_156_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_40.prefab_name].transform, "story_v_out_325111", "325111036", "story_v_out_325111.awb")

						arg_153_1:RecordAudio("325111036", var_156_46)
						arg_153_1:RecordAudio("325111036", var_156_46)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_325111", "325111036", "story_v_out_325111.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_325111", "325111036", "story_v_out_325111.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_47 = math.max(var_156_38, arg_153_1.talkMaxDuration)

			if var_156_37 <= arg_153_1.time_ and arg_153_1.time_ < var_156_37 + var_156_47 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_37) / var_156_47

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_37 + var_156_47 and arg_153_1.time_ < var_156_37 + var_156_47 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
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

		arg_153_1:InitPlayNodeList()
	end,
	Play325111037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 325111037
		arg_157_1.duration_ = 6.2

		local var_157_0 = {
			zh = 4.7,
			ja = 6.2
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play325111038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1075ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1075ui_story == nil then
				arg_157_1.var_.characterEffect1075ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1075ui_story and not isNil(var_160_0) then
					arg_157_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1075ui_story then
				arg_157_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_160_4 = arg_157_1.actors_["1053ui_story"]
			local var_160_5 = 0

			if var_160_5 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1053ui_story == nil then
				arg_157_1.var_.characterEffect1053ui_story = var_160_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_6 = 0.200000002980232

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_6 and not isNil(var_160_4) then
				local var_160_7 = (arg_157_1.time_ - var_160_5) / var_160_6

				if arg_157_1.var_.characterEffect1053ui_story and not isNil(var_160_4) then
					local var_160_8 = Mathf.Lerp(0, 0.5, var_160_7)

					arg_157_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1053ui_story.fillRatio = var_160_8
				end
			end

			if arg_157_1.time_ >= var_160_5 + var_160_6 and arg_157_1.time_ < var_160_5 + var_160_6 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1053ui_story then
				local var_160_9 = 0.5

				arg_157_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1053ui_story.fillRatio = var_160_9
			end

			local var_160_10 = 0
			local var_160_11 = 0.6

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_12 = arg_157_1:FormatText(StoryNameCfg[381].name)

				arg_157_1.leftNameTxt_.text = var_160_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_13 = arg_157_1:GetWordFromCfg(325111037)
				local var_160_14 = arg_157_1:FormatText(var_160_13.content)

				arg_157_1.text_.text = var_160_14

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_15 = 24
				local var_160_16 = utf8.len(var_160_14)
				local var_160_17 = var_160_15 <= 0 and var_160_11 or var_160_11 * (var_160_16 / var_160_15)

				if var_160_17 > 0 and var_160_11 < var_160_17 then
					arg_157_1.talkMaxDuration = var_160_17

					if var_160_17 + var_160_10 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_17 + var_160_10
					end
				end

				arg_157_1.text_.text = var_160_14
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111037", "story_v_out_325111.awb") ~= 0 then
					local var_160_18 = manager.audio:GetVoiceLength("story_v_out_325111", "325111037", "story_v_out_325111.awb") / 1000

					if var_160_18 + var_160_10 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_18 + var_160_10
					end

					if var_160_13.prefab_name ~= "" and arg_157_1.actors_[var_160_13.prefab_name] ~= nil then
						local var_160_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_13.prefab_name].transform, "story_v_out_325111", "325111037", "story_v_out_325111.awb")

						arg_157_1:RecordAudio("325111037", var_160_19)
						arg_157_1:RecordAudio("325111037", var_160_19)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_325111", "325111037", "story_v_out_325111.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_325111", "325111037", "story_v_out_325111.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_20 = math.max(var_160_11, arg_157_1.talkMaxDuration)

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_20 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_10) / var_160_20

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_10 + var_160_20 and arg_157_1.time_ < var_160_10 + var_160_20 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play325111038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 325111038
		arg_161_1.duration_ = 6.87

		local var_161_0 = {
			zh = 5.533,
			ja = 6.866
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play325111039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1053ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1053ui_story == nil then
				arg_161_1.var_.characterEffect1053ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1053ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1053ui_story then
				arg_161_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_164_4 = arg_161_1.actors_["1075ui_story"]
			local var_164_5 = 0

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1075ui_story == nil then
				arg_161_1.var_.characterEffect1075ui_story = var_164_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_6 and not isNil(var_164_4) then
				local var_164_7 = (arg_161_1.time_ - var_164_5) / var_164_6

				if arg_161_1.var_.characterEffect1075ui_story and not isNil(var_164_4) then
					local var_164_8 = Mathf.Lerp(0, 0.5, var_164_7)

					arg_161_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1075ui_story.fillRatio = var_164_8
				end
			end

			if arg_161_1.time_ >= var_164_5 + var_164_6 and arg_161_1.time_ < var_164_5 + var_164_6 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1075ui_story then
				local var_164_9 = 0.5

				arg_161_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1075ui_story.fillRatio = var_164_9
			end

			local var_164_10 = 0
			local var_164_11 = 0.6

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_12 = arg_161_1:FormatText(StoryNameCfg[472].name)

				arg_161_1.leftNameTxt_.text = var_164_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_13 = arg_161_1:GetWordFromCfg(325111038)
				local var_164_14 = arg_161_1:FormatText(var_164_13.content)

				arg_161_1.text_.text = var_164_14

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_15 = 24
				local var_164_16 = utf8.len(var_164_14)
				local var_164_17 = var_164_15 <= 0 and var_164_11 or var_164_11 * (var_164_16 / var_164_15)

				if var_164_17 > 0 and var_164_11 < var_164_17 then
					arg_161_1.talkMaxDuration = var_164_17

					if var_164_17 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_17 + var_164_10
					end
				end

				arg_161_1.text_.text = var_164_14
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111038", "story_v_out_325111.awb") ~= 0 then
					local var_164_18 = manager.audio:GetVoiceLength("story_v_out_325111", "325111038", "story_v_out_325111.awb") / 1000

					if var_164_18 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_18 + var_164_10
					end

					if var_164_13.prefab_name ~= "" and arg_161_1.actors_[var_164_13.prefab_name] ~= nil then
						local var_164_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_13.prefab_name].transform, "story_v_out_325111", "325111038", "story_v_out_325111.awb")

						arg_161_1:RecordAudio("325111038", var_164_19)
						arg_161_1:RecordAudio("325111038", var_164_19)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_325111", "325111038", "story_v_out_325111.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_325111", "325111038", "story_v_out_325111.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_20 = math.max(var_164_11, arg_161_1.talkMaxDuration)

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_20 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_10) / var_164_20

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_10 + var_164_20 and arg_161_1.time_ < var_164_10 + var_164_20 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play325111039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 325111039
		arg_165_1.duration_ = 11.43

		local var_165_0 = {
			zh = 6.766,
			ja = 11.433
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play325111040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1075ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1075ui_story == nil then
				arg_165_1.var_.characterEffect1075ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1075ui_story and not isNil(var_168_0) then
					arg_165_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1075ui_story then
				arg_165_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_168_4 = arg_165_1.actors_["1053ui_story"]
			local var_168_5 = 0

			if var_168_5 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1053ui_story == nil then
				arg_165_1.var_.characterEffect1053ui_story = var_168_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_6 = 0.200000002980232

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_6 and not isNil(var_168_4) then
				local var_168_7 = (arg_165_1.time_ - var_168_5) / var_168_6

				if arg_165_1.var_.characterEffect1053ui_story and not isNil(var_168_4) then
					local var_168_8 = Mathf.Lerp(0, 0.5, var_168_7)

					arg_165_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1053ui_story.fillRatio = var_168_8
				end
			end

			if arg_165_1.time_ >= var_168_5 + var_168_6 and arg_165_1.time_ < var_168_5 + var_168_6 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1053ui_story then
				local var_168_9 = 0.5

				arg_165_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1053ui_story.fillRatio = var_168_9
			end

			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
				arg_165_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_168_11 = 0
			local var_168_12 = 0.8

			if var_168_11 < arg_165_1.time_ and arg_165_1.time_ <= var_168_11 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_13 = arg_165_1:FormatText(StoryNameCfg[381].name)

				arg_165_1.leftNameTxt_.text = var_168_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_14 = arg_165_1:GetWordFromCfg(325111039)
				local var_168_15 = arg_165_1:FormatText(var_168_14.content)

				arg_165_1.text_.text = var_168_15

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_16 = 32
				local var_168_17 = utf8.len(var_168_15)
				local var_168_18 = var_168_16 <= 0 and var_168_12 or var_168_12 * (var_168_17 / var_168_16)

				if var_168_18 > 0 and var_168_12 < var_168_18 then
					arg_165_1.talkMaxDuration = var_168_18

					if var_168_18 + var_168_11 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_18 + var_168_11
					end
				end

				arg_165_1.text_.text = var_168_15
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111039", "story_v_out_325111.awb") ~= 0 then
					local var_168_19 = manager.audio:GetVoiceLength("story_v_out_325111", "325111039", "story_v_out_325111.awb") / 1000

					if var_168_19 + var_168_11 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_19 + var_168_11
					end

					if var_168_14.prefab_name ~= "" and arg_165_1.actors_[var_168_14.prefab_name] ~= nil then
						local var_168_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_14.prefab_name].transform, "story_v_out_325111", "325111039", "story_v_out_325111.awb")

						arg_165_1:RecordAudio("325111039", var_168_20)
						arg_165_1:RecordAudio("325111039", var_168_20)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_325111", "325111039", "story_v_out_325111.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_325111", "325111039", "story_v_out_325111.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_21 = math.max(var_168_12, arg_165_1.talkMaxDuration)

			if var_168_11 <= arg_165_1.time_ and arg_165_1.time_ < var_168_11 + var_168_21 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_11) / var_168_21

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_11 + var_168_21 and arg_165_1.time_ < var_168_11 + var_168_21 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play325111040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 325111040
		arg_169_1.duration_ = 13.6

		local var_169_0 = {
			zh = 9.933,
			ja = 13.6
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play325111041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 1.225

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[381].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:GetWordFromCfg(325111040)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 49
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111040", "story_v_out_325111.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_325111", "325111040", "story_v_out_325111.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_325111", "325111040", "story_v_out_325111.awb")

						arg_169_1:RecordAudio("325111040", var_172_9)
						arg_169_1:RecordAudio("325111040", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_325111", "325111040", "story_v_out_325111.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_325111", "325111040", "story_v_out_325111.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_10 and arg_169_1.time_ < var_172_0 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play325111041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 325111041
		arg_173_1.duration_ = 9.97

		local var_173_0 = {
			zh = 7.1,
			ja = 9.966
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play325111042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action6_1")
			end

			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_176_2 = 0
			local var_176_3 = 0.825

			if var_176_2 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_4 = arg_173_1:FormatText(StoryNameCfg[381].name)

				arg_173_1.leftNameTxt_.text = var_176_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_5 = arg_173_1:GetWordFromCfg(325111041)
				local var_176_6 = arg_173_1:FormatText(var_176_5.content)

				arg_173_1.text_.text = var_176_6

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 33
				local var_176_8 = utf8.len(var_176_6)
				local var_176_9 = var_176_7 <= 0 and var_176_3 or var_176_3 * (var_176_8 / var_176_7)

				if var_176_9 > 0 and var_176_3 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_6
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111041", "story_v_out_325111.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_325111", "325111041", "story_v_out_325111.awb") / 1000

					if var_176_10 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_2
					end

					if var_176_5.prefab_name ~= "" and arg_173_1.actors_[var_176_5.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_5.prefab_name].transform, "story_v_out_325111", "325111041", "story_v_out_325111.awb")

						arg_173_1:RecordAudio("325111041", var_176_11)
						arg_173_1:RecordAudio("325111041", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_325111", "325111041", "story_v_out_325111.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_325111", "325111041", "story_v_out_325111.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_12 and arg_173_1.time_ < var_176_2 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play325111042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 325111042
		arg_177_1.duration_ = 8.73

		local var_177_0 = {
			zh = 6.3,
			ja = 8.733
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
				arg_177_0:Play325111043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1053ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1053ui_story == nil then
				arg_177_1.var_.characterEffect1053ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1053ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1053ui_story then
				arg_177_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_180_4 = arg_177_1.actors_["1075ui_story"]
			local var_180_5 = 0

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1075ui_story == nil then
				arg_177_1.var_.characterEffect1075ui_story = var_180_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_6 = 0.200000002980232

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_6 and not isNil(var_180_4) then
				local var_180_7 = (arg_177_1.time_ - var_180_5) / var_180_6

				if arg_177_1.var_.characterEffect1075ui_story and not isNil(var_180_4) then
					local var_180_8 = Mathf.Lerp(0, 0.5, var_180_7)

					arg_177_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1075ui_story.fillRatio = var_180_8
				end
			end

			if arg_177_1.time_ >= var_180_5 + var_180_6 and arg_177_1.time_ < var_180_5 + var_180_6 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1075ui_story then
				local var_180_9 = 0.5

				arg_177_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1075ui_story.fillRatio = var_180_9
			end

			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 then
				arg_177_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_2")
			end

			local var_180_11 = 0
			local var_180_12 = 0.65

			if var_180_11 < arg_177_1.time_ and arg_177_1.time_ <= var_180_11 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_13 = arg_177_1:FormatText(StoryNameCfg[472].name)

				arg_177_1.leftNameTxt_.text = var_180_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_14 = arg_177_1:GetWordFromCfg(325111042)
				local var_180_15 = arg_177_1:FormatText(var_180_14.content)

				arg_177_1.text_.text = var_180_15

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_16 = 26
				local var_180_17 = utf8.len(var_180_15)
				local var_180_18 = var_180_16 <= 0 and var_180_12 or var_180_12 * (var_180_17 / var_180_16)

				if var_180_18 > 0 and var_180_12 < var_180_18 then
					arg_177_1.talkMaxDuration = var_180_18

					if var_180_18 + var_180_11 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_18 + var_180_11
					end
				end

				arg_177_1.text_.text = var_180_15
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111042", "story_v_out_325111.awb") ~= 0 then
					local var_180_19 = manager.audio:GetVoiceLength("story_v_out_325111", "325111042", "story_v_out_325111.awb") / 1000

					if var_180_19 + var_180_11 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_19 + var_180_11
					end

					if var_180_14.prefab_name ~= "" and arg_177_1.actors_[var_180_14.prefab_name] ~= nil then
						local var_180_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_14.prefab_name].transform, "story_v_out_325111", "325111042", "story_v_out_325111.awb")

						arg_177_1:RecordAudio("325111042", var_180_20)
						arg_177_1:RecordAudio("325111042", var_180_20)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_325111", "325111042", "story_v_out_325111.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_325111", "325111042", "story_v_out_325111.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_21 = math.max(var_180_12, arg_177_1.talkMaxDuration)

			if var_180_11 <= arg_177_1.time_ and arg_177_1.time_ < var_180_11 + var_180_21 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_11) / var_180_21

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_11 + var_180_21 and arg_177_1.time_ < var_180_11 + var_180_21 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play325111043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 325111043
		arg_181_1.duration_ = 3.1

		local var_181_0 = {
			zh = 3,
			ja = 3.1
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
				arg_181_0:Play325111044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1075ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1075ui_story == nil then
				arg_181_1.var_.characterEffect1075ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1075ui_story and not isNil(var_184_0) then
					arg_181_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1075ui_story then
				arg_181_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["1053ui_story"]
			local var_184_5 = 0

			if var_184_5 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1053ui_story == nil then
				arg_181_1.var_.characterEffect1053ui_story = var_184_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_6 = 0.200000002980232

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_6 and not isNil(var_184_4) then
				local var_184_7 = (arg_181_1.time_ - var_184_5) / var_184_6

				if arg_181_1.var_.characterEffect1053ui_story and not isNil(var_184_4) then
					local var_184_8 = Mathf.Lerp(0, 0.5, var_184_7)

					arg_181_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1053ui_story.fillRatio = var_184_8
				end
			end

			if arg_181_1.time_ >= var_184_5 + var_184_6 and arg_181_1.time_ < var_184_5 + var_184_6 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1053ui_story then
				local var_184_9 = 0.5

				arg_181_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1053ui_story.fillRatio = var_184_9
			end

			local var_184_10 = 0
			local var_184_11 = 0.225

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_12 = arg_181_1:FormatText(StoryNameCfg[381].name)

				arg_181_1.leftNameTxt_.text = var_184_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_13 = arg_181_1:GetWordFromCfg(325111043)
				local var_184_14 = arg_181_1:FormatText(var_184_13.content)

				arg_181_1.text_.text = var_184_14

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_15 = 9
				local var_184_16 = utf8.len(var_184_14)
				local var_184_17 = var_184_15 <= 0 and var_184_11 or var_184_11 * (var_184_16 / var_184_15)

				if var_184_17 > 0 and var_184_11 < var_184_17 then
					arg_181_1.talkMaxDuration = var_184_17

					if var_184_17 + var_184_10 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_17 + var_184_10
					end
				end

				arg_181_1.text_.text = var_184_14
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111043", "story_v_out_325111.awb") ~= 0 then
					local var_184_18 = manager.audio:GetVoiceLength("story_v_out_325111", "325111043", "story_v_out_325111.awb") / 1000

					if var_184_18 + var_184_10 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_18 + var_184_10
					end

					if var_184_13.prefab_name ~= "" and arg_181_1.actors_[var_184_13.prefab_name] ~= nil then
						local var_184_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_13.prefab_name].transform, "story_v_out_325111", "325111043", "story_v_out_325111.awb")

						arg_181_1:RecordAudio("325111043", var_184_19)
						arg_181_1:RecordAudio("325111043", var_184_19)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_325111", "325111043", "story_v_out_325111.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_325111", "325111043", "story_v_out_325111.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_20 = math.max(var_184_11, arg_181_1.talkMaxDuration)

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_20 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_10) / var_184_20

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_10 + var_184_20 and arg_181_1.time_ < var_184_10 + var_184_20 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play325111044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 325111044
		arg_185_1.duration_ = 8

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play325111045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.66666666666667

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				local var_188_1 = manager.ui.mainCamera.transform.localPosition
				local var_188_2 = Vector3.New(0, 0, 10) + Vector3.New(var_188_1.x, var_188_1.y, 0)
				local var_188_3 = arg_185_1.bgs_.ST2010

				var_188_3.transform.localPosition = var_188_2
				var_188_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_4 = var_188_3:GetComponent("SpriteRenderer")

				if var_188_4 and var_188_4.sprite then
					local var_188_5 = (var_188_3.transform.localPosition - var_188_1).z
					local var_188_6 = manager.ui.mainCameraCom_
					local var_188_7 = 2 * var_188_5 * Mathf.Tan(var_188_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_188_8 = var_188_7 * var_188_6.aspect
					local var_188_9 = var_188_4.sprite.bounds.size.x
					local var_188_10 = var_188_4.sprite.bounds.size.y
					local var_188_11 = var_188_8 / var_188_9
					local var_188_12 = var_188_7 / var_188_10
					local var_188_13 = var_188_12 < var_188_11 and var_188_11 or var_188_12

					var_188_3.transform.localScale = Vector3.New(var_188_13, var_188_13, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "ST2010" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_14 = 1.66666666666667

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1.allBtn_.enabled = false
			end

			local var_188_15 = 0.3

			if arg_185_1.time_ >= var_188_14 + var_188_15 and arg_185_1.time_ < var_188_14 + var_188_15 + arg_188_0 then
				arg_185_1.allBtn_.enabled = true
			end

			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_17 = 1.66666666666667

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17
				local var_188_19 = Color.New(0, 0, 0)

				var_188_19.a = Mathf.Lerp(0, 1, var_188_18)
				arg_185_1.mask_.color = var_188_19
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 then
				local var_188_20 = Color.New(0, 0, 0)

				var_188_20.a = 1
				arg_185_1.mask_.color = var_188_20
			end

			local var_188_21 = 1.66666666666667

			if var_188_21 < arg_185_1.time_ and arg_185_1.time_ <= var_188_21 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_22 = 2

			if var_188_21 <= arg_185_1.time_ and arg_185_1.time_ < var_188_21 + var_188_22 then
				local var_188_23 = (arg_185_1.time_ - var_188_21) / var_188_22
				local var_188_24 = Color.New(0, 0, 0)

				var_188_24.a = Mathf.Lerp(1, 0, var_188_23)
				arg_185_1.mask_.color = var_188_24
			end

			if arg_185_1.time_ >= var_188_21 + var_188_22 and arg_185_1.time_ < var_188_21 + var_188_22 + arg_188_0 then
				local var_188_25 = Color.New(0, 0, 0)
				local var_188_26 = 0

				arg_185_1.mask_.enabled = false
				var_188_25.a = var_188_26
				arg_185_1.mask_.color = var_188_25
			end

			local var_188_27 = arg_185_1.actors_["1075ui_story"].transform
			local var_188_28 = 1.66666666666667

			if var_188_28 < arg_185_1.time_ and arg_185_1.time_ <= var_188_28 + arg_188_0 then
				arg_185_1.var_.moveOldPos1075ui_story = var_188_27.localPosition
			end

			local var_188_29 = 0.001

			if var_188_28 <= arg_185_1.time_ and arg_185_1.time_ < var_188_28 + var_188_29 then
				local var_188_30 = (arg_185_1.time_ - var_188_28) / var_188_29
				local var_188_31 = Vector3.New(0, 100, 0)

				var_188_27.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1075ui_story, var_188_31, var_188_30)

				local var_188_32 = manager.ui.mainCamera.transform.position - var_188_27.position

				var_188_27.forward = Vector3.New(var_188_32.x, var_188_32.y, var_188_32.z)

				local var_188_33 = var_188_27.localEulerAngles

				var_188_33.z = 0
				var_188_33.x = 0
				var_188_27.localEulerAngles = var_188_33
			end

			if arg_185_1.time_ >= var_188_28 + var_188_29 and arg_185_1.time_ < var_188_28 + var_188_29 + arg_188_0 then
				var_188_27.localPosition = Vector3.New(0, 100, 0)

				local var_188_34 = manager.ui.mainCamera.transform.position - var_188_27.position

				var_188_27.forward = Vector3.New(var_188_34.x, var_188_34.y, var_188_34.z)

				local var_188_35 = var_188_27.localEulerAngles

				var_188_35.z = 0
				var_188_35.x = 0
				var_188_27.localEulerAngles = var_188_35
			end

			local var_188_36 = arg_185_1.actors_["1053ui_story"].transform
			local var_188_37 = 1.66666666666667

			if var_188_37 < arg_185_1.time_ and arg_185_1.time_ <= var_188_37 + arg_188_0 then
				arg_185_1.var_.moveOldPos1053ui_story = var_188_36.localPosition

				local var_188_38 = GameObjectTools.GetOrAddComponent(var_188_36.gameObject, typeof(DynamicBoneHelper))

				if var_188_38 then
					var_188_38:EnableDynamicBone(false)
				end
			end

			local var_188_39 = 0.001

			if var_188_37 <= arg_185_1.time_ and arg_185_1.time_ < var_188_37 + var_188_39 then
				local var_188_40 = (arg_185_1.time_ - var_188_37) / var_188_39
				local var_188_41 = Vector3.New(0, 100, 0)

				var_188_36.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1053ui_story, var_188_41, var_188_40)

				local var_188_42 = manager.ui.mainCamera.transform.position - var_188_36.position

				var_188_36.forward = Vector3.New(var_188_42.x, var_188_42.y, var_188_42.z)

				local var_188_43 = var_188_36.localEulerAngles

				var_188_43.z = 0
				var_188_43.x = 0
				var_188_36.localEulerAngles = var_188_43
			end

			if arg_185_1.time_ >= var_188_37 + var_188_39 and arg_185_1.time_ < var_188_37 + var_188_39 + arg_188_0 then
				var_188_36.localPosition = Vector3.New(0, 100, 0)

				local var_188_44 = manager.ui.mainCamera.transform.position - var_188_36.position

				var_188_36.forward = Vector3.New(var_188_44.x, var_188_44.y, var_188_44.z)

				local var_188_45 = var_188_36.localEulerAngles

				var_188_45.z = 0
				var_188_45.x = 0
				var_188_36.localEulerAngles = var_188_45

				local var_188_46 = GameObjectTools.GetOrAddComponent(var_188_36.gameObject, typeof(DynamicBoneHelper))

				if var_188_46 then
					var_188_46:EnableDynamicBone(true)
				end
			end

			local var_188_47 = arg_185_1.actors_["1075ui_story"]
			local var_188_48 = 1.66666666666667

			if var_188_48 < arg_185_1.time_ and arg_185_1.time_ <= var_188_48 + arg_188_0 and not isNil(var_188_47) and arg_185_1.var_.characterEffect1075ui_story == nil then
				arg_185_1.var_.characterEffect1075ui_story = var_188_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_49 = 0.200000002980232

			if var_188_48 <= arg_185_1.time_ and arg_185_1.time_ < var_188_48 + var_188_49 and not isNil(var_188_47) then
				local var_188_50 = (arg_185_1.time_ - var_188_48) / var_188_49

				if arg_185_1.var_.characterEffect1075ui_story and not isNil(var_188_47) then
					local var_188_51 = Mathf.Lerp(0, 0.5, var_188_50)

					arg_185_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1075ui_story.fillRatio = var_188_51
				end
			end

			if arg_185_1.time_ >= var_188_48 + var_188_49 and arg_185_1.time_ < var_188_48 + var_188_49 + arg_188_0 and not isNil(var_188_47) and arg_185_1.var_.characterEffect1075ui_story then
				local var_188_52 = 0.5

				arg_185_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1075ui_story.fillRatio = var_188_52
			end

			local var_188_53 = 0.1
			local var_188_54 = 1

			if var_188_53 < arg_185_1.time_ and arg_185_1.time_ <= var_188_53 + arg_188_0 then
				local var_188_55 = "play"
				local var_188_56 = "effect"

				arg_185_1:AudioAction(var_188_55, var_188_56, "se_story_140", "se_story_140_foley_down", "")
			end

			local var_188_57 = 0.5
			local var_188_58 = 1

			if var_188_57 < arg_185_1.time_ and arg_185_1.time_ <= var_188_57 + arg_188_0 then
				local var_188_59 = "play"
				local var_188_60 = "effect"

				arg_185_1:AudioAction(var_188_59, var_188_60, "se_story_activity_2_1_4", "se_story_activity_2_1_4_warchess_box_down", "")
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_61 = 3
			local var_188_62 = 1.2

			if var_188_61 < arg_185_1.time_ and arg_185_1.time_ <= var_188_61 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_63 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_63:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_64 = arg_185_1:GetWordFromCfg(325111044)
				local var_188_65 = arg_185_1:FormatText(var_188_64.content)

				arg_185_1.text_.text = var_188_65

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_66 = 48
				local var_188_67 = utf8.len(var_188_65)
				local var_188_68 = var_188_66 <= 0 and var_188_62 or var_188_62 * (var_188_67 / var_188_66)

				if var_188_68 > 0 and var_188_62 < var_188_68 then
					arg_185_1.talkMaxDuration = var_188_68
					var_188_61 = var_188_61 + 0.3

					if var_188_68 + var_188_61 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_68 + var_188_61
					end
				end

				arg_185_1.text_.text = var_188_65
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_69 = var_188_61 + 0.3
			local var_188_70 = math.max(var_188_62, arg_185_1.talkMaxDuration)

			if var_188_69 <= arg_185_1.time_ and arg_185_1.time_ < var_188_69 + var_188_70 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_69) / var_188_70

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_69 + var_188_70 and arg_185_1.time_ < var_188_69 + var_188_70 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play325111045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 325111045
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play325111046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_194_1 = 0
			local var_194_2 = 1.175

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:GetWordFromCfg(325111045)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 47
				local var_194_6 = utf8.len(var_194_4)
				local var_194_7 = var_194_5 <= 0 and var_194_2 or var_194_2 * (var_194_6 / var_194_5)

				if var_194_7 > 0 and var_194_2 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_8 and arg_191_1.time_ < var_194_1 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play325111046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 325111046
		arg_195_1.duration_ = 6

		local var_195_0 = {
			zh = 6,
			ja = 4.8
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
				arg_195_0:Play325111047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1077ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1077ui_story = var_198_0.localPosition

				local var_198_2 = GameObjectTools.GetOrAddComponent(var_198_0.gameObject, typeof(DynamicBoneHelper))

				if var_198_2 then
					var_198_2:EnableDynamicBone(false)
				end
			end

			local var_198_3 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_3 then
				local var_198_4 = (arg_195_1.time_ - var_198_1) / var_198_3
				local var_198_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1077ui_story, var_198_5, var_198_4)

				local var_198_6 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_6.x, var_198_6.y, var_198_6.z)

				local var_198_7 = var_198_0.localEulerAngles

				var_198_7.z = 0
				var_198_7.x = 0
				var_198_0.localEulerAngles = var_198_7
			end

			if arg_195_1.time_ >= var_198_1 + var_198_3 and arg_195_1.time_ < var_198_1 + var_198_3 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_198_8 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_8.x, var_198_8.y, var_198_8.z)

				local var_198_9 = var_198_0.localEulerAngles

				var_198_9.z = 0
				var_198_9.x = 0
				var_198_0.localEulerAngles = var_198_9

				local var_198_10 = GameObjectTools.GetOrAddComponent(var_198_0.gameObject, typeof(DynamicBoneHelper))

				if var_198_10 then
					var_198_10:EnableDynamicBone(true)
				end
			end

			local var_198_11 = arg_195_1.actors_["1077ui_story"]
			local var_198_12 = 0

			if var_198_12 < arg_195_1.time_ and arg_195_1.time_ <= var_198_12 + arg_198_0 and not isNil(var_198_11) and arg_195_1.var_.characterEffect1077ui_story == nil then
				arg_195_1.var_.characterEffect1077ui_story = var_198_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_13 = 0.200000002980232

			if var_198_12 <= arg_195_1.time_ and arg_195_1.time_ < var_198_12 + var_198_13 and not isNil(var_198_11) then
				local var_198_14 = (arg_195_1.time_ - var_198_12) / var_198_13

				if arg_195_1.var_.characterEffect1077ui_story and not isNil(var_198_11) then
					arg_195_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_12 + var_198_13 and arg_195_1.time_ < var_198_12 + var_198_13 + arg_198_0 and not isNil(var_198_11) and arg_195_1.var_.characterEffect1077ui_story then
				arg_195_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_198_15 = 0

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_198_16 = 0
			local var_198_17 = 0.675

			if var_198_16 < arg_195_1.time_ and arg_195_1.time_ <= var_198_16 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_18 = arg_195_1:FormatText(StoryNameCfg[1467].name)

				arg_195_1.leftNameTxt_.text = var_198_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_19 = arg_195_1:GetWordFromCfg(325111046)
				local var_198_20 = arg_195_1:FormatText(var_198_19.content)

				arg_195_1.text_.text = var_198_20

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_21 = 27
				local var_198_22 = utf8.len(var_198_20)
				local var_198_23 = var_198_21 <= 0 and var_198_17 or var_198_17 * (var_198_22 / var_198_21)

				if var_198_23 > 0 and var_198_17 < var_198_23 then
					arg_195_1.talkMaxDuration = var_198_23

					if var_198_23 + var_198_16 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_23 + var_198_16
					end
				end

				arg_195_1.text_.text = var_198_20
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111046", "story_v_out_325111.awb") ~= 0 then
					local var_198_24 = manager.audio:GetVoiceLength("story_v_out_325111", "325111046", "story_v_out_325111.awb") / 1000

					if var_198_24 + var_198_16 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_24 + var_198_16
					end

					if var_198_19.prefab_name ~= "" and arg_195_1.actors_[var_198_19.prefab_name] ~= nil then
						local var_198_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_19.prefab_name].transform, "story_v_out_325111", "325111046", "story_v_out_325111.awb")

						arg_195_1:RecordAudio("325111046", var_198_25)
						arg_195_1:RecordAudio("325111046", var_198_25)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_325111", "325111046", "story_v_out_325111.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_325111", "325111046", "story_v_out_325111.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_26 = math.max(var_198_17, arg_195_1.talkMaxDuration)

			if var_198_16 <= arg_195_1.time_ and arg_195_1.time_ < var_198_16 + var_198_26 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_16) / var_198_26

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_16 + var_198_26 and arg_195_1.time_ < var_198_16 + var_198_26 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play325111047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 325111047
		arg_199_1.duration_ = 11.67

		local var_199_0 = {
			zh = 11.033,
			ja = 11.666
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
				arg_199_0:Play325111048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 1.125

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[1467].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:GetWordFromCfg(325111047)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111047", "story_v_out_325111.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_325111", "325111047", "story_v_out_325111.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_325111", "325111047", "story_v_out_325111.awb")

						arg_199_1:RecordAudio("325111047", var_202_9)
						arg_199_1:RecordAudio("325111047", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_325111", "325111047", "story_v_out_325111.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_325111", "325111047", "story_v_out_325111.awb")
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
	Play325111048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 325111048
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play325111049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1077ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos1077ui_story = var_206_0.localPosition

				local var_206_2 = GameObjectTools.GetOrAddComponent(var_206_0.gameObject, typeof(DynamicBoneHelper))

				if var_206_2 then
					var_206_2:EnableDynamicBone(false)
				end
			end

			local var_206_3 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_3 then
				local var_206_4 = (arg_203_1.time_ - var_206_1) / var_206_3
				local var_206_5 = Vector3.New(0, 100, 0)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1077ui_story, var_206_5, var_206_4)

				local var_206_6 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_6.x, var_206_6.y, var_206_6.z)

				local var_206_7 = var_206_0.localEulerAngles

				var_206_7.z = 0
				var_206_7.x = 0
				var_206_0.localEulerAngles = var_206_7
			end

			if arg_203_1.time_ >= var_206_1 + var_206_3 and arg_203_1.time_ < var_206_1 + var_206_3 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, 100, 0)

				local var_206_8 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_8.x, var_206_8.y, var_206_8.z)

				local var_206_9 = var_206_0.localEulerAngles

				var_206_9.z = 0
				var_206_9.x = 0
				var_206_0.localEulerAngles = var_206_9

				local var_206_10 = GameObjectTools.GetOrAddComponent(var_206_0.gameObject, typeof(DynamicBoneHelper))

				if var_206_10 then
					var_206_10:EnableDynamicBone(true)
				end
			end

			local var_206_11 = arg_203_1.actors_["1077ui_story"]
			local var_206_12 = 0

			if var_206_12 < arg_203_1.time_ and arg_203_1.time_ <= var_206_12 + arg_206_0 and not isNil(var_206_11) and arg_203_1.var_.characterEffect1077ui_story == nil then
				arg_203_1.var_.characterEffect1077ui_story = var_206_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_13 = 0.200000002980232

			if var_206_12 <= arg_203_1.time_ and arg_203_1.time_ < var_206_12 + var_206_13 and not isNil(var_206_11) then
				local var_206_14 = (arg_203_1.time_ - var_206_12) / var_206_13

				if arg_203_1.var_.characterEffect1077ui_story and not isNil(var_206_11) then
					local var_206_15 = Mathf.Lerp(0, 0.5, var_206_14)

					arg_203_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1077ui_story.fillRatio = var_206_15
				end
			end

			if arg_203_1.time_ >= var_206_12 + var_206_13 and arg_203_1.time_ < var_206_12 + var_206_13 + arg_206_0 and not isNil(var_206_11) and arg_203_1.var_.characterEffect1077ui_story then
				local var_206_16 = 0.5

				arg_203_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1077ui_story.fillRatio = var_206_16
			end

			local var_206_17 = 0
			local var_206_18 = 0.95

			if var_206_17 < arg_203_1.time_ and arg_203_1.time_ <= var_206_17 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_19 = arg_203_1:GetWordFromCfg(325111048)
				local var_206_20 = arg_203_1:FormatText(var_206_19.content)

				arg_203_1.text_.text = var_206_20

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_21 = 38
				local var_206_22 = utf8.len(var_206_20)
				local var_206_23 = var_206_21 <= 0 and var_206_18 or var_206_18 * (var_206_22 / var_206_21)

				if var_206_23 > 0 and var_206_18 < var_206_23 then
					arg_203_1.talkMaxDuration = var_206_23

					if var_206_23 + var_206_17 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_23 + var_206_17
					end
				end

				arg_203_1.text_.text = var_206_20
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_24 = math.max(var_206_18, arg_203_1.talkMaxDuration)

			if var_206_17 <= arg_203_1.time_ and arg_203_1.time_ < var_206_17 + var_206_24 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_17) / var_206_24

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_17 + var_206_24 and arg_203_1.time_ < var_206_17 + var_206_24 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play325111049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 325111049
		arg_207_1.duration_ = 4.57

		local var_207_0 = {
			zh = 4.166,
			ja = 4.566
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
				arg_207_0:Play325111050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1077ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1077ui_story = var_210_0.localPosition

				local var_210_2 = GameObjectTools.GetOrAddComponent(var_210_0.gameObject, typeof(DynamicBoneHelper))

				if var_210_2 then
					var_210_2:EnableDynamicBone(false)
				end
			end

			local var_210_3 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_3 then
				local var_210_4 = (arg_207_1.time_ - var_210_1) / var_210_3
				local var_210_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1077ui_story, var_210_5, var_210_4)

				local var_210_6 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_6.x, var_210_6.y, var_210_6.z)

				local var_210_7 = var_210_0.localEulerAngles

				var_210_7.z = 0
				var_210_7.x = 0
				var_210_0.localEulerAngles = var_210_7
			end

			if arg_207_1.time_ >= var_210_1 + var_210_3 and arg_207_1.time_ < var_210_1 + var_210_3 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_210_8 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_8.x, var_210_8.y, var_210_8.z)

				local var_210_9 = var_210_0.localEulerAngles

				var_210_9.z = 0
				var_210_9.x = 0
				var_210_0.localEulerAngles = var_210_9

				local var_210_10 = GameObjectTools.GetOrAddComponent(var_210_0.gameObject, typeof(DynamicBoneHelper))

				if var_210_10 then
					var_210_10:EnableDynamicBone(true)
				end
			end

			local var_210_11 = arg_207_1.actors_["1077ui_story"]
			local var_210_12 = 0

			if var_210_12 < arg_207_1.time_ and arg_207_1.time_ <= var_210_12 + arg_210_0 and not isNil(var_210_11) and arg_207_1.var_.characterEffect1077ui_story == nil then
				arg_207_1.var_.characterEffect1077ui_story = var_210_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_13 = 0.200000002980232

			if var_210_12 <= arg_207_1.time_ and arg_207_1.time_ < var_210_12 + var_210_13 and not isNil(var_210_11) then
				local var_210_14 = (arg_207_1.time_ - var_210_12) / var_210_13

				if arg_207_1.var_.characterEffect1077ui_story and not isNil(var_210_11) then
					arg_207_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_12 + var_210_13 and arg_207_1.time_ < var_210_12 + var_210_13 + arg_210_0 and not isNil(var_210_11) and arg_207_1.var_.characterEffect1077ui_story then
				arg_207_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_210_15 = 0
			local var_210_16 = 0.425

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_17 = arg_207_1:FormatText(StoryNameCfg[1467].name)

				arg_207_1.leftNameTxt_.text = var_210_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_18 = arg_207_1:GetWordFromCfg(325111049)
				local var_210_19 = arg_207_1:FormatText(var_210_18.content)

				arg_207_1.text_.text = var_210_19

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_20 = 17
				local var_210_21 = utf8.len(var_210_19)
				local var_210_22 = var_210_20 <= 0 and var_210_16 or var_210_16 * (var_210_21 / var_210_20)

				if var_210_22 > 0 and var_210_16 < var_210_22 then
					arg_207_1.talkMaxDuration = var_210_22

					if var_210_22 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_22 + var_210_15
					end
				end

				arg_207_1.text_.text = var_210_19
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111049", "story_v_out_325111.awb") ~= 0 then
					local var_210_23 = manager.audio:GetVoiceLength("story_v_out_325111", "325111049", "story_v_out_325111.awb") / 1000

					if var_210_23 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_23 + var_210_15
					end

					if var_210_18.prefab_name ~= "" and arg_207_1.actors_[var_210_18.prefab_name] ~= nil then
						local var_210_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_18.prefab_name].transform, "story_v_out_325111", "325111049", "story_v_out_325111.awb")

						arg_207_1:RecordAudio("325111049", var_210_24)
						arg_207_1:RecordAudio("325111049", var_210_24)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_325111", "325111049", "story_v_out_325111.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_325111", "325111049", "story_v_out_325111.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_25 = math.max(var_210_16, arg_207_1.talkMaxDuration)

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_25 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_15) / var_210_25

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_15 + var_210_25 and arg_207_1.time_ < var_210_15 + var_210_25 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play325111050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 325111050
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play325111051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1077ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1077ui_story = var_214_0.localPosition

				local var_214_2 = GameObjectTools.GetOrAddComponent(var_214_0.gameObject, typeof(DynamicBoneHelper))

				if var_214_2 then
					var_214_2:EnableDynamicBone(false)
				end
			end

			local var_214_3 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_3 then
				local var_214_4 = (arg_211_1.time_ - var_214_1) / var_214_3
				local var_214_5 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1077ui_story, var_214_5, var_214_4)

				local var_214_6 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_6.x, var_214_6.y, var_214_6.z)

				local var_214_7 = var_214_0.localEulerAngles

				var_214_7.z = 0
				var_214_7.x = 0
				var_214_0.localEulerAngles = var_214_7
			end

			if arg_211_1.time_ >= var_214_1 + var_214_3 and arg_211_1.time_ < var_214_1 + var_214_3 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, 100, 0)

				local var_214_8 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_8.x, var_214_8.y, var_214_8.z)

				local var_214_9 = var_214_0.localEulerAngles

				var_214_9.z = 0
				var_214_9.x = 0
				var_214_0.localEulerAngles = var_214_9

				local var_214_10 = GameObjectTools.GetOrAddComponent(var_214_0.gameObject, typeof(DynamicBoneHelper))

				if var_214_10 then
					var_214_10:EnableDynamicBone(true)
				end
			end

			local var_214_11 = arg_211_1.actors_["1077ui_story"]
			local var_214_12 = 0

			if var_214_12 < arg_211_1.time_ and arg_211_1.time_ <= var_214_12 + arg_214_0 and not isNil(var_214_11) and arg_211_1.var_.characterEffect1077ui_story == nil then
				arg_211_1.var_.characterEffect1077ui_story = var_214_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_13 = 0.200000002980232

			if var_214_12 <= arg_211_1.time_ and arg_211_1.time_ < var_214_12 + var_214_13 and not isNil(var_214_11) then
				local var_214_14 = (arg_211_1.time_ - var_214_12) / var_214_13

				if arg_211_1.var_.characterEffect1077ui_story and not isNil(var_214_11) then
					local var_214_15 = Mathf.Lerp(0, 0.5, var_214_14)

					arg_211_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1077ui_story.fillRatio = var_214_15
				end
			end

			if arg_211_1.time_ >= var_214_12 + var_214_13 and arg_211_1.time_ < var_214_12 + var_214_13 + arg_214_0 and not isNil(var_214_11) and arg_211_1.var_.characterEffect1077ui_story then
				local var_214_16 = 0.5

				arg_211_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1077ui_story.fillRatio = var_214_16
			end

			local var_214_17 = 0
			local var_214_18 = 1.325

			if var_214_17 < arg_211_1.time_ and arg_211_1.time_ <= var_214_17 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_19 = arg_211_1:GetWordFromCfg(325111050)
				local var_214_20 = arg_211_1:FormatText(var_214_19.content)

				arg_211_1.text_.text = var_214_20

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_21 = 53
				local var_214_22 = utf8.len(var_214_20)
				local var_214_23 = var_214_21 <= 0 and var_214_18 or var_214_18 * (var_214_22 / var_214_21)

				if var_214_23 > 0 and var_214_18 < var_214_23 then
					arg_211_1.talkMaxDuration = var_214_23

					if var_214_23 + var_214_17 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_23 + var_214_17
					end
				end

				arg_211_1.text_.text = var_214_20
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_24 = math.max(var_214_18, arg_211_1.talkMaxDuration)

			if var_214_17 <= arg_211_1.time_ and arg_211_1.time_ < var_214_17 + var_214_24 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_17) / var_214_24

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_17 + var_214_24 and arg_211_1.time_ < var_214_17 + var_214_24 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play325111051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 325111051
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play325111052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 1.05

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(325111051)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 42
				local var_218_5 = utf8.len(var_218_3)
				local var_218_6 = var_218_4 <= 0 and var_218_1 or var_218_1 * (var_218_5 / var_218_4)

				if var_218_6 > 0 and var_218_1 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_7 and arg_215_1.time_ < var_218_0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play325111052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 325111052
		arg_219_1.duration_ = 4.97

		local var_219_0 = {
			zh = 4.766,
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
				arg_219_0:Play325111053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1077ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1077ui_story = var_222_0.localPosition

				local var_222_2 = GameObjectTools.GetOrAddComponent(var_222_0.gameObject, typeof(DynamicBoneHelper))

				if var_222_2 then
					var_222_2:EnableDynamicBone(false)
				end
			end

			local var_222_3 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_3 then
				local var_222_4 = (arg_219_1.time_ - var_222_1) / var_222_3
				local var_222_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1077ui_story, var_222_5, var_222_4)

				local var_222_6 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_6.x, var_222_6.y, var_222_6.z)

				local var_222_7 = var_222_0.localEulerAngles

				var_222_7.z = 0
				var_222_7.x = 0
				var_222_0.localEulerAngles = var_222_7
			end

			if arg_219_1.time_ >= var_222_1 + var_222_3 and arg_219_1.time_ < var_222_1 + var_222_3 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_222_8 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_8.x, var_222_8.y, var_222_8.z)

				local var_222_9 = var_222_0.localEulerAngles

				var_222_9.z = 0
				var_222_9.x = 0
				var_222_0.localEulerAngles = var_222_9

				local var_222_10 = GameObjectTools.GetOrAddComponent(var_222_0.gameObject, typeof(DynamicBoneHelper))

				if var_222_10 then
					var_222_10:EnableDynamicBone(true)
				end
			end

			local var_222_11 = arg_219_1.actors_["1077ui_story"]
			local var_222_12 = 0

			if var_222_12 < arg_219_1.time_ and arg_219_1.time_ <= var_222_12 + arg_222_0 and not isNil(var_222_11) and arg_219_1.var_.characterEffect1077ui_story == nil then
				arg_219_1.var_.characterEffect1077ui_story = var_222_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_13 = 0.200000002980232

			if var_222_12 <= arg_219_1.time_ and arg_219_1.time_ < var_222_12 + var_222_13 and not isNil(var_222_11) then
				local var_222_14 = (arg_219_1.time_ - var_222_12) / var_222_13

				if arg_219_1.var_.characterEffect1077ui_story and not isNil(var_222_11) then
					arg_219_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_12 + var_222_13 and arg_219_1.time_ < var_222_12 + var_222_13 + arg_222_0 and not isNil(var_222_11) and arg_219_1.var_.characterEffect1077ui_story then
				arg_219_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_222_15 = 0

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			local var_222_16 = 0
			local var_222_17 = 0.575

			if var_222_16 < arg_219_1.time_ and arg_219_1.time_ <= var_222_16 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_18 = arg_219_1:FormatText(StoryNameCfg[1467].name)

				arg_219_1.leftNameTxt_.text = var_222_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_19 = arg_219_1:GetWordFromCfg(325111052)
				local var_222_20 = arg_219_1:FormatText(var_222_19.content)

				arg_219_1.text_.text = var_222_20

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_21 = 23
				local var_222_22 = utf8.len(var_222_20)
				local var_222_23 = var_222_21 <= 0 and var_222_17 or var_222_17 * (var_222_22 / var_222_21)

				if var_222_23 > 0 and var_222_17 < var_222_23 then
					arg_219_1.talkMaxDuration = var_222_23

					if var_222_23 + var_222_16 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_23 + var_222_16
					end
				end

				arg_219_1.text_.text = var_222_20
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111052", "story_v_out_325111.awb") ~= 0 then
					local var_222_24 = manager.audio:GetVoiceLength("story_v_out_325111", "325111052", "story_v_out_325111.awb") / 1000

					if var_222_24 + var_222_16 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_24 + var_222_16
					end

					if var_222_19.prefab_name ~= "" and arg_219_1.actors_[var_222_19.prefab_name] ~= nil then
						local var_222_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_19.prefab_name].transform, "story_v_out_325111", "325111052", "story_v_out_325111.awb")

						arg_219_1:RecordAudio("325111052", var_222_25)
						arg_219_1:RecordAudio("325111052", var_222_25)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_325111", "325111052", "story_v_out_325111.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_325111", "325111052", "story_v_out_325111.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_26 = math.max(var_222_17, arg_219_1.talkMaxDuration)

			if var_222_16 <= arg_219_1.time_ and arg_219_1.time_ < var_222_16 + var_222_26 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_16) / var_222_26

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_16 + var_222_26 and arg_219_1.time_ < var_222_16 + var_222_26 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play325111053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 325111053
		arg_223_1.duration_ = 4.37

		local var_223_0 = {
			zh = 4.366,
			ja = 3.433
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
				arg_223_0:Play325111054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1077ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1077ui_story == nil then
				arg_223_1.var_.characterEffect1077ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect1077ui_story and not isNil(var_226_0) then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1077ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1077ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1077ui_story.fillRatio = var_226_5
			end

			local var_226_6 = 0

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			local var_226_7 = 1.23333333333333

			if arg_223_1.time_ >= var_226_6 + var_226_7 and arg_223_1.time_ < var_226_6 + var_226_7 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end

			local var_226_8 = 0
			local var_226_9 = 0.35

			if var_226_8 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_10 = arg_223_1:FormatText(StoryNameCfg[1455].name)

				arg_223_1.leftNameTxt_.text = var_226_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_11 = arg_223_1:GetWordFromCfg(325111053)
				local var_226_12 = arg_223_1:FormatText(var_226_11.content)

				arg_223_1.text_.text = var_226_12

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_13 = 14
				local var_226_14 = utf8.len(var_226_12)
				local var_226_15 = var_226_13 <= 0 and var_226_9 or var_226_9 * (var_226_14 / var_226_13)

				if var_226_15 > 0 and var_226_9 < var_226_15 then
					arg_223_1.talkMaxDuration = var_226_15

					if var_226_15 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_15 + var_226_8
					end
				end

				arg_223_1.text_.text = var_226_12
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111053", "story_v_out_325111.awb") ~= 0 then
					local var_226_16 = manager.audio:GetVoiceLength("story_v_out_325111", "325111053", "story_v_out_325111.awb") / 1000

					if var_226_16 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_16 + var_226_8
					end

					if var_226_11.prefab_name ~= "" and arg_223_1.actors_[var_226_11.prefab_name] ~= nil then
						local var_226_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_11.prefab_name].transform, "story_v_out_325111", "325111053", "story_v_out_325111.awb")

						arg_223_1:RecordAudio("325111053", var_226_17)
						arg_223_1:RecordAudio("325111053", var_226_17)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_325111", "325111053", "story_v_out_325111.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_325111", "325111053", "story_v_out_325111.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_18 = math.max(var_226_9, arg_223_1.talkMaxDuration)

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_18 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_8) / var_226_18

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_8 + var_226_18 and arg_223_1.time_ < var_226_8 + var_226_18 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play325111054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 325111054
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play325111055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = "1059ui_story"

			if arg_227_1.actors_[var_230_0] == nil then
				local var_230_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_230_1) then
					local var_230_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_227_1.stage_.transform)

					var_230_2.name = var_230_0
					var_230_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_227_1.actors_[var_230_0] = var_230_2

					local var_230_3 = var_230_2:GetComponentInChildren(typeof(CharacterEffect))

					var_230_3.enabled = true

					local var_230_4 = GameObjectTools.GetOrAddComponent(var_230_2, typeof(DynamicBoneHelper))

					if var_230_4 then
						var_230_4:EnableDynamicBone(false)
					end

					arg_227_1:ShowWeapon(var_230_3.transform, false)

					arg_227_1.var_[var_230_0 .. "Animator"] = var_230_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_227_1.var_[var_230_0 .. "Animator"].applyRootMotion = true
					arg_227_1.var_[var_230_0 .. "LipSync"] = var_230_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_230_5 = arg_227_1.actors_["1059ui_story"].transform
			local var_230_6 = 0

			if var_230_6 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.var_.moveOldPos1059ui_story = var_230_5.localPosition
			end

			local var_230_7 = 0.001

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_7 then
				local var_230_8 = (arg_227_1.time_ - var_230_6) / var_230_7
				local var_230_9 = Vector3.New(0, 100, 0)

				var_230_5.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1059ui_story, var_230_9, var_230_8)

				local var_230_10 = manager.ui.mainCamera.transform.position - var_230_5.position

				var_230_5.forward = Vector3.New(var_230_10.x, var_230_10.y, var_230_10.z)

				local var_230_11 = var_230_5.localEulerAngles

				var_230_11.z = 0
				var_230_11.x = 0
				var_230_5.localEulerAngles = var_230_11
			end

			if arg_227_1.time_ >= var_230_6 + var_230_7 and arg_227_1.time_ < var_230_6 + var_230_7 + arg_230_0 then
				var_230_5.localPosition = Vector3.New(0, 100, 0)

				local var_230_12 = manager.ui.mainCamera.transform.position - var_230_5.position

				var_230_5.forward = Vector3.New(var_230_12.x, var_230_12.y, var_230_12.z)

				local var_230_13 = var_230_5.localEulerAngles

				var_230_13.z = 0
				var_230_13.x = 0
				var_230_5.localEulerAngles = var_230_13
			end

			local var_230_14 = arg_227_1.actors_["1077ui_story"].transform
			local var_230_15 = 0

			if var_230_15 < arg_227_1.time_ and arg_227_1.time_ <= var_230_15 + arg_230_0 then
				arg_227_1.var_.moveOldPos1077ui_story = var_230_14.localPosition

				local var_230_16 = GameObjectTools.GetOrAddComponent(var_230_14.gameObject, typeof(DynamicBoneHelper))

				if var_230_16 then
					var_230_16:EnableDynamicBone(false)
				end
			end

			local var_230_17 = 0.001

			if var_230_15 <= arg_227_1.time_ and arg_227_1.time_ < var_230_15 + var_230_17 then
				local var_230_18 = (arg_227_1.time_ - var_230_15) / var_230_17
				local var_230_19 = Vector3.New(0, 100, 0)

				var_230_14.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1077ui_story, var_230_19, var_230_18)

				local var_230_20 = manager.ui.mainCamera.transform.position - var_230_14.position

				var_230_14.forward = Vector3.New(var_230_20.x, var_230_20.y, var_230_20.z)

				local var_230_21 = var_230_14.localEulerAngles

				var_230_21.z = 0
				var_230_21.x = 0
				var_230_14.localEulerAngles = var_230_21
			end

			if arg_227_1.time_ >= var_230_15 + var_230_17 and arg_227_1.time_ < var_230_15 + var_230_17 + arg_230_0 then
				var_230_14.localPosition = Vector3.New(0, 100, 0)

				local var_230_22 = manager.ui.mainCamera.transform.position - var_230_14.position

				var_230_14.forward = Vector3.New(var_230_22.x, var_230_22.y, var_230_22.z)

				local var_230_23 = var_230_14.localEulerAngles

				var_230_23.z = 0
				var_230_23.x = 0
				var_230_14.localEulerAngles = var_230_23

				local var_230_24 = GameObjectTools.GetOrAddComponent(var_230_14.gameObject, typeof(DynamicBoneHelper))

				if var_230_24 then
					var_230_24:EnableDynamicBone(true)
				end
			end

			local var_230_25 = arg_227_1.actors_["1059ui_story"]
			local var_230_26 = 0

			if var_230_26 < arg_227_1.time_ and arg_227_1.time_ <= var_230_26 + arg_230_0 and not isNil(var_230_25) and arg_227_1.var_.characterEffect1059ui_story == nil then
				arg_227_1.var_.characterEffect1059ui_story = var_230_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_27 = 0.200000002980232

			if var_230_26 <= arg_227_1.time_ and arg_227_1.time_ < var_230_26 + var_230_27 and not isNil(var_230_25) then
				local var_230_28 = (arg_227_1.time_ - var_230_26) / var_230_27

				if arg_227_1.var_.characterEffect1059ui_story and not isNil(var_230_25) then
					local var_230_29 = Mathf.Lerp(0, 0.5, var_230_28)

					arg_227_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1059ui_story.fillRatio = var_230_29
				end
			end

			if arg_227_1.time_ >= var_230_26 + var_230_27 and arg_227_1.time_ < var_230_26 + var_230_27 + arg_230_0 and not isNil(var_230_25) and arg_227_1.var_.characterEffect1059ui_story then
				local var_230_30 = 0.5

				arg_227_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1059ui_story.fillRatio = var_230_30
			end

			local var_230_31 = 0.1
			local var_230_32 = 1

			if var_230_31 < arg_227_1.time_ and arg_227_1.time_ <= var_230_31 + arg_230_0 then
				local var_230_33 = "play"
				local var_230_34 = "effect"

				arg_227_1:AudioAction(var_230_33, var_230_34, "se_story_1311", "se_story_1311_roll", "")
			end

			local var_230_35 = 0
			local var_230_36 = 1.325

			if var_230_35 < arg_227_1.time_ and arg_227_1.time_ <= var_230_35 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_37 = arg_227_1:GetWordFromCfg(325111054)
				local var_230_38 = arg_227_1:FormatText(var_230_37.content)

				arg_227_1.text_.text = var_230_38

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_39 = 53
				local var_230_40 = utf8.len(var_230_38)
				local var_230_41 = var_230_39 <= 0 and var_230_36 or var_230_36 * (var_230_40 / var_230_39)

				if var_230_41 > 0 and var_230_36 < var_230_41 then
					arg_227_1.talkMaxDuration = var_230_41

					if var_230_41 + var_230_35 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_41 + var_230_35
					end
				end

				arg_227_1.text_.text = var_230_38
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_42 = math.max(var_230_36, arg_227_1.talkMaxDuration)

			if var_230_35 <= arg_227_1.time_ and arg_227_1.time_ < var_230_35 + var_230_42 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_35) / var_230_42

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_35 + var_230_42 and arg_227_1.time_ < var_230_35 + var_230_42 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play325111055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 325111055
		arg_231_1.duration_ = 3.1

		local var_231_0 = {
			zh = 1.999999999999,
			ja = 3.1
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
				arg_231_0:Play325111056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1077ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos1077ui_story = var_234_0.localPosition

				local var_234_2 = GameObjectTools.GetOrAddComponent(var_234_0.gameObject, typeof(DynamicBoneHelper))

				if var_234_2 then
					var_234_2:EnableDynamicBone(false)
				end
			end

			local var_234_3 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_3 then
				local var_234_4 = (arg_231_1.time_ - var_234_1) / var_234_3
				local var_234_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1077ui_story, var_234_5, var_234_4)

				local var_234_6 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_6.x, var_234_6.y, var_234_6.z)

				local var_234_7 = var_234_0.localEulerAngles

				var_234_7.z = 0
				var_234_7.x = 0
				var_234_0.localEulerAngles = var_234_7
			end

			if arg_231_1.time_ >= var_234_1 + var_234_3 and arg_231_1.time_ < var_234_1 + var_234_3 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_234_8 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_8.x, var_234_8.y, var_234_8.z)

				local var_234_9 = var_234_0.localEulerAngles

				var_234_9.z = 0
				var_234_9.x = 0
				var_234_0.localEulerAngles = var_234_9

				local var_234_10 = GameObjectTools.GetOrAddComponent(var_234_0.gameObject, typeof(DynamicBoneHelper))

				if var_234_10 then
					var_234_10:EnableDynamicBone(true)
				end
			end

			local var_234_11 = arg_231_1.actors_["1077ui_story"]
			local var_234_12 = 0

			if var_234_12 < arg_231_1.time_ and arg_231_1.time_ <= var_234_12 + arg_234_0 and not isNil(var_234_11) and arg_231_1.var_.characterEffect1077ui_story == nil then
				arg_231_1.var_.characterEffect1077ui_story = var_234_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_13 = 0.200000002980232

			if var_234_12 <= arg_231_1.time_ and arg_231_1.time_ < var_234_12 + var_234_13 and not isNil(var_234_11) then
				local var_234_14 = (arg_231_1.time_ - var_234_12) / var_234_13

				if arg_231_1.var_.characterEffect1077ui_story and not isNil(var_234_11) then
					arg_231_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_12 + var_234_13 and arg_231_1.time_ < var_234_12 + var_234_13 + arg_234_0 and not isNil(var_234_11) and arg_231_1.var_.characterEffect1077ui_story then
				arg_231_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_234_15 = 0

			if var_234_15 < arg_231_1.time_ and arg_231_1.time_ <= var_234_15 + arg_234_0 then
				arg_231_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_234_16 = 0

			if var_234_16 < arg_231_1.time_ and arg_231_1.time_ <= var_234_16 + arg_234_0 then
				arg_231_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_234_17 = 0
			local var_234_18 = 0.1

			if var_234_17 < arg_231_1.time_ and arg_231_1.time_ <= var_234_17 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_19 = arg_231_1:FormatText(StoryNameCfg[1467].name)

				arg_231_1.leftNameTxt_.text = var_234_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_20 = arg_231_1:GetWordFromCfg(325111055)
				local var_234_21 = arg_231_1:FormatText(var_234_20.content)

				arg_231_1.text_.text = var_234_21

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_22 = 4
				local var_234_23 = utf8.len(var_234_21)
				local var_234_24 = var_234_22 <= 0 and var_234_18 or var_234_18 * (var_234_23 / var_234_22)

				if var_234_24 > 0 and var_234_18 < var_234_24 then
					arg_231_1.talkMaxDuration = var_234_24

					if var_234_24 + var_234_17 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_24 + var_234_17
					end
				end

				arg_231_1.text_.text = var_234_21
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111055", "story_v_out_325111.awb") ~= 0 then
					local var_234_25 = manager.audio:GetVoiceLength("story_v_out_325111", "325111055", "story_v_out_325111.awb") / 1000

					if var_234_25 + var_234_17 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_25 + var_234_17
					end

					if var_234_20.prefab_name ~= "" and arg_231_1.actors_[var_234_20.prefab_name] ~= nil then
						local var_234_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_20.prefab_name].transform, "story_v_out_325111", "325111055", "story_v_out_325111.awb")

						arg_231_1:RecordAudio("325111055", var_234_26)
						arg_231_1:RecordAudio("325111055", var_234_26)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_325111", "325111055", "story_v_out_325111.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_325111", "325111055", "story_v_out_325111.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_27 = math.max(var_234_18, arg_231_1.talkMaxDuration)

			if var_234_17 <= arg_231_1.time_ and arg_231_1.time_ < var_234_17 + var_234_27 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_17) / var_234_27

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_17 + var_234_27 and arg_231_1.time_ < var_234_17 + var_234_27 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play325111056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 325111056
		arg_235_1.duration_ = 6.17

		local var_235_0 = {
			zh = 6.166,
			ja = 6.1
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play325111057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1077ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos1077ui_story = var_238_0.localPosition

				local var_238_2 = GameObjectTools.GetOrAddComponent(var_238_0.gameObject, typeof(DynamicBoneHelper))

				if var_238_2 then
					var_238_2:EnableDynamicBone(false)
				end
			end

			local var_238_3 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_3 then
				local var_238_4 = (arg_235_1.time_ - var_238_1) / var_238_3
				local var_238_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1077ui_story, var_238_5, var_238_4)

				local var_238_6 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_6.x, var_238_6.y, var_238_6.z)

				local var_238_7 = var_238_0.localEulerAngles

				var_238_7.z = 0
				var_238_7.x = 0
				var_238_0.localEulerAngles = var_238_7
			end

			if arg_235_1.time_ >= var_238_1 + var_238_3 and arg_235_1.time_ < var_238_1 + var_238_3 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_238_8 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_8.x, var_238_8.y, var_238_8.z)

				local var_238_9 = var_238_0.localEulerAngles

				var_238_9.z = 0
				var_238_9.x = 0
				var_238_0.localEulerAngles = var_238_9

				local var_238_10 = GameObjectTools.GetOrAddComponent(var_238_0.gameObject, typeof(DynamicBoneHelper))

				if var_238_10 then
					var_238_10:EnableDynamicBone(true)
				end
			end

			local var_238_11 = arg_235_1.actors_["1077ui_story"]
			local var_238_12 = 0

			if var_238_12 < arg_235_1.time_ and arg_235_1.time_ <= var_238_12 + arg_238_0 and not isNil(var_238_11) and arg_235_1.var_.characterEffect1077ui_story == nil then
				arg_235_1.var_.characterEffect1077ui_story = var_238_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_13 = 0.200000002980232

			if var_238_12 <= arg_235_1.time_ and arg_235_1.time_ < var_238_12 + var_238_13 and not isNil(var_238_11) then
				local var_238_14 = (arg_235_1.time_ - var_238_12) / var_238_13

				if arg_235_1.var_.characterEffect1077ui_story and not isNil(var_238_11) then
					local var_238_15 = Mathf.Lerp(0, 0.5, var_238_14)

					arg_235_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1077ui_story.fillRatio = var_238_15
				end
			end

			if arg_235_1.time_ >= var_238_12 + var_238_13 and arg_235_1.time_ < var_238_12 + var_238_13 + arg_238_0 and not isNil(var_238_11) and arg_235_1.var_.characterEffect1077ui_story then
				local var_238_16 = 0.5

				arg_235_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1077ui_story.fillRatio = var_238_16
			end

			local var_238_17 = 0
			local var_238_18 = 0.65

			if var_238_17 < arg_235_1.time_ and arg_235_1.time_ <= var_238_17 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_19 = arg_235_1:FormatText(StoryNameCfg[1455].name)

				arg_235_1.leftNameTxt_.text = var_238_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_20 = arg_235_1:GetWordFromCfg(325111056)
				local var_238_21 = arg_235_1:FormatText(var_238_20.content)

				arg_235_1.text_.text = var_238_21

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_22 = 26
				local var_238_23 = utf8.len(var_238_21)
				local var_238_24 = var_238_22 <= 0 and var_238_18 or var_238_18 * (var_238_23 / var_238_22)

				if var_238_24 > 0 and var_238_18 < var_238_24 then
					arg_235_1.talkMaxDuration = var_238_24

					if var_238_24 + var_238_17 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_24 + var_238_17
					end
				end

				arg_235_1.text_.text = var_238_21
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111056", "story_v_out_325111.awb") ~= 0 then
					local var_238_25 = manager.audio:GetVoiceLength("story_v_out_325111", "325111056", "story_v_out_325111.awb") / 1000

					if var_238_25 + var_238_17 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_25 + var_238_17
					end

					if var_238_20.prefab_name ~= "" and arg_235_1.actors_[var_238_20.prefab_name] ~= nil then
						local var_238_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_20.prefab_name].transform, "story_v_out_325111", "325111056", "story_v_out_325111.awb")

						arg_235_1:RecordAudio("325111056", var_238_26)
						arg_235_1:RecordAudio("325111056", var_238_26)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_325111", "325111056", "story_v_out_325111.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_325111", "325111056", "story_v_out_325111.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_27 = math.max(var_238_18, arg_235_1.talkMaxDuration)

			if var_238_17 <= arg_235_1.time_ and arg_235_1.time_ < var_238_17 + var_238_27 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_17) / var_238_27

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_17 + var_238_27 and arg_235_1.time_ < var_238_17 + var_238_27 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play325111057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 325111057
		arg_239_1.duration_ = 9.6

		local var_239_0 = {
			zh = 9.6,
			ja = 8.266
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play325111058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.9

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[1455].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(325111057)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 36
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111057", "story_v_out_325111.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_325111", "325111057", "story_v_out_325111.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_325111", "325111057", "story_v_out_325111.awb")

						arg_239_1:RecordAudio("325111057", var_242_9)
						arg_239_1:RecordAudio("325111057", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_325111", "325111057", "story_v_out_325111.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_325111", "325111057", "story_v_out_325111.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_10 and arg_239_1.time_ < var_242_0 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play325111058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 325111058
		arg_243_1.duration_ = 6

		local var_243_0 = {
			zh = 3.633,
			ja = 6
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play325111059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1077ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1077ui_story == nil then
				arg_243_1.var_.characterEffect1077ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect1077ui_story and not isNil(var_246_0) then
					arg_243_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1077ui_story then
				arg_243_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_246_4 = arg_243_1.actors_["1059ui_story"]
			local var_246_5 = 0

			if var_246_5 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 and not isNil(var_246_4) and arg_243_1.var_.characterEffect1059ui_story == nil then
				arg_243_1.var_.characterEffect1059ui_story = var_246_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_6 = 0.200000002980232

			if var_246_5 <= arg_243_1.time_ and arg_243_1.time_ < var_246_5 + var_246_6 and not isNil(var_246_4) then
				local var_246_7 = (arg_243_1.time_ - var_246_5) / var_246_6

				if arg_243_1.var_.characterEffect1059ui_story and not isNil(var_246_4) then
					local var_246_8 = Mathf.Lerp(0, 0.5, var_246_7)

					arg_243_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1059ui_story.fillRatio = var_246_8
				end
			end

			if arg_243_1.time_ >= var_246_5 + var_246_6 and arg_243_1.time_ < var_246_5 + var_246_6 + arg_246_0 and not isNil(var_246_4) and arg_243_1.var_.characterEffect1059ui_story then
				local var_246_9 = 0.5

				arg_243_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1059ui_story.fillRatio = var_246_9
			end

			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 then
				arg_243_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_246_11 = 0
			local var_246_12 = 0.5

			if var_246_11 < arg_243_1.time_ and arg_243_1.time_ <= var_246_11 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_13 = arg_243_1:FormatText(StoryNameCfg[1467].name)

				arg_243_1.leftNameTxt_.text = var_246_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_14 = arg_243_1:GetWordFromCfg(325111058)
				local var_246_15 = arg_243_1:FormatText(var_246_14.content)

				arg_243_1.text_.text = var_246_15

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_16 = 20
				local var_246_17 = utf8.len(var_246_15)
				local var_246_18 = var_246_16 <= 0 and var_246_12 or var_246_12 * (var_246_17 / var_246_16)

				if var_246_18 > 0 and var_246_12 < var_246_18 then
					arg_243_1.talkMaxDuration = var_246_18

					if var_246_18 + var_246_11 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_18 + var_246_11
					end
				end

				arg_243_1.text_.text = var_246_15
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111058", "story_v_out_325111.awb") ~= 0 then
					local var_246_19 = manager.audio:GetVoiceLength("story_v_out_325111", "325111058", "story_v_out_325111.awb") / 1000

					if var_246_19 + var_246_11 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_19 + var_246_11
					end

					if var_246_14.prefab_name ~= "" and arg_243_1.actors_[var_246_14.prefab_name] ~= nil then
						local var_246_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_14.prefab_name].transform, "story_v_out_325111", "325111058", "story_v_out_325111.awb")

						arg_243_1:RecordAudio("325111058", var_246_20)
						arg_243_1:RecordAudio("325111058", var_246_20)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_325111", "325111058", "story_v_out_325111.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_325111", "325111058", "story_v_out_325111.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_21 = math.max(var_246_12, arg_243_1.talkMaxDuration)

			if var_246_11 <= arg_243_1.time_ and arg_243_1.time_ < var_246_11 + var_246_21 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_11) / var_246_21

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_11 + var_246_21 and arg_243_1.time_ < var_246_11 + var_246_21 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play325111059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 325111059
		arg_247_1.duration_ = 6

		local var_247_0 = {
			zh = 5.5,
			ja = 6
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play325111060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1059ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1059ui_story == nil then
				arg_247_1.var_.characterEffect1059ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1059ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1059ui_story then
				arg_247_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_250_4 = arg_247_1.actors_["1077ui_story"]
			local var_250_5 = 0

			if var_250_5 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect1077ui_story == nil then
				arg_247_1.var_.characterEffect1077ui_story = var_250_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_6 = 0.200000002980232

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_6 and not isNil(var_250_4) then
				local var_250_7 = (arg_247_1.time_ - var_250_5) / var_250_6

				if arg_247_1.var_.characterEffect1077ui_story and not isNil(var_250_4) then
					local var_250_8 = Mathf.Lerp(0, 0.5, var_250_7)

					arg_247_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1077ui_story.fillRatio = var_250_8
				end
			end

			if arg_247_1.time_ >= var_250_5 + var_250_6 and arg_247_1.time_ < var_250_5 + var_250_6 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect1077ui_story then
				local var_250_9 = 0.5

				arg_247_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1077ui_story.fillRatio = var_250_9
			end

			local var_250_10 = 0
			local var_250_11 = 0.6

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_12 = arg_247_1:FormatText(StoryNameCfg[1455].name)

				arg_247_1.leftNameTxt_.text = var_250_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_13 = arg_247_1:GetWordFromCfg(325111059)
				local var_250_14 = arg_247_1:FormatText(var_250_13.content)

				arg_247_1.text_.text = var_250_14

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_15 = 24
				local var_250_16 = utf8.len(var_250_14)
				local var_250_17 = var_250_15 <= 0 and var_250_11 or var_250_11 * (var_250_16 / var_250_15)

				if var_250_17 > 0 and var_250_11 < var_250_17 then
					arg_247_1.talkMaxDuration = var_250_17

					if var_250_17 + var_250_10 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_17 + var_250_10
					end
				end

				arg_247_1.text_.text = var_250_14
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111059", "story_v_out_325111.awb") ~= 0 then
					local var_250_18 = manager.audio:GetVoiceLength("story_v_out_325111", "325111059", "story_v_out_325111.awb") / 1000

					if var_250_18 + var_250_10 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_18 + var_250_10
					end

					if var_250_13.prefab_name ~= "" and arg_247_1.actors_[var_250_13.prefab_name] ~= nil then
						local var_250_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_13.prefab_name].transform, "story_v_out_325111", "325111059", "story_v_out_325111.awb")

						arg_247_1:RecordAudio("325111059", var_250_19)
						arg_247_1:RecordAudio("325111059", var_250_19)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_325111", "325111059", "story_v_out_325111.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_325111", "325111059", "story_v_out_325111.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_20 = math.max(var_250_11, arg_247_1.talkMaxDuration)

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_20 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_10) / var_250_20

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_10 + var_250_20 and arg_247_1.time_ < var_250_10 + var_250_20 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play325111060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 325111060
		arg_251_1.duration_ = 13.43

		local var_251_0 = {
			zh = 10.133,
			ja = 13.433
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play325111061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.85

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[1455].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:GetWordFromCfg(325111060)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 34
				local var_254_6 = utf8.len(var_254_4)
				local var_254_7 = var_254_5 <= 0 and var_254_1 or var_254_1 * (var_254_6 / var_254_5)

				if var_254_7 > 0 and var_254_1 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111060", "story_v_out_325111.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_325111", "325111060", "story_v_out_325111.awb") / 1000

					if var_254_8 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_0
					end

					if var_254_3.prefab_name ~= "" and arg_251_1.actors_[var_254_3.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_3.prefab_name].transform, "story_v_out_325111", "325111060", "story_v_out_325111.awb")

						arg_251_1:RecordAudio("325111060", var_254_9)
						arg_251_1:RecordAudio("325111060", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_325111", "325111060", "story_v_out_325111.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_325111", "325111060", "story_v_out_325111.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_10 and arg_251_1.time_ < var_254_0 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play325111061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 325111061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play325111062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1059ui_story"].transform
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.var_.moveOldPos1059ui_story = var_258_0.localPosition
			end

			local var_258_2 = 0.001

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2
				local var_258_4 = Vector3.New(0, 100, 0)

				var_258_0.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1059ui_story, var_258_4, var_258_3)

				local var_258_5 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_5.x, var_258_5.y, var_258_5.z)

				local var_258_6 = var_258_0.localEulerAngles

				var_258_6.z = 0
				var_258_6.x = 0
				var_258_0.localEulerAngles = var_258_6
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 then
				var_258_0.localPosition = Vector3.New(0, 100, 0)

				local var_258_7 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_7.x, var_258_7.y, var_258_7.z)

				local var_258_8 = var_258_0.localEulerAngles

				var_258_8.z = 0
				var_258_8.x = 0
				var_258_0.localEulerAngles = var_258_8
			end

			local var_258_9 = arg_255_1.actors_["1077ui_story"].transform
			local var_258_10 = 0

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 then
				arg_255_1.var_.moveOldPos1077ui_story = var_258_9.localPosition

				local var_258_11 = GameObjectTools.GetOrAddComponent(var_258_9.gameObject, typeof(DynamicBoneHelper))

				if var_258_11 then
					var_258_11:EnableDynamicBone(false)
				end
			end

			local var_258_12 = 0.001

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_12 then
				local var_258_13 = (arg_255_1.time_ - var_258_10) / var_258_12
				local var_258_14 = Vector3.New(0, 100, 0)

				var_258_9.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1077ui_story, var_258_14, var_258_13)

				local var_258_15 = manager.ui.mainCamera.transform.position - var_258_9.position

				var_258_9.forward = Vector3.New(var_258_15.x, var_258_15.y, var_258_15.z)

				local var_258_16 = var_258_9.localEulerAngles

				var_258_16.z = 0
				var_258_16.x = 0
				var_258_9.localEulerAngles = var_258_16
			end

			if arg_255_1.time_ >= var_258_10 + var_258_12 and arg_255_1.time_ < var_258_10 + var_258_12 + arg_258_0 then
				var_258_9.localPosition = Vector3.New(0, 100, 0)

				local var_258_17 = manager.ui.mainCamera.transform.position - var_258_9.position

				var_258_9.forward = Vector3.New(var_258_17.x, var_258_17.y, var_258_17.z)

				local var_258_18 = var_258_9.localEulerAngles

				var_258_18.z = 0
				var_258_18.x = 0
				var_258_9.localEulerAngles = var_258_18

				local var_258_19 = GameObjectTools.GetOrAddComponent(var_258_9.gameObject, typeof(DynamicBoneHelper))

				if var_258_19 then
					var_258_19:EnableDynamicBone(true)
				end
			end

			local var_258_20 = arg_255_1.actors_["1059ui_story"]
			local var_258_21 = 0

			if var_258_21 < arg_255_1.time_ and arg_255_1.time_ <= var_258_21 + arg_258_0 and not isNil(var_258_20) and arg_255_1.var_.characterEffect1059ui_story == nil then
				arg_255_1.var_.characterEffect1059ui_story = var_258_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_22 = 0.200000002980232

			if var_258_21 <= arg_255_1.time_ and arg_255_1.time_ < var_258_21 + var_258_22 and not isNil(var_258_20) then
				local var_258_23 = (arg_255_1.time_ - var_258_21) / var_258_22

				if arg_255_1.var_.characterEffect1059ui_story and not isNil(var_258_20) then
					local var_258_24 = Mathf.Lerp(0, 0.5, var_258_23)

					arg_255_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1059ui_story.fillRatio = var_258_24
				end
			end

			if arg_255_1.time_ >= var_258_21 + var_258_22 and arg_255_1.time_ < var_258_21 + var_258_22 + arg_258_0 and not isNil(var_258_20) and arg_255_1.var_.characterEffect1059ui_story then
				local var_258_25 = 0.5

				arg_255_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1059ui_story.fillRatio = var_258_25
			end

			local var_258_26 = 0.1
			local var_258_27 = 1

			if var_258_26 < arg_255_1.time_ and arg_255_1.time_ <= var_258_26 + arg_258_0 then
				local var_258_28 = "play"
				local var_258_29 = "effect"

				arg_255_1:AudioAction(var_258_28, var_258_29, "se_story_148", "se_story_148_sword13", "")
			end

			local var_258_30 = 0
			local var_258_31 = 0.6

			if var_258_30 < arg_255_1.time_ and arg_255_1.time_ <= var_258_30 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_32 = arg_255_1:GetWordFromCfg(325111061)
				local var_258_33 = arg_255_1:FormatText(var_258_32.content)

				arg_255_1.text_.text = var_258_33

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_34 = 25
				local var_258_35 = utf8.len(var_258_33)
				local var_258_36 = var_258_34 <= 0 and var_258_31 or var_258_31 * (var_258_35 / var_258_34)

				if var_258_36 > 0 and var_258_31 < var_258_36 then
					arg_255_1.talkMaxDuration = var_258_36

					if var_258_36 + var_258_30 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_36 + var_258_30
					end
				end

				arg_255_1.text_.text = var_258_33
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_37 = math.max(var_258_31, arg_255_1.talkMaxDuration)

			if var_258_30 <= arg_255_1.time_ and arg_255_1.time_ < var_258_30 + var_258_37 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_30) / var_258_37

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_30 + var_258_37 and arg_255_1.time_ < var_258_30 + var_258_37 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play325111062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 325111062
		arg_259_1.duration_ = 6

		local var_259_0 = {
			zh = 4.333,
			ja = 6
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play325111063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 0.4

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_2 = arg_259_1:FormatText(StoryNameCfg[1455].name)

				arg_259_1.leftNameTxt_.text = var_262_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_3 = arg_259_1:GetWordFromCfg(325111062)
				local var_262_4 = arg_259_1:FormatText(var_262_3.content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 16
				local var_262_6 = utf8.len(var_262_4)
				local var_262_7 = var_262_5 <= 0 and var_262_1 or var_262_1 * (var_262_6 / var_262_5)

				if var_262_7 > 0 and var_262_1 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111062", "story_v_out_325111.awb") ~= 0 then
					local var_262_8 = manager.audio:GetVoiceLength("story_v_out_325111", "325111062", "story_v_out_325111.awb") / 1000

					if var_262_8 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_0
					end

					if var_262_3.prefab_name ~= "" and arg_259_1.actors_[var_262_3.prefab_name] ~= nil then
						local var_262_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_3.prefab_name].transform, "story_v_out_325111", "325111062", "story_v_out_325111.awb")

						arg_259_1:RecordAudio("325111062", var_262_9)
						arg_259_1:RecordAudio("325111062", var_262_9)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_325111", "325111062", "story_v_out_325111.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_325111", "325111062", "story_v_out_325111.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_10 and arg_259_1.time_ < var_262_0 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play325111063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 325111063
		arg_263_1.duration_ = 10.37

		local var_263_0 = {
			zh = 6.766,
			ja = 10.366
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
			arg_263_1.auto_ = false
		end

		function arg_263_1.playNext_(arg_265_0)
			arg_263_1.onStoryFinished_()
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 1

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				local var_266_2 = "play"
				local var_266_3 = "effect"

				arg_263_1:AudioAction(var_266_2, var_266_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_266_4 = 0
			local var_266_5 = 0.825

			if var_266_4 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_6 = arg_263_1:FormatText(StoryNameCfg[1455].name)

				arg_263_1.leftNameTxt_.text = var_266_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_7 = arg_263_1:GetWordFromCfg(325111063)
				local var_266_8 = arg_263_1:FormatText(var_266_7.content)

				arg_263_1.text_.text = var_266_8

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 33
				local var_266_10 = utf8.len(var_266_8)
				local var_266_11 = var_266_9 <= 0 and var_266_5 or var_266_5 * (var_266_10 / var_266_9)

				if var_266_11 > 0 and var_266_5 < var_266_11 then
					arg_263_1.talkMaxDuration = var_266_11

					if var_266_11 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_8
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325111", "325111063", "story_v_out_325111.awb") ~= 0 then
					local var_266_12 = manager.audio:GetVoiceLength("story_v_out_325111", "325111063", "story_v_out_325111.awb") / 1000

					if var_266_12 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_12 + var_266_4
					end

					if var_266_7.prefab_name ~= "" and arg_263_1.actors_[var_266_7.prefab_name] ~= nil then
						local var_266_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_7.prefab_name].transform, "story_v_out_325111", "325111063", "story_v_out_325111.awb")

						arg_263_1:RecordAudio("325111063", var_266_13)
						arg_263_1:RecordAudio("325111063", var_266_13)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_325111", "325111063", "story_v_out_325111.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_325111", "325111063", "story_v_out_325111.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_14 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_14 and arg_263_1.time_ < var_266_4 + var_266_14 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST41",
		"TextureConfig/Background/J23g",
		"TextureConfig/Background/J23h",
		"TextureConfig/Background/ST2010",
		"TextureConfig/Background/ST42"
	},
	voices = {
		"story_v_out_325111.awb"
	}
}
