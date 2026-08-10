return {
	Play121541001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121541001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play121541002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST29a"

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
				local var_4_5 = arg_1_1.bgs_.ST29a

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
					if iter_4_0 ~= "ST29a" then
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
			local var_4_23 = 0.133333333333333

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

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_32 = 2
			local var_4_33 = 0.125

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_34 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_34:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_35 = arg_1_1:GetWordFromCfg(121541001)
				local var_4_36 = arg_1_1:FormatText(var_4_35.content)

				arg_1_1.text_.text = var_4_36

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_37 = 5
				local var_4_38 = utf8.len(var_4_36)
				local var_4_39 = var_4_37 <= 0 and var_4_33 or var_4_33 * (var_4_38 / var_4_37)

				if var_4_39 > 0 and var_4_33 < var_4_39 then
					arg_1_1.talkMaxDuration = var_4_39
					var_4_32 = var_4_32 + 0.3

					if var_4_39 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_32
					end
				end

				arg_1_1.text_.text = var_4_36
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_40 = var_4_32 + 0.3
			local var_4_41 = math.max(var_4_33, arg_1_1.talkMaxDuration)

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_40) / var_4_41

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play121541002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 121541002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play121541003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.45

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(121541002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 58
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play121541003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 121541003
		arg_12_1.duration_ = 6.1

		local var_12_0 = {
			ja = 2.9,
			ko = 6.1,
			zh = 6.1
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
				arg_12_0:Play121541004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1072ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1072ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["1072ui_story"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos1072ui_story = var_15_5.localPosition
			end

			local var_15_7 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7
				local var_15_9 = Vector3.New(0, -0.71, -6)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1072ui_story, var_15_9, var_15_8)

				local var_15_10 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_10.x, var_15_10.y, var_15_10.z)

				local var_15_11 = var_15_5.localEulerAngles

				var_15_11.z = 0
				var_15_11.x = 0
				var_15_5.localEulerAngles = var_15_11
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(0, -0.71, -6)

				local var_15_12 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_12.x, var_15_12.y, var_15_12.z)

				local var_15_13 = var_15_5.localEulerAngles

				var_15_13.z = 0
				var_15_13.x = 0
				var_15_5.localEulerAngles = var_15_13
			end

			local var_15_14 = arg_12_1.actors_["1072ui_story"]
			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1072ui_story == nil then
				arg_12_1.var_.characterEffect1072ui_story = var_15_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_16 = 0.200000002980232

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_16 and not isNil(var_15_14) then
				local var_15_17 = (arg_12_1.time_ - var_15_15) / var_15_16

				if arg_12_1.var_.characterEffect1072ui_story and not isNil(var_15_14) then
					arg_12_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_15 + var_15_16 and arg_12_1.time_ < var_15_15 + var_15_16 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1072ui_story then
				arg_12_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_15_18 = 0

			if var_15_18 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_15_19 = 0

			if var_15_19 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				arg_12_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_15_20 = 0
			local var_15_21 = 0.425

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_22 = arg_12_1:FormatText(StoryNameCfg[379].name)

				arg_12_1.leftNameTxt_.text = var_15_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_23 = arg_12_1:GetWordFromCfg(121541003)
				local var_15_24 = arg_12_1:FormatText(var_15_23.content)

				arg_12_1.text_.text = var_15_24

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_25 = 17
				local var_15_26 = utf8.len(var_15_24)
				local var_15_27 = var_15_25 <= 0 and var_15_21 or var_15_21 * (var_15_26 / var_15_25)

				if var_15_27 > 0 and var_15_21 < var_15_27 then
					arg_12_1.talkMaxDuration = var_15_27

					if var_15_27 + var_15_20 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_27 + var_15_20
					end
				end

				arg_12_1.text_.text = var_15_24
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541003", "story_v_out_121541.awb") ~= 0 then
					local var_15_28 = manager.audio:GetVoiceLength("story_v_out_121541", "121541003", "story_v_out_121541.awb") / 1000

					if var_15_28 + var_15_20 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_28 + var_15_20
					end

					if var_15_23.prefab_name ~= "" and arg_12_1.actors_[var_15_23.prefab_name] ~= nil then
						local var_15_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_23.prefab_name].transform, "story_v_out_121541", "121541003", "story_v_out_121541.awb")

						arg_12_1:RecordAudio("121541003", var_15_29)
						arg_12_1:RecordAudio("121541003", var_15_29)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_121541", "121541003", "story_v_out_121541.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_121541", "121541003", "story_v_out_121541.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_30 = math.max(var_15_21, arg_12_1.talkMaxDuration)

			if var_15_20 <= arg_12_1.time_ and arg_12_1.time_ < var_15_20 + var_15_30 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_20) / var_15_30

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_20 + var_15_30 and arg_12_1.time_ < var_15_20 + var_15_30 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play121541004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 121541004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play121541005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1072ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos1072ui_story = var_19_0.localPosition
			end

			local var_19_2 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2
				local var_19_4 = Vector3.New(0, 100, 0)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1072ui_story, var_19_4, var_19_3)

				local var_19_5 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_5.x, var_19_5.y, var_19_5.z)

				local var_19_6 = var_19_0.localEulerAngles

				var_19_6.z = 0
				var_19_6.x = 0
				var_19_0.localEulerAngles = var_19_6
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, 100, 0)

				local var_19_7 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_7.x, var_19_7.y, var_19_7.z)

				local var_19_8 = var_19_0.localEulerAngles

				var_19_8.z = 0
				var_19_8.x = 0
				var_19_0.localEulerAngles = var_19_8
			end

			local var_19_9 = arg_16_1.actors_["1072ui_story"]
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1072ui_story == nil then
				arg_16_1.var_.characterEffect1072ui_story = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.200000002980232

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 and not isNil(var_19_9) then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11

				if arg_16_1.var_.characterEffect1072ui_story and not isNil(var_19_9) then
					local var_19_13 = Mathf.Lerp(0, 0.5, var_19_12)

					arg_16_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1072ui_story.fillRatio = var_19_13
				end
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1072ui_story then
				local var_19_14 = 0.5

				arg_16_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1072ui_story.fillRatio = var_19_14
			end

			local var_19_15 = 0
			local var_19_16 = 1.1

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_17 = arg_16_1:GetWordFromCfg(121541004)
				local var_19_18 = arg_16_1:FormatText(var_19_17.content)

				arg_16_1.text_.text = var_19_18

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_19 = 44
				local var_19_20 = utf8.len(var_19_18)
				local var_19_21 = var_19_19 <= 0 and var_19_16 or var_19_16 * (var_19_20 / var_19_19)

				if var_19_21 > 0 and var_19_16 < var_19_21 then
					arg_16_1.talkMaxDuration = var_19_21

					if var_19_21 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_21 + var_19_15
					end
				end

				arg_16_1.text_.text = var_19_18
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_16, arg_16_1.talkMaxDuration)

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_15) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_15 + var_19_22 and arg_16_1.time_ < var_19_15 + var_19_22 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play121541005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 121541005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play121541006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 1.475

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(121541005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 59
				local var_23_5 = utf8.len(var_23_3)
				local var_23_6 = var_23_4 <= 0 and var_23_1 or var_23_1 * (var_23_5 / var_23_4)

				if var_23_6 > 0 and var_23_1 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_7 and arg_20_1.time_ < var_23_0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play121541006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 121541006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play121541007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.9

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(121541006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 36
				local var_27_5 = utf8.len(var_27_3)
				local var_27_6 = var_27_4 <= 0 and var_27_1 or var_27_1 * (var_27_5 / var_27_4)

				if var_27_6 > 0 and var_27_1 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_7 and arg_24_1.time_ < var_27_0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play121541007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 121541007
		arg_28_1.duration_ = 5.87

		local var_28_0 = {
			ja = 5.866,
			ko = 4.766,
			zh = 4.766
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
				arg_28_0:Play121541008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1072ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1072ui_story == nil then
				arg_28_1.var_.characterEffect1072ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1072ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1072ui_story then
				arg_28_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_31_4 = 0

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_31_6 = arg_28_1.actors_["1072ui_story"].transform
			local var_31_7 = 0

			if var_31_7 < arg_28_1.time_ and arg_28_1.time_ <= var_31_7 + arg_31_0 then
				arg_28_1.var_.moveOldPos1072ui_story = var_31_6.localPosition
			end

			local var_31_8 = 0.001

			if var_31_7 <= arg_28_1.time_ and arg_28_1.time_ < var_31_7 + var_31_8 then
				local var_31_9 = (arg_28_1.time_ - var_31_7) / var_31_8
				local var_31_10 = Vector3.New(0, -0.71, -6)

				var_31_6.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1072ui_story, var_31_10, var_31_9)

				local var_31_11 = manager.ui.mainCamera.transform.position - var_31_6.position

				var_31_6.forward = Vector3.New(var_31_11.x, var_31_11.y, var_31_11.z)

				local var_31_12 = var_31_6.localEulerAngles

				var_31_12.z = 0
				var_31_12.x = 0
				var_31_6.localEulerAngles = var_31_12
			end

			if arg_28_1.time_ >= var_31_7 + var_31_8 and arg_28_1.time_ < var_31_7 + var_31_8 + arg_31_0 then
				var_31_6.localPosition = Vector3.New(0, -0.71, -6)

				local var_31_13 = manager.ui.mainCamera.transform.position - var_31_6.position

				var_31_6.forward = Vector3.New(var_31_13.x, var_31_13.y, var_31_13.z)

				local var_31_14 = var_31_6.localEulerAngles

				var_31_14.z = 0
				var_31_14.x = 0
				var_31_6.localEulerAngles = var_31_14
			end

			local var_31_15 = 0
			local var_31_16 = 0.4

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_17 = arg_28_1:FormatText(StoryNameCfg[379].name)

				arg_28_1.leftNameTxt_.text = var_31_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_18 = arg_28_1:GetWordFromCfg(121541007)
				local var_31_19 = arg_28_1:FormatText(var_31_18.content)

				arg_28_1.text_.text = var_31_19

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_20 = 16
				local var_31_21 = utf8.len(var_31_19)
				local var_31_22 = var_31_20 <= 0 and var_31_16 or var_31_16 * (var_31_21 / var_31_20)

				if var_31_22 > 0 and var_31_16 < var_31_22 then
					arg_28_1.talkMaxDuration = var_31_22

					if var_31_22 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_22 + var_31_15
					end
				end

				arg_28_1.text_.text = var_31_19
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541007", "story_v_out_121541.awb") ~= 0 then
					local var_31_23 = manager.audio:GetVoiceLength("story_v_out_121541", "121541007", "story_v_out_121541.awb") / 1000

					if var_31_23 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_23 + var_31_15
					end

					if var_31_18.prefab_name ~= "" and arg_28_1.actors_[var_31_18.prefab_name] ~= nil then
						local var_31_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_18.prefab_name].transform, "story_v_out_121541", "121541007", "story_v_out_121541.awb")

						arg_28_1:RecordAudio("121541007", var_31_24)
						arg_28_1:RecordAudio("121541007", var_31_24)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_121541", "121541007", "story_v_out_121541.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_121541", "121541007", "story_v_out_121541.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_25 = math.max(var_31_16, arg_28_1.talkMaxDuration)

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_25 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_15) / var_31_25

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_15 + var_31_25 and arg_28_1.time_ < var_31_15 + var_31_25 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play121541008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 121541008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play121541009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1072ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos1072ui_story = var_35_0.localPosition
			end

			local var_35_2 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2
				local var_35_4 = Vector3.New(0, 100, 0)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1072ui_story, var_35_4, var_35_3)

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

			local var_35_9 = arg_32_1.actors_["1072ui_story"]
			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect1072ui_story == nil then
				arg_32_1.var_.characterEffect1072ui_story = var_35_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.200000002980232

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_11 and not isNil(var_35_9) then
				local var_35_12 = (arg_32_1.time_ - var_35_10) / var_35_11

				if arg_32_1.var_.characterEffect1072ui_story and not isNil(var_35_9) then
					local var_35_13 = Mathf.Lerp(0, 0.5, var_35_12)

					arg_32_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1072ui_story.fillRatio = var_35_13
				end
			end

			if arg_32_1.time_ >= var_35_10 + var_35_11 and arg_32_1.time_ < var_35_10 + var_35_11 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect1072ui_story then
				local var_35_14 = 0.5

				arg_32_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1072ui_story.fillRatio = var_35_14
			end

			local var_35_15 = 0
			local var_35_16 = 1.25

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_17 = arg_32_1:GetWordFromCfg(121541008)
				local var_35_18 = arg_32_1:FormatText(var_35_17.content)

				arg_32_1.text_.text = var_35_18

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_19 = 50
				local var_35_20 = utf8.len(var_35_18)
				local var_35_21 = var_35_19 <= 0 and var_35_16 or var_35_16 * (var_35_20 / var_35_19)

				if var_35_21 > 0 and var_35_16 < var_35_21 then
					arg_32_1.talkMaxDuration = var_35_21

					if var_35_21 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_21 + var_35_15
					end
				end

				arg_32_1.text_.text = var_35_18
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_22 = math.max(var_35_16, arg_32_1.talkMaxDuration)

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_22 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_15) / var_35_22

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_15 + var_35_22 and arg_32_1.time_ < var_35_15 + var_35_22 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play121541009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 121541009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play121541010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.3
			local var_39_1 = 0.7

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				local var_39_2 = "play"
				local var_39_3 = "effect"

				arg_36_1:AudioAction(var_39_2, var_39_3, "se_story_121_04", "se_story_121_04_engineclose_far", "")
			end

			local var_39_4 = 0.3
			local var_39_5 = 1

			if var_39_4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				local var_39_6 = "stop"
				local var_39_7 = "effect"

				arg_36_1:AudioAction(var_39_6, var_39_7, "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			local var_39_8 = 0
			local var_39_9 = 0.45

			if var_39_8 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_10 = arg_36_1:GetWordFromCfg(121541009)
				local var_39_11 = arg_36_1:FormatText(var_39_10.content)

				arg_36_1.text_.text = var_39_11

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_12 = 18
				local var_39_13 = utf8.len(var_39_11)
				local var_39_14 = var_39_12 <= 0 and var_39_9 or var_39_9 * (var_39_13 / var_39_12)

				if var_39_14 > 0 and var_39_9 < var_39_14 then
					arg_36_1.talkMaxDuration = var_39_14

					if var_39_14 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_11
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_15 = math.max(var_39_9, arg_36_1.talkMaxDuration)

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_15 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_8) / var_39_15

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_8 + var_39_15 and arg_36_1.time_ < var_39_8 + var_39_15 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play121541010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 121541010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play121541011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.15

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

				local var_43_2 = arg_40_1:GetWordFromCfg(121541010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 6
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
	Play121541011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 121541011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play121541012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.2
			local var_47_1 = 1

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				local var_47_2 = "play"
				local var_47_3 = "effect"

				arg_44_1:AudioAction(var_47_2, var_47_3, "se_story_121_04", "se_story_121_04_enginerepair_far", "")
			end

			local var_47_4 = 0
			local var_47_5 = 1.525

			if var_47_4 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(121541011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_8 = 61
				local var_47_9 = utf8.len(var_47_7)
				local var_47_10 = var_47_8 <= 0 and var_47_5 or var_47_5 * (var_47_9 / var_47_8)

				if var_47_10 > 0 and var_47_5 < var_47_10 then
					arg_44_1.talkMaxDuration = var_47_10

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_11 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_11 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_11

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_11 and arg_44_1.time_ < var_47_4 + var_47_11 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play121541012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 121541012
		arg_48_1.duration_ = 5.07

		local var_48_0 = {
			ja = 4.733,
			ko = 5.066,
			zh = 5.066
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
				arg_48_0:Play121541013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = "ST32a"

			if arg_48_1.bgs_[var_51_0] == nil then
				local var_51_1 = Object.Instantiate(arg_48_1.paintGo_)

				var_51_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_51_0)
				var_51_1.name = var_51_0
				var_51_1.transform.parent = arg_48_1.stage_.transform
				var_51_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.bgs_[var_51_0] = var_51_1
			end

			local var_51_2 = 0

			if var_51_2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				local var_51_3 = manager.ui.mainCamera.transform.localPosition
				local var_51_4 = Vector3.New(0, 0, 10) + Vector3.New(var_51_3.x, var_51_3.y, 0)
				local var_51_5 = arg_48_1.bgs_.ST32a

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
					if iter_51_0 ~= "ST32a" then
						iter_51_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_51_16 = 0

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_17 = 2

			if var_51_16 <= arg_48_1.time_ and arg_48_1.time_ < var_51_16 + var_51_17 then
				local var_51_18 = (arg_48_1.time_ - var_51_16) / var_51_17
				local var_51_19 = Color.New(1, 1, 1)

				var_51_19.a = Mathf.Lerp(1, 0, var_51_18)
				arg_48_1.mask_.color = var_51_19
			end

			if arg_48_1.time_ >= var_51_16 + var_51_17 and arg_48_1.time_ < var_51_16 + var_51_17 + arg_51_0 then
				local var_51_20 = Color.New(1, 1, 1)
				local var_51_21 = 0

				arg_48_1.mask_.enabled = false
				var_51_20.a = var_51_21
				arg_48_1.mask_.color = var_51_20
			end

			local var_51_22 = 0
			local var_51_23 = 0.633333333333333

			if var_51_22 < arg_48_1.time_ and arg_48_1.time_ <= var_51_22 + arg_51_0 then
				local var_51_24 = "play"
				local var_51_25 = "effect"

				arg_48_1:AudioAction(var_51_24, var_51_25, "se_story_121_04", "se_story_121_04_faillcall", "")
			end

			local var_51_26 = 0
			local var_51_27 = 1

			if var_51_26 < arg_48_1.time_ and arg_48_1.time_ <= var_51_26 + arg_51_0 then
				local var_51_28 = "stop"
				local var_51_29 = "music"

				arg_48_1:AudioAction(var_51_28, var_51_29, "se_story_121_04", "se_story_121_04_enginerepair_far", "")

				local var_51_30 = ""
				local var_51_31 = manager.audio:GetAudioName("se_story_121_04", "se_story_121_04_enginerepair_far")

				if var_51_31 ~= "" then
					if arg_48_1.bgmTxt_.text ~= var_51_31 and arg_48_1.bgmTxt_.text ~= "" then
						if arg_48_1.bgmTxt2_.text ~= "" then
							arg_48_1.bgmTxt_.text = arg_48_1.bgmTxt2_.text
						end

						arg_48_1.bgmTxt2_.text = var_51_31

						arg_48_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_48_1.bgmTxt_.text = var_51_31
						arg_48_1.bgmTxt2_.text = var_51_31
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

			local var_51_32 = 2
			local var_51_33 = 0.25

			if var_51_32 < arg_48_1.time_ and arg_48_1.time_ <= var_51_32 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0

				arg_48_1.dialog_:SetActive(true)

				arg_48_1.dialogCg_.alpha = 0

				local var_51_34 = LeanTween.value(arg_48_1.dialog_, 0, 1, 0.3)

				var_51_34:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_48_1.dialogCg_.alpha = arg_53_0
				end))
				var_51_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_48_1.dialog_)
					var_51_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_48_1.duration_ = arg_48_1.duration_ + 0.3

				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_35 = arg_48_1:FormatText(StoryNameCfg[379].name)

				arg_48_1.leftNameTxt_.text = var_51_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_36 = arg_48_1:GetWordFromCfg(121541012)
				local var_51_37 = arg_48_1:FormatText(var_51_36.content)

				arg_48_1.text_.text = var_51_37

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_38 = 10
				local var_51_39 = utf8.len(var_51_37)
				local var_51_40 = var_51_38 <= 0 and var_51_33 or var_51_33 * (var_51_39 / var_51_38)

				if var_51_40 > 0 and var_51_33 < var_51_40 then
					arg_48_1.talkMaxDuration = var_51_40
					var_51_32 = var_51_32 + 0.3

					if var_51_40 + var_51_32 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_40 + var_51_32
					end
				end

				arg_48_1.text_.text = var_51_37
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541012", "story_v_out_121541.awb") ~= 0 then
					local var_51_41 = manager.audio:GetVoiceLength("story_v_out_121541", "121541012", "story_v_out_121541.awb") / 1000

					if var_51_41 + var_51_32 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_41 + var_51_32
					end

					if var_51_36.prefab_name ~= "" and arg_48_1.actors_[var_51_36.prefab_name] ~= nil then
						local var_51_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_36.prefab_name].transform, "story_v_out_121541", "121541012", "story_v_out_121541.awb")

						arg_48_1:RecordAudio("121541012", var_51_42)
						arg_48_1:RecordAudio("121541012", var_51_42)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_121541", "121541012", "story_v_out_121541.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_121541", "121541012", "story_v_out_121541.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_43 = var_51_32 + 0.3
			local var_51_44 = math.max(var_51_33, arg_48_1.talkMaxDuration)

			if var_51_43 <= arg_48_1.time_ and arg_48_1.time_ < var_51_43 + var_51_44 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_43) / var_51_44

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_43 + var_51_44 and arg_48_1.time_ < var_51_43 + var_51_44 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play121541013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 121541013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play121541014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.575

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_2 = arg_55_1:GetWordFromCfg(121541013)
				local var_58_3 = arg_55_1:FormatText(var_58_2.content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 23
				local var_58_5 = utf8.len(var_58_3)
				local var_58_6 = var_58_4 <= 0 and var_58_1 or var_58_1 * (var_58_5 / var_58_4)

				if var_58_6 > 0 and var_58_1 < var_58_6 then
					arg_55_1.talkMaxDuration = var_58_6

					if var_58_6 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_7 and arg_55_1.time_ < var_58_0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play121541014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 121541014
		arg_59_1.duration_ = 5.6

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play121541015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.633333333333333

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				local var_62_2 = "play"
				local var_62_3 = "effect"

				arg_59_1:AudioAction(var_62_2, var_62_3, "se_story_121_04", "se_story_121_04_cabinetbreak", "")
			end

			local var_62_4 = manager.ui.mainCamera.transform
			local var_62_5 = 0

			if var_62_5 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 then
				arg_59_1.var_.shakeOldPos = var_62_4.localPosition
			end

			local var_62_6 = 0.6

			if var_62_5 <= arg_59_1.time_ and arg_59_1.time_ < var_62_5 + var_62_6 then
				local var_62_7 = (arg_59_1.time_ - var_62_5) / 0.066
				local var_62_8, var_62_9 = math.modf(var_62_7)

				var_62_4.localPosition = Vector3.New(var_62_9 * 0.13, var_62_9 * 0.13, var_62_9 * 0.13) + arg_59_1.var_.shakeOldPos
			end

			if arg_59_1.time_ >= var_62_5 + var_62_6 and arg_59_1.time_ < var_62_5 + var_62_6 + arg_62_0 then
				var_62_4.localPosition = arg_59_1.var_.shakeOldPos
			end

			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 then
				arg_59_1.allBtn_.enabled = false
			end

			local var_62_11 = 0.6

			if arg_59_1.time_ >= var_62_10 + var_62_11 and arg_59_1.time_ < var_62_10 + var_62_11 + arg_62_0 then
				arg_59_1.allBtn_.enabled = true
			end

			local var_62_12 = 1.5
			local var_62_13 = 0.233333333333333

			if var_62_12 < arg_59_1.time_ and arg_59_1.time_ <= var_62_12 + arg_62_0 then
				local var_62_14 = "play"
				local var_62_15 = "music"

				arg_59_1:AudioAction(var_62_14, var_62_15, "bgm_activity_2_1_story_farewell", "bgm_activity_2_1_story_farewell", "bgm_activity_2_1_story_farewell.awb")

				local var_62_16 = ""
				local var_62_17 = manager.audio:GetAudioName("bgm_activity_2_1_story_farewell", "bgm_activity_2_1_story_farewell")

				if var_62_17 ~= "" then
					if arg_59_1.bgmTxt_.text ~= var_62_17 and arg_59_1.bgmTxt_.text ~= "" then
						if arg_59_1.bgmTxt2_.text ~= "" then
							arg_59_1.bgmTxt_.text = arg_59_1.bgmTxt2_.text
						end

						arg_59_1.bgmTxt2_.text = var_62_17

						arg_59_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_59_1.bgmTxt_.text = var_62_17
						arg_59_1.bgmTxt2_.text = var_62_17
					end

					if arg_59_1.bgmTimer then
						arg_59_1.bgmTimer:Stop()

						arg_59_1.bgmTimer = nil
					end

					if arg_59_1.settingData.show_music_name == 1 then
						arg_59_1.musicController:SetSelectedState("show")
						arg_59_1.musicAnimator_:Play("open", 0, 0)

						if arg_59_1.settingData.music_time ~= 0 then
							arg_59_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_59_1.settingData.music_time), function()
								if arg_59_1 == nil or isNil(arg_59_1.bgmTxt_) then
									return
								end

								arg_59_1.musicController:SetSelectedState("hide")
								arg_59_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_59_1.frameCnt_ <= 1 then
				arg_59_1.dialog_:SetActive(false)
			end

			local var_62_18 = 0.6
			local var_62_19 = 1.575

			if var_62_18 < arg_59_1.time_ and arg_59_1.time_ <= var_62_18 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_20 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_20:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_59_1.dialogCg_.alpha = arg_64_0
				end))
				var_62_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_21 = arg_59_1:GetWordFromCfg(121541014)
				local var_62_22 = arg_59_1:FormatText(var_62_21.content)

				arg_59_1.text_.text = var_62_22

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_23 = 63
				local var_62_24 = utf8.len(var_62_22)
				local var_62_25 = var_62_23 <= 0 and var_62_19 or var_62_19 * (var_62_24 / var_62_23)

				if var_62_25 > 0 and var_62_19 < var_62_25 then
					arg_59_1.talkMaxDuration = var_62_25
					var_62_18 = var_62_18 + 0.3

					if var_62_25 + var_62_18 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_25 + var_62_18
					end
				end

				arg_59_1.text_.text = var_62_22
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_26 = var_62_18 + 0.3
			local var_62_27 = math.max(var_62_19, arg_59_1.talkMaxDuration)

			if var_62_26 <= arg_59_1.time_ and arg_59_1.time_ < var_62_26 + var_62_27 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_26) / var_62_27

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_26 + var_62_27 and arg_59_1.time_ < var_62_26 + var_62_27 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play121541015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 121541015
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play121541016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 1.225

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_2 = arg_66_1:GetWordFromCfg(121541015)
				local var_69_3 = arg_66_1:FormatText(var_69_2.content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 49
				local var_69_5 = utf8.len(var_69_3)
				local var_69_6 = var_69_4 <= 0 and var_69_1 or var_69_1 * (var_69_5 / var_69_4)

				if var_69_6 > 0 and var_69_1 < var_69_6 then
					arg_66_1.talkMaxDuration = var_69_6

					if var_69_6 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_6 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_7 and arg_66_1.time_ < var_69_0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play121541016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 121541016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play121541017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 1.36666666666667
			local var_73_1 = 0.133333333333333

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				local var_73_2 = "play"
				local var_73_3 = "effect"

				arg_70_1:AudioAction(var_73_2, var_73_3, "se_story_side_1093", "se_story_1093_message_get", "")
			end

			local var_73_4 = 0
			local var_73_5 = 1.675

			if var_73_4 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_6 = arg_70_1:GetWordFromCfg(121541016)
				local var_73_7 = arg_70_1:FormatText(var_73_6.content)

				arg_70_1.text_.text = var_73_7

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_8 = 67
				local var_73_9 = utf8.len(var_73_7)
				local var_73_10 = var_73_8 <= 0 and var_73_5 or var_73_5 * (var_73_9 / var_73_8)

				if var_73_10 > 0 and var_73_5 < var_73_10 then
					arg_70_1.talkMaxDuration = var_73_10

					if var_73_10 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_4
					end
				end

				arg_70_1.text_.text = var_73_7
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_11 = math.max(var_73_5, arg_70_1.talkMaxDuration)

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_11 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_4) / var_73_11

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_4 + var_73_11 and arg_70_1.time_ < var_73_4 + var_73_11 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play121541017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 121541017
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play121541018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 1.85

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_2 = arg_74_1:GetWordFromCfg(121541017)
				local var_77_3 = arg_74_1:FormatText(var_77_2.content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 74
				local var_77_5 = utf8.len(var_77_3)
				local var_77_6 = var_77_4 <= 0 and var_77_1 or var_77_1 * (var_77_5 / var_77_4)

				if var_77_6 > 0 and var_77_1 < var_77_6 then
					arg_74_1.talkMaxDuration = var_77_6

					if var_77_6 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_7 and arg_74_1.time_ < var_77_0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play121541018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 121541018
		arg_78_1.duration_ = 2.67

		local var_78_0 = {
			ja = 2.6,
			ko = 2.666,
			zh = 2.666
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
				arg_78_0:Play121541019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1072ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos1072ui_story = var_81_0.localPosition
			end

			local var_81_2 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2
				local var_81_4 = Vector3.New(-0.7, -0.71, -6)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1072ui_story, var_81_4, var_81_3)

				local var_81_5 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_5.x, var_81_5.y, var_81_5.z)

				local var_81_6 = var_81_0.localEulerAngles

				var_81_6.z = 0
				var_81_6.x = 0
				var_81_0.localEulerAngles = var_81_6
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_81_7 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_7.x, var_81_7.y, var_81_7.z)

				local var_81_8 = var_81_0.localEulerAngles

				var_81_8.z = 0
				var_81_8.x = 0
				var_81_0.localEulerAngles = var_81_8
			end

			local var_81_9 = arg_78_1.actors_["1072ui_story"]
			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 and not isNil(var_81_9) and arg_78_1.var_.characterEffect1072ui_story == nil then
				arg_78_1.var_.characterEffect1072ui_story = var_81_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_11 = 0.200000002980232

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_11 and not isNil(var_81_9) then
				local var_81_12 = (arg_78_1.time_ - var_81_10) / var_81_11

				if arg_78_1.var_.characterEffect1072ui_story and not isNil(var_81_9) then
					arg_78_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_10 + var_81_11 and arg_78_1.time_ < var_81_10 + var_81_11 + arg_81_0 and not isNil(var_81_9) and arg_78_1.var_.characterEffect1072ui_story then
				arg_78_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_81_13 = 0

			if var_81_13 < arg_78_1.time_ and arg_78_1.time_ <= var_81_13 + arg_81_0 then
				arg_78_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_81_14 = 0

			if var_81_14 < arg_78_1.time_ and arg_78_1.time_ <= var_81_14 + arg_81_0 then
				arg_78_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_81_15 = "1076ui_story"

			if arg_78_1.actors_[var_81_15] == nil then
				local var_81_16 = Asset.Load("Char/" .. "1076ui_story")

				if not isNil(var_81_16) then
					local var_81_17 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_78_1.stage_.transform)

					var_81_17.name = var_81_15
					var_81_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_78_1.actors_[var_81_15] = var_81_17

					local var_81_18 = var_81_17:GetComponentInChildren(typeof(CharacterEffect))

					var_81_18.enabled = true

					local var_81_19 = GameObjectTools.GetOrAddComponent(var_81_17, typeof(DynamicBoneHelper))

					if var_81_19 then
						var_81_19:EnableDynamicBone(false)
					end

					arg_78_1:ShowWeapon(var_81_18.transform, false)

					arg_78_1.var_[var_81_15 .. "Animator"] = var_81_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_78_1.var_[var_81_15 .. "Animator"].applyRootMotion = true
					arg_78_1.var_[var_81_15 .. "LipSync"] = var_81_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_81_20 = arg_78_1.actors_["1076ui_story"].transform
			local var_81_21 = 0

			if var_81_21 < arg_78_1.time_ and arg_78_1.time_ <= var_81_21 + arg_81_0 then
				arg_78_1.var_.moveOldPos1076ui_story = var_81_20.localPosition
			end

			local var_81_22 = 0.001

			if var_81_21 <= arg_78_1.time_ and arg_78_1.time_ < var_81_21 + var_81_22 then
				local var_81_23 = (arg_78_1.time_ - var_81_21) / var_81_22
				local var_81_24 = Vector3.New(0.7, -1.06, -6.2)

				var_81_20.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1076ui_story, var_81_24, var_81_23)

				local var_81_25 = manager.ui.mainCamera.transform.position - var_81_20.position

				var_81_20.forward = Vector3.New(var_81_25.x, var_81_25.y, var_81_25.z)

				local var_81_26 = var_81_20.localEulerAngles

				var_81_26.z = 0
				var_81_26.x = 0
				var_81_20.localEulerAngles = var_81_26
			end

			if arg_78_1.time_ >= var_81_21 + var_81_22 and arg_78_1.time_ < var_81_21 + var_81_22 + arg_81_0 then
				var_81_20.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_81_27 = manager.ui.mainCamera.transform.position - var_81_20.position

				var_81_20.forward = Vector3.New(var_81_27.x, var_81_27.y, var_81_27.z)

				local var_81_28 = var_81_20.localEulerAngles

				var_81_28.z = 0
				var_81_28.x = 0
				var_81_20.localEulerAngles = var_81_28
			end

			local var_81_29 = arg_78_1.actors_["1076ui_story"]
			local var_81_30 = 0

			if var_81_30 < arg_78_1.time_ and arg_78_1.time_ <= var_81_30 + arg_81_0 and not isNil(var_81_29) and arg_78_1.var_.characterEffect1076ui_story == nil then
				arg_78_1.var_.characterEffect1076ui_story = var_81_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_31 = 0.200000002980232

			if var_81_30 <= arg_78_1.time_ and arg_78_1.time_ < var_81_30 + var_81_31 and not isNil(var_81_29) then
				local var_81_32 = (arg_78_1.time_ - var_81_30) / var_81_31

				if arg_78_1.var_.characterEffect1076ui_story and not isNil(var_81_29) then
					local var_81_33 = Mathf.Lerp(0, 0.5, var_81_32)

					arg_78_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1076ui_story.fillRatio = var_81_33
				end
			end

			if arg_78_1.time_ >= var_81_30 + var_81_31 and arg_78_1.time_ < var_81_30 + var_81_31 + arg_81_0 and not isNil(var_81_29) and arg_78_1.var_.characterEffect1076ui_story then
				local var_81_34 = 0.5

				arg_78_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1076ui_story.fillRatio = var_81_34
			end

			local var_81_35 = 0

			if var_81_35 < arg_78_1.time_ and arg_78_1.time_ <= var_81_35 + arg_81_0 then
				arg_78_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_81_36 = arg_78_1.actors_["1076ui_story"]
			local var_81_37 = 0

			if var_81_37 < arg_78_1.time_ and arg_78_1.time_ <= var_81_37 + arg_81_0 then
				if arg_78_1.var_.characterEffect1076ui_story == nil then
					arg_78_1.var_.characterEffect1076ui_story = var_81_36:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_81_38 = arg_78_1.var_.characterEffect1076ui_story

				var_81_38.imageEffect:turnOff()

				var_81_38.interferenceEffect.enabled = true
				var_81_38.interferenceEffect.noise = 0.001
				var_81_38.interferenceEffect.simTimeScale = 1
				var_81_38.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_81_39 = arg_78_1.actors_["1076ui_story"]
			local var_81_40 = 0
			local var_81_41 = 0.2

			if var_81_40 < arg_78_1.time_ and arg_78_1.time_ <= var_81_40 + arg_81_0 then
				if arg_78_1.var_.characterEffect1076ui_story == nil then
					arg_78_1.var_.characterEffect1076ui_story = var_81_39:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_78_1.var_.characterEffect1076ui_story.imageEffect:turnOn(false)
			end

			local var_81_42 = 0
			local var_81_43 = 0.3

			if var_81_42 < arg_78_1.time_ and arg_78_1.time_ <= var_81_42 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_44 = arg_78_1:FormatText(StoryNameCfg[379].name)

				arg_78_1.leftNameTxt_.text = var_81_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_45 = arg_78_1:GetWordFromCfg(121541018)
				local var_81_46 = arg_78_1:FormatText(var_81_45.content)

				arg_78_1.text_.text = var_81_46

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_47 = 12
				local var_81_48 = utf8.len(var_81_46)
				local var_81_49 = var_81_47 <= 0 and var_81_43 or var_81_43 * (var_81_48 / var_81_47)

				if var_81_49 > 0 and var_81_43 < var_81_49 then
					arg_78_1.talkMaxDuration = var_81_49

					if var_81_49 + var_81_42 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_49 + var_81_42
					end
				end

				arg_78_1.text_.text = var_81_46
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541018", "story_v_out_121541.awb") ~= 0 then
					local var_81_50 = manager.audio:GetVoiceLength("story_v_out_121541", "121541018", "story_v_out_121541.awb") / 1000

					if var_81_50 + var_81_42 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_50 + var_81_42
					end

					if var_81_45.prefab_name ~= "" and arg_78_1.actors_[var_81_45.prefab_name] ~= nil then
						local var_81_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_45.prefab_name].transform, "story_v_out_121541", "121541018", "story_v_out_121541.awb")

						arg_78_1:RecordAudio("121541018", var_81_51)
						arg_78_1:RecordAudio("121541018", var_81_51)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_121541", "121541018", "story_v_out_121541.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_121541", "121541018", "story_v_out_121541.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_52 = math.max(var_81_43, arg_78_1.talkMaxDuration)

			if var_81_42 <= arg_78_1.time_ and arg_78_1.time_ < var_81_42 + var_81_52 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_42) / var_81_52

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_42 + var_81_52 and arg_78_1.time_ < var_81_42 + var_81_52 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play121541019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 121541019
		arg_82_1.duration_ = 4.2

		local var_82_0 = {
			ja = 4.2,
			ko = 2.733,
			zh = 2.733
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
				arg_82_0:Play121541020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1072ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1072ui_story == nil then
				arg_82_1.var_.characterEffect1072ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect1072ui_story and not isNil(var_85_0) then
					local var_85_4 = Mathf.Lerp(0, 0.5, var_85_3)

					arg_82_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1072ui_story.fillRatio = var_85_4
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1072ui_story then
				local var_85_5 = 0.5

				arg_82_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1072ui_story.fillRatio = var_85_5
			end

			local var_85_6 = arg_82_1.actors_["1076ui_story"]
			local var_85_7 = 0

			if var_85_7 < arg_82_1.time_ and arg_82_1.time_ <= var_85_7 + arg_85_0 and not isNil(var_85_6) and arg_82_1.var_.characterEffect1076ui_story == nil then
				arg_82_1.var_.characterEffect1076ui_story = var_85_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_8 = 0.200000002980232

			if var_85_7 <= arg_82_1.time_ and arg_82_1.time_ < var_85_7 + var_85_8 and not isNil(var_85_6) then
				local var_85_9 = (arg_82_1.time_ - var_85_7) / var_85_8

				if arg_82_1.var_.characterEffect1076ui_story and not isNil(var_85_6) then
					arg_82_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_7 + var_85_8 and arg_82_1.time_ < var_85_7 + var_85_8 + arg_85_0 and not isNil(var_85_6) and arg_82_1.var_.characterEffect1076ui_story then
				arg_82_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_85_10 = 0
			local var_85_11 = 0.275

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_12 = arg_82_1:FormatText(StoryNameCfg[389].name)

				arg_82_1.leftNameTxt_.text = var_85_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_13 = arg_82_1:GetWordFromCfg(121541019)
				local var_85_14 = arg_82_1:FormatText(var_85_13.content)

				arg_82_1.text_.text = var_85_14

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_15 = 11
				local var_85_16 = utf8.len(var_85_14)
				local var_85_17 = var_85_15 <= 0 and var_85_11 or var_85_11 * (var_85_16 / var_85_15)

				if var_85_17 > 0 and var_85_11 < var_85_17 then
					arg_82_1.talkMaxDuration = var_85_17

					if var_85_17 + var_85_10 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_17 + var_85_10
					end
				end

				arg_82_1.text_.text = var_85_14
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541019", "story_v_out_121541.awb") ~= 0 then
					local var_85_18 = manager.audio:GetVoiceLength("story_v_out_121541", "121541019", "story_v_out_121541.awb") / 1000

					if var_85_18 + var_85_10 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_18 + var_85_10
					end

					if var_85_13.prefab_name ~= "" and arg_82_1.actors_[var_85_13.prefab_name] ~= nil then
						local var_85_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_13.prefab_name].transform, "story_v_out_121541", "121541019", "story_v_out_121541.awb")

						arg_82_1:RecordAudio("121541019", var_85_19)
						arg_82_1:RecordAudio("121541019", var_85_19)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_121541", "121541019", "story_v_out_121541.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_121541", "121541019", "story_v_out_121541.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_20 = math.max(var_85_11, arg_82_1.talkMaxDuration)

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_20 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_10) / var_85_20

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_10 + var_85_20 and arg_82_1.time_ < var_85_10 + var_85_20 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play121541020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 121541020
		arg_86_1.duration_ = 8.27

		local var_86_0 = {
			ja = 8.266,
			ko = 8.233,
			zh = 8.233
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
				arg_86_0:Play121541021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1072ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1072ui_story == nil then
				arg_86_1.var_.characterEffect1072ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1072ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1072ui_story then
				arg_86_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_89_4 = 0

			if var_89_4 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_89_5 = arg_86_1.actors_["1076ui_story"]
			local var_89_6 = 0

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 and not isNil(var_89_5) and arg_86_1.var_.characterEffect1076ui_story == nil then
				arg_86_1.var_.characterEffect1076ui_story = var_89_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_7 = 0.200000002980232

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_7 and not isNil(var_89_5) then
				local var_89_8 = (arg_86_1.time_ - var_89_6) / var_89_7

				if arg_86_1.var_.characterEffect1076ui_story and not isNil(var_89_5) then
					local var_89_9 = Mathf.Lerp(0, 0.5, var_89_8)

					arg_86_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1076ui_story.fillRatio = var_89_9
				end
			end

			if arg_86_1.time_ >= var_89_6 + var_89_7 and arg_86_1.time_ < var_89_6 + var_89_7 + arg_89_0 and not isNil(var_89_5) and arg_86_1.var_.characterEffect1076ui_story then
				local var_89_10 = 0.5

				arg_86_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1076ui_story.fillRatio = var_89_10
			end

			local var_89_11 = 0
			local var_89_12 = 0.5

			if var_89_11 < arg_86_1.time_ and arg_86_1.time_ <= var_89_11 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_13 = arg_86_1:FormatText(StoryNameCfg[379].name)

				arg_86_1.leftNameTxt_.text = var_89_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_14 = arg_86_1:GetWordFromCfg(121541020)
				local var_89_15 = arg_86_1:FormatText(var_89_14.content)

				arg_86_1.text_.text = var_89_15

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_16 = 20
				local var_89_17 = utf8.len(var_89_15)
				local var_89_18 = var_89_16 <= 0 and var_89_12 or var_89_12 * (var_89_17 / var_89_16)

				if var_89_18 > 0 and var_89_12 < var_89_18 then
					arg_86_1.talkMaxDuration = var_89_18

					if var_89_18 + var_89_11 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_18 + var_89_11
					end
				end

				arg_86_1.text_.text = var_89_15
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541020", "story_v_out_121541.awb") ~= 0 then
					local var_89_19 = manager.audio:GetVoiceLength("story_v_out_121541", "121541020", "story_v_out_121541.awb") / 1000

					if var_89_19 + var_89_11 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_19 + var_89_11
					end

					if var_89_14.prefab_name ~= "" and arg_86_1.actors_[var_89_14.prefab_name] ~= nil then
						local var_89_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_14.prefab_name].transform, "story_v_out_121541", "121541020", "story_v_out_121541.awb")

						arg_86_1:RecordAudio("121541020", var_89_20)
						arg_86_1:RecordAudio("121541020", var_89_20)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_121541", "121541020", "story_v_out_121541.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_121541", "121541020", "story_v_out_121541.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_21 = math.max(var_89_12, arg_86_1.talkMaxDuration)

			if var_89_11 <= arg_86_1.time_ and arg_86_1.time_ < var_89_11 + var_89_21 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_11) / var_89_21

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_11 + var_89_21 and arg_86_1.time_ < var_89_11 + var_89_21 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play121541021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 121541021
		arg_90_1.duration_ = 7.47

		local var_90_0 = {
			ja = 7.466,
			ko = 5.766,
			zh = 5.766
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
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play121541022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1076ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1076ui_story == nil then
				arg_90_1.var_.characterEffect1076ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1076ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1076ui_story then
				arg_90_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_93_4 = 0

			if var_93_4 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_1")
			end

			local var_93_5 = 0

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 then
				arg_90_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_93_6 = arg_90_1.actors_["1072ui_story"]
			local var_93_7 = 0

			if var_93_7 < arg_90_1.time_ and arg_90_1.time_ <= var_93_7 + arg_93_0 and not isNil(var_93_6) and arg_90_1.var_.characterEffect1072ui_story == nil then
				arg_90_1.var_.characterEffect1072ui_story = var_93_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_8 = 0.200000002980232

			if var_93_7 <= arg_90_1.time_ and arg_90_1.time_ < var_93_7 + var_93_8 and not isNil(var_93_6) then
				local var_93_9 = (arg_90_1.time_ - var_93_7) / var_93_8

				if arg_90_1.var_.characterEffect1072ui_story and not isNil(var_93_6) then
					local var_93_10 = Mathf.Lerp(0, 0.5, var_93_9)

					arg_90_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1072ui_story.fillRatio = var_93_10
				end
			end

			if arg_90_1.time_ >= var_93_7 + var_93_8 and arg_90_1.time_ < var_93_7 + var_93_8 + arg_93_0 and not isNil(var_93_6) and arg_90_1.var_.characterEffect1072ui_story then
				local var_93_11 = 0.5

				arg_90_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1072ui_story.fillRatio = var_93_11
			end

			local var_93_12 = 0
			local var_93_13 = 0.65

			if var_93_12 < arg_90_1.time_ and arg_90_1.time_ <= var_93_12 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_14 = arg_90_1:FormatText(StoryNameCfg[389].name)

				arg_90_1.leftNameTxt_.text = var_93_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_15 = arg_90_1:GetWordFromCfg(121541021)
				local var_93_16 = arg_90_1:FormatText(var_93_15.content)

				arg_90_1.text_.text = var_93_16

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_17 = 26
				local var_93_18 = utf8.len(var_93_16)
				local var_93_19 = var_93_17 <= 0 and var_93_13 or var_93_13 * (var_93_18 / var_93_17)

				if var_93_19 > 0 and var_93_13 < var_93_19 then
					arg_90_1.talkMaxDuration = var_93_19

					if var_93_19 + var_93_12 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_19 + var_93_12
					end
				end

				arg_90_1.text_.text = var_93_16
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541021", "story_v_out_121541.awb") ~= 0 then
					local var_93_20 = manager.audio:GetVoiceLength("story_v_out_121541", "121541021", "story_v_out_121541.awb") / 1000

					if var_93_20 + var_93_12 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_20 + var_93_12
					end

					if var_93_15.prefab_name ~= "" and arg_90_1.actors_[var_93_15.prefab_name] ~= nil then
						local var_93_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_15.prefab_name].transform, "story_v_out_121541", "121541021", "story_v_out_121541.awb")

						arg_90_1:RecordAudio("121541021", var_93_21)
						arg_90_1:RecordAudio("121541021", var_93_21)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_121541", "121541021", "story_v_out_121541.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_121541", "121541021", "story_v_out_121541.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_22 = math.max(var_93_13, arg_90_1.talkMaxDuration)

			if var_93_12 <= arg_90_1.time_ and arg_90_1.time_ < var_93_12 + var_93_22 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_12) / var_93_22

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_12 + var_93_22 and arg_90_1.time_ < var_93_12 + var_93_22 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play121541022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 121541022
		arg_94_1.duration_ = 8.97

		local var_94_0 = {
			ja = 8.966,
			ko = 7.233,
			zh = 7.233
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play121541023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1072ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1072ui_story == nil then
				arg_94_1.var_.characterEffect1072ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1072ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1072ui_story then
				arg_94_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_97_4 = 0

			if var_97_4 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_1")
			end

			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_97_6 = arg_94_1.actors_["1076ui_story"]
			local var_97_7 = 0

			if var_97_7 < arg_94_1.time_ and arg_94_1.time_ <= var_97_7 + arg_97_0 and not isNil(var_97_6) and arg_94_1.var_.characterEffect1076ui_story == nil then
				arg_94_1.var_.characterEffect1076ui_story = var_97_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_8 = 0.200000002980232

			if var_97_7 <= arg_94_1.time_ and arg_94_1.time_ < var_97_7 + var_97_8 and not isNil(var_97_6) then
				local var_97_9 = (arg_94_1.time_ - var_97_7) / var_97_8

				if arg_94_1.var_.characterEffect1076ui_story and not isNil(var_97_6) then
					local var_97_10 = Mathf.Lerp(0, 0.5, var_97_9)

					arg_94_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1076ui_story.fillRatio = var_97_10
				end
			end

			if arg_94_1.time_ >= var_97_7 + var_97_8 and arg_94_1.time_ < var_97_7 + var_97_8 + arg_97_0 and not isNil(var_97_6) and arg_94_1.var_.characterEffect1076ui_story then
				local var_97_11 = 0.5

				arg_94_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1076ui_story.fillRatio = var_97_11
			end

			local var_97_12 = 0

			if var_97_12 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 then
				arg_94_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_2")
			end

			local var_97_13 = 0
			local var_97_14 = 0.95

			if var_97_13 < arg_94_1.time_ and arg_94_1.time_ <= var_97_13 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_15 = arg_94_1:FormatText(StoryNameCfg[379].name)

				arg_94_1.leftNameTxt_.text = var_97_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_16 = arg_94_1:GetWordFromCfg(121541022)
				local var_97_17 = arg_94_1:FormatText(var_97_16.content)

				arg_94_1.text_.text = var_97_17

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_18 = 37
				local var_97_19 = utf8.len(var_97_17)
				local var_97_20 = var_97_18 <= 0 and var_97_14 or var_97_14 * (var_97_19 / var_97_18)

				if var_97_20 > 0 and var_97_14 < var_97_20 then
					arg_94_1.talkMaxDuration = var_97_20

					if var_97_20 + var_97_13 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_20 + var_97_13
					end
				end

				arg_94_1.text_.text = var_97_17
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541022", "story_v_out_121541.awb") ~= 0 then
					local var_97_21 = manager.audio:GetVoiceLength("story_v_out_121541", "121541022", "story_v_out_121541.awb") / 1000

					if var_97_21 + var_97_13 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_21 + var_97_13
					end

					if var_97_16.prefab_name ~= "" and arg_94_1.actors_[var_97_16.prefab_name] ~= nil then
						local var_97_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_16.prefab_name].transform, "story_v_out_121541", "121541022", "story_v_out_121541.awb")

						arg_94_1:RecordAudio("121541022", var_97_22)
						arg_94_1:RecordAudio("121541022", var_97_22)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_121541", "121541022", "story_v_out_121541.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_121541", "121541022", "story_v_out_121541.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_23 = math.max(var_97_14, arg_94_1.talkMaxDuration)

			if var_97_13 <= arg_94_1.time_ and arg_94_1.time_ < var_97_13 + var_97_23 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_13) / var_97_23

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_13 + var_97_23 and arg_94_1.time_ < var_97_13 + var_97_23 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play121541023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 121541023
		arg_98_1.duration_ = 5.2

		local var_98_0 = {
			ja = 5.2,
			ko = 4.633,
			zh = 4.633
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play121541024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_2")
			end

			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_101_2 = 0
			local var_101_3 = 0.525

			if var_101_2 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_4 = arg_98_1:FormatText(StoryNameCfg[379].name)

				arg_98_1.leftNameTxt_.text = var_101_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_5 = arg_98_1:GetWordFromCfg(121541023)
				local var_101_6 = arg_98_1:FormatText(var_101_5.content)

				arg_98_1.text_.text = var_101_6

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_7 = 21
				local var_101_8 = utf8.len(var_101_6)
				local var_101_9 = var_101_7 <= 0 and var_101_3 or var_101_3 * (var_101_8 / var_101_7)

				if var_101_9 > 0 and var_101_3 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_2
					end
				end

				arg_98_1.text_.text = var_101_6
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541023", "story_v_out_121541.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_121541", "121541023", "story_v_out_121541.awb") / 1000

					if var_101_10 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_2
					end

					if var_101_5.prefab_name ~= "" and arg_98_1.actors_[var_101_5.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_5.prefab_name].transform, "story_v_out_121541", "121541023", "story_v_out_121541.awb")

						arg_98_1:RecordAudio("121541023", var_101_11)
						arg_98_1:RecordAudio("121541023", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_121541", "121541023", "story_v_out_121541.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_121541", "121541023", "story_v_out_121541.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_3, arg_98_1.talkMaxDuration)

			if var_101_2 <= arg_98_1.time_ and arg_98_1.time_ < var_101_2 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_2) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_2 + var_101_12 and arg_98_1.time_ < var_101_2 + var_101_12 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play121541024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 121541024
		arg_102_1.duration_ = 8.87

		local var_102_0 = {
			ja = 8.866,
			ko = 6,
			zh = 6
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play121541025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1076ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1076ui_story == nil then
				arg_102_1.var_.characterEffect1076ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1076ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1076ui_story then
				arg_102_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_105_4 = 0

			if var_105_4 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action4_1")
			end

			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_105_6 = arg_102_1.actors_["1072ui_story"]
			local var_105_7 = 0

			if var_105_7 < arg_102_1.time_ and arg_102_1.time_ <= var_105_7 + arg_105_0 and not isNil(var_105_6) and arg_102_1.var_.characterEffect1072ui_story == nil then
				arg_102_1.var_.characterEffect1072ui_story = var_105_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_8 = 0.200000002980232

			if var_105_7 <= arg_102_1.time_ and arg_102_1.time_ < var_105_7 + var_105_8 and not isNil(var_105_6) then
				local var_105_9 = (arg_102_1.time_ - var_105_7) / var_105_8

				if arg_102_1.var_.characterEffect1072ui_story and not isNil(var_105_6) then
					local var_105_10 = Mathf.Lerp(0, 0.5, var_105_9)

					arg_102_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1072ui_story.fillRatio = var_105_10
				end
			end

			if arg_102_1.time_ >= var_105_7 + var_105_8 and arg_102_1.time_ < var_105_7 + var_105_8 + arg_105_0 and not isNil(var_105_6) and arg_102_1.var_.characterEffect1072ui_story then
				local var_105_11 = 0.5

				arg_102_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1072ui_story.fillRatio = var_105_11
			end

			local var_105_12 = 0
			local var_105_13 = 0.575

			if var_105_12 < arg_102_1.time_ and arg_102_1.time_ <= var_105_12 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_14 = arg_102_1:FormatText(StoryNameCfg[389].name)

				arg_102_1.leftNameTxt_.text = var_105_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_15 = arg_102_1:GetWordFromCfg(121541024)
				local var_105_16 = arg_102_1:FormatText(var_105_15.content)

				arg_102_1.text_.text = var_105_16

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_17 = 23
				local var_105_18 = utf8.len(var_105_16)
				local var_105_19 = var_105_17 <= 0 and var_105_13 or var_105_13 * (var_105_18 / var_105_17)

				if var_105_19 > 0 and var_105_13 < var_105_19 then
					arg_102_1.talkMaxDuration = var_105_19

					if var_105_19 + var_105_12 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_19 + var_105_12
					end
				end

				arg_102_1.text_.text = var_105_16
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541024", "story_v_out_121541.awb") ~= 0 then
					local var_105_20 = manager.audio:GetVoiceLength("story_v_out_121541", "121541024", "story_v_out_121541.awb") / 1000

					if var_105_20 + var_105_12 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_20 + var_105_12
					end

					if var_105_15.prefab_name ~= "" and arg_102_1.actors_[var_105_15.prefab_name] ~= nil then
						local var_105_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_15.prefab_name].transform, "story_v_out_121541", "121541024", "story_v_out_121541.awb")

						arg_102_1:RecordAudio("121541024", var_105_21)
						arg_102_1:RecordAudio("121541024", var_105_21)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_121541", "121541024", "story_v_out_121541.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_121541", "121541024", "story_v_out_121541.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_22 = math.max(var_105_13, arg_102_1.talkMaxDuration)

			if var_105_12 <= arg_102_1.time_ and arg_102_1.time_ < var_105_12 + var_105_22 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_12) / var_105_22

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_12 + var_105_22 and arg_102_1.time_ < var_105_12 + var_105_22 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play121541025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 121541025
		arg_106_1.duration_ = 7.33

		local var_106_0 = {
			ja = 7.333,
			ko = 4.966,
			zh = 4.966
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play121541026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1072ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1072ui_story == nil then
				arg_106_1.var_.characterEffect1072ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1072ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1072ui_story then
				arg_106_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_109_4 = 0

			if var_109_4 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_109_5 = arg_106_1.actors_["1076ui_story"]
			local var_109_6 = 0

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 and not isNil(var_109_5) and arg_106_1.var_.characterEffect1076ui_story == nil then
				arg_106_1.var_.characterEffect1076ui_story = var_109_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_7 = 0.200000002980232

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_7 and not isNil(var_109_5) then
				local var_109_8 = (arg_106_1.time_ - var_109_6) / var_109_7

				if arg_106_1.var_.characterEffect1076ui_story and not isNil(var_109_5) then
					local var_109_9 = Mathf.Lerp(0, 0.5, var_109_8)

					arg_106_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1076ui_story.fillRatio = var_109_9
				end
			end

			if arg_106_1.time_ >= var_109_6 + var_109_7 and arg_106_1.time_ < var_109_6 + var_109_7 + arg_109_0 and not isNil(var_109_5) and arg_106_1.var_.characterEffect1076ui_story then
				local var_109_10 = 0.5

				arg_106_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1076ui_story.fillRatio = var_109_10
			end

			local var_109_11 = 0
			local var_109_12 = 0.425

			if var_109_11 < arg_106_1.time_ and arg_106_1.time_ <= var_109_11 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_13 = arg_106_1:FormatText(StoryNameCfg[379].name)

				arg_106_1.leftNameTxt_.text = var_109_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_14 = arg_106_1:GetWordFromCfg(121541025)
				local var_109_15 = arg_106_1:FormatText(var_109_14.content)

				arg_106_1.text_.text = var_109_15

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_16 = 17
				local var_109_17 = utf8.len(var_109_15)
				local var_109_18 = var_109_16 <= 0 and var_109_12 or var_109_12 * (var_109_17 / var_109_16)

				if var_109_18 > 0 and var_109_12 < var_109_18 then
					arg_106_1.talkMaxDuration = var_109_18

					if var_109_18 + var_109_11 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_18 + var_109_11
					end
				end

				arg_106_1.text_.text = var_109_15
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541025", "story_v_out_121541.awb") ~= 0 then
					local var_109_19 = manager.audio:GetVoiceLength("story_v_out_121541", "121541025", "story_v_out_121541.awb") / 1000

					if var_109_19 + var_109_11 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_19 + var_109_11
					end

					if var_109_14.prefab_name ~= "" and arg_106_1.actors_[var_109_14.prefab_name] ~= nil then
						local var_109_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_14.prefab_name].transform, "story_v_out_121541", "121541025", "story_v_out_121541.awb")

						arg_106_1:RecordAudio("121541025", var_109_20)
						arg_106_1:RecordAudio("121541025", var_109_20)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_121541", "121541025", "story_v_out_121541.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_121541", "121541025", "story_v_out_121541.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_21 = math.max(var_109_12, arg_106_1.talkMaxDuration)

			if var_109_11 <= arg_106_1.time_ and arg_106_1.time_ < var_109_11 + var_109_21 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_11) / var_109_21

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_11 + var_109_21 and arg_106_1.time_ < var_109_11 + var_109_21 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play121541026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 121541026
		arg_110_1.duration_ = 3.03

		local var_110_0 = {
			ja = 3.033,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play121541027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1076ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1076ui_story == nil then
				arg_110_1.var_.characterEffect1076ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1076ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1076ui_story then
				arg_110_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_113_4 = 0

			if var_113_4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action4_2")
			end

			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_113_6 = arg_110_1.actors_["1072ui_story"]
			local var_113_7 = 0

			if var_113_7 < arg_110_1.time_ and arg_110_1.time_ <= var_113_7 + arg_113_0 and not isNil(var_113_6) and arg_110_1.var_.characterEffect1072ui_story == nil then
				arg_110_1.var_.characterEffect1072ui_story = var_113_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_8 = 0.200000002980232

			if var_113_7 <= arg_110_1.time_ and arg_110_1.time_ < var_113_7 + var_113_8 and not isNil(var_113_6) then
				local var_113_9 = (arg_110_1.time_ - var_113_7) / var_113_8

				if arg_110_1.var_.characterEffect1072ui_story and not isNil(var_113_6) then
					local var_113_10 = Mathf.Lerp(0, 0.5, var_113_9)

					arg_110_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1072ui_story.fillRatio = var_113_10
				end
			end

			if arg_110_1.time_ >= var_113_7 + var_113_8 and arg_110_1.time_ < var_113_7 + var_113_8 + arg_113_0 and not isNil(var_113_6) and arg_110_1.var_.characterEffect1072ui_story then
				local var_113_11 = 0.5

				arg_110_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1072ui_story.fillRatio = var_113_11
			end

			local var_113_12 = 0
			local var_113_13 = 0.1

			if var_113_12 < arg_110_1.time_ and arg_110_1.time_ <= var_113_12 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_14 = arg_110_1:FormatText(StoryNameCfg[389].name)

				arg_110_1.leftNameTxt_.text = var_113_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_15 = arg_110_1:GetWordFromCfg(121541026)
				local var_113_16 = arg_110_1:FormatText(var_113_15.content)

				arg_110_1.text_.text = var_113_16

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_17 = 4
				local var_113_18 = utf8.len(var_113_16)
				local var_113_19 = var_113_17 <= 0 and var_113_13 or var_113_13 * (var_113_18 / var_113_17)

				if var_113_19 > 0 and var_113_13 < var_113_19 then
					arg_110_1.talkMaxDuration = var_113_19

					if var_113_19 + var_113_12 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_19 + var_113_12
					end
				end

				arg_110_1.text_.text = var_113_16
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541026", "story_v_out_121541.awb") ~= 0 then
					local var_113_20 = manager.audio:GetVoiceLength("story_v_out_121541", "121541026", "story_v_out_121541.awb") / 1000

					if var_113_20 + var_113_12 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_20 + var_113_12
					end

					if var_113_15.prefab_name ~= "" and arg_110_1.actors_[var_113_15.prefab_name] ~= nil then
						local var_113_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_15.prefab_name].transform, "story_v_out_121541", "121541026", "story_v_out_121541.awb")

						arg_110_1:RecordAudio("121541026", var_113_21)
						arg_110_1:RecordAudio("121541026", var_113_21)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_121541", "121541026", "story_v_out_121541.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_121541", "121541026", "story_v_out_121541.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_22 = math.max(var_113_13, arg_110_1.talkMaxDuration)

			if var_113_12 <= arg_110_1.time_ and arg_110_1.time_ < var_113_12 + var_113_22 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_12) / var_113_22

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_12 + var_113_22 and arg_110_1.time_ < var_113_12 + var_113_22 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play121541027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 121541027
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play121541028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1076ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1076ui_story == nil then
				arg_114_1.var_.characterEffect1076ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1076ui_story and not isNil(var_117_0) then
					local var_117_4 = Mathf.Lerp(0, 0.5, var_117_3)

					arg_114_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1076ui_story.fillRatio = var_117_4
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1076ui_story then
				local var_117_5 = 0.5

				arg_114_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1076ui_story.fillRatio = var_117_5
			end

			local var_117_6 = 0
			local var_117_7 = 0.825

			if var_117_6 < arg_114_1.time_ and arg_114_1.time_ <= var_117_6 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_8 = arg_114_1:GetWordFromCfg(121541027)
				local var_117_9 = arg_114_1:FormatText(var_117_8.content)

				arg_114_1.text_.text = var_117_9

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_10 = 33
				local var_117_11 = utf8.len(var_117_9)
				local var_117_12 = var_117_10 <= 0 and var_117_7 or var_117_7 * (var_117_11 / var_117_10)

				if var_117_12 > 0 and var_117_7 < var_117_12 then
					arg_114_1.talkMaxDuration = var_117_12

					if var_117_12 + var_117_6 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_12 + var_117_6
					end
				end

				arg_114_1.text_.text = var_117_9
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_13 = math.max(var_117_7, arg_114_1.talkMaxDuration)

			if var_117_6 <= arg_114_1.time_ and arg_114_1.time_ < var_117_6 + var_117_13 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_6) / var_117_13

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_6 + var_117_13 and arg_114_1.time_ < var_117_6 + var_117_13 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play121541028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 121541028
		arg_118_1.duration_ = 6.33

		local var_118_0 = {
			ja = 4.233,
			ko = 6.333,
			zh = 6.333
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play121541029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1072ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1072ui_story == nil then
				arg_118_1.var_.characterEffect1072ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1072ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1072ui_story then
				arg_118_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_121_4 = 0

			if var_121_4 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 then
				arg_118_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_121_6 = 0
			local var_121_7 = 0.575

			if var_121_6 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_8 = arg_118_1:FormatText(StoryNameCfg[379].name)

				arg_118_1.leftNameTxt_.text = var_121_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_9 = arg_118_1:GetWordFromCfg(121541028)
				local var_121_10 = arg_118_1:FormatText(var_121_9.content)

				arg_118_1.text_.text = var_121_10

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 23
				local var_121_12 = utf8.len(var_121_10)
				local var_121_13 = var_121_11 <= 0 and var_121_7 or var_121_7 * (var_121_12 / var_121_11)

				if var_121_13 > 0 and var_121_7 < var_121_13 then
					arg_118_1.talkMaxDuration = var_121_13

					if var_121_13 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_13 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_10
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541028", "story_v_out_121541.awb") ~= 0 then
					local var_121_14 = manager.audio:GetVoiceLength("story_v_out_121541", "121541028", "story_v_out_121541.awb") / 1000

					if var_121_14 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_14 + var_121_6
					end

					if var_121_9.prefab_name ~= "" and arg_118_1.actors_[var_121_9.prefab_name] ~= nil then
						local var_121_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_9.prefab_name].transform, "story_v_out_121541", "121541028", "story_v_out_121541.awb")

						arg_118_1:RecordAudio("121541028", var_121_15)
						arg_118_1:RecordAudio("121541028", var_121_15)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_121541", "121541028", "story_v_out_121541.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_121541", "121541028", "story_v_out_121541.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_16 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_16 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_16

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_16 and arg_118_1.time_ < var_121_6 + var_121_16 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play121541029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 121541029
		arg_122_1.duration_ = 4.07

		local var_122_0 = {
			ja = 4.066,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play121541030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1076ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1076ui_story == nil then
				arg_122_1.var_.characterEffect1076ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1076ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1076ui_story then
				arg_122_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_125_4 = 0

			if var_125_4 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_125_5 = arg_122_1.actors_["1072ui_story"]
			local var_125_6 = 0

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 and not isNil(var_125_5) and arg_122_1.var_.characterEffect1072ui_story == nil then
				arg_122_1.var_.characterEffect1072ui_story = var_125_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_7 = 0.200000002980232

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_7 and not isNil(var_125_5) then
				local var_125_8 = (arg_122_1.time_ - var_125_6) / var_125_7

				if arg_122_1.var_.characterEffect1072ui_story and not isNil(var_125_5) then
					local var_125_9 = Mathf.Lerp(0, 0.5, var_125_8)

					arg_122_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1072ui_story.fillRatio = var_125_9
				end
			end

			if arg_122_1.time_ >= var_125_6 + var_125_7 and arg_122_1.time_ < var_125_6 + var_125_7 + arg_125_0 and not isNil(var_125_5) and arg_122_1.var_.characterEffect1072ui_story then
				local var_125_10 = 0.5

				arg_122_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1072ui_story.fillRatio = var_125_10
			end

			local var_125_11 = 0
			local var_125_12 = 0.25

			if var_125_11 < arg_122_1.time_ and arg_122_1.time_ <= var_125_11 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_13 = arg_122_1:FormatText(StoryNameCfg[389].name)

				arg_122_1.leftNameTxt_.text = var_125_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_14 = arg_122_1:GetWordFromCfg(121541029)
				local var_125_15 = arg_122_1:FormatText(var_125_14.content)

				arg_122_1.text_.text = var_125_15

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_16 = 10
				local var_125_17 = utf8.len(var_125_15)
				local var_125_18 = var_125_16 <= 0 and var_125_12 or var_125_12 * (var_125_17 / var_125_16)

				if var_125_18 > 0 and var_125_12 < var_125_18 then
					arg_122_1.talkMaxDuration = var_125_18

					if var_125_18 + var_125_11 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_18 + var_125_11
					end
				end

				arg_122_1.text_.text = var_125_15
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541029", "story_v_out_121541.awb") ~= 0 then
					local var_125_19 = manager.audio:GetVoiceLength("story_v_out_121541", "121541029", "story_v_out_121541.awb") / 1000

					if var_125_19 + var_125_11 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_19 + var_125_11
					end

					if var_125_14.prefab_name ~= "" and arg_122_1.actors_[var_125_14.prefab_name] ~= nil then
						local var_125_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_14.prefab_name].transform, "story_v_out_121541", "121541029", "story_v_out_121541.awb")

						arg_122_1:RecordAudio("121541029", var_125_20)
						arg_122_1:RecordAudio("121541029", var_125_20)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_121541", "121541029", "story_v_out_121541.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_121541", "121541029", "story_v_out_121541.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_21 = math.max(var_125_12, arg_122_1.talkMaxDuration)

			if var_125_11 <= arg_122_1.time_ and arg_122_1.time_ < var_125_11 + var_125_21 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_11) / var_125_21

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_11 + var_125_21 and arg_122_1.time_ < var_125_11 + var_125_21 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play121541030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 121541030
		arg_126_1.duration_ = 9.63

		local var_126_0 = {
			ja = 9.633,
			ko = 6.4,
			zh = 6.4
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play121541031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 0.75

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_2 = arg_126_1:FormatText(StoryNameCfg[389].name)

				arg_126_1.leftNameTxt_.text = var_129_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_3 = arg_126_1:GetWordFromCfg(121541030)
				local var_129_4 = arg_126_1:FormatText(var_129_3.content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 30
				local var_129_6 = utf8.len(var_129_4)
				local var_129_7 = var_129_5 <= 0 and var_129_1 or var_129_1 * (var_129_6 / var_129_5)

				if var_129_7 > 0 and var_129_1 < var_129_7 then
					arg_126_1.talkMaxDuration = var_129_7

					if var_129_7 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_4
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541030", "story_v_out_121541.awb") ~= 0 then
					local var_129_8 = manager.audio:GetVoiceLength("story_v_out_121541", "121541030", "story_v_out_121541.awb") / 1000

					if var_129_8 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_8 + var_129_0
					end

					if var_129_3.prefab_name ~= "" and arg_126_1.actors_[var_129_3.prefab_name] ~= nil then
						local var_129_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_3.prefab_name].transform, "story_v_out_121541", "121541030", "story_v_out_121541.awb")

						arg_126_1:RecordAudio("121541030", var_129_9)
						arg_126_1:RecordAudio("121541030", var_129_9)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_121541", "121541030", "story_v_out_121541.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_121541", "121541030", "story_v_out_121541.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_10 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_10 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_10

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_10 and arg_126_1.time_ < var_129_0 + var_129_10 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play121541031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 121541031
		arg_130_1.duration_ = 5.9

		local var_130_0 = {
			ja = 5.9,
			ko = 5.666,
			zh = 5.666
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play121541032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1072ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1072ui_story == nil then
				arg_130_1.var_.characterEffect1072ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect1072ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1072ui_story then
				arg_130_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_133_4 = 0

			if var_133_4 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_133_5 = 0

			if var_133_5 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_133_6 = arg_130_1.actors_["1076ui_story"]
			local var_133_7 = 0

			if var_133_7 < arg_130_1.time_ and arg_130_1.time_ <= var_133_7 + arg_133_0 and not isNil(var_133_6) and arg_130_1.var_.characterEffect1076ui_story == nil then
				arg_130_1.var_.characterEffect1076ui_story = var_133_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_8 = 0.200000002980232

			if var_133_7 <= arg_130_1.time_ and arg_130_1.time_ < var_133_7 + var_133_8 and not isNil(var_133_6) then
				local var_133_9 = (arg_130_1.time_ - var_133_7) / var_133_8

				if arg_130_1.var_.characterEffect1076ui_story and not isNil(var_133_6) then
					local var_133_10 = Mathf.Lerp(0, 0.5, var_133_9)

					arg_130_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1076ui_story.fillRatio = var_133_10
				end
			end

			if arg_130_1.time_ >= var_133_7 + var_133_8 and arg_130_1.time_ < var_133_7 + var_133_8 + arg_133_0 and not isNil(var_133_6) and arg_130_1.var_.characterEffect1076ui_story then
				local var_133_11 = 0.5

				arg_130_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1076ui_story.fillRatio = var_133_11
			end

			local var_133_12 = 0
			local var_133_13 = 0.475

			if var_133_12 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_14 = arg_130_1:FormatText(StoryNameCfg[379].name)

				arg_130_1.leftNameTxt_.text = var_133_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_15 = arg_130_1:GetWordFromCfg(121541031)
				local var_133_16 = arg_130_1:FormatText(var_133_15.content)

				arg_130_1.text_.text = var_133_16

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_17 = 19
				local var_133_18 = utf8.len(var_133_16)
				local var_133_19 = var_133_17 <= 0 and var_133_13 or var_133_13 * (var_133_18 / var_133_17)

				if var_133_19 > 0 and var_133_13 < var_133_19 then
					arg_130_1.talkMaxDuration = var_133_19

					if var_133_19 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_19 + var_133_12
					end
				end

				arg_130_1.text_.text = var_133_16
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541031", "story_v_out_121541.awb") ~= 0 then
					local var_133_20 = manager.audio:GetVoiceLength("story_v_out_121541", "121541031", "story_v_out_121541.awb") / 1000

					if var_133_20 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_20 + var_133_12
					end

					if var_133_15.prefab_name ~= "" and arg_130_1.actors_[var_133_15.prefab_name] ~= nil then
						local var_133_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_15.prefab_name].transform, "story_v_out_121541", "121541031", "story_v_out_121541.awb")

						arg_130_1:RecordAudio("121541031", var_133_21)
						arg_130_1:RecordAudio("121541031", var_133_21)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_121541", "121541031", "story_v_out_121541.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_121541", "121541031", "story_v_out_121541.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_22 = math.max(var_133_13, arg_130_1.talkMaxDuration)

			if var_133_12 <= arg_130_1.time_ and arg_130_1.time_ < var_133_12 + var_133_22 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_12) / var_133_22

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_12 + var_133_22 and arg_130_1.time_ < var_133_12 + var_133_22 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play121541032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 121541032
		arg_134_1.duration_ = 6.73

		local var_134_0 = {
			ja = 6.733,
			ko = 5.933,
			zh = 5.933
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play121541033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1076ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1076ui_story == nil then
				arg_134_1.var_.characterEffect1076ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1076ui_story and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1076ui_story then
				arg_134_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_137_4 = 0

			if var_137_4 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action6_1")
			end

			local var_137_5 = 0

			if var_137_5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 then
				arg_134_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_137_6 = arg_134_1.actors_["1072ui_story"]
			local var_137_7 = 0

			if var_137_7 < arg_134_1.time_ and arg_134_1.time_ <= var_137_7 + arg_137_0 and not isNil(var_137_6) and arg_134_1.var_.characterEffect1072ui_story == nil then
				arg_134_1.var_.characterEffect1072ui_story = var_137_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_8 = 0.200000002980232

			if var_137_7 <= arg_134_1.time_ and arg_134_1.time_ < var_137_7 + var_137_8 and not isNil(var_137_6) then
				local var_137_9 = (arg_134_1.time_ - var_137_7) / var_137_8

				if arg_134_1.var_.characterEffect1072ui_story and not isNil(var_137_6) then
					local var_137_10 = Mathf.Lerp(0, 0.5, var_137_9)

					arg_134_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1072ui_story.fillRatio = var_137_10
				end
			end

			if arg_134_1.time_ >= var_137_7 + var_137_8 and arg_134_1.time_ < var_137_7 + var_137_8 + arg_137_0 and not isNil(var_137_6) and arg_134_1.var_.characterEffect1072ui_story then
				local var_137_11 = 0.5

				arg_134_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1072ui_story.fillRatio = var_137_11
			end

			local var_137_12 = 0
			local var_137_13 = 0.55

			if var_137_12 < arg_134_1.time_ and arg_134_1.time_ <= var_137_12 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_14 = arg_134_1:FormatText(StoryNameCfg[389].name)

				arg_134_1.leftNameTxt_.text = var_137_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_15 = arg_134_1:GetWordFromCfg(121541032)
				local var_137_16 = arg_134_1:FormatText(var_137_15.content)

				arg_134_1.text_.text = var_137_16

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_17 = 22
				local var_137_18 = utf8.len(var_137_16)
				local var_137_19 = var_137_17 <= 0 and var_137_13 or var_137_13 * (var_137_18 / var_137_17)

				if var_137_19 > 0 and var_137_13 < var_137_19 then
					arg_134_1.talkMaxDuration = var_137_19

					if var_137_19 + var_137_12 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_19 + var_137_12
					end
				end

				arg_134_1.text_.text = var_137_16
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541032", "story_v_out_121541.awb") ~= 0 then
					local var_137_20 = manager.audio:GetVoiceLength("story_v_out_121541", "121541032", "story_v_out_121541.awb") / 1000

					if var_137_20 + var_137_12 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_20 + var_137_12
					end

					if var_137_15.prefab_name ~= "" and arg_134_1.actors_[var_137_15.prefab_name] ~= nil then
						local var_137_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_15.prefab_name].transform, "story_v_out_121541", "121541032", "story_v_out_121541.awb")

						arg_134_1:RecordAudio("121541032", var_137_21)
						arg_134_1:RecordAudio("121541032", var_137_21)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_121541", "121541032", "story_v_out_121541.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_121541", "121541032", "story_v_out_121541.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_22 = math.max(var_137_13, arg_134_1.talkMaxDuration)

			if var_137_12 <= arg_134_1.time_ and arg_134_1.time_ < var_137_12 + var_137_22 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_12) / var_137_22

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_12 + var_137_22 and arg_134_1.time_ < var_137_12 + var_137_22 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play121541033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 121541033
		arg_138_1.duration_ = 10.07

		local var_138_0 = {
			ja = 10.066,
			ko = 9.666,
			zh = 9.666
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play121541034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1072ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1072ui_story == nil then
				arg_138_1.var_.characterEffect1072ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1072ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1072ui_story then
				arg_138_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_141_4 = 0

			if var_141_4 < arg_138_1.time_ and arg_138_1.time_ <= var_141_4 + arg_141_0 then
				arg_138_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_1")
			end

			local var_141_5 = 0

			if var_141_5 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_141_6 = arg_138_1.actors_["1076ui_story"]
			local var_141_7 = 0

			if var_141_7 < arg_138_1.time_ and arg_138_1.time_ <= var_141_7 + arg_141_0 and not isNil(var_141_6) and arg_138_1.var_.characterEffect1076ui_story == nil then
				arg_138_1.var_.characterEffect1076ui_story = var_141_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_8 = 0.200000002980232

			if var_141_7 <= arg_138_1.time_ and arg_138_1.time_ < var_141_7 + var_141_8 and not isNil(var_141_6) then
				local var_141_9 = (arg_138_1.time_ - var_141_7) / var_141_8

				if arg_138_1.var_.characterEffect1076ui_story and not isNil(var_141_6) then
					local var_141_10 = Mathf.Lerp(0, 0.5, var_141_9)

					arg_138_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1076ui_story.fillRatio = var_141_10
				end
			end

			if arg_138_1.time_ >= var_141_7 + var_141_8 and arg_138_1.time_ < var_141_7 + var_141_8 + arg_141_0 and not isNil(var_141_6) and arg_138_1.var_.characterEffect1076ui_story then
				local var_141_11 = 0.5

				arg_138_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1076ui_story.fillRatio = var_141_11
			end

			local var_141_12 = 0
			local var_141_13 = 1.025

			if var_141_12 < arg_138_1.time_ and arg_138_1.time_ <= var_141_12 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_14 = arg_138_1:FormatText(StoryNameCfg[379].name)

				arg_138_1.leftNameTxt_.text = var_141_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_15 = arg_138_1:GetWordFromCfg(121541033)
				local var_141_16 = arg_138_1:FormatText(var_141_15.content)

				arg_138_1.text_.text = var_141_16

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_17 = 41
				local var_141_18 = utf8.len(var_141_16)
				local var_141_19 = var_141_17 <= 0 and var_141_13 or var_141_13 * (var_141_18 / var_141_17)

				if var_141_19 > 0 and var_141_13 < var_141_19 then
					arg_138_1.talkMaxDuration = var_141_19

					if var_141_19 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_19 + var_141_12
					end
				end

				arg_138_1.text_.text = var_141_16
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541033", "story_v_out_121541.awb") ~= 0 then
					local var_141_20 = manager.audio:GetVoiceLength("story_v_out_121541", "121541033", "story_v_out_121541.awb") / 1000

					if var_141_20 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_20 + var_141_12
					end

					if var_141_15.prefab_name ~= "" and arg_138_1.actors_[var_141_15.prefab_name] ~= nil then
						local var_141_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_15.prefab_name].transform, "story_v_out_121541", "121541033", "story_v_out_121541.awb")

						arg_138_1:RecordAudio("121541033", var_141_21)
						arg_138_1:RecordAudio("121541033", var_141_21)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_121541", "121541033", "story_v_out_121541.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_121541", "121541033", "story_v_out_121541.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_22 = math.max(var_141_13, arg_138_1.talkMaxDuration)

			if var_141_12 <= arg_138_1.time_ and arg_138_1.time_ < var_141_12 + var_141_22 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_12) / var_141_22

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_12 + var_141_22 and arg_138_1.time_ < var_141_12 + var_141_22 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play121541034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 121541034
		arg_142_1.duration_ = 7.63

		local var_142_0 = {
			ja = 7.633,
			ko = 7.433,
			zh = 7.433
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play121541035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_2")
			end

			local var_145_1 = 0
			local var_145_2 = 0.725

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_3 = arg_142_1:FormatText(StoryNameCfg[379].name)

				arg_142_1.leftNameTxt_.text = var_145_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_4 = arg_142_1:GetWordFromCfg(121541034)
				local var_145_5 = arg_142_1:FormatText(var_145_4.content)

				arg_142_1.text_.text = var_145_5

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_6 = 29
				local var_145_7 = utf8.len(var_145_5)
				local var_145_8 = var_145_6 <= 0 and var_145_2 or var_145_2 * (var_145_7 / var_145_6)

				if var_145_8 > 0 and var_145_2 < var_145_8 then
					arg_142_1.talkMaxDuration = var_145_8

					if var_145_8 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_1
					end
				end

				arg_142_1.text_.text = var_145_5
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541034", "story_v_out_121541.awb") ~= 0 then
					local var_145_9 = manager.audio:GetVoiceLength("story_v_out_121541", "121541034", "story_v_out_121541.awb") / 1000

					if var_145_9 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_1
					end

					if var_145_4.prefab_name ~= "" and arg_142_1.actors_[var_145_4.prefab_name] ~= nil then
						local var_145_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_4.prefab_name].transform, "story_v_out_121541", "121541034", "story_v_out_121541.awb")

						arg_142_1:RecordAudio("121541034", var_145_10)
						arg_142_1:RecordAudio("121541034", var_145_10)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_121541", "121541034", "story_v_out_121541.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_121541", "121541034", "story_v_out_121541.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_11 = math.max(var_145_2, arg_142_1.talkMaxDuration)

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_11 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_1) / var_145_11

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_1 + var_145_11 and arg_142_1.time_ < var_145_1 + var_145_11 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play121541035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 121541035
		arg_146_1.duration_ = 4.8

		local var_146_0 = {
			ja = 4.8,
			ko = 3.2,
			zh = 3.2
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play121541036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1076ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1076ui_story == nil then
				arg_146_1.var_.characterEffect1076ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1076ui_story and not isNil(var_149_0) then
					arg_146_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1076ui_story then
				arg_146_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_149_4 = 0

			if var_149_4 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action6_2")
			end

			local var_149_5 = 0

			if var_149_5 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 then
				arg_146_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_149_6 = arg_146_1.actors_["1072ui_story"]
			local var_149_7 = 0

			if var_149_7 < arg_146_1.time_ and arg_146_1.time_ <= var_149_7 + arg_149_0 and not isNil(var_149_6) and arg_146_1.var_.characterEffect1072ui_story == nil then
				arg_146_1.var_.characterEffect1072ui_story = var_149_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_8 = 0.200000002980232

			if var_149_7 <= arg_146_1.time_ and arg_146_1.time_ < var_149_7 + var_149_8 and not isNil(var_149_6) then
				local var_149_9 = (arg_146_1.time_ - var_149_7) / var_149_8

				if arg_146_1.var_.characterEffect1072ui_story and not isNil(var_149_6) then
					local var_149_10 = Mathf.Lerp(0, 0.5, var_149_9)

					arg_146_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1072ui_story.fillRatio = var_149_10
				end
			end

			if arg_146_1.time_ >= var_149_7 + var_149_8 and arg_146_1.time_ < var_149_7 + var_149_8 + arg_149_0 and not isNil(var_149_6) and arg_146_1.var_.characterEffect1072ui_story then
				local var_149_11 = 0.5

				arg_146_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1072ui_story.fillRatio = var_149_11
			end

			local var_149_12 = 0
			local var_149_13 = 0.275

			if var_149_12 < arg_146_1.time_ and arg_146_1.time_ <= var_149_12 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_14 = arg_146_1:FormatText(StoryNameCfg[389].name)

				arg_146_1.leftNameTxt_.text = var_149_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_15 = arg_146_1:GetWordFromCfg(121541035)
				local var_149_16 = arg_146_1:FormatText(var_149_15.content)

				arg_146_1.text_.text = var_149_16

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_17 = 11
				local var_149_18 = utf8.len(var_149_16)
				local var_149_19 = var_149_17 <= 0 and var_149_13 or var_149_13 * (var_149_18 / var_149_17)

				if var_149_19 > 0 and var_149_13 < var_149_19 then
					arg_146_1.talkMaxDuration = var_149_19

					if var_149_19 + var_149_12 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_19 + var_149_12
					end
				end

				arg_146_1.text_.text = var_149_16
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541035", "story_v_out_121541.awb") ~= 0 then
					local var_149_20 = manager.audio:GetVoiceLength("story_v_out_121541", "121541035", "story_v_out_121541.awb") / 1000

					if var_149_20 + var_149_12 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_20 + var_149_12
					end

					if var_149_15.prefab_name ~= "" and arg_146_1.actors_[var_149_15.prefab_name] ~= nil then
						local var_149_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_15.prefab_name].transform, "story_v_out_121541", "121541035", "story_v_out_121541.awb")

						arg_146_1:RecordAudio("121541035", var_149_21)
						arg_146_1:RecordAudio("121541035", var_149_21)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_121541", "121541035", "story_v_out_121541.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_121541", "121541035", "story_v_out_121541.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_22 = math.max(var_149_13, arg_146_1.talkMaxDuration)

			if var_149_12 <= arg_146_1.time_ and arg_146_1.time_ < var_149_12 + var_149_22 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_12) / var_149_22

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_12 + var_149_22 and arg_146_1.time_ < var_149_12 + var_149_22 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play121541036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 121541036
		arg_150_1.duration_ = 6.7

		local var_150_0 = {
			ja = 6.7,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play121541037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1072ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1072ui_story == nil then
				arg_150_1.var_.characterEffect1072ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect1072ui_story and not isNil(var_153_0) then
					arg_150_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1072ui_story then
				arg_150_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_153_4 = 0

			if var_153_4 < arg_150_1.time_ and arg_150_1.time_ <= var_153_4 + arg_153_0 then
				arg_150_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_153_5 = 0

			if var_153_5 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 then
				arg_150_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_153_6 = arg_150_1.actors_["1076ui_story"]
			local var_153_7 = 0

			if var_153_7 < arg_150_1.time_ and arg_150_1.time_ <= var_153_7 + arg_153_0 and not isNil(var_153_6) and arg_150_1.var_.characterEffect1076ui_story == nil then
				arg_150_1.var_.characterEffect1076ui_story = var_153_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_8 = 0.200000002980232

			if var_153_7 <= arg_150_1.time_ and arg_150_1.time_ < var_153_7 + var_153_8 and not isNil(var_153_6) then
				local var_153_9 = (arg_150_1.time_ - var_153_7) / var_153_8

				if arg_150_1.var_.characterEffect1076ui_story and not isNil(var_153_6) then
					local var_153_10 = Mathf.Lerp(0, 0.5, var_153_9)

					arg_150_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1076ui_story.fillRatio = var_153_10
				end
			end

			if arg_150_1.time_ >= var_153_7 + var_153_8 and arg_150_1.time_ < var_153_7 + var_153_8 + arg_153_0 and not isNil(var_153_6) and arg_150_1.var_.characterEffect1076ui_story then
				local var_153_11 = 0.5

				arg_150_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1076ui_story.fillRatio = var_153_11
			end

			local var_153_12 = 0
			local var_153_13 = 0.175

			if var_153_12 < arg_150_1.time_ and arg_150_1.time_ <= var_153_12 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_14 = arg_150_1:FormatText(StoryNameCfg[379].name)

				arg_150_1.leftNameTxt_.text = var_153_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_15 = arg_150_1:GetWordFromCfg(121541036)
				local var_153_16 = arg_150_1:FormatText(var_153_15.content)

				arg_150_1.text_.text = var_153_16

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_17 = 7
				local var_153_18 = utf8.len(var_153_16)
				local var_153_19 = var_153_17 <= 0 and var_153_13 or var_153_13 * (var_153_18 / var_153_17)

				if var_153_19 > 0 and var_153_13 < var_153_19 then
					arg_150_1.talkMaxDuration = var_153_19

					if var_153_19 + var_153_12 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_19 + var_153_12
					end
				end

				arg_150_1.text_.text = var_153_16
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541036", "story_v_out_121541.awb") ~= 0 then
					local var_153_20 = manager.audio:GetVoiceLength("story_v_out_121541", "121541036", "story_v_out_121541.awb") / 1000

					if var_153_20 + var_153_12 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_20 + var_153_12
					end

					if var_153_15.prefab_name ~= "" and arg_150_1.actors_[var_153_15.prefab_name] ~= nil then
						local var_153_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_15.prefab_name].transform, "story_v_out_121541", "121541036", "story_v_out_121541.awb")

						arg_150_1:RecordAudio("121541036", var_153_21)
						arg_150_1:RecordAudio("121541036", var_153_21)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_121541", "121541036", "story_v_out_121541.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_121541", "121541036", "story_v_out_121541.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_22 = math.max(var_153_13, arg_150_1.talkMaxDuration)

			if var_153_12 <= arg_150_1.time_ and arg_150_1.time_ < var_153_12 + var_153_22 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_12) / var_153_22

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_12 + var_153_22 and arg_150_1.time_ < var_153_12 + var_153_22 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play121541037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 121541037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play121541038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1072ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1072ui_story == nil then
				arg_154_1.var_.characterEffect1072ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1072ui_story and not isNil(var_157_0) then
					local var_157_4 = Mathf.Lerp(0, 0.5, var_157_3)

					arg_154_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1072ui_story.fillRatio = var_157_4
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1072ui_story then
				local var_157_5 = 0.5

				arg_154_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1072ui_story.fillRatio = var_157_5
			end

			local var_157_6 = 0
			local var_157_7 = 1.35

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_8 = arg_154_1:GetWordFromCfg(121541037)
				local var_157_9 = arg_154_1:FormatText(var_157_8.content)

				arg_154_1.text_.text = var_157_9

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_10 = 54
				local var_157_11 = utf8.len(var_157_9)
				local var_157_12 = var_157_10 <= 0 and var_157_7 or var_157_7 * (var_157_11 / var_157_10)

				if var_157_12 > 0 and var_157_7 < var_157_12 then
					arg_154_1.talkMaxDuration = var_157_12

					if var_157_12 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_12 + var_157_6
					end
				end

				arg_154_1.text_.text = var_157_9
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_13 = math.max(var_157_7, arg_154_1.talkMaxDuration)

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_13 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_6) / var_157_13

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_6 + var_157_13 and arg_154_1.time_ < var_157_6 + var_157_13 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play121541038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 121541038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play121541039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.7

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_2 = arg_158_1:GetWordFromCfg(121541038)
				local var_161_3 = arg_158_1:FormatText(var_161_2.content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 28
				local var_161_5 = utf8.len(var_161_3)
				local var_161_6 = var_161_4 <= 0 and var_161_1 or var_161_1 * (var_161_5 / var_161_4)

				if var_161_6 > 0 and var_161_1 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_7 and arg_158_1.time_ < var_161_0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play121541039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 121541039
		arg_162_1.duration_ = 5.27

		local var_162_0 = {
			ja = 1.999999999999,
			ko = 5.266,
			zh = 5.266
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play121541040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1076ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1076ui_story == nil then
				arg_162_1.var_.characterEffect1076ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1076ui_story and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1076ui_story then
				arg_162_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_165_4 = 0

			if var_165_4 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_165_5 = 0

			if var_165_5 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 then
				arg_162_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_165_6 = 0
			local var_165_7 = 0.1

			if var_165_6 < arg_162_1.time_ and arg_162_1.time_ <= var_165_6 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_8 = arg_162_1:FormatText(StoryNameCfg[389].name)

				arg_162_1.leftNameTxt_.text = var_165_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_9 = arg_162_1:GetWordFromCfg(121541039)
				local var_165_10 = arg_162_1:FormatText(var_165_9.content)

				arg_162_1.text_.text = var_165_10

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_11 = 4
				local var_165_12 = utf8.len(var_165_10)
				local var_165_13 = var_165_11 <= 0 and var_165_7 or var_165_7 * (var_165_12 / var_165_11)

				if var_165_13 > 0 and var_165_7 < var_165_13 then
					arg_162_1.talkMaxDuration = var_165_13

					if var_165_13 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_13 + var_165_6
					end
				end

				arg_162_1.text_.text = var_165_10
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541039", "story_v_out_121541.awb") ~= 0 then
					local var_165_14 = manager.audio:GetVoiceLength("story_v_out_121541", "121541039", "story_v_out_121541.awb") / 1000

					if var_165_14 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_14 + var_165_6
					end

					if var_165_9.prefab_name ~= "" and arg_162_1.actors_[var_165_9.prefab_name] ~= nil then
						local var_165_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_9.prefab_name].transform, "story_v_out_121541", "121541039", "story_v_out_121541.awb")

						arg_162_1:RecordAudio("121541039", var_165_15)
						arg_162_1:RecordAudio("121541039", var_165_15)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_121541", "121541039", "story_v_out_121541.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_121541", "121541039", "story_v_out_121541.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_16 = math.max(var_165_7, arg_162_1.talkMaxDuration)

			if var_165_6 <= arg_162_1.time_ and arg_162_1.time_ < var_165_6 + var_165_16 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_6) / var_165_16

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_6 + var_165_16 and arg_162_1.time_ < var_165_6 + var_165_16 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play121541040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 121541040
		arg_166_1.duration_ = 4.37

		local var_166_0 = {
			ja = 4.366,
			ko = 4.3,
			zh = 4.3
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play121541041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1072ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1072ui_story == nil then
				arg_166_1.var_.characterEffect1072ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect1072ui_story and not isNil(var_169_0) then
					arg_166_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1072ui_story then
				arg_166_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_169_4 = 0

			if var_169_4 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_169_5 = arg_166_1.actors_["1076ui_story"]
			local var_169_6 = 0

			if var_169_6 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 and not isNil(var_169_5) and arg_166_1.var_.characterEffect1076ui_story == nil then
				arg_166_1.var_.characterEffect1076ui_story = var_169_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_7 = 0.200000002980232

			if var_169_6 <= arg_166_1.time_ and arg_166_1.time_ < var_169_6 + var_169_7 and not isNil(var_169_5) then
				local var_169_8 = (arg_166_1.time_ - var_169_6) / var_169_7

				if arg_166_1.var_.characterEffect1076ui_story and not isNil(var_169_5) then
					local var_169_9 = Mathf.Lerp(0, 0.5, var_169_8)

					arg_166_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1076ui_story.fillRatio = var_169_9
				end
			end

			if arg_166_1.time_ >= var_169_6 + var_169_7 and arg_166_1.time_ < var_169_6 + var_169_7 + arg_169_0 and not isNil(var_169_5) and arg_166_1.var_.characterEffect1076ui_story then
				local var_169_10 = 0.5

				arg_166_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1076ui_story.fillRatio = var_169_10
			end

			local var_169_11 = 0
			local var_169_12 = 0.125

			if var_169_11 < arg_166_1.time_ and arg_166_1.time_ <= var_169_11 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_13 = arg_166_1:FormatText(StoryNameCfg[379].name)

				arg_166_1.leftNameTxt_.text = var_169_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_14 = arg_166_1:GetWordFromCfg(121541040)
				local var_169_15 = arg_166_1:FormatText(var_169_14.content)

				arg_166_1.text_.text = var_169_15

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_16 = 5
				local var_169_17 = utf8.len(var_169_15)
				local var_169_18 = var_169_16 <= 0 and var_169_12 or var_169_12 * (var_169_17 / var_169_16)

				if var_169_18 > 0 and var_169_12 < var_169_18 then
					arg_166_1.talkMaxDuration = var_169_18

					if var_169_18 + var_169_11 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_18 + var_169_11
					end
				end

				arg_166_1.text_.text = var_169_15
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541040", "story_v_out_121541.awb") ~= 0 then
					local var_169_19 = manager.audio:GetVoiceLength("story_v_out_121541", "121541040", "story_v_out_121541.awb") / 1000

					if var_169_19 + var_169_11 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_19 + var_169_11
					end

					if var_169_14.prefab_name ~= "" and arg_166_1.actors_[var_169_14.prefab_name] ~= nil then
						local var_169_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_14.prefab_name].transform, "story_v_out_121541", "121541040", "story_v_out_121541.awb")

						arg_166_1:RecordAudio("121541040", var_169_20)
						arg_166_1:RecordAudio("121541040", var_169_20)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_121541", "121541040", "story_v_out_121541.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_121541", "121541040", "story_v_out_121541.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_21 = math.max(var_169_12, arg_166_1.talkMaxDuration)

			if var_169_11 <= arg_166_1.time_ and arg_166_1.time_ < var_169_11 + var_169_21 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_11) / var_169_21

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_11 + var_169_21 and arg_166_1.time_ < var_169_11 + var_169_21 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play121541041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 121541041
		arg_170_1.duration_ = 8.13

		local var_170_0 = {
			ja = 8.133,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play121541042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1076ui_story"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect1076ui_story == nil then
				arg_170_1.var_.characterEffect1076ui_story = var_173_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.200000002980232

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.characterEffect1076ui_story and not isNil(var_173_0) then
					arg_170_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect1076ui_story then
				arg_170_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_173_4 = 0

			if var_173_4 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_173_5 = arg_170_1.actors_["1072ui_story"]
			local var_173_6 = 0

			if var_173_6 < arg_170_1.time_ and arg_170_1.time_ <= var_173_6 + arg_173_0 and not isNil(var_173_5) and arg_170_1.var_.characterEffect1072ui_story == nil then
				arg_170_1.var_.characterEffect1072ui_story = var_173_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_7 = 0.200000002980232

			if var_173_6 <= arg_170_1.time_ and arg_170_1.time_ < var_173_6 + var_173_7 and not isNil(var_173_5) then
				local var_173_8 = (arg_170_1.time_ - var_173_6) / var_173_7

				if arg_170_1.var_.characterEffect1072ui_story and not isNil(var_173_5) then
					local var_173_9 = Mathf.Lerp(0, 0.5, var_173_8)

					arg_170_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1072ui_story.fillRatio = var_173_9
				end
			end

			if arg_170_1.time_ >= var_173_6 + var_173_7 and arg_170_1.time_ < var_173_6 + var_173_7 + arg_173_0 and not isNil(var_173_5) and arg_170_1.var_.characterEffect1072ui_story then
				local var_173_10 = 0.5

				arg_170_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1072ui_story.fillRatio = var_173_10
			end

			local var_173_11 = 0
			local var_173_12 = 0.1

			if var_173_11 < arg_170_1.time_ and arg_170_1.time_ <= var_173_11 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_13 = arg_170_1:FormatText(StoryNameCfg[389].name)

				arg_170_1.leftNameTxt_.text = var_173_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_14 = arg_170_1:GetWordFromCfg(121541041)
				local var_173_15 = arg_170_1:FormatText(var_173_14.content)

				arg_170_1.text_.text = var_173_15

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_16 = 4
				local var_173_17 = utf8.len(var_173_15)
				local var_173_18 = var_173_16 <= 0 and var_173_12 or var_173_12 * (var_173_17 / var_173_16)

				if var_173_18 > 0 and var_173_12 < var_173_18 then
					arg_170_1.talkMaxDuration = var_173_18

					if var_173_18 + var_173_11 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_18 + var_173_11
					end
				end

				arg_170_1.text_.text = var_173_15
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541041", "story_v_out_121541.awb") ~= 0 then
					local var_173_19 = manager.audio:GetVoiceLength("story_v_out_121541", "121541041", "story_v_out_121541.awb") / 1000

					if var_173_19 + var_173_11 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_19 + var_173_11
					end

					if var_173_14.prefab_name ~= "" and arg_170_1.actors_[var_173_14.prefab_name] ~= nil then
						local var_173_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_14.prefab_name].transform, "story_v_out_121541", "121541041", "story_v_out_121541.awb")

						arg_170_1:RecordAudio("121541041", var_173_20)
						arg_170_1:RecordAudio("121541041", var_173_20)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_121541", "121541041", "story_v_out_121541.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_121541", "121541041", "story_v_out_121541.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_21 = math.max(var_173_12, arg_170_1.talkMaxDuration)

			if var_173_11 <= arg_170_1.time_ and arg_170_1.time_ < var_173_11 + var_173_21 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_11) / var_173_21

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_11 + var_173_21 and arg_170_1.time_ < var_173_11 + var_173_21 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play121541042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 121541042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play121541043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1076ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1076ui_story == nil then
				arg_174_1.var_.characterEffect1076ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect1076ui_story and not isNil(var_177_0) then
					local var_177_4 = Mathf.Lerp(0, 0.5, var_177_3)

					arg_174_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1076ui_story.fillRatio = var_177_4
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1076ui_story then
				local var_177_5 = 0.5

				arg_174_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1076ui_story.fillRatio = var_177_5
			end

			local var_177_6 = 0
			local var_177_7 = 1.325

			if var_177_6 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_8 = arg_174_1:GetWordFromCfg(121541042)
				local var_177_9 = arg_174_1:FormatText(var_177_8.content)

				arg_174_1.text_.text = var_177_9

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_10 = 53
				local var_177_11 = utf8.len(var_177_9)
				local var_177_12 = var_177_10 <= 0 and var_177_7 or var_177_7 * (var_177_11 / var_177_10)

				if var_177_12 > 0 and var_177_7 < var_177_12 then
					arg_174_1.talkMaxDuration = var_177_12

					if var_177_12 + var_177_6 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_12 + var_177_6
					end
				end

				arg_174_1.text_.text = var_177_9
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_13 = math.max(var_177_7, arg_174_1.talkMaxDuration)

			if var_177_6 <= arg_174_1.time_ and arg_174_1.time_ < var_177_6 + var_177_13 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_6) / var_177_13

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_6 + var_177_13 and arg_174_1.time_ < var_177_6 + var_177_13 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play121541043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 121541043
		arg_178_1.duration_ = 12.5

		local var_178_0 = {
			ja = 12.5,
			ko = 8.166,
			zh = 8.166
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play121541044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1072ui_story"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1072ui_story == nil then
				arg_178_1.var_.characterEffect1072ui_story = var_181_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.characterEffect1072ui_story and not isNil(var_181_0) then
					arg_178_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1072ui_story then
				arg_178_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_181_4 = 0

			if var_181_4 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_1")
			end

			local var_181_5 = 0

			if var_181_5 < arg_178_1.time_ and arg_178_1.time_ <= var_181_5 + arg_181_0 then
				arg_178_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_181_6 = 0
			local var_181_7 = 0.875

			if var_181_6 < arg_178_1.time_ and arg_178_1.time_ <= var_181_6 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_8 = arg_178_1:FormatText(StoryNameCfg[379].name)

				arg_178_1.leftNameTxt_.text = var_181_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_9 = arg_178_1:GetWordFromCfg(121541043)
				local var_181_10 = arg_178_1:FormatText(var_181_9.content)

				arg_178_1.text_.text = var_181_10

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_11 = 35
				local var_181_12 = utf8.len(var_181_10)
				local var_181_13 = var_181_11 <= 0 and var_181_7 or var_181_7 * (var_181_12 / var_181_11)

				if var_181_13 > 0 and var_181_7 < var_181_13 then
					arg_178_1.talkMaxDuration = var_181_13

					if var_181_13 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_13 + var_181_6
					end
				end

				arg_178_1.text_.text = var_181_10
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541043", "story_v_out_121541.awb") ~= 0 then
					local var_181_14 = manager.audio:GetVoiceLength("story_v_out_121541", "121541043", "story_v_out_121541.awb") / 1000

					if var_181_14 + var_181_6 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_14 + var_181_6
					end

					if var_181_9.prefab_name ~= "" and arg_178_1.actors_[var_181_9.prefab_name] ~= nil then
						local var_181_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_9.prefab_name].transform, "story_v_out_121541", "121541043", "story_v_out_121541.awb")

						arg_178_1:RecordAudio("121541043", var_181_15)
						arg_178_1:RecordAudio("121541043", var_181_15)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_121541", "121541043", "story_v_out_121541.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_121541", "121541043", "story_v_out_121541.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_16 = math.max(var_181_7, arg_178_1.talkMaxDuration)

			if var_181_6 <= arg_178_1.time_ and arg_178_1.time_ < var_181_6 + var_181_16 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_6) / var_181_16

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_6 + var_181_16 and arg_178_1.time_ < var_181_6 + var_181_16 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play121541044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 121541044
		arg_182_1.duration_ = 5.13

		local var_182_0 = {
			ja = 4.666,
			ko = 5.133,
			zh = 5.133
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play121541045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1076ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1076ui_story == nil then
				arg_182_1.var_.characterEffect1076ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1076ui_story and not isNil(var_185_0) then
					arg_182_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1076ui_story then
				arg_182_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_185_4 = 0

			if var_185_4 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_185_5 = 0

			if var_185_5 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 then
				arg_182_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_185_6 = arg_182_1.actors_["1072ui_story"]
			local var_185_7 = 0

			if var_185_7 < arg_182_1.time_ and arg_182_1.time_ <= var_185_7 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect1072ui_story == nil then
				arg_182_1.var_.characterEffect1072ui_story = var_185_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_8 = 0.200000002980232

			if var_185_7 <= arg_182_1.time_ and arg_182_1.time_ < var_185_7 + var_185_8 and not isNil(var_185_6) then
				local var_185_9 = (arg_182_1.time_ - var_185_7) / var_185_8

				if arg_182_1.var_.characterEffect1072ui_story and not isNil(var_185_6) then
					local var_185_10 = Mathf.Lerp(0, 0.5, var_185_9)

					arg_182_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1072ui_story.fillRatio = var_185_10
				end
			end

			if arg_182_1.time_ >= var_185_7 + var_185_8 and arg_182_1.time_ < var_185_7 + var_185_8 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect1072ui_story then
				local var_185_11 = 0.5

				arg_182_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1072ui_story.fillRatio = var_185_11
			end

			local var_185_12 = 0

			if var_185_12 < arg_182_1.time_ and arg_182_1.time_ <= var_185_12 + arg_185_0 then
				arg_182_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_2")
			end

			local var_185_13 = 0
			local var_185_14 = 0.475

			if var_185_13 < arg_182_1.time_ and arg_182_1.time_ <= var_185_13 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_15 = arg_182_1:FormatText(StoryNameCfg[389].name)

				arg_182_1.leftNameTxt_.text = var_185_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_16 = arg_182_1:GetWordFromCfg(121541044)
				local var_185_17 = arg_182_1:FormatText(var_185_16.content)

				arg_182_1.text_.text = var_185_17

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_18 = 19
				local var_185_19 = utf8.len(var_185_17)
				local var_185_20 = var_185_18 <= 0 and var_185_14 or var_185_14 * (var_185_19 / var_185_18)

				if var_185_20 > 0 and var_185_14 < var_185_20 then
					arg_182_1.talkMaxDuration = var_185_20

					if var_185_20 + var_185_13 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_20 + var_185_13
					end
				end

				arg_182_1.text_.text = var_185_17
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541044", "story_v_out_121541.awb") ~= 0 then
					local var_185_21 = manager.audio:GetVoiceLength("story_v_out_121541", "121541044", "story_v_out_121541.awb") / 1000

					if var_185_21 + var_185_13 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_21 + var_185_13
					end

					if var_185_16.prefab_name ~= "" and arg_182_1.actors_[var_185_16.prefab_name] ~= nil then
						local var_185_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_16.prefab_name].transform, "story_v_out_121541", "121541044", "story_v_out_121541.awb")

						arg_182_1:RecordAudio("121541044", var_185_22)
						arg_182_1:RecordAudio("121541044", var_185_22)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_121541", "121541044", "story_v_out_121541.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_121541", "121541044", "story_v_out_121541.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_23 = math.max(var_185_14, arg_182_1.talkMaxDuration)

			if var_185_13 <= arg_182_1.time_ and arg_182_1.time_ < var_185_13 + var_185_23 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_13) / var_185_23

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_13 + var_185_23 and arg_182_1.time_ < var_185_13 + var_185_23 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play121541045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 121541045
		arg_186_1.duration_ = 7.6

		local var_186_0 = {
			ja = 7.6,
			ko = 3.766,
			zh = 3.766
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play121541046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1072ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1072ui_story == nil then
				arg_186_1.var_.characterEffect1072ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect1072ui_story and not isNil(var_189_0) then
					arg_186_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1072ui_story then
				arg_186_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_189_4 = 0

			if var_189_4 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_189_5 = arg_186_1.actors_["1076ui_story"]
			local var_189_6 = 0

			if var_189_6 < arg_186_1.time_ and arg_186_1.time_ <= var_189_6 + arg_189_0 and not isNil(var_189_5) and arg_186_1.var_.characterEffect1076ui_story == nil then
				arg_186_1.var_.characterEffect1076ui_story = var_189_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_7 = 0.200000002980232

			if var_189_6 <= arg_186_1.time_ and arg_186_1.time_ < var_189_6 + var_189_7 and not isNil(var_189_5) then
				local var_189_8 = (arg_186_1.time_ - var_189_6) / var_189_7

				if arg_186_1.var_.characterEffect1076ui_story and not isNil(var_189_5) then
					local var_189_9 = Mathf.Lerp(0, 0.5, var_189_8)

					arg_186_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1076ui_story.fillRatio = var_189_9
				end
			end

			if arg_186_1.time_ >= var_189_6 + var_189_7 and arg_186_1.time_ < var_189_6 + var_189_7 + arg_189_0 and not isNil(var_189_5) and arg_186_1.var_.characterEffect1076ui_story then
				local var_189_10 = 0.5

				arg_186_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1076ui_story.fillRatio = var_189_10
			end

			local var_189_11 = 0
			local var_189_12 = 0.475

			if var_189_11 < arg_186_1.time_ and arg_186_1.time_ <= var_189_11 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_13 = arg_186_1:FormatText(StoryNameCfg[379].name)

				arg_186_1.leftNameTxt_.text = var_189_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_14 = arg_186_1:GetWordFromCfg(121541045)
				local var_189_15 = arg_186_1:FormatText(var_189_14.content)

				arg_186_1.text_.text = var_189_15

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_16 = 19
				local var_189_17 = utf8.len(var_189_15)
				local var_189_18 = var_189_16 <= 0 and var_189_12 or var_189_12 * (var_189_17 / var_189_16)

				if var_189_18 > 0 and var_189_12 < var_189_18 then
					arg_186_1.talkMaxDuration = var_189_18

					if var_189_18 + var_189_11 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_18 + var_189_11
					end
				end

				arg_186_1.text_.text = var_189_15
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541045", "story_v_out_121541.awb") ~= 0 then
					local var_189_19 = manager.audio:GetVoiceLength("story_v_out_121541", "121541045", "story_v_out_121541.awb") / 1000

					if var_189_19 + var_189_11 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_19 + var_189_11
					end

					if var_189_14.prefab_name ~= "" and arg_186_1.actors_[var_189_14.prefab_name] ~= nil then
						local var_189_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_14.prefab_name].transform, "story_v_out_121541", "121541045", "story_v_out_121541.awb")

						arg_186_1:RecordAudio("121541045", var_189_20)
						arg_186_1:RecordAudio("121541045", var_189_20)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_121541", "121541045", "story_v_out_121541.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_121541", "121541045", "story_v_out_121541.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_21 = math.max(var_189_12, arg_186_1.talkMaxDuration)

			if var_189_11 <= arg_186_1.time_ and arg_186_1.time_ < var_189_11 + var_189_21 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_11) / var_189_21

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_11 + var_189_21 and arg_186_1.time_ < var_189_11 + var_189_21 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play121541046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 121541046
		arg_190_1.duration_ = 8.23

		local var_190_0 = {
			ja = 8.233,
			ko = 4.3,
			zh = 4.3
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play121541047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1072ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1072ui_story == nil then
				arg_190_1.var_.characterEffect1072ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1072ui_story and not isNil(var_193_0) then
					arg_190_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1072ui_story then
				arg_190_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_193_4 = 0

			if var_193_4 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			local var_193_5 = 0

			if var_193_5 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 then
				arg_190_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_193_6 = 0
			local var_193_7 = 0.525

			if var_193_6 < arg_190_1.time_ and arg_190_1.time_ <= var_193_6 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_8 = arg_190_1:FormatText(StoryNameCfg[379].name)

				arg_190_1.leftNameTxt_.text = var_193_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_9 = arg_190_1:GetWordFromCfg(121541046)
				local var_193_10 = arg_190_1:FormatText(var_193_9.content)

				arg_190_1.text_.text = var_193_10

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_11 = 21
				local var_193_12 = utf8.len(var_193_10)
				local var_193_13 = var_193_11 <= 0 and var_193_7 or var_193_7 * (var_193_12 / var_193_11)

				if var_193_13 > 0 and var_193_7 < var_193_13 then
					arg_190_1.talkMaxDuration = var_193_13

					if var_193_13 + var_193_6 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_13 + var_193_6
					end
				end

				arg_190_1.text_.text = var_193_10
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541046", "story_v_out_121541.awb") ~= 0 then
					local var_193_14 = manager.audio:GetVoiceLength("story_v_out_121541", "121541046", "story_v_out_121541.awb") / 1000

					if var_193_14 + var_193_6 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_14 + var_193_6
					end

					if var_193_9.prefab_name ~= "" and arg_190_1.actors_[var_193_9.prefab_name] ~= nil then
						local var_193_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_9.prefab_name].transform, "story_v_out_121541", "121541046", "story_v_out_121541.awb")

						arg_190_1:RecordAudio("121541046", var_193_15)
						arg_190_1:RecordAudio("121541046", var_193_15)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_121541", "121541046", "story_v_out_121541.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_121541", "121541046", "story_v_out_121541.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_16 = math.max(var_193_7, arg_190_1.talkMaxDuration)

			if var_193_6 <= arg_190_1.time_ and arg_190_1.time_ < var_193_6 + var_193_16 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_6) / var_193_16

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_6 + var_193_16 and arg_190_1.time_ < var_193_6 + var_193_16 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play121541047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 121541047
		arg_194_1.duration_ = 4.93

		local var_194_0 = {
			ja = 4.933,
			ko = 1.5,
			zh = 1.5
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play121541048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0
			local var_197_1 = 0.15

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_2 = arg_194_1:FormatText(StoryNameCfg[379].name)

				arg_194_1.leftNameTxt_.text = var_197_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_3 = arg_194_1:GetWordFromCfg(121541047)
				local var_197_4 = arg_194_1:FormatText(var_197_3.content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 6
				local var_197_6 = utf8.len(var_197_4)
				local var_197_7 = var_197_5 <= 0 and var_197_1 or var_197_1 * (var_197_6 / var_197_5)

				if var_197_7 > 0 and var_197_1 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_0
					end
				end

				arg_194_1.text_.text = var_197_4
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541047", "story_v_out_121541.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_121541", "121541047", "story_v_out_121541.awb") / 1000

					if var_197_8 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_0
					end

					if var_197_3.prefab_name ~= "" and arg_194_1.actors_[var_197_3.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_3.prefab_name].transform, "story_v_out_121541", "121541047", "story_v_out_121541.awb")

						arg_194_1:RecordAudio("121541047", var_197_9)
						arg_194_1:RecordAudio("121541047", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_121541", "121541047", "story_v_out_121541.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_121541", "121541047", "story_v_out_121541.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_1, arg_194_1.talkMaxDuration)

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_0) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_0 + var_197_10 and arg_194_1.time_ < var_197_0 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play121541048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 121541048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play121541049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1072ui_story"].transform
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPos1072ui_story = var_201_0.localPosition
			end

			local var_201_2 = 0.001

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2
				local var_201_4 = Vector3.New(0, 100, 0)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1072ui_story, var_201_4, var_201_3)

				local var_201_5 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_5.x, var_201_5.y, var_201_5.z)

				local var_201_6 = var_201_0.localEulerAngles

				var_201_6.z = 0
				var_201_6.x = 0
				var_201_0.localEulerAngles = var_201_6
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(0, 100, 0)

				local var_201_7 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_7.x, var_201_7.y, var_201_7.z)

				local var_201_8 = var_201_0.localEulerAngles

				var_201_8.z = 0
				var_201_8.x = 0
				var_201_0.localEulerAngles = var_201_8
			end

			local var_201_9 = arg_198_1.actors_["1072ui_story"]
			local var_201_10 = 0

			if var_201_10 < arg_198_1.time_ and arg_198_1.time_ <= var_201_10 + arg_201_0 and not isNil(var_201_9) and arg_198_1.var_.characterEffect1072ui_story == nil then
				arg_198_1.var_.characterEffect1072ui_story = var_201_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_11 = 0.200000002980232

			if var_201_10 <= arg_198_1.time_ and arg_198_1.time_ < var_201_10 + var_201_11 and not isNil(var_201_9) then
				local var_201_12 = (arg_198_1.time_ - var_201_10) / var_201_11

				if arg_198_1.var_.characterEffect1072ui_story and not isNil(var_201_9) then
					local var_201_13 = Mathf.Lerp(0, 0.5, var_201_12)

					arg_198_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1072ui_story.fillRatio = var_201_13
				end
			end

			if arg_198_1.time_ >= var_201_10 + var_201_11 and arg_198_1.time_ < var_201_10 + var_201_11 + arg_201_0 and not isNil(var_201_9) and arg_198_1.var_.characterEffect1072ui_story then
				local var_201_14 = 0.5

				arg_198_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1072ui_story.fillRatio = var_201_14
			end

			local var_201_15 = arg_198_1.actors_["1076ui_story"].transform
			local var_201_16 = 0

			if var_201_16 < arg_198_1.time_ and arg_198_1.time_ <= var_201_16 + arg_201_0 then
				arg_198_1.var_.moveOldPos1076ui_story = var_201_15.localPosition
			end

			local var_201_17 = 0.001

			if var_201_16 <= arg_198_1.time_ and arg_198_1.time_ < var_201_16 + var_201_17 then
				local var_201_18 = (arg_198_1.time_ - var_201_16) / var_201_17
				local var_201_19 = Vector3.New(0, 100, 0)

				var_201_15.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1076ui_story, var_201_19, var_201_18)

				local var_201_20 = manager.ui.mainCamera.transform.position - var_201_15.position

				var_201_15.forward = Vector3.New(var_201_20.x, var_201_20.y, var_201_20.z)

				local var_201_21 = var_201_15.localEulerAngles

				var_201_21.z = 0
				var_201_21.x = 0
				var_201_15.localEulerAngles = var_201_21
			end

			if arg_198_1.time_ >= var_201_16 + var_201_17 and arg_198_1.time_ < var_201_16 + var_201_17 + arg_201_0 then
				var_201_15.localPosition = Vector3.New(0, 100, 0)

				local var_201_22 = manager.ui.mainCamera.transform.position - var_201_15.position

				var_201_15.forward = Vector3.New(var_201_22.x, var_201_22.y, var_201_22.z)

				local var_201_23 = var_201_15.localEulerAngles

				var_201_23.z = 0
				var_201_23.x = 0
				var_201_15.localEulerAngles = var_201_23
			end

			local var_201_24 = arg_198_1.actors_["1076ui_story"]
			local var_201_25 = 0

			if var_201_25 < arg_198_1.time_ and arg_198_1.time_ <= var_201_25 + arg_201_0 and not isNil(var_201_24) and arg_198_1.var_.characterEffect1076ui_story == nil then
				arg_198_1.var_.characterEffect1076ui_story = var_201_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_26 = 0.200000002980232

			if var_201_25 <= arg_198_1.time_ and arg_198_1.time_ < var_201_25 + var_201_26 and not isNil(var_201_24) then
				local var_201_27 = (arg_198_1.time_ - var_201_25) / var_201_26

				if arg_198_1.var_.characterEffect1076ui_story and not isNil(var_201_24) then
					local var_201_28 = Mathf.Lerp(0, 0.5, var_201_27)

					arg_198_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1076ui_story.fillRatio = var_201_28
				end
			end

			if arg_198_1.time_ >= var_201_25 + var_201_26 and arg_198_1.time_ < var_201_25 + var_201_26 + arg_201_0 and not isNil(var_201_24) and arg_198_1.var_.characterEffect1076ui_story then
				local var_201_29 = 0.5

				arg_198_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1076ui_story.fillRatio = var_201_29
			end

			local var_201_30 = 0
			local var_201_31 = 0.6

			if var_201_30 < arg_198_1.time_ and arg_198_1.time_ <= var_201_30 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_32 = arg_198_1:GetWordFromCfg(121541048)
				local var_201_33 = arg_198_1:FormatText(var_201_32.content)

				arg_198_1.text_.text = var_201_33

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_34 = 24
				local var_201_35 = utf8.len(var_201_33)
				local var_201_36 = var_201_34 <= 0 and var_201_31 or var_201_31 * (var_201_35 / var_201_34)

				if var_201_36 > 0 and var_201_31 < var_201_36 then
					arg_198_1.talkMaxDuration = var_201_36

					if var_201_36 + var_201_30 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_36 + var_201_30
					end
				end

				arg_198_1.text_.text = var_201_33
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_37 = math.max(var_201_31, arg_198_1.talkMaxDuration)

			if var_201_30 <= arg_198_1.time_ and arg_198_1.time_ < var_201_30 + var_201_37 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_30) / var_201_37

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_30 + var_201_37 and arg_198_1.time_ < var_201_30 + var_201_37 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play121541049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 121541049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play121541050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0
			local var_205_1 = 0.6

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_2 = arg_202_1:GetWordFromCfg(121541049)
				local var_205_3 = arg_202_1:FormatText(var_205_2.content)

				arg_202_1.text_.text = var_205_3

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 24
				local var_205_5 = utf8.len(var_205_3)
				local var_205_6 = var_205_4 <= 0 and var_205_1 or var_205_1 * (var_205_5 / var_205_4)

				if var_205_6 > 0 and var_205_1 < var_205_6 then
					arg_202_1.talkMaxDuration = var_205_6

					if var_205_6 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_6 + var_205_0
					end
				end

				arg_202_1.text_.text = var_205_3
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_1, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_7 and arg_202_1.time_ < var_205_0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play121541050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 121541050
		arg_206_1.duration_ = 9.6

		local var_206_0 = {
			ja = 9.6,
			ko = 4.766,
			zh = 4.766
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play121541051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1072ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos1072ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(0, -0.71, -6)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1072ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = arg_206_1.actors_["1072ui_story"]
			local var_209_10 = 0

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect1072ui_story == nil then
				arg_206_1.var_.characterEffect1072ui_story = var_209_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_11 = 0.200000002980232

			if var_209_10 <= arg_206_1.time_ and arg_206_1.time_ < var_209_10 + var_209_11 and not isNil(var_209_9) then
				local var_209_12 = (arg_206_1.time_ - var_209_10) / var_209_11

				if arg_206_1.var_.characterEffect1072ui_story and not isNil(var_209_9) then
					arg_206_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_10 + var_209_11 and arg_206_1.time_ < var_209_10 + var_209_11 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect1072ui_story then
				arg_206_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_209_13 = 0

			if var_209_13 < arg_206_1.time_ and arg_206_1.time_ <= var_209_13 + arg_209_0 then
				arg_206_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_209_14 = 0

			if var_209_14 < arg_206_1.time_ and arg_206_1.time_ <= var_209_14 + arg_209_0 then
				arg_206_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_209_15 = 0
			local var_209_16 = 0.475

			if var_209_15 < arg_206_1.time_ and arg_206_1.time_ <= var_209_15 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_17 = arg_206_1:FormatText(StoryNameCfg[379].name)

				arg_206_1.leftNameTxt_.text = var_209_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_18 = arg_206_1:GetWordFromCfg(121541050)
				local var_209_19 = arg_206_1:FormatText(var_209_18.content)

				arg_206_1.text_.text = var_209_19

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_20 = 19
				local var_209_21 = utf8.len(var_209_19)
				local var_209_22 = var_209_20 <= 0 and var_209_16 or var_209_16 * (var_209_21 / var_209_20)

				if var_209_22 > 0 and var_209_16 < var_209_22 then
					arg_206_1.talkMaxDuration = var_209_22

					if var_209_22 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_22 + var_209_15
					end
				end

				arg_206_1.text_.text = var_209_19
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541050", "story_v_out_121541.awb") ~= 0 then
					local var_209_23 = manager.audio:GetVoiceLength("story_v_out_121541", "121541050", "story_v_out_121541.awb") / 1000

					if var_209_23 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_23 + var_209_15
					end

					if var_209_18.prefab_name ~= "" and arg_206_1.actors_[var_209_18.prefab_name] ~= nil then
						local var_209_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_18.prefab_name].transform, "story_v_out_121541", "121541050", "story_v_out_121541.awb")

						arg_206_1:RecordAudio("121541050", var_209_24)
						arg_206_1:RecordAudio("121541050", var_209_24)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_121541", "121541050", "story_v_out_121541.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_121541", "121541050", "story_v_out_121541.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_16, arg_206_1.talkMaxDuration)

			if var_209_15 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_25 and arg_206_1.time_ < var_209_15 + var_209_25 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play121541051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 121541051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play121541052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1072ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1072ui_story == nil then
				arg_210_1.var_.characterEffect1072ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect1072ui_story and not isNil(var_213_0) then
					local var_213_4 = Mathf.Lerp(0, 0.5, var_213_3)

					arg_210_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1072ui_story.fillRatio = var_213_4
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1072ui_story then
				local var_213_5 = 0.5

				arg_210_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1072ui_story.fillRatio = var_213_5
			end

			local var_213_6 = 0
			local var_213_7 = 1.225

			if var_213_6 < arg_210_1.time_ and arg_210_1.time_ <= var_213_6 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_8 = arg_210_1:GetWordFromCfg(121541051)
				local var_213_9 = arg_210_1:FormatText(var_213_8.content)

				arg_210_1.text_.text = var_213_9

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_10 = 49
				local var_213_11 = utf8.len(var_213_9)
				local var_213_12 = var_213_10 <= 0 and var_213_7 or var_213_7 * (var_213_11 / var_213_10)

				if var_213_12 > 0 and var_213_7 < var_213_12 then
					arg_210_1.talkMaxDuration = var_213_12

					if var_213_12 + var_213_6 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_12 + var_213_6
					end
				end

				arg_210_1.text_.text = var_213_9
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_13 = math.max(var_213_7, arg_210_1.talkMaxDuration)

			if var_213_6 <= arg_210_1.time_ and arg_210_1.time_ < var_213_6 + var_213_13 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_6) / var_213_13

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_6 + var_213_13 and arg_210_1.time_ < var_213_6 + var_213_13 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play121541052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 121541052
		arg_214_1.duration_ = 7.37

		local var_214_0 = {
			ja = 7.366,
			ko = 6.733,
			zh = 6.733
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play121541053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1072ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1072ui_story == nil then
				arg_214_1.var_.characterEffect1072ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect1072ui_story and not isNil(var_217_0) then
					arg_214_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1072ui_story then
				arg_214_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_217_4 = 0

			if var_217_4 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			local var_217_5 = 0

			if var_217_5 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 then
				arg_214_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_217_6 = 0
			local var_217_7 = 0.725

			if var_217_6 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_8 = arg_214_1:FormatText(StoryNameCfg[379].name)

				arg_214_1.leftNameTxt_.text = var_217_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_9 = arg_214_1:GetWordFromCfg(121541052)
				local var_217_10 = arg_214_1:FormatText(var_217_9.content)

				arg_214_1.text_.text = var_217_10

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 29
				local var_217_12 = utf8.len(var_217_10)
				local var_217_13 = var_217_11 <= 0 and var_217_7 or var_217_7 * (var_217_12 / var_217_11)

				if var_217_13 > 0 and var_217_7 < var_217_13 then
					arg_214_1.talkMaxDuration = var_217_13

					if var_217_13 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_13 + var_217_6
					end
				end

				arg_214_1.text_.text = var_217_10
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541052", "story_v_out_121541.awb") ~= 0 then
					local var_217_14 = manager.audio:GetVoiceLength("story_v_out_121541", "121541052", "story_v_out_121541.awb") / 1000

					if var_217_14 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_14 + var_217_6
					end

					if var_217_9.prefab_name ~= "" and arg_214_1.actors_[var_217_9.prefab_name] ~= nil then
						local var_217_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_9.prefab_name].transform, "story_v_out_121541", "121541052", "story_v_out_121541.awb")

						arg_214_1:RecordAudio("121541052", var_217_15)
						arg_214_1:RecordAudio("121541052", var_217_15)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_121541", "121541052", "story_v_out_121541.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_121541", "121541052", "story_v_out_121541.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_16 = math.max(var_217_7, arg_214_1.talkMaxDuration)

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_16 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_6) / var_217_16

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_6 + var_217_16 and arg_214_1.time_ < var_217_6 + var_217_16 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play121541053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 121541053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play121541054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1072ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos1072ui_story = var_221_0.localPosition
			end

			local var_221_2 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2
				local var_221_4 = Vector3.New(0, 100, 0)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1072ui_story, var_221_4, var_221_3)

				local var_221_5 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_5.x, var_221_5.y, var_221_5.z)

				local var_221_6 = var_221_0.localEulerAngles

				var_221_6.z = 0
				var_221_6.x = 0
				var_221_0.localEulerAngles = var_221_6
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(0, 100, 0)

				local var_221_7 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_7.x, var_221_7.y, var_221_7.z)

				local var_221_8 = var_221_0.localEulerAngles

				var_221_8.z = 0
				var_221_8.x = 0
				var_221_0.localEulerAngles = var_221_8
			end

			local var_221_9 = arg_218_1.actors_["1072ui_story"]
			local var_221_10 = 0

			if var_221_10 < arg_218_1.time_ and arg_218_1.time_ <= var_221_10 + arg_221_0 and not isNil(var_221_9) and arg_218_1.var_.characterEffect1072ui_story == nil then
				arg_218_1.var_.characterEffect1072ui_story = var_221_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_11 = 0.200000002980232

			if var_221_10 <= arg_218_1.time_ and arg_218_1.time_ < var_221_10 + var_221_11 and not isNil(var_221_9) then
				local var_221_12 = (arg_218_1.time_ - var_221_10) / var_221_11

				if arg_218_1.var_.characterEffect1072ui_story and not isNil(var_221_9) then
					local var_221_13 = Mathf.Lerp(0, 0.5, var_221_12)

					arg_218_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1072ui_story.fillRatio = var_221_13
				end
			end

			if arg_218_1.time_ >= var_221_10 + var_221_11 and arg_218_1.time_ < var_221_10 + var_221_11 + arg_221_0 and not isNil(var_221_9) and arg_218_1.var_.characterEffect1072ui_story then
				local var_221_14 = 0.5

				arg_218_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1072ui_story.fillRatio = var_221_14
			end

			local var_221_15 = 0
			local var_221_16 = 1.15

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_17 = arg_218_1:GetWordFromCfg(121541053)
				local var_221_18 = arg_218_1:FormatText(var_221_17.content)

				arg_218_1.text_.text = var_221_18

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_19 = 46
				local var_221_20 = utf8.len(var_221_18)
				local var_221_21 = var_221_19 <= 0 and var_221_16 or var_221_16 * (var_221_20 / var_221_19)

				if var_221_21 > 0 and var_221_16 < var_221_21 then
					arg_218_1.talkMaxDuration = var_221_21

					if var_221_21 + var_221_15 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_21 + var_221_15
					end
				end

				arg_218_1.text_.text = var_221_18
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_22 = math.max(var_221_16, arg_218_1.talkMaxDuration)

			if var_221_15 <= arg_218_1.time_ and arg_218_1.time_ < var_221_15 + var_221_22 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_15) / var_221_22

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_15 + var_221_22 and arg_218_1.time_ < var_221_15 + var_221_22 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play121541054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 121541054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play121541055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 1.325

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_2 = arg_222_1:GetWordFromCfg(121541054)
				local var_225_3 = arg_222_1:FormatText(var_225_2.content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 53
				local var_225_5 = utf8.len(var_225_3)
				local var_225_6 = var_225_4 <= 0 and var_225_1 or var_225_1 * (var_225_5 / var_225_4)

				if var_225_6 > 0 and var_225_1 < var_225_6 then
					arg_222_1.talkMaxDuration = var_225_6

					if var_225_6 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_6 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_3
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_7 and arg_222_1.time_ < var_225_0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play121541055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 121541055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play121541056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 0.375

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_2 = arg_226_1:GetWordFromCfg(121541055)
				local var_229_3 = arg_226_1:FormatText(var_229_2.content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_4 = 15
				local var_229_5 = utf8.len(var_229_3)
				local var_229_6 = var_229_4 <= 0 and var_229_1 or var_229_1 * (var_229_5 / var_229_4)

				if var_229_6 > 0 and var_229_1 < var_229_6 then
					arg_226_1.talkMaxDuration = var_229_6

					if var_229_6 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_6 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_7 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_7 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_7

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_7 and arg_226_1.time_ < var_229_0 + var_229_7 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play121541056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 121541056
		arg_230_1.duration_ = 2

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play121541057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1072ui_story"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos1072ui_story = var_233_0.localPosition
			end

			local var_233_2 = 0.001

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2
				local var_233_4 = Vector3.New(0, -0.71, -6)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1072ui_story, var_233_4, var_233_3)

				local var_233_5 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_5.x, var_233_5.y, var_233_5.z)

				local var_233_6 = var_233_0.localEulerAngles

				var_233_6.z = 0
				var_233_6.x = 0
				var_233_0.localEulerAngles = var_233_6
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 then
				var_233_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_233_7 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_7.x, var_233_7.y, var_233_7.z)

				local var_233_8 = var_233_0.localEulerAngles

				var_233_8.z = 0
				var_233_8.x = 0
				var_233_0.localEulerAngles = var_233_8
			end

			local var_233_9 = arg_230_1.actors_["1072ui_story"]
			local var_233_10 = 0

			if var_233_10 < arg_230_1.time_ and arg_230_1.time_ <= var_233_10 + arg_233_0 and not isNil(var_233_9) and arg_230_1.var_.characterEffect1072ui_story == nil then
				arg_230_1.var_.characterEffect1072ui_story = var_233_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_11 = 0.200000002980232

			if var_233_10 <= arg_230_1.time_ and arg_230_1.time_ < var_233_10 + var_233_11 and not isNil(var_233_9) then
				local var_233_12 = (arg_230_1.time_ - var_233_10) / var_233_11

				if arg_230_1.var_.characterEffect1072ui_story and not isNil(var_233_9) then
					arg_230_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_10 + var_233_11 and arg_230_1.time_ < var_233_10 + var_233_11 + arg_233_0 and not isNil(var_233_9) and arg_230_1.var_.characterEffect1072ui_story then
				arg_230_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_233_13 = 0

			if var_233_13 < arg_230_1.time_ and arg_230_1.time_ <= var_233_13 + arg_233_0 then
				arg_230_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_233_14 = 0

			if var_233_14 < arg_230_1.time_ and arg_230_1.time_ <= var_233_14 + arg_233_0 then
				arg_230_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_233_15 = 0
			local var_233_16 = 0.125

			if var_233_15 < arg_230_1.time_ and arg_230_1.time_ <= var_233_15 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_17 = arg_230_1:FormatText(StoryNameCfg[379].name)

				arg_230_1.leftNameTxt_.text = var_233_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_18 = arg_230_1:GetWordFromCfg(121541056)
				local var_233_19 = arg_230_1:FormatText(var_233_18.content)

				arg_230_1.text_.text = var_233_19

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_20 = 5
				local var_233_21 = utf8.len(var_233_19)
				local var_233_22 = var_233_20 <= 0 and var_233_16 or var_233_16 * (var_233_21 / var_233_20)

				if var_233_22 > 0 and var_233_16 < var_233_22 then
					arg_230_1.talkMaxDuration = var_233_22

					if var_233_22 + var_233_15 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_22 + var_233_15
					end
				end

				arg_230_1.text_.text = var_233_19
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541056", "story_v_out_121541.awb") ~= 0 then
					local var_233_23 = manager.audio:GetVoiceLength("story_v_out_121541", "121541056", "story_v_out_121541.awb") / 1000

					if var_233_23 + var_233_15 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_23 + var_233_15
					end

					if var_233_18.prefab_name ~= "" and arg_230_1.actors_[var_233_18.prefab_name] ~= nil then
						local var_233_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_18.prefab_name].transform, "story_v_out_121541", "121541056", "story_v_out_121541.awb")

						arg_230_1:RecordAudio("121541056", var_233_24)
						arg_230_1:RecordAudio("121541056", var_233_24)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_121541", "121541056", "story_v_out_121541.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_121541", "121541056", "story_v_out_121541.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_25 = math.max(var_233_16, arg_230_1.talkMaxDuration)

			if var_233_15 <= arg_230_1.time_ and arg_230_1.time_ < var_233_15 + var_233_25 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_15) / var_233_25

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_15 + var_233_25 and arg_230_1.time_ < var_233_15 + var_233_25 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play121541057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 121541057
		arg_234_1.duration_ = 9

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play121541058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = "XH0308"

			if arg_234_1.bgs_[var_237_0] == nil then
				local var_237_1 = Object.Instantiate(arg_234_1.paintGo_)

				var_237_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_237_0)
				var_237_1.name = var_237_0
				var_237_1.transform.parent = arg_234_1.stage_.transform
				var_237_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_234_1.bgs_[var_237_0] = var_237_1
			end

			local var_237_2 = 1.999999999999

			if var_237_2 < arg_234_1.time_ and arg_234_1.time_ <= var_237_2 + arg_237_0 then
				local var_237_3 = manager.ui.mainCamera.transform.localPosition
				local var_237_4 = Vector3.New(0, 0, 10) + Vector3.New(var_237_3.x, var_237_3.y, 0)
				local var_237_5 = arg_234_1.bgs_.XH0308

				var_237_5.transform.localPosition = var_237_4
				var_237_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_237_6 = var_237_5:GetComponent("SpriteRenderer")

				if var_237_6 and var_237_6.sprite then
					local var_237_7 = (var_237_5.transform.localPosition - var_237_3).z
					local var_237_8 = manager.ui.mainCameraCom_
					local var_237_9 = 2 * var_237_7 * Mathf.Tan(var_237_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_237_10 = var_237_9 * var_237_8.aspect
					local var_237_11 = var_237_6.sprite.bounds.size.x
					local var_237_12 = var_237_6.sprite.bounds.size.y
					local var_237_13 = var_237_10 / var_237_11
					local var_237_14 = var_237_9 / var_237_12
					local var_237_15 = var_237_14 < var_237_13 and var_237_13 or var_237_14

					var_237_5.transform.localScale = Vector3.New(var_237_15, var_237_15, 0)
				end

				for iter_237_0, iter_237_1 in pairs(arg_234_1.bgs_) do
					if iter_237_0 ~= "XH0308" then
						iter_237_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_237_16 = 0

			if var_237_16 < arg_234_1.time_ and arg_234_1.time_ <= var_237_16 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_17 = 2

			if var_237_16 <= arg_234_1.time_ and arg_234_1.time_ < var_237_16 + var_237_17 then
				local var_237_18 = (arg_234_1.time_ - var_237_16) / var_237_17
				local var_237_19 = Color.New(0, 0, 0)

				var_237_19.a = Mathf.Lerp(0, 1, var_237_18)
				arg_234_1.mask_.color = var_237_19
			end

			if arg_234_1.time_ >= var_237_16 + var_237_17 and arg_234_1.time_ < var_237_16 + var_237_17 + arg_237_0 then
				local var_237_20 = Color.New(0, 0, 0)

				var_237_20.a = 1
				arg_234_1.mask_.color = var_237_20
			end

			local var_237_21 = 2

			if var_237_21 < arg_234_1.time_ and arg_234_1.time_ <= var_237_21 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_22 = 2

			if var_237_21 <= arg_234_1.time_ and arg_234_1.time_ < var_237_21 + var_237_22 then
				local var_237_23 = (arg_234_1.time_ - var_237_21) / var_237_22
				local var_237_24 = Color.New(0, 0, 0)

				var_237_24.a = Mathf.Lerp(1, 0, var_237_23)
				arg_234_1.mask_.color = var_237_24
			end

			if arg_234_1.time_ >= var_237_21 + var_237_22 and arg_234_1.time_ < var_237_21 + var_237_22 + arg_237_0 then
				local var_237_25 = Color.New(0, 0, 0)
				local var_237_26 = 0

				arg_234_1.mask_.enabled = false
				var_237_25.a = var_237_26
				arg_234_1.mask_.color = var_237_25
			end

			local var_237_27 = arg_234_1.actors_["1072ui_story"].transform
			local var_237_28 = 1.96599999815226

			if var_237_28 < arg_234_1.time_ and arg_234_1.time_ <= var_237_28 + arg_237_0 then
				arg_234_1.var_.moveOldPos1072ui_story = var_237_27.localPosition
			end

			local var_237_29 = 0.001

			if var_237_28 <= arg_234_1.time_ and arg_234_1.time_ < var_237_28 + var_237_29 then
				local var_237_30 = (arg_234_1.time_ - var_237_28) / var_237_29
				local var_237_31 = Vector3.New(0, 100, 0)

				var_237_27.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1072ui_story, var_237_31, var_237_30)

				local var_237_32 = manager.ui.mainCamera.transform.position - var_237_27.position

				var_237_27.forward = Vector3.New(var_237_32.x, var_237_32.y, var_237_32.z)

				local var_237_33 = var_237_27.localEulerAngles

				var_237_33.z = 0
				var_237_33.x = 0
				var_237_27.localEulerAngles = var_237_33
			end

			if arg_234_1.time_ >= var_237_28 + var_237_29 and arg_234_1.time_ < var_237_28 + var_237_29 + arg_237_0 then
				var_237_27.localPosition = Vector3.New(0, 100, 0)

				local var_237_34 = manager.ui.mainCamera.transform.position - var_237_27.position

				var_237_27.forward = Vector3.New(var_237_34.x, var_237_34.y, var_237_34.z)

				local var_237_35 = var_237_27.localEulerAngles

				var_237_35.z = 0
				var_237_35.x = 0
				var_237_27.localEulerAngles = var_237_35
			end

			local var_237_36 = arg_234_1.actors_["1072ui_story"]
			local var_237_37 = 1.96599999815226

			if var_237_37 < arg_234_1.time_ and arg_234_1.time_ <= var_237_37 + arg_237_0 and not isNil(var_237_36) and arg_234_1.var_.characterEffect1072ui_story == nil then
				arg_234_1.var_.characterEffect1072ui_story = var_237_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_38 = 0.034000001847744

			if var_237_37 <= arg_234_1.time_ and arg_234_1.time_ < var_237_37 + var_237_38 and not isNil(var_237_36) then
				local var_237_39 = (arg_234_1.time_ - var_237_37) / var_237_38

				if arg_234_1.var_.characterEffect1072ui_story and not isNil(var_237_36) then
					local var_237_40 = Mathf.Lerp(0, 0.5, var_237_39)

					arg_234_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1072ui_story.fillRatio = var_237_40
				end
			end

			if arg_234_1.time_ >= var_237_37 + var_237_38 and arg_234_1.time_ < var_237_37 + var_237_38 + arg_237_0 and not isNil(var_237_36) and arg_234_1.var_.characterEffect1072ui_story then
				local var_237_41 = 0.5

				arg_234_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1072ui_story.fillRatio = var_237_41
			end

			local var_237_42 = arg_234_1.bgs_.XH0308.transform
			local var_237_43 = 1.999999999999

			if var_237_43 < arg_234_1.time_ and arg_234_1.time_ <= var_237_43 + arg_237_0 then
				arg_234_1.var_.moveOldPosXH0308 = var_237_42.localPosition
			end

			local var_237_44 = 0.001

			if var_237_43 <= arg_234_1.time_ and arg_234_1.time_ < var_237_43 + var_237_44 then
				local var_237_45 = (arg_234_1.time_ - var_237_43) / var_237_44
				local var_237_46 = Vector3.New(2, 2.86, -5)

				var_237_42.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPosXH0308, var_237_46, var_237_45)
			end

			if arg_234_1.time_ >= var_237_43 + var_237_44 and arg_234_1.time_ < var_237_43 + var_237_44 + arg_237_0 then
				var_237_42.localPosition = Vector3.New(2, 2.86, -5)
			end

			local var_237_47 = arg_234_1.bgs_.XH0308.transform
			local var_237_48 = 2.01666666666667

			if var_237_48 < arg_234_1.time_ and arg_234_1.time_ <= var_237_48 + arg_237_0 then
				arg_234_1.var_.moveOldPosXH0308 = var_237_47.localPosition
			end

			local var_237_49 = 5

			if var_237_48 <= arg_234_1.time_ and arg_234_1.time_ < var_237_48 + var_237_49 then
				local var_237_50 = (arg_234_1.time_ - var_237_48) / var_237_49
				local var_237_51 = Vector3.New(2, 3.36, -3)

				var_237_47.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPosXH0308, var_237_51, var_237_50)
			end

			if arg_234_1.time_ >= var_237_48 + var_237_49 and arg_234_1.time_ < var_237_48 + var_237_49 + arg_237_0 then
				var_237_47.localPosition = Vector3.New(2, 3.36, -3)
			end

			local var_237_52 = 3.999999999999

			if var_237_52 < arg_234_1.time_ and arg_234_1.time_ <= var_237_52 + arg_237_0 then
				arg_234_1.allBtn_.enabled = false
			end

			local var_237_53 = 1.01666666666767

			if arg_234_1.time_ >= var_237_52 + var_237_53 and arg_234_1.time_ < var_237_52 + var_237_53 + arg_237_0 then
				arg_234_1.allBtn_.enabled = true
			end

			if arg_234_1.frameCnt_ <= 1 then
				arg_234_1.dialog_:SetActive(false)
			end

			local var_237_54 = 3.999999999999
			local var_237_55 = 1.15

			if var_237_54 < arg_234_1.time_ and arg_234_1.time_ <= var_237_54 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0

				arg_234_1.dialog_:SetActive(true)

				arg_234_1.dialogCg_.alpha = 0

				local var_237_56 = LeanTween.value(arg_234_1.dialog_, 0, 1, 0.3)

				var_237_56:setOnUpdate(LuaHelper.FloatAction(function(arg_238_0)
					arg_234_1.dialogCg_.alpha = arg_238_0
				end))
				var_237_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_234_1.dialog_)
					var_237_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_234_1.duration_ = arg_234_1.duration_ + 0.3

				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_57 = arg_234_1:GetWordFromCfg(121541057)
				local var_237_58 = arg_234_1:FormatText(var_237_57.content)

				arg_234_1.text_.text = var_237_58

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_59 = 46
				local var_237_60 = utf8.len(var_237_58)
				local var_237_61 = var_237_59 <= 0 and var_237_55 or var_237_55 * (var_237_60 / var_237_59)

				if var_237_61 > 0 and var_237_55 < var_237_61 then
					arg_234_1.talkMaxDuration = var_237_61
					var_237_54 = var_237_54 + 0.3

					if var_237_61 + var_237_54 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_61 + var_237_54
					end
				end

				arg_234_1.text_.text = var_237_58
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_62 = var_237_54 + 0.3
			local var_237_63 = math.max(var_237_55, arg_234_1.talkMaxDuration)

			if var_237_62 <= arg_234_1.time_ and arg_234_1.time_ < var_237_62 + var_237_63 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_62) / var_237_63

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_62 + var_237_63 and arg_234_1.time_ < var_237_62 + var_237_63 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "XH0308",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0308",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play121541058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 121541058
		arg_240_1.duration_ = 9.7

		local var_240_0 = {
			ja = 5.366,
			ko = 9.7,
			zh = 9.7
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play121541059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.bgs_.XH0308.transform
			local var_243_1 = 1.5

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.var_.moveOldPosXH0308 = var_243_0.localPosition
			end

			local var_243_2 = 0.001

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2
				local var_243_4 = Vector3.New(0, 1, 9.5)

				var_243_0.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPosXH0308, var_243_4, var_243_3)
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 then
				var_243_0.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_243_5 = arg_240_1.bgs_.XH0308.transform
			local var_243_6 = 1.51666666666667

			if var_243_6 < arg_240_1.time_ and arg_240_1.time_ <= var_243_6 + arg_243_0 then
				arg_240_1.var_.moveOldPosXH0308 = var_243_5.localPosition
			end

			local var_243_7 = 3

			if var_243_6 <= arg_240_1.time_ and arg_240_1.time_ < var_243_6 + var_243_7 then
				local var_243_8 = (arg_240_1.time_ - var_243_6) / var_243_7
				local var_243_9 = Vector3.New(0, 1, 10)

				var_243_5.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPosXH0308, var_243_9, var_243_8)
			end

			if arg_240_1.time_ >= var_243_6 + var_243_7 and arg_240_1.time_ < var_243_6 + var_243_7 + arg_243_0 then
				var_243_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_243_10 = 0

			if var_243_10 < arg_240_1.time_ and arg_240_1.time_ <= var_243_10 + arg_243_0 then
				arg_240_1.mask_.enabled = true
				arg_240_1.mask_.raycastTarget = true

				arg_240_1:SetGaussion(false)
			end

			local var_243_11 = 1.5

			if var_243_10 <= arg_240_1.time_ and arg_240_1.time_ < var_243_10 + var_243_11 then
				local var_243_12 = (arg_240_1.time_ - var_243_10) / var_243_11
				local var_243_13 = Color.New(0, 0, 0)

				var_243_13.a = Mathf.Lerp(0, 1, var_243_12)
				arg_240_1.mask_.color = var_243_13
			end

			if arg_240_1.time_ >= var_243_10 + var_243_11 and arg_240_1.time_ < var_243_10 + var_243_11 + arg_243_0 then
				local var_243_14 = Color.New(0, 0, 0)

				var_243_14.a = 1
				arg_240_1.mask_.color = var_243_14
			end

			local var_243_15 = 1.5

			if var_243_15 < arg_240_1.time_ and arg_240_1.time_ <= var_243_15 + arg_243_0 then
				arg_240_1.mask_.enabled = true
				arg_240_1.mask_.raycastTarget = true

				arg_240_1:SetGaussion(false)
			end

			local var_243_16 = 1.5

			if var_243_15 <= arg_240_1.time_ and arg_240_1.time_ < var_243_15 + var_243_16 then
				local var_243_17 = (arg_240_1.time_ - var_243_15) / var_243_16
				local var_243_18 = Color.New(0, 0, 0)

				var_243_18.a = Mathf.Lerp(1, 0, var_243_17)
				arg_240_1.mask_.color = var_243_18
			end

			if arg_240_1.time_ >= var_243_15 + var_243_16 and arg_240_1.time_ < var_243_15 + var_243_16 + arg_243_0 then
				local var_243_19 = Color.New(0, 0, 0)
				local var_243_20 = 0

				arg_240_1.mask_.enabled = false
				var_243_19.a = var_243_20
				arg_240_1.mask_.color = var_243_19
			end

			local var_243_21 = 3

			if var_243_21 < arg_240_1.time_ and arg_240_1.time_ <= var_243_21 + arg_243_0 then
				arg_240_1.allBtn_.enabled = false
			end

			local var_243_22 = 1.51666666666667

			if arg_240_1.time_ >= var_243_21 + var_243_22 and arg_240_1.time_ < var_243_21 + var_243_22 + arg_243_0 then
				arg_240_1.allBtn_.enabled = true
			end

			if arg_240_1.frameCnt_ <= 1 then
				arg_240_1.dialog_:SetActive(false)
			end

			local var_243_23 = 3
			local var_243_24 = 0.35

			if var_243_23 < arg_240_1.time_ and arg_240_1.time_ <= var_243_23 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0

				arg_240_1.dialog_:SetActive(true)

				arg_240_1.dialogCg_.alpha = 0

				local var_243_25 = LeanTween.value(arg_240_1.dialog_, 0, 1, 0.3)

				var_243_25:setOnUpdate(LuaHelper.FloatAction(function(arg_244_0)
					arg_240_1.dialogCg_.alpha = arg_244_0
				end))
				var_243_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_240_1.dialog_)
					var_243_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_240_1.duration_ = arg_240_1.duration_ + 0.3

				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_26 = arg_240_1:FormatText(StoryNameCfg[379].name)

				arg_240_1.leftNameTxt_.text = var_243_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_27 = arg_240_1:GetWordFromCfg(121541058)
				local var_243_28 = arg_240_1:FormatText(var_243_27.content)

				arg_240_1.text_.text = var_243_28

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_29 = 14
				local var_243_30 = utf8.len(var_243_28)
				local var_243_31 = var_243_29 <= 0 and var_243_24 or var_243_24 * (var_243_30 / var_243_29)

				if var_243_31 > 0 and var_243_24 < var_243_31 then
					arg_240_1.talkMaxDuration = var_243_31
					var_243_23 = var_243_23 + 0.3

					if var_243_31 + var_243_23 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_31 + var_243_23
					end
				end

				arg_240_1.text_.text = var_243_28
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541058", "story_v_out_121541.awb") ~= 0 then
					local var_243_32 = manager.audio:GetVoiceLength("story_v_out_121541", "121541058", "story_v_out_121541.awb") / 1000

					if var_243_32 + var_243_23 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_32 + var_243_23
					end

					if var_243_27.prefab_name ~= "" and arg_240_1.actors_[var_243_27.prefab_name] ~= nil then
						local var_243_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_27.prefab_name].transform, "story_v_out_121541", "121541058", "story_v_out_121541.awb")

						arg_240_1:RecordAudio("121541058", var_243_33)
						arg_240_1:RecordAudio("121541058", var_243_33)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_121541", "121541058", "story_v_out_121541.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_121541", "121541058", "story_v_out_121541.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_34 = var_243_23 + 0.3
			local var_243_35 = math.max(var_243_24, arg_240_1.talkMaxDuration)

			if var_243_34 <= arg_240_1.time_ and arg_240_1.time_ < var_243_34 + var_243_35 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_34) / var_243_35

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_34 + var_243_35 and arg_240_1.time_ < var_243_34 + var_243_35 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0308",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0308",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 1.51666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play121541059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 121541059
		arg_246_1.duration_ = 4.4

		local var_246_0 = {
			ja = 4.4,
			ko = 4,
			zh = 4
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play121541060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 0.45

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_2 = arg_246_1:FormatText(StoryNameCfg[379].name)

				arg_246_1.leftNameTxt_.text = var_249_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_3 = arg_246_1:GetWordFromCfg(121541059)
				local var_249_4 = arg_246_1:FormatText(var_249_3.content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 17
				local var_249_6 = utf8.len(var_249_4)
				local var_249_7 = var_249_5 <= 0 and var_249_1 or var_249_1 * (var_249_6 / var_249_5)

				if var_249_7 > 0 and var_249_1 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541059", "story_v_out_121541.awb") ~= 0 then
					local var_249_8 = manager.audio:GetVoiceLength("story_v_out_121541", "121541059", "story_v_out_121541.awb") / 1000

					if var_249_8 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_8 + var_249_0
					end

					if var_249_3.prefab_name ~= "" and arg_246_1.actors_[var_249_3.prefab_name] ~= nil then
						local var_249_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_3.prefab_name].transform, "story_v_out_121541", "121541059", "story_v_out_121541.awb")

						arg_246_1:RecordAudio("121541059", var_249_9)
						arg_246_1:RecordAudio("121541059", var_249_9)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_121541", "121541059", "story_v_out_121541.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_121541", "121541059", "story_v_out_121541.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_10 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_10 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_10

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_10 and arg_246_1.time_ < var_249_0 + var_249_10 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play121541060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 121541060
		arg_250_1.duration_ = 5.8

		local var_250_0 = {
			ja = 5.8,
			ko = 4.866,
			zh = 4.866
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play121541061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.525

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_2 = arg_250_1:FormatText(StoryNameCfg[379].name)

				arg_250_1.leftNameTxt_.text = var_253_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_3 = arg_250_1:GetWordFromCfg(121541060)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 21
				local var_253_6 = utf8.len(var_253_4)
				local var_253_7 = var_253_5 <= 0 and var_253_1 or var_253_1 * (var_253_6 / var_253_5)

				if var_253_7 > 0 and var_253_1 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541060", "story_v_out_121541.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_out_121541", "121541060", "story_v_out_121541.awb") / 1000

					if var_253_8 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_0
					end

					if var_253_3.prefab_name ~= "" and arg_250_1.actors_[var_253_3.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_3.prefab_name].transform, "story_v_out_121541", "121541060", "story_v_out_121541.awb")

						arg_250_1:RecordAudio("121541060", var_253_9)
						arg_250_1:RecordAudio("121541060", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_121541", "121541060", "story_v_out_121541.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_121541", "121541060", "story_v_out_121541.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_10 and arg_250_1.time_ < var_253_0 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play121541061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 121541061
		arg_254_1.duration_ = 9.9

		local var_254_0 = {
			ja = 4.8,
			ko = 9.9,
			zh = 9.9
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play121541062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0
			local var_257_1 = 0.45

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_2 = arg_254_1:FormatText(StoryNameCfg[379].name)

				arg_254_1.leftNameTxt_.text = var_257_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_3 = arg_254_1:GetWordFromCfg(121541061)
				local var_257_4 = arg_254_1:FormatText(var_257_3.content)

				arg_254_1.text_.text = var_257_4

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 20
				local var_257_6 = utf8.len(var_257_4)
				local var_257_7 = var_257_5 <= 0 and var_257_1 or var_257_1 * (var_257_6 / var_257_5)

				if var_257_7 > 0 and var_257_1 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_0
					end
				end

				arg_254_1.text_.text = var_257_4
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541061", "story_v_out_121541.awb") ~= 0 then
					local var_257_8 = manager.audio:GetVoiceLength("story_v_out_121541", "121541061", "story_v_out_121541.awb") / 1000

					if var_257_8 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_8 + var_257_0
					end

					if var_257_3.prefab_name ~= "" and arg_254_1.actors_[var_257_3.prefab_name] ~= nil then
						local var_257_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_3.prefab_name].transform, "story_v_out_121541", "121541061", "story_v_out_121541.awb")

						arg_254_1:RecordAudio("121541061", var_257_9)
						arg_254_1:RecordAudio("121541061", var_257_9)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_121541", "121541061", "story_v_out_121541.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_121541", "121541061", "story_v_out_121541.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_10 = math.max(var_257_1, arg_254_1.talkMaxDuration)

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_10 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_0) / var_257_10

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_0 + var_257_10 and arg_254_1.time_ < var_257_0 + var_257_10 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play121541062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 121541062
		arg_258_1.duration_ = 3.33

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play121541063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 0.05

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_2 = arg_258_1:FormatText(StoryNameCfg[379].name)

				arg_258_1.leftNameTxt_.text = var_261_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_3 = arg_258_1:GetWordFromCfg(121541062)
				local var_261_4 = arg_258_1:FormatText(var_261_3.content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541062", "story_v_out_121541.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_out_121541", "121541062", "story_v_out_121541.awb") / 1000

					if var_261_8 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_0
					end

					if var_261_3.prefab_name ~= "" and arg_258_1.actors_[var_261_3.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_3.prefab_name].transform, "story_v_out_121541", "121541062", "story_v_out_121541.awb")

						arg_258_1:RecordAudio("121541062", var_261_9)
						arg_258_1:RecordAudio("121541062", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_121541", "121541062", "story_v_out_121541.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_121541", "121541062", "story_v_out_121541.awb")
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
	Play121541063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 121541063
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play121541064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 1.525

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_2 = arg_262_1:GetWordFromCfg(121541063)
				local var_265_3 = arg_262_1:FormatText(var_265_2.content)

				arg_262_1.text_.text = var_265_3

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 61
				local var_265_5 = utf8.len(var_265_3)
				local var_265_6 = var_265_4 <= 0 and var_265_1 or var_265_1 * (var_265_5 / var_265_4)

				if var_265_6 > 0 and var_265_1 < var_265_6 then
					arg_262_1.talkMaxDuration = var_265_6

					if var_265_6 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_6 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_3
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_7 and arg_262_1.time_ < var_265_0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play121541064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 121541064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play121541065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 1.225

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_2 = arg_266_1:GetWordFromCfg(121541064)
				local var_269_3 = arg_266_1:FormatText(var_269_2.content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_4 = 49
				local var_269_5 = utf8.len(var_269_3)
				local var_269_6 = var_269_4 <= 0 and var_269_1 or var_269_1 * (var_269_5 / var_269_4)

				if var_269_6 > 0 and var_269_1 < var_269_6 then
					arg_266_1.talkMaxDuration = var_269_6

					if var_269_6 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_6 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_7 and arg_266_1.time_ < var_269_0 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play121541065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 121541065
		arg_270_1.duration_ = 5.23

		local var_270_0 = {
			ja = 5.233,
			ko = 5.133,
			zh = 5.133
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
				arg_270_0:Play121541066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.5

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[379].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_3 = arg_270_1:GetWordFromCfg(121541065)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541065", "story_v_out_121541.awb") ~= 0 then
					local var_273_8 = manager.audio:GetVoiceLength("story_v_out_121541", "121541065", "story_v_out_121541.awb") / 1000

					if var_273_8 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_0
					end

					if var_273_3.prefab_name ~= "" and arg_270_1.actors_[var_273_3.prefab_name] ~= nil then
						local var_273_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_3.prefab_name].transform, "story_v_out_121541", "121541065", "story_v_out_121541.awb")

						arg_270_1:RecordAudio("121541065", var_273_9)
						arg_270_1:RecordAudio("121541065", var_273_9)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_121541", "121541065", "story_v_out_121541.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_121541", "121541065", "story_v_out_121541.awb")
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
	Play121541066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 121541066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play121541067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.95

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_2 = arg_274_1:GetWordFromCfg(121541066)
				local var_277_3 = arg_274_1:FormatText(var_277_2.content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_4 = 38
				local var_277_5 = utf8.len(var_277_3)
				local var_277_6 = var_277_4 <= 0 and var_277_1 or var_277_1 * (var_277_5 / var_277_4)

				if var_277_6 > 0 and var_277_1 < var_277_6 then
					arg_274_1.talkMaxDuration = var_277_6

					if var_277_6 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_6 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_7 and arg_274_1.time_ < var_277_0 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play121541067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 121541067
		arg_278_1.duration_ = 14.1

		local var_278_0 = {
			ja = 14.1,
			ko = 7.1,
			zh = 7.1
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
				arg_278_0:Play121541068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 0.675

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[379].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_3 = arg_278_1:GetWordFromCfg(121541067)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541067", "story_v_out_121541.awb") ~= 0 then
					local var_281_8 = manager.audio:GetVoiceLength("story_v_out_121541", "121541067", "story_v_out_121541.awb") / 1000

					if var_281_8 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_0
					end

					if var_281_3.prefab_name ~= "" and arg_278_1.actors_[var_281_3.prefab_name] ~= nil then
						local var_281_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_3.prefab_name].transform, "story_v_out_121541", "121541067", "story_v_out_121541.awb")

						arg_278_1:RecordAudio("121541067", var_281_9)
						arg_278_1:RecordAudio("121541067", var_281_9)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_121541", "121541067", "story_v_out_121541.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_121541", "121541067", "story_v_out_121541.awb")
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
	Play121541068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 121541068
		arg_282_1.duration_ = 5.07

		local var_282_0 = {
			ja = 5.066,
			ko = 3.133,
			zh = 3.133
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
				arg_282_0:Play121541069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 0.15

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_2 = arg_282_1:FormatText(StoryNameCfg[379].name)

				arg_282_1.leftNameTxt_.text = var_285_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_3 = arg_282_1:GetWordFromCfg(121541068)
				local var_285_4 = arg_282_1:FormatText(var_285_3.content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541068", "story_v_out_121541.awb") ~= 0 then
					local var_285_8 = manager.audio:GetVoiceLength("story_v_out_121541", "121541068", "story_v_out_121541.awb") / 1000

					if var_285_8 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_8 + var_285_0
					end

					if var_285_3.prefab_name ~= "" and arg_282_1.actors_[var_285_3.prefab_name] ~= nil then
						local var_285_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_3.prefab_name].transform, "story_v_out_121541", "121541068", "story_v_out_121541.awb")

						arg_282_1:RecordAudio("121541068", var_285_9)
						arg_282_1:RecordAudio("121541068", var_285_9)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_121541", "121541068", "story_v_out_121541.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_121541", "121541068", "story_v_out_121541.awb")
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
	Play121541069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 121541069
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play121541070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.95

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_2 = arg_286_1:GetWordFromCfg(121541069)
				local var_289_3 = arg_286_1:FormatText(var_289_2.content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_4 = 38
				local var_289_5 = utf8.len(var_289_3)
				local var_289_6 = var_289_4 <= 0 and var_289_1 or var_289_1 * (var_289_5 / var_289_4)

				if var_289_6 > 0 and var_289_1 < var_289_6 then
					arg_286_1.talkMaxDuration = var_289_6

					if var_289_6 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_6 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_7 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_7 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_7

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_7 and arg_286_1.time_ < var_289_0 + var_289_7 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play121541070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 121541070
		arg_290_1.duration_ = 9

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play121541071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 2

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				local var_293_1 = manager.ui.mainCamera.transform.localPosition
				local var_293_2 = Vector3.New(0, 0, 10) + Vector3.New(var_293_1.x, var_293_1.y, 0)
				local var_293_3 = arg_290_1.bgs_.ST29a

				var_293_3.transform.localPosition = var_293_2
				var_293_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_293_4 = var_293_3:GetComponent("SpriteRenderer")

				if var_293_4 and var_293_4.sprite then
					local var_293_5 = (var_293_3.transform.localPosition - var_293_1).z
					local var_293_6 = manager.ui.mainCameraCom_
					local var_293_7 = 2 * var_293_5 * Mathf.Tan(var_293_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_293_8 = var_293_7 * var_293_6.aspect
					local var_293_9 = var_293_4.sprite.bounds.size.x
					local var_293_10 = var_293_4.sprite.bounds.size.y
					local var_293_11 = var_293_8 / var_293_9
					local var_293_12 = var_293_7 / var_293_10
					local var_293_13 = var_293_12 < var_293_11 and var_293_11 or var_293_12

					var_293_3.transform.localScale = Vector3.New(var_293_13, var_293_13, 0)
				end

				for iter_293_0, iter_293_1 in pairs(arg_290_1.bgs_) do
					if iter_293_0 ~= "ST29a" then
						iter_293_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_293_14 = 0

			if var_293_14 < arg_290_1.time_ and arg_290_1.time_ <= var_293_14 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_15 = 2

			if var_293_14 <= arg_290_1.time_ and arg_290_1.time_ < var_293_14 + var_293_15 then
				local var_293_16 = (arg_290_1.time_ - var_293_14) / var_293_15
				local var_293_17 = Color.New(0, 0, 0)

				var_293_17.a = Mathf.Lerp(0, 1, var_293_16)
				arg_290_1.mask_.color = var_293_17
			end

			if arg_290_1.time_ >= var_293_14 + var_293_15 and arg_290_1.time_ < var_293_14 + var_293_15 + arg_293_0 then
				local var_293_18 = Color.New(0, 0, 0)

				var_293_18.a = 1
				arg_290_1.mask_.color = var_293_18
			end

			local var_293_19 = 2

			if var_293_19 < arg_290_1.time_ and arg_290_1.time_ <= var_293_19 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_20 = 2

			if var_293_19 <= arg_290_1.time_ and arg_290_1.time_ < var_293_19 + var_293_20 then
				local var_293_21 = (arg_290_1.time_ - var_293_19) / var_293_20
				local var_293_22 = Color.New(0, 0, 0)

				var_293_22.a = Mathf.Lerp(1, 0, var_293_21)
				arg_290_1.mask_.color = var_293_22
			end

			if arg_290_1.time_ >= var_293_19 + var_293_20 and arg_290_1.time_ < var_293_19 + var_293_20 + arg_293_0 then
				local var_293_23 = Color.New(0, 0, 0)
				local var_293_24 = 0

				arg_290_1.mask_.enabled = false
				var_293_23.a = var_293_24
				arg_290_1.mask_.color = var_293_23
			end

			local var_293_25 = 1.46666666666667
			local var_293_26 = 1

			if var_293_25 < arg_290_1.time_ and arg_290_1.time_ <= var_293_25 + arg_293_0 then
				local var_293_27 = "play"
				local var_293_28 = "effect"

				arg_290_1:AudioAction(var_293_27, var_293_28, "se_story_121_04", "se_story_121_04_officefootstep", "")
			end

			local var_293_29 = 1.43333333333333
			local var_293_30 = 1

			if var_293_29 < arg_290_1.time_ and arg_290_1.time_ <= var_293_29 + arg_293_0 then
				local var_293_31 = "play"
				local var_293_32 = "effect"

				arg_290_1:AudioAction(var_293_31, var_293_32, "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if arg_290_1.frameCnt_ <= 1 then
				arg_290_1.dialog_:SetActive(false)
			end

			local var_293_33 = 4
			local var_293_34 = 1.35

			if var_293_33 < arg_290_1.time_ and arg_290_1.time_ <= var_293_33 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				arg_290_1.dialog_:SetActive(true)

				arg_290_1.dialogCg_.alpha = 0

				local var_293_35 = LeanTween.value(arg_290_1.dialog_, 0, 1, 0.3)

				var_293_35:setOnUpdate(LuaHelper.FloatAction(function(arg_294_0)
					arg_290_1.dialogCg_.alpha = arg_294_0
				end))
				var_293_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_290_1.dialog_)
					var_293_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_290_1.duration_ = arg_290_1.duration_ + 0.3

				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_36 = arg_290_1:GetWordFromCfg(121541070)
				local var_293_37 = arg_290_1:FormatText(var_293_36.content)

				arg_290_1.text_.text = var_293_37

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_38 = 55
				local var_293_39 = utf8.len(var_293_37)
				local var_293_40 = var_293_38 <= 0 and var_293_34 or var_293_34 * (var_293_39 / var_293_38)

				if var_293_40 > 0 and var_293_34 < var_293_40 then
					arg_290_1.talkMaxDuration = var_293_40
					var_293_33 = var_293_33 + 0.3

					if var_293_40 + var_293_33 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_40 + var_293_33
					end
				end

				arg_290_1.text_.text = var_293_37
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_41 = var_293_33 + 0.3
			local var_293_42 = math.max(var_293_34, arg_290_1.talkMaxDuration)

			if var_293_41 <= arg_290_1.time_ and arg_290_1.time_ < var_293_41 + var_293_42 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_41) / var_293_42

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_41 + var_293_42 and arg_290_1.time_ < var_293_41 + var_293_42 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play121541071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 121541071
		arg_296_1.duration_ = 3.43

		local var_296_0 = {
			ja = 3.433,
			ko = 2.5,
			zh = 2.5
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play121541072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0
			local var_299_1 = 0.275

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_2 = arg_296_1:FormatText(StoryNameCfg[443].name)

				arg_296_1.leftNameTxt_.text = var_299_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_3 = arg_296_1:GetWordFromCfg(121541071)
				local var_299_4 = arg_296_1:FormatText(var_299_3.content)

				arg_296_1.text_.text = var_299_4

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 11
				local var_299_6 = utf8.len(var_299_4)
				local var_299_7 = var_299_5 <= 0 and var_299_1 or var_299_1 * (var_299_6 / var_299_5)

				if var_299_7 > 0 and var_299_1 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_0
					end
				end

				arg_296_1.text_.text = var_299_4
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541071", "story_v_out_121541.awb") ~= 0 then
					local var_299_8 = manager.audio:GetVoiceLength("story_v_out_121541", "121541071", "story_v_out_121541.awb") / 1000

					if var_299_8 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_8 + var_299_0
					end

					if var_299_3.prefab_name ~= "" and arg_296_1.actors_[var_299_3.prefab_name] ~= nil then
						local var_299_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_3.prefab_name].transform, "story_v_out_121541", "121541071", "story_v_out_121541.awb")

						arg_296_1:RecordAudio("121541071", var_299_9)
						arg_296_1:RecordAudio("121541071", var_299_9)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_121541", "121541071", "story_v_out_121541.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_121541", "121541071", "story_v_out_121541.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_10 = math.max(var_299_1, arg_296_1.talkMaxDuration)

			if var_299_0 <= arg_296_1.time_ and arg_296_1.time_ < var_299_0 + var_299_10 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_0) / var_299_10

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_0 + var_299_10 and arg_296_1.time_ < var_299_0 + var_299_10 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play121541072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 121541072
		arg_300_1.duration_ = 4.03

		local var_300_0 = {
			ja = 3.5,
			ko = 4.033,
			zh = 4.033
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play121541073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 0.25

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_2 = arg_300_1:FormatText(StoryNameCfg[379].name)

				arg_300_1.leftNameTxt_.text = var_303_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_3 = arg_300_1:GetWordFromCfg(121541072)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 10
				local var_303_6 = utf8.len(var_303_4)
				local var_303_7 = var_303_5 <= 0 and var_303_1 or var_303_1 * (var_303_6 / var_303_5)

				if var_303_7 > 0 and var_303_1 < var_303_7 then
					arg_300_1.talkMaxDuration = var_303_7

					if var_303_7 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121541", "121541072", "story_v_out_121541.awb") ~= 0 then
					local var_303_8 = manager.audio:GetVoiceLength("story_v_out_121541", "121541072", "story_v_out_121541.awb") / 1000

					if var_303_8 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_8 + var_303_0
					end

					if var_303_3.prefab_name ~= "" and arg_300_1.actors_[var_303_3.prefab_name] ~= nil then
						local var_303_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_3.prefab_name].transform, "story_v_out_121541", "121541072", "story_v_out_121541.awb")

						arg_300_1:RecordAudio("121541072", var_303_9)
						arg_300_1:RecordAudio("121541072", var_303_9)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_121541", "121541072", "story_v_out_121541.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_121541", "121541072", "story_v_out_121541.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_10 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_10 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_10

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_10 and arg_300_1.time_ < var_303_0 + var_303_10 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play121541073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 121541073
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play121541074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 1.075

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_2 = arg_304_1:GetWordFromCfg(121541073)
				local var_307_3 = arg_304_1:FormatText(var_307_2.content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 43
				local var_307_5 = utf8.len(var_307_3)
				local var_307_6 = var_307_4 <= 0 and var_307_1 or var_307_1 * (var_307_5 / var_307_4)

				if var_307_6 > 0 and var_307_1 < var_307_6 then
					arg_304_1.talkMaxDuration = var_307_6

					if var_307_6 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_6 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_7 and arg_304_1.time_ < var_307_0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play121541074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 121541074
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
			arg_308_1.auto_ = false
		end

		function arg_308_1.playNext_(arg_310_0)
			arg_308_1.onStoryFinished_()
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0
			local var_311_1 = 1.325

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_2 = arg_308_1:GetWordFromCfg(121541074)
				local var_311_3 = arg_308_1:FormatText(var_311_2.content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_4 = 53
				local var_311_5 = utf8.len(var_311_3)
				local var_311_6 = var_311_4 <= 0 and var_311_1 or var_311_1 * (var_311_5 / var_311_4)

				if var_311_6 > 0 and var_311_1 < var_311_6 then
					arg_308_1.talkMaxDuration = var_311_6

					if var_311_6 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_6 + var_311_0
					end
				end

				arg_308_1.text_.text = var_311_3
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_7 = math.max(var_311_1, arg_308_1.talkMaxDuration)

			if var_311_0 <= arg_308_1.time_ and arg_308_1.time_ < var_311_0 + var_311_7 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_0) / var_311_7

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_0 + var_311_7 and arg_308_1.time_ < var_311_0 + var_311_7 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST29a",
		"TextureConfig/Background/ST32a",
		"TextureConfig/Background/XH0308"
	},
	voices = {
		"story_v_out_121541.awb"
	}
}
