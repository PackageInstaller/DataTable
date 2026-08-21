return {
	Play111182001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111182001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111182002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D05"

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
				local var_4_5 = arg_1_1.bgs_.D05

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
					if iter_4_0 ~= "D05" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.D05
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueD05 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueD05 = var_4_18
				end

				arg_1_1.var_.alphaOldValueD05 = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueD05, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueD05 then
					local var_4_22 = arg_1_1.var_.alphaMatValueD05.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueD05.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueD05 then
				local var_4_23 = arg_1_1.var_.alphaMatValueD05
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

			local var_4_27 = 2
			local var_4_28 = 1

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				local var_4_29 = "play"
				local var_4_30 = "music"

				arg_1_1:AudioAction(var_4_29, var_4_30, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_31 = ""
				local var_4_32 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			local var_4_33 = 2
			local var_4_34 = 0.65

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_35 = arg_1_1:GetWordFromCfg(111182001)
				local var_4_36 = arg_1_1:FormatText(var_4_35.content)

				arg_1_1.text_.text = var_4_36

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_37 = 26
				local var_4_38 = utf8.len(var_4_36)
				local var_4_39 = var_4_37 <= 0 and var_4_34 or var_4_34 * (var_4_38 / var_4_37)

				if var_4_39 > 0 and var_4_34 < var_4_39 then
					arg_1_1.talkMaxDuration = var_4_39

					if var_4_39 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_36
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_40 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_33 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_40 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_40

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_40 and arg_1_1.time_ < var_4_33 + var_4_40 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111182002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 111182002
		arg_6_1.duration_ = 5.4

		local var_6_0 = {
			ja = 5.4,
			ko = 3.766,
			zh = 5.133,
			en = 5.233
		}
		local var_6_1 = manager.audio:GetLocalizationFlag()

		if var_6_0[var_6_1] ~= nil then
			arg_6_1.duration_ = var_6_0[var_6_1]
		end

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play111182003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = "1096ui_story"

			if arg_6_1.actors_[var_9_0] == nil then
				local var_9_1 = Asset.Load("Char/" .. "1096ui_story")

				if not isNil(var_9_1) then
					local var_9_2 = Object.Instantiate(Asset.Load("Char/" .. "1096ui_story"), arg_6_1.stage_.transform)

					var_9_2.name = var_9_0
					var_9_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_6_1.actors_[var_9_0] = var_9_2

					local var_9_3 = var_9_2:GetComponentInChildren(typeof(CharacterEffect))

					var_9_3.enabled = true

					local var_9_4 = GameObjectTools.GetOrAddComponent(var_9_2, typeof(DynamicBoneHelper))

					if var_9_4 then
						var_9_4:EnableDynamicBone(false)
					end

					arg_6_1:ShowWeapon(var_9_3.transform, false)

					arg_6_1.var_[var_9_0 .. "Animator"] = var_9_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_6_1.var_[var_9_0 .. "Animator"].applyRootMotion = true
					arg_6_1.var_[var_9_0 .. "LipSync"] = var_9_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_9_5 = arg_6_1.actors_["1096ui_story"].transform
			local var_9_6 = 0

			if var_9_6 < arg_6_1.time_ and arg_6_1.time_ <= var_9_6 + arg_9_0 then
				arg_6_1.var_.moveOldPos1096ui_story = var_9_5.localPosition
			end

			local var_9_7 = 0.001

			if var_9_6 <= arg_6_1.time_ and arg_6_1.time_ < var_9_6 + var_9_7 then
				local var_9_8 = (arg_6_1.time_ - var_9_6) / var_9_7
				local var_9_9 = Vector3.New(0, -1.13, -5.6)

				var_9_5.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPos1096ui_story, var_9_9, var_9_8)

				local var_9_10 = manager.ui.mainCamera.transform.position - var_9_5.position

				var_9_5.forward = Vector3.New(var_9_10.x, var_9_10.y, var_9_10.z)

				local var_9_11 = var_9_5.localEulerAngles

				var_9_11.z = 0
				var_9_11.x = 0
				var_9_5.localEulerAngles = var_9_11
			end

			if arg_6_1.time_ >= var_9_6 + var_9_7 and arg_6_1.time_ < var_9_6 + var_9_7 + arg_9_0 then
				var_9_5.localPosition = Vector3.New(0, -1.13, -5.6)

				local var_9_12 = manager.ui.mainCamera.transform.position - var_9_5.position

				var_9_5.forward = Vector3.New(var_9_12.x, var_9_12.y, var_9_12.z)

				local var_9_13 = var_9_5.localEulerAngles

				var_9_13.z = 0
				var_9_13.x = 0
				var_9_5.localEulerAngles = var_9_13
			end

			local var_9_14 = 0

			if var_9_14 < arg_6_1.time_ and arg_6_1.time_ <= var_9_14 + arg_9_0 then
				arg_6_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action1_1")
			end

			local var_9_15 = 0

			if var_9_15 < arg_6_1.time_ and arg_6_1.time_ <= var_9_15 + arg_9_0 then
				arg_6_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_9_16 = arg_6_1.actors_["1096ui_story"]
			local var_9_17 = 0

			if var_9_17 < arg_6_1.time_ and arg_6_1.time_ <= var_9_17 + arg_9_0 and not isNil(var_9_16) and arg_6_1.var_.characterEffect1096ui_story == nil then
				arg_6_1.var_.characterEffect1096ui_story = var_9_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_9_18 = 0.2

			if var_9_17 <= arg_6_1.time_ and arg_6_1.time_ < var_9_17 + var_9_18 and not isNil(var_9_16) then
				local var_9_19 = (arg_6_1.time_ - var_9_17) / var_9_18

				if arg_6_1.var_.characterEffect1096ui_story and not isNil(var_9_16) then
					arg_6_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_6_1.time_ >= var_9_17 + var_9_18 and arg_6_1.time_ < var_9_17 + var_9_18 + arg_9_0 and not isNil(var_9_16) and arg_6_1.var_.characterEffect1096ui_story then
				arg_6_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_9_20 = 0
			local var_9_21 = 0.4

			if var_9_20 < arg_6_1.time_ and arg_6_1.time_ <= var_9_20 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0
				arg_6_1.dialogCg_.alpha = 1

				arg_6_1.dialog_:SetActive(true)
				SetActive(arg_6_1.leftNameGo_, true)

				local var_9_22 = arg_6_1:FormatText(StoryNameCfg[169].name)

				arg_6_1.leftNameTxt_.text = var_9_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_1.leftNameTxt_.transform)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1.leftNameTxt_.text)
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_23 = arg_6_1:GetWordFromCfg(111182002)
				local var_9_24 = arg_6_1:FormatText(var_9_23.content)

				arg_6_1.text_.text = var_9_24

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_25 = 16
				local var_9_26 = utf8.len(var_9_24)
				local var_9_27 = var_9_25 <= 0 and var_9_21 or var_9_21 * (var_9_26 / var_9_25)

				if var_9_27 > 0 and var_9_21 < var_9_27 then
					arg_6_1.talkMaxDuration = var_9_27

					if var_9_27 + var_9_20 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_27 + var_9_20
					end
				end

				arg_6_1.text_.text = var_9_24
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111182", "111182002", "story_v_out_111182.awb") ~= 0 then
					local var_9_28 = manager.audio:GetVoiceLength("story_v_out_111182", "111182002", "story_v_out_111182.awb") / 1000

					if var_9_28 + var_9_20 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_28 + var_9_20
					end

					if var_9_23.prefab_name ~= "" and arg_6_1.actors_[var_9_23.prefab_name] ~= nil then
						local var_9_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_6_1.actors_[var_9_23.prefab_name].transform, "story_v_out_111182", "111182002", "story_v_out_111182.awb")

						arg_6_1:RecordAudio("111182002", var_9_29)
						arg_6_1:RecordAudio("111182002", var_9_29)
					else
						arg_6_1:AudioAction("play", "voice", "story_v_out_111182", "111182002", "story_v_out_111182.awb")
					end

					arg_6_1:RecordHistoryTalkVoice("story_v_out_111182", "111182002", "story_v_out_111182.awb")
				end

				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_30 = math.max(var_9_21, arg_6_1.talkMaxDuration)

			if var_9_20 <= arg_6_1.time_ and arg_6_1.time_ < var_9_20 + var_9_30 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_20) / var_9_30

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_20 + var_9_30 and arg_6_1.time_ < var_9_20 + var_9_30 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {
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

		arg_6_1:InitPlayNodeList()
	end,
	Play111182003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 111182003
		arg_10_1.duration_ = 3.07

		local var_10_0 = {
			ja = 3.066,
			ko = 1.933,
			zh = 2.166,
			en = 1.9
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play111182004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = arg_10_1.actors_["1096ui_story"]
			local var_13_1 = 0

			if var_13_1 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 and not isNil(var_13_0) and arg_10_1.var_.characterEffect1096ui_story == nil then
				arg_10_1.var_.characterEffect1096ui_story = var_13_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_2 = 0.2

			if var_13_1 <= arg_10_1.time_ and arg_10_1.time_ < var_13_1 + var_13_2 and not isNil(var_13_0) then
				local var_13_3 = (arg_10_1.time_ - var_13_1) / var_13_2

				if arg_10_1.var_.characterEffect1096ui_story and not isNil(var_13_0) then
					local var_13_4 = Mathf.Lerp(0, 0.5, var_13_3)

					arg_10_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_10_1.var_.characterEffect1096ui_story.fillRatio = var_13_4
				end
			end

			if arg_10_1.time_ >= var_13_1 + var_13_2 and arg_10_1.time_ < var_13_1 + var_13_2 + arg_13_0 and not isNil(var_13_0) and arg_10_1.var_.characterEffect1096ui_story then
				local var_13_5 = 0.5

				arg_10_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_10_1.var_.characterEffect1096ui_story.fillRatio = var_13_5
			end

			local var_13_6 = 0
			local var_13_7 = 0.275

			if var_13_6 < arg_10_1.time_ and arg_10_1.time_ <= var_13_6 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_8 = arg_10_1:FormatText(StoryNameCfg[32].name)

				arg_10_1.leftNameTxt_.text = var_13_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, true)
				arg_10_1.iconController_:SetSelectedState("hero")

				arg_10_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_10_1.callingController_:SetSelectedState("normal")

				arg_10_1.keyicon_.color = Color.New(1, 1, 1)
				arg_10_1.icon_.color = Color.New(1, 1, 1)

				local var_13_9 = arg_10_1:GetWordFromCfg(111182003)
				local var_13_10 = arg_10_1:FormatText(var_13_9.content)

				arg_10_1.text_.text = var_13_10

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_11 = 11
				local var_13_12 = utf8.len(var_13_10)
				local var_13_13 = var_13_11 <= 0 and var_13_7 or var_13_7 * (var_13_12 / var_13_11)

				if var_13_13 > 0 and var_13_7 < var_13_13 then
					arg_10_1.talkMaxDuration = var_13_13

					if var_13_13 + var_13_6 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_13 + var_13_6
					end
				end

				arg_10_1.text_.text = var_13_10
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111182", "111182003", "story_v_out_111182.awb") ~= 0 then
					local var_13_14 = manager.audio:GetVoiceLength("story_v_out_111182", "111182003", "story_v_out_111182.awb") / 1000

					if var_13_14 + var_13_6 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_14 + var_13_6
					end

					if var_13_9.prefab_name ~= "" and arg_10_1.actors_[var_13_9.prefab_name] ~= nil then
						local var_13_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_9.prefab_name].transform, "story_v_out_111182", "111182003", "story_v_out_111182.awb")

						arg_10_1:RecordAudio("111182003", var_13_15)
						arg_10_1:RecordAudio("111182003", var_13_15)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_111182", "111182003", "story_v_out_111182.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_111182", "111182003", "story_v_out_111182.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_16 = math.max(var_13_7, arg_10_1.talkMaxDuration)

			if var_13_6 <= arg_10_1.time_ and arg_10_1.time_ < var_13_6 + var_13_16 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_6) / var_13_16

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_6 + var_13_16 and arg_10_1.time_ < var_13_6 + var_13_16 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play111182004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 111182004
		arg_14_1.duration_ = 9.53

		local var_14_0 = {
			ja = 6.633,
			ko = 8.933,
			zh = 9.533,
			en = 8.666
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play111182005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_17_1 = arg_14_1.actors_["1096ui_story"]
			local var_17_2 = 0

			if var_17_2 < arg_14_1.time_ and arg_14_1.time_ <= var_17_2 + arg_17_0 and not isNil(var_17_1) and arg_14_1.var_.characterEffect1096ui_story == nil then
				arg_14_1.var_.characterEffect1096ui_story = var_17_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_3 = 0.2

			if var_17_2 <= arg_14_1.time_ and arg_14_1.time_ < var_17_2 + var_17_3 and not isNil(var_17_1) then
				local var_17_4 = (arg_14_1.time_ - var_17_2) / var_17_3

				if arg_14_1.var_.characterEffect1096ui_story and not isNil(var_17_1) then
					arg_14_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_14_1.time_ >= var_17_2 + var_17_3 and arg_14_1.time_ < var_17_2 + var_17_3 + arg_17_0 and not isNil(var_17_1) and arg_14_1.var_.characterEffect1096ui_story then
				arg_14_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_17_5 = 0
			local var_17_6 = 0.975

			if var_17_5 < arg_14_1.time_ and arg_14_1.time_ <= var_17_5 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_7 = arg_14_1:FormatText(StoryNameCfg[169].name)

				arg_14_1.leftNameTxt_.text = var_17_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_8 = arg_14_1:GetWordFromCfg(111182004)
				local var_17_9 = arg_14_1:FormatText(var_17_8.content)

				arg_14_1.text_.text = var_17_9

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_10 = 39
				local var_17_11 = utf8.len(var_17_9)
				local var_17_12 = var_17_10 <= 0 and var_17_6 or var_17_6 * (var_17_11 / var_17_10)

				if var_17_12 > 0 and var_17_6 < var_17_12 then
					arg_14_1.talkMaxDuration = var_17_12

					if var_17_12 + var_17_5 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_12 + var_17_5
					end
				end

				arg_14_1.text_.text = var_17_9
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111182", "111182004", "story_v_out_111182.awb") ~= 0 then
					local var_17_13 = manager.audio:GetVoiceLength("story_v_out_111182", "111182004", "story_v_out_111182.awb") / 1000

					if var_17_13 + var_17_5 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_13 + var_17_5
					end

					if var_17_8.prefab_name ~= "" and arg_14_1.actors_[var_17_8.prefab_name] ~= nil then
						local var_17_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_8.prefab_name].transform, "story_v_out_111182", "111182004", "story_v_out_111182.awb")

						arg_14_1:RecordAudio("111182004", var_17_14)
						arg_14_1:RecordAudio("111182004", var_17_14)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_111182", "111182004", "story_v_out_111182.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_111182", "111182004", "story_v_out_111182.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_15 = math.max(var_17_6, arg_14_1.talkMaxDuration)

			if var_17_5 <= arg_14_1.time_ and arg_14_1.time_ < var_17_5 + var_17_15 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_5) / var_17_15

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_5 + var_17_15 and arg_14_1.time_ < var_17_5 + var_17_15 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play111182005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 111182005
		arg_18_1.duration_ = 8.9

		local var_18_0 = {
			ja = 3.766,
			ko = 8.9,
			zh = 5.533,
			en = 4.4
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play111182006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_21_1 = 0
			local var_21_2 = 0.8

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_3 = arg_18_1:FormatText(StoryNameCfg[169].name)

				arg_18_1.leftNameTxt_.text = var_21_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_4 = arg_18_1:GetWordFromCfg(111182005)
				local var_21_5 = arg_18_1:FormatText(var_21_4.content)

				arg_18_1.text_.text = var_21_5

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_6 = 32
				local var_21_7 = utf8.len(var_21_5)
				local var_21_8 = var_21_6 <= 0 and var_21_2 or var_21_2 * (var_21_7 / var_21_6)

				if var_21_8 > 0 and var_21_2 < var_21_8 then
					arg_18_1.talkMaxDuration = var_21_8

					if var_21_8 + var_21_1 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_1
					end
				end

				arg_18_1.text_.text = var_21_5
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111182", "111182005", "story_v_out_111182.awb") ~= 0 then
					local var_21_9 = manager.audio:GetVoiceLength("story_v_out_111182", "111182005", "story_v_out_111182.awb") / 1000

					if var_21_9 + var_21_1 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_9 + var_21_1
					end

					if var_21_4.prefab_name ~= "" and arg_18_1.actors_[var_21_4.prefab_name] ~= nil then
						local var_21_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_4.prefab_name].transform, "story_v_out_111182", "111182005", "story_v_out_111182.awb")

						arg_18_1:RecordAudio("111182005", var_21_10)
						arg_18_1:RecordAudio("111182005", var_21_10)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_111182", "111182005", "story_v_out_111182.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_111182", "111182005", "story_v_out_111182.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_11 = math.max(var_21_2, arg_18_1.talkMaxDuration)

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_11 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_1) / var_21_11

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_1 + var_21_11 and arg_18_1.time_ < var_21_1 + var_21_11 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play111182006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 111182006
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play111182007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1096ui_story"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1096ui_story == nil then
				arg_22_1.var_.characterEffect1096ui_story = var_25_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_2 = 0.2

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.characterEffect1096ui_story and not isNil(var_25_0) then
					local var_25_4 = Mathf.Lerp(0, 0.5, var_25_3)

					arg_22_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_22_1.var_.characterEffect1096ui_story.fillRatio = var_25_4
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1096ui_story then
				local var_25_5 = 0.5

				arg_22_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_22_1.var_.characterEffect1096ui_story.fillRatio = var_25_5
			end

			local var_25_6 = 0
			local var_25_7 = 0.5

			if var_25_6 < arg_22_1.time_ and arg_22_1.time_ <= var_25_6 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_8 = arg_22_1:GetWordFromCfg(111182006)
				local var_25_9 = arg_22_1:FormatText(var_25_8.content)

				arg_22_1.text_.text = var_25_9

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_10 = 20
				local var_25_11 = utf8.len(var_25_9)
				local var_25_12 = var_25_10 <= 0 and var_25_7 or var_25_7 * (var_25_11 / var_25_10)

				if var_25_12 > 0 and var_25_7 < var_25_12 then
					arg_22_1.talkMaxDuration = var_25_12

					if var_25_12 + var_25_6 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_12 + var_25_6
					end
				end

				arg_22_1.text_.text = var_25_9
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_13 = math.max(var_25_7, arg_22_1.talkMaxDuration)

			if var_25_6 <= arg_22_1.time_ and arg_22_1.time_ < var_25_6 + var_25_13 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_6) / var_25_13

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_6 + var_25_13 and arg_22_1.time_ < var_25_6 + var_25_13 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play111182007 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 111182007
		arg_26_1.duration_ = 12.43

		local var_26_0 = {
			ja = 12.433,
			ko = 8.166,
			zh = 6.2,
			en = 6.466
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play111182008(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 1

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_2 = arg_26_1:FormatText(StoryNameCfg[32].name)

				arg_26_1.leftNameTxt_.text = var_29_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_3 = arg_26_1:GetWordFromCfg(111182007)
				local var_29_4 = arg_26_1:FormatText(var_29_3.content)

				arg_26_1.text_.text = var_29_4

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 36
				local var_29_6 = utf8.len(var_29_4)
				local var_29_7 = var_29_5 <= 0 and var_29_1 or var_29_1 * (var_29_6 / var_29_5)

				if var_29_7 > 0 and var_29_1 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_4
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111182", "111182007", "story_v_out_111182.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_111182", "111182007", "story_v_out_111182.awb") / 1000

					if var_29_8 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_0
					end

					if var_29_3.prefab_name ~= "" and arg_26_1.actors_[var_29_3.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_3.prefab_name].transform, "story_v_out_111182", "111182007", "story_v_out_111182.awb")

						arg_26_1:RecordAudio("111182007", var_29_9)
						arg_26_1:RecordAudio("111182007", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_111182", "111182007", "story_v_out_111182.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_111182", "111182007", "story_v_out_111182.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_10 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_10 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_10

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_10 and arg_26_1.time_ < var_29_0 + var_29_10 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play111182008 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 111182008
		arg_30_1.duration_ = 7.9

		local var_30_0 = {
			ja = 5.233,
			ko = 7.9,
			zh = 6.5,
			en = 7.066
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
				arg_30_0:Play111182009(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 0.775

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_2 = arg_30_1:FormatText(StoryNameCfg[32].name)

				arg_30_1.leftNameTxt_.text = var_33_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_3 = arg_30_1:GetWordFromCfg(111182008)
				local var_33_4 = arg_30_1:FormatText(var_33_3.content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 31
				local var_33_6 = utf8.len(var_33_4)
				local var_33_7 = var_33_5 <= 0 and var_33_1 or var_33_1 * (var_33_6 / var_33_5)

				if var_33_7 > 0 and var_33_1 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111182", "111182008", "story_v_out_111182.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_111182", "111182008", "story_v_out_111182.awb") / 1000

					if var_33_8 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_0
					end

					if var_33_3.prefab_name ~= "" and arg_30_1.actors_[var_33_3.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_3.prefab_name].transform, "story_v_out_111182", "111182008", "story_v_out_111182.awb")

						arg_30_1:RecordAudio("111182008", var_33_9)
						arg_30_1:RecordAudio("111182008", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_111182", "111182008", "story_v_out_111182.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_111182", "111182008", "story_v_out_111182.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_10 and arg_30_1.time_ < var_33_0 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play111182009 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 111182009
		arg_34_1.duration_ = 5.3

		local var_34_0 = {
			ja = 3.633,
			ko = 5.3,
			zh = 3.9,
			en = 3.733
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play111182010(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0
			local var_37_1 = 0.55

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_2 = arg_34_1:FormatText(StoryNameCfg[32].name)

				arg_34_1.leftNameTxt_.text = var_37_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_3 = arg_34_1:GetWordFromCfg(111182009)
				local var_37_4 = arg_34_1:FormatText(var_37_3.content)

				arg_34_1.text_.text = var_37_4

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_5 = 18
				local var_37_6 = utf8.len(var_37_4)
				local var_37_7 = var_37_5 <= 0 and var_37_1 or var_37_1 * (var_37_6 / var_37_5)

				if var_37_7 > 0 and var_37_1 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_0
					end
				end

				arg_34_1.text_.text = var_37_4
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111182", "111182009", "story_v_out_111182.awb") ~= 0 then
					local var_37_8 = manager.audio:GetVoiceLength("story_v_out_111182", "111182009", "story_v_out_111182.awb") / 1000

					if var_37_8 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_0
					end

					if var_37_3.prefab_name ~= "" and arg_34_1.actors_[var_37_3.prefab_name] ~= nil then
						local var_37_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_3.prefab_name].transform, "story_v_out_111182", "111182009", "story_v_out_111182.awb")

						arg_34_1:RecordAudio("111182009", var_37_9)
						arg_34_1:RecordAudio("111182009", var_37_9)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_111182", "111182009", "story_v_out_111182.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_111182", "111182009", "story_v_out_111182.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_10 = math.max(var_37_1, arg_34_1.talkMaxDuration)

			if var_37_0 <= arg_34_1.time_ and arg_34_1.time_ < var_37_0 + var_37_10 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_0) / var_37_10

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_0 + var_37_10 and arg_34_1.time_ < var_37_0 + var_37_10 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play111182010 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 111182010
		arg_38_1.duration_ = 4.37

		local var_38_0 = {
			ja = 3.966,
			ko = 3.633,
			zh = 4.366,
			en = 4.233
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play111182011(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action4_1")
			end

			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_41_2 = arg_38_1.actors_["1096ui_story"]
			local var_41_3 = 0

			if var_41_3 < arg_38_1.time_ and arg_38_1.time_ <= var_41_3 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.characterEffect1096ui_story == nil then
				arg_38_1.var_.characterEffect1096ui_story = var_41_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_4 = 0.2

			if var_41_3 <= arg_38_1.time_ and arg_38_1.time_ < var_41_3 + var_41_4 and not isNil(var_41_2) then
				local var_41_5 = (arg_38_1.time_ - var_41_3) / var_41_4

				if arg_38_1.var_.characterEffect1096ui_story and not isNil(var_41_2) then
					arg_38_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_3 + var_41_4 and arg_38_1.time_ < var_41_3 + var_41_4 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.characterEffect1096ui_story then
				arg_38_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_41_6 = 0
			local var_41_7 = 0.425

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_8 = arg_38_1:FormatText(StoryNameCfg[169].name)

				arg_38_1.leftNameTxt_.text = var_41_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_9 = arg_38_1:GetWordFromCfg(111182010)
				local var_41_10 = arg_38_1:FormatText(var_41_9.content)

				arg_38_1.text_.text = var_41_10

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 17
				local var_41_12 = utf8.len(var_41_10)
				local var_41_13 = var_41_11 <= 0 and var_41_7 or var_41_7 * (var_41_12 / var_41_11)

				if var_41_13 > 0 and var_41_7 < var_41_13 then
					arg_38_1.talkMaxDuration = var_41_13

					if var_41_13 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_10
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111182", "111182010", "story_v_out_111182.awb") ~= 0 then
					local var_41_14 = manager.audio:GetVoiceLength("story_v_out_111182", "111182010", "story_v_out_111182.awb") / 1000

					if var_41_14 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_14 + var_41_6
					end

					if var_41_9.prefab_name ~= "" and arg_38_1.actors_[var_41_9.prefab_name] ~= nil then
						local var_41_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_9.prefab_name].transform, "story_v_out_111182", "111182010", "story_v_out_111182.awb")

						arg_38_1:RecordAudio("111182010", var_41_15)
						arg_38_1:RecordAudio("111182010", var_41_15)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_111182", "111182010", "story_v_out_111182.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_111182", "111182010", "story_v_out_111182.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_16 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_16 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_16

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_16 and arg_38_1.time_ < var_41_6 + var_41_16 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play111182011 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 111182011
		arg_42_1.duration_ = 2.6

		local var_42_0 = {
			ja = 0.799999999999,
			ko = 1.6,
			zh = 2.6,
			en = 1.266
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play111182012(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1096ui_story"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1096ui_story == nil then
				arg_42_1.var_.characterEffect1096ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.2

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect1096ui_story and not isNil(var_45_0) then
					local var_45_4 = Mathf.Lerp(0, 0.5, var_45_3)

					arg_42_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1096ui_story.fillRatio = var_45_4
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1096ui_story then
				local var_45_5 = 0.5

				arg_42_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1096ui_story.fillRatio = var_45_5
			end

			local var_45_6 = 0
			local var_45_7 = 0.125

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_8 = arg_42_1:FormatText(StoryNameCfg[32].name)

				arg_42_1.leftNameTxt_.text = var_45_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_9 = arg_42_1:GetWordFromCfg(111182011)
				local var_45_10 = arg_42_1:FormatText(var_45_9.content)

				arg_42_1.text_.text = var_45_10

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_11 = 5
				local var_45_12 = utf8.len(var_45_10)
				local var_45_13 = var_45_11 <= 0 and var_45_7 or var_45_7 * (var_45_12 / var_45_11)

				if var_45_13 > 0 and var_45_7 < var_45_13 then
					arg_42_1.talkMaxDuration = var_45_13

					if var_45_13 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_13 + var_45_6
					end
				end

				arg_42_1.text_.text = var_45_10
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111182", "111182011", "story_v_out_111182.awb") ~= 0 then
					local var_45_14 = manager.audio:GetVoiceLength("story_v_out_111182", "111182011", "story_v_out_111182.awb") / 1000

					if var_45_14 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_14 + var_45_6
					end

					if var_45_9.prefab_name ~= "" and arg_42_1.actors_[var_45_9.prefab_name] ~= nil then
						local var_45_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_9.prefab_name].transform, "story_v_out_111182", "111182011", "story_v_out_111182.awb")

						arg_42_1:RecordAudio("111182011", var_45_15)
						arg_42_1:RecordAudio("111182011", var_45_15)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_111182", "111182011", "story_v_out_111182.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_111182", "111182011", "story_v_out_111182.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_16 = math.max(var_45_7, arg_42_1.talkMaxDuration)

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_16 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_6) / var_45_16

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_6 + var_45_16 and arg_42_1.time_ < var_45_6 + var_45_16 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play111182012 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 111182012
		arg_46_1.duration_ = 6.9

		local var_46_0 = {
			ja = 6.9,
			ko = 2.866,
			zh = 2.5,
			en = 3.733
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play111182013(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action442")
			end

			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_49_2 = arg_46_1.actors_["1096ui_story"]
			local var_49_3 = 0

			if var_49_3 < arg_46_1.time_ and arg_46_1.time_ <= var_49_3 + arg_49_0 and not isNil(var_49_2) and arg_46_1.var_.characterEffect1096ui_story == nil then
				arg_46_1.var_.characterEffect1096ui_story = var_49_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_4 = 0.2

			if var_49_3 <= arg_46_1.time_ and arg_46_1.time_ < var_49_3 + var_49_4 and not isNil(var_49_2) then
				local var_49_5 = (arg_46_1.time_ - var_49_3) / var_49_4

				if arg_46_1.var_.characterEffect1096ui_story and not isNil(var_49_2) then
					arg_46_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_3 + var_49_4 and arg_46_1.time_ < var_49_3 + var_49_4 + arg_49_0 and not isNil(var_49_2) and arg_46_1.var_.characterEffect1096ui_story then
				arg_46_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_49_6 = 0
			local var_49_7 = 0.2

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_8 = arg_46_1:FormatText(StoryNameCfg[169].name)

				arg_46_1.leftNameTxt_.text = var_49_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_9 = arg_46_1:GetWordFromCfg(111182012)
				local var_49_10 = arg_46_1:FormatText(var_49_9.content)

				arg_46_1.text_.text = var_49_10

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_11 = 8
				local var_49_12 = utf8.len(var_49_10)
				local var_49_13 = var_49_11 <= 0 and var_49_7 or var_49_7 * (var_49_12 / var_49_11)

				if var_49_13 > 0 and var_49_7 < var_49_13 then
					arg_46_1.talkMaxDuration = var_49_13

					if var_49_13 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_13 + var_49_6
					end
				end

				arg_46_1.text_.text = var_49_10
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111182", "111182012", "story_v_out_111182.awb") ~= 0 then
					local var_49_14 = manager.audio:GetVoiceLength("story_v_out_111182", "111182012", "story_v_out_111182.awb") / 1000

					if var_49_14 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_14 + var_49_6
					end

					if var_49_9.prefab_name ~= "" and arg_46_1.actors_[var_49_9.prefab_name] ~= nil then
						local var_49_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_9.prefab_name].transform, "story_v_out_111182", "111182012", "story_v_out_111182.awb")

						arg_46_1:RecordAudio("111182012", var_49_15)
						arg_46_1:RecordAudio("111182012", var_49_15)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_111182", "111182012", "story_v_out_111182.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_111182", "111182012", "story_v_out_111182.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_16 = math.max(var_49_7, arg_46_1.talkMaxDuration)

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_16 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_6) / var_49_16

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_6 + var_49_16 and arg_46_1.time_ < var_49_6 + var_49_16 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play111182013 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 111182013
		arg_50_1.duration_ = 5.6

		local var_50_0 = {
			ja = 5.6,
			ko = 5.133,
			zh = 4.033,
			en = 3.133
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play111182014(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1096ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1096ui_story == nil then
				arg_50_1.var_.characterEffect1096ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.2

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect1096ui_story and not isNil(var_53_0) then
					local var_53_4 = Mathf.Lerp(0, 0.5, var_53_3)

					arg_50_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1096ui_story.fillRatio = var_53_4
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1096ui_story then
				local var_53_5 = 0.5

				arg_50_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1096ui_story.fillRatio = var_53_5
			end

			local var_53_6 = 0
			local var_53_7 = 0.5

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[32].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_9 = arg_50_1:GetWordFromCfg(111182013)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 20
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_7 or var_53_7 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_7 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111182", "111182013", "story_v_out_111182.awb") ~= 0 then
					local var_53_14 = manager.audio:GetVoiceLength("story_v_out_111182", "111182013", "story_v_out_111182.awb") / 1000

					if var_53_14 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_6
					end

					if var_53_9.prefab_name ~= "" and arg_50_1.actors_[var_53_9.prefab_name] ~= nil then
						local var_53_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_9.prefab_name].transform, "story_v_out_111182", "111182013", "story_v_out_111182.awb")

						arg_50_1:RecordAudio("111182013", var_53_15)
						arg_50_1:RecordAudio("111182013", var_53_15)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_111182", "111182013", "story_v_out_111182.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_111182", "111182013", "story_v_out_111182.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_16 and arg_50_1.time_ < var_53_6 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play111182014 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 111182014
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play111182015(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1096ui_story"].transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.moveOldPos1096ui_story = var_57_0.localPosition
			end

			local var_57_2 = 0.001

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2
				local var_57_4 = Vector3.New(0, 100, 0)

				var_57_0.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1096ui_story, var_57_4, var_57_3)

				local var_57_5 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_5.x, var_57_5.y, var_57_5.z)

				local var_57_6 = var_57_0.localEulerAngles

				var_57_6.z = 0
				var_57_6.x = 0
				var_57_0.localEulerAngles = var_57_6
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 then
				var_57_0.localPosition = Vector3.New(0, 100, 0)

				local var_57_7 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_7.x, var_57_7.y, var_57_7.z)

				local var_57_8 = var_57_0.localEulerAngles

				var_57_8.z = 0
				var_57_8.x = 0
				var_57_0.localEulerAngles = var_57_8
			end

			local var_57_9 = 0
			local var_57_10 = 0.825

			if var_57_9 < arg_54_1.time_ and arg_54_1.time_ <= var_57_9 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_11 = arg_54_1:GetWordFromCfg(111182014)
				local var_57_12 = arg_54_1:FormatText(var_57_11.content)

				arg_54_1.text_.text = var_57_12

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_13 = 33
				local var_57_14 = utf8.len(var_57_12)
				local var_57_15 = var_57_13 <= 0 and var_57_10 or var_57_10 * (var_57_14 / var_57_13)

				if var_57_15 > 0 and var_57_10 < var_57_15 then
					arg_54_1.talkMaxDuration = var_57_15

					if var_57_15 + var_57_9 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_15 + var_57_9
					end
				end

				arg_54_1.text_.text = var_57_12
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_16 = math.max(var_57_10, arg_54_1.talkMaxDuration)

			if var_57_9 <= arg_54_1.time_ and arg_54_1.time_ < var_57_9 + var_57_16 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_9) / var_57_16

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_9 + var_57_16 and arg_54_1.time_ < var_57_9 + var_57_16 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
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

		arg_54_1:InitPlayNodeList()
	end,
	Play111182015 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 111182015
		arg_58_1.duration_ = 6.9

		local var_58_0 = {
			ja = 6.2,
			ko = 4.833,
			zh = 5.1,
			en = 6.9
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play111182016(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action425")
			end

			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_61_2 = arg_58_1.actors_["1096ui_story"]
			local var_61_3 = 0

			if var_61_3 < arg_58_1.time_ and arg_58_1.time_ <= var_61_3 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect1096ui_story == nil then
				arg_58_1.var_.characterEffect1096ui_story = var_61_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_4 = 0.2

			if var_61_3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_3 + var_61_4 and not isNil(var_61_2) then
				local var_61_5 = (arg_58_1.time_ - var_61_3) / var_61_4

				if arg_58_1.var_.characterEffect1096ui_story and not isNil(var_61_2) then
					arg_58_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_3 + var_61_4 and arg_58_1.time_ < var_61_3 + var_61_4 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect1096ui_story then
				arg_58_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_61_6 = arg_58_1.actors_["1096ui_story"].transform
			local var_61_7 = 0

			if var_61_7 < arg_58_1.time_ and arg_58_1.time_ <= var_61_7 + arg_61_0 then
				arg_58_1.var_.moveOldPos1096ui_story = var_61_6.localPosition
			end

			local var_61_8 = 0.001

			if var_61_7 <= arg_58_1.time_ and arg_58_1.time_ < var_61_7 + var_61_8 then
				local var_61_9 = (arg_58_1.time_ - var_61_7) / var_61_8
				local var_61_10 = Vector3.New(0, -1.13, -5.6)

				var_61_6.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1096ui_story, var_61_10, var_61_9)

				local var_61_11 = manager.ui.mainCamera.transform.position - var_61_6.position

				var_61_6.forward = Vector3.New(var_61_11.x, var_61_11.y, var_61_11.z)

				local var_61_12 = var_61_6.localEulerAngles

				var_61_12.z = 0
				var_61_12.x = 0
				var_61_6.localEulerAngles = var_61_12
			end

			if arg_58_1.time_ >= var_61_7 + var_61_8 and arg_58_1.time_ < var_61_7 + var_61_8 + arg_61_0 then
				var_61_6.localPosition = Vector3.New(0, -1.13, -5.6)

				local var_61_13 = manager.ui.mainCamera.transform.position - var_61_6.position

				var_61_6.forward = Vector3.New(var_61_13.x, var_61_13.y, var_61_13.z)

				local var_61_14 = var_61_6.localEulerAngles

				var_61_14.z = 0
				var_61_14.x = 0
				var_61_6.localEulerAngles = var_61_14
			end

			local var_61_15 = 0
			local var_61_16 = 0.6

			if var_61_15 < arg_58_1.time_ and arg_58_1.time_ <= var_61_15 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_17 = arg_58_1:FormatText(StoryNameCfg[169].name)

				arg_58_1.leftNameTxt_.text = var_61_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_18 = arg_58_1:GetWordFromCfg(111182015)
				local var_61_19 = arg_58_1:FormatText(var_61_18.content)

				arg_58_1.text_.text = var_61_19

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_20 = 20
				local var_61_21 = utf8.len(var_61_19)
				local var_61_22 = var_61_20 <= 0 and var_61_16 or var_61_16 * (var_61_21 / var_61_20)

				if var_61_22 > 0 and var_61_16 < var_61_22 then
					arg_58_1.talkMaxDuration = var_61_22

					if var_61_22 + var_61_15 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_22 + var_61_15
					end
				end

				arg_58_1.text_.text = var_61_19
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111182", "111182015", "story_v_out_111182.awb") ~= 0 then
					local var_61_23 = manager.audio:GetVoiceLength("story_v_out_111182", "111182015", "story_v_out_111182.awb") / 1000

					if var_61_23 + var_61_15 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_23 + var_61_15
					end

					if var_61_18.prefab_name ~= "" and arg_58_1.actors_[var_61_18.prefab_name] ~= nil then
						local var_61_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_18.prefab_name].transform, "story_v_out_111182", "111182015", "story_v_out_111182.awb")

						arg_58_1:RecordAudio("111182015", var_61_24)
						arg_58_1:RecordAudio("111182015", var_61_24)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_111182", "111182015", "story_v_out_111182.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_111182", "111182015", "story_v_out_111182.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_25 = math.max(var_61_16, arg_58_1.talkMaxDuration)

			if var_61_15 <= arg_58_1.time_ and arg_58_1.time_ < var_61_15 + var_61_25 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_15) / var_61_25

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_15 + var_61_25 and arg_58_1.time_ < var_61_15 + var_61_25 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play111182016 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 111182016
		arg_62_1.duration_ = 6.2

		local var_62_0 = {
			ja = 6.2,
			ko = 5.266,
			zh = 4.633,
			en = 3.2
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play111182017(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action5_2")
			end

			local var_65_2 = 0
			local var_65_3 = 0.525

			if var_65_2 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_4 = arg_62_1:FormatText(StoryNameCfg[169].name)

				arg_62_1.leftNameTxt_.text = var_65_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_5 = arg_62_1:GetWordFromCfg(111182016)
				local var_65_6 = arg_62_1:FormatText(var_65_5.content)

				arg_62_1.text_.text = var_65_6

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_7 = 21
				local var_65_8 = utf8.len(var_65_6)
				local var_65_9 = var_65_7 <= 0 and var_65_3 or var_65_3 * (var_65_8 / var_65_7)

				if var_65_9 > 0 and var_65_3 < var_65_9 then
					arg_62_1.talkMaxDuration = var_65_9

					if var_65_9 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_2
					end
				end

				arg_62_1.text_.text = var_65_6
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111182", "111182016", "story_v_out_111182.awb") ~= 0 then
					local var_65_10 = manager.audio:GetVoiceLength("story_v_out_111182", "111182016", "story_v_out_111182.awb") / 1000

					if var_65_10 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_2
					end

					if var_65_5.prefab_name ~= "" and arg_62_1.actors_[var_65_5.prefab_name] ~= nil then
						local var_65_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_5.prefab_name].transform, "story_v_out_111182", "111182016", "story_v_out_111182.awb")

						arg_62_1:RecordAudio("111182016", var_65_11)
						arg_62_1:RecordAudio("111182016", var_65_11)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_111182", "111182016", "story_v_out_111182.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_111182", "111182016", "story_v_out_111182.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_12 = math.max(var_65_3, arg_62_1.talkMaxDuration)

			if var_65_2 <= arg_62_1.time_ and arg_62_1.time_ < var_65_2 + var_65_12 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_2) / var_65_12

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_2 + var_65_12 and arg_62_1.time_ < var_65_2 + var_65_12 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play111182017 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 111182017
		arg_66_1.duration_ = 5

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
			local var_69_0 = arg_66_1.actors_["1096ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos1096ui_story = var_69_0.localPosition
			end

			local var_69_2 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2
				local var_69_4 = Vector3.New(0, 100, 0)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1096ui_story, var_69_4, var_69_3)

				local var_69_5 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_5.x, var_69_5.y, var_69_5.z)

				local var_69_6 = var_69_0.localEulerAngles

				var_69_6.z = 0
				var_69_6.x = 0
				var_69_0.localEulerAngles = var_69_6
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(0, 100, 0)

				local var_69_7 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_7.x, var_69_7.y, var_69_7.z)

				local var_69_8 = var_69_0.localEulerAngles

				var_69_8.z = 0
				var_69_8.x = 0
				var_69_0.localEulerAngles = var_69_8
			end

			local var_69_9 = 0
			local var_69_10 = 0.55

			if var_69_9 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_11 = arg_66_1:GetWordFromCfg(111182017)
				local var_69_12 = arg_66_1:FormatText(var_69_11.content)

				arg_66_1.text_.text = var_69_12

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_13 = 22
				local var_69_14 = utf8.len(var_69_12)
				local var_69_15 = var_69_13 <= 0 and var_69_10 or var_69_10 * (var_69_14 / var_69_13)

				if var_69_15 > 0 and var_69_10 < var_69_15 then
					arg_66_1.talkMaxDuration = var_69_15

					if var_69_15 + var_69_9 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_15 + var_69_9
					end
				end

				arg_66_1.text_.text = var_69_12
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_16 = math.max(var_69_10, arg_66_1.talkMaxDuration)

			if var_69_9 <= arg_66_1.time_ and arg_66_1.time_ < var_69_9 + var_69_16 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_9) / var_69_16

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_9 + var_69_16 and arg_66_1.time_ < var_69_9 + var_69_16 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
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

		arg_66_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D05"
	},
	voices = {
		"story_v_out_111182.awb"
	}
}
