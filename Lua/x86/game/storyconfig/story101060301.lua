return {
	Play106031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play106031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "C06b"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = arg_1_1.bgs_.C06b
			local var_4_3 = 0

			if var_4_3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				local var_4_4 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueC06b = var_4_4.color.a
					arg_1_1.var_.alphaMatValueC06b = var_4_4
				end

				arg_1_1.var_.alphaOldValueC06b = 0
			end

			local var_4_5 = 1.5

			if var_4_3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_3 + var_4_5 then
				local var_4_6 = (arg_1_1.time_ - var_4_3) / var_4_5
				local var_4_7 = Mathf.Lerp(arg_1_1.var_.alphaOldValueC06b, 1, var_4_6)

				if arg_1_1.var_.alphaMatValueC06b then
					local var_4_8 = arg_1_1.var_.alphaMatValueC06b.color

					var_4_8.a = var_4_7
					arg_1_1.var_.alphaMatValueC06b.color = var_4_8
				end
			end

			if arg_1_1.time_ >= var_4_3 + var_4_5 and arg_1_1.time_ < var_4_3 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueC06b then
				local var_4_9 = arg_1_1.var_.alphaMatValueC06b
				local var_4_10 = var_4_9.color

				var_4_10.a = 1
				var_4_9.color = var_4_10
			end

			local var_4_11 = 0

			if var_4_11 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				local var_4_12 = manager.ui.mainCamera.transform.localPosition
				local var_4_13 = Vector3.New(0, 0, 10) + Vector3.New(var_4_12.x, var_4_12.y, 0)
				local var_4_14 = arg_1_1.bgs_.C06b

				var_4_14.transform.localPosition = var_4_13
				var_4_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_15 = var_4_14:GetComponent("SpriteRenderer")

				if var_4_15 and var_4_15.sprite then
					local var_4_16 = (var_4_14.transform.localPosition - var_4_12).z
					local var_4_17 = manager.ui.mainCameraCom_
					local var_4_18 = 2 * var_4_16 * Mathf.Tan(var_4_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_19 = var_4_18 * var_4_17.aspect
					local var_4_20 = var_4_15.sprite.bounds.size.x
					local var_4_21 = var_4_15.sprite.bounds.size.y
					local var_4_22 = var_4_19 / var_4_20
					local var_4_23 = var_4_18 / var_4_21
					local var_4_24 = var_4_23 < var_4_22 and var_4_22 or var_4_23

					var_4_14.transform.localScale = Vector3.New(var_4_24, var_4_24, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C06b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_25 = 0
			local var_4_26 = 1

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_27 = "play"
				local var_4_28 = "music"

				arg_1_1:AudioAction(var_4_27, var_4_28, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_29 = ""
				local var_4_30 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_30 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_30 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_30

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_30
						arg_1_1.bgmTxt2_.text = var_4_30
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

			local var_4_31 = 0

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_32 = 1.5

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_33 = 2
			local var_4_34 = 0.15

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

				local var_4_36 = arg_1_1:GetWordFromCfg(106031001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 6
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
	Play106031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 106031002
		arg_8_1.duration_ = 4.63

		local var_8_0 = {
			ja = 4.633,
			ko = 4.4,
			zh = 3.733,
			en = 3.3
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
				arg_8_0:Play106031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1050ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1050ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 then
				arg_8_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_11_6 = 0
			local var_11_7 = 0.4

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_8 = arg_8_1:FormatText(StoryNameCfg[76].name)

				arg_8_1.leftNameTxt_.text = var_11_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_9 = arg_8_1:GetWordFromCfg(106031002)
				local var_11_10 = arg_8_1:FormatText(var_11_9.content)

				arg_8_1.text_.text = var_11_10

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_11 = 16
				local var_11_12 = utf8.len(var_11_10)
				local var_11_13 = var_11_11 <= 0 and var_11_7 or var_11_7 * (var_11_12 / var_11_11)

				if var_11_13 > 0 and var_11_7 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_6
					end
				end

				arg_8_1.text_.text = var_11_10
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106031", "106031002", "story_v_out_106031.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_106031", "106031002", "story_v_out_106031.awb") / 1000

					if var_11_14 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_6
					end

					if var_11_9.prefab_name ~= "" and arg_8_1.actors_[var_11_9.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_9.prefab_name].transform, "story_v_out_106031", "106031002", "story_v_out_106031.awb")

						arg_8_1:RecordAudio("106031002", var_11_15)
						arg_8_1:RecordAudio("106031002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_106031", "106031002", "story_v_out_106031.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_106031", "106031002", "story_v_out_106031.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_7, arg_8_1.talkMaxDuration)

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_6) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_6 + var_11_16 and arg_8_1.time_ < var_11_6 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play106031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 106031003
		arg_12_1.duration_ = 4.47

		local var_12_0 = {
			ja = 3.433,
			ko = 1.5,
			zh = 1.4,
			en = 4.466
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
				arg_12_0:Play106031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1050ui_story"]
			local var_15_1 = 0.0166666666666667

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1050ui_story == nil then
				arg_12_1.var_.characterEffect1050ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1050ui_story and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1050ui_story then
				arg_12_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_15_4 = arg_12_1.actors_["1050ui_story"].transform
			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.var_.moveOldPos1050ui_story = var_15_4.localPosition
			end

			local var_15_6 = 0.001

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 then
				local var_15_7 = (arg_12_1.time_ - var_15_5) / var_15_6
				local var_15_8 = Vector3.New(0, -1, -6.1)

				var_15_4.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1050ui_story, var_15_8, var_15_7)

				local var_15_9 = manager.ui.mainCamera.transform.position - var_15_4.position

				var_15_4.forward = Vector3.New(var_15_9.x, var_15_9.y, var_15_9.z)

				local var_15_10 = var_15_4.localEulerAngles

				var_15_10.z = 0
				var_15_10.x = 0
				var_15_4.localEulerAngles = var_15_10
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 then
				var_15_4.localPosition = Vector3.New(0, -1, -6.1)

				local var_15_11 = manager.ui.mainCamera.transform.position - var_15_4.position

				var_15_4.forward = Vector3.New(var_15_11.x, var_15_11.y, var_15_11.z)

				local var_15_12 = var_15_4.localEulerAngles

				var_15_12.z = 0
				var_15_12.x = 0
				var_15_4.localEulerAngles = var_15_12
			end

			local var_15_13 = 0

			if var_15_13 < arg_12_1.time_ and arg_12_1.time_ <= var_15_13 + arg_15_0 then
				arg_12_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_15_14 = 0
			local var_15_15 = 0.525

			if var_15_14 < arg_12_1.time_ and arg_12_1.time_ <= var_15_14 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_16 = arg_12_1:FormatText(StoryNameCfg[74].name)

				arg_12_1.leftNameTxt_.text = var_15_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_17 = arg_12_1:GetWordFromCfg(106031003)
				local var_15_18 = arg_12_1:FormatText(var_15_17.content)

				arg_12_1.text_.text = var_15_18

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_19 = 21
				local var_15_20 = utf8.len(var_15_18)
				local var_15_21 = var_15_19 <= 0 and var_15_15 or var_15_15 * (var_15_20 / var_15_19)

				if var_15_21 > 0 and var_15_15 < var_15_21 then
					arg_12_1.talkMaxDuration = var_15_21

					if var_15_21 + var_15_14 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_21 + var_15_14
					end
				end

				arg_12_1.text_.text = var_15_18
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106031", "106031003", "story_v_out_106031.awb") ~= 0 then
					local var_15_22 = manager.audio:GetVoiceLength("story_v_out_106031", "106031003", "story_v_out_106031.awb") / 1000

					if var_15_22 + var_15_14 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_22 + var_15_14
					end

					if var_15_17.prefab_name ~= "" and arg_12_1.actors_[var_15_17.prefab_name] ~= nil then
						local var_15_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_17.prefab_name].transform, "story_v_out_106031", "106031003", "story_v_out_106031.awb")

						arg_12_1:RecordAudio("106031003", var_15_23)
						arg_12_1:RecordAudio("106031003", var_15_23)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_106031", "106031003", "story_v_out_106031.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_106031", "106031003", "story_v_out_106031.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_24 = math.max(var_15_15, arg_12_1.talkMaxDuration)

			if var_15_14 <= arg_12_1.time_ and arg_12_1.time_ < var_15_14 + var_15_24 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_14) / var_15_24

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_14 + var_15_24 and arg_12_1.time_ < var_15_14 + var_15_24 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play106031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 106031004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play106031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				local var_19_2 = "play"
				local var_19_3 = "effect"

				arg_16_1:AudioAction(var_19_2, var_19_3, "se_story_6", "se_story_6_snake02", "")
			end

			local var_19_4 = 0
			local var_19_5 = 0.1

			if var_19_4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_6 = arg_16_1:FormatText(StoryNameCfg[77].name)

				arg_16_1.leftNameTxt_.text = var_19_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_7 = arg_16_1:GetWordFromCfg(106031004)
				local var_19_8 = arg_16_1:FormatText(var_19_7.content)

				arg_16_1.text_.text = var_19_8

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 4
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
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_12 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_12 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_12

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_12 and arg_16_1.time_ < var_19_4 + var_19_12 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play106031005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 106031005
		arg_20_1.duration_ = 2.77

		local var_20_0 = {
			ja = 2.1,
			ko = 1.999999999999,
			zh = 2.033,
			en = 2.766
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
				arg_20_0:Play106031006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1050ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1050ui_story == nil then
				arg_20_1.var_.characterEffect1050ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1050ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1050ui_story then
				arg_20_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_23_4 = 0

			if var_23_4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_23_6 = 0
			local var_23_7 = 0.225

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[74].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_9 = arg_20_1:GetWordFromCfg(106031005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_106031", "106031005", "story_v_out_106031.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_106031", "106031005", "story_v_out_106031.awb") / 1000

					if var_23_14 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_6
					end

					if var_23_9.prefab_name ~= "" and arg_20_1.actors_[var_23_9.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_9.prefab_name].transform, "story_v_out_106031", "106031005", "story_v_out_106031.awb")

						arg_20_1:RecordAudio("106031005", var_23_15)
						arg_20_1:RecordAudio("106031005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_106031", "106031005", "story_v_out_106031.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_106031", "106031005", "story_v_out_106031.awb")
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
	Play106031006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 106031006
		arg_24_1.duration_ = 2.47

		local var_24_0 = {
			ja = 2.166,
			ko = 0.999999999999,
			zh = 2.466,
			en = 2.366
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
				arg_24_0:Play106031007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_27_1 = 0
			local var_27_2 = 0.1

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_3 = arg_24_1:FormatText(StoryNameCfg[74].name)

				arg_24_1.leftNameTxt_.text = var_27_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:GetWordFromCfg(106031006)
				local var_27_5 = arg_24_1:FormatText(var_27_4.content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 4
				local var_27_7 = utf8.len(var_27_5)
				local var_27_8 = var_27_6 <= 0 and var_27_2 or var_27_2 * (var_27_7 / var_27_6)

				if var_27_8 > 0 and var_27_2 < var_27_8 then
					arg_24_1.talkMaxDuration = var_27_8

					if var_27_8 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106031", "106031006", "story_v_out_106031.awb") ~= 0 then
					local var_27_9 = manager.audio:GetVoiceLength("story_v_out_106031", "106031006", "story_v_out_106031.awb") / 1000

					if var_27_9 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_1
					end

					if var_27_4.prefab_name ~= "" and arg_24_1.actors_[var_27_4.prefab_name] ~= nil then
						local var_27_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_4.prefab_name].transform, "story_v_out_106031", "106031006", "story_v_out_106031.awb")

						arg_24_1:RecordAudio("106031006", var_27_10)
						arg_24_1:RecordAudio("106031006", var_27_10)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_106031", "106031006", "story_v_out_106031.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_106031", "106031006", "story_v_out_106031.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_11 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_11 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_11

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_11 and arg_24_1.time_ < var_27_1 + var_27_11 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play106031007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 106031007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play106031008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1050ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1050ui_story == nil then
				arg_28_1.var_.characterEffect1050ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1050ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1050ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1050ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1050ui_story.fillRatio = var_31_5
			end

			local var_31_6 = arg_28_1.actors_["1050ui_story"].transform
			local var_31_7 = 0

			if var_31_7 < arg_28_1.time_ and arg_28_1.time_ <= var_31_7 + arg_31_0 then
				arg_28_1.var_.moveOldPos1050ui_story = var_31_6.localPosition
			end

			local var_31_8 = 0.001

			if var_31_7 <= arg_28_1.time_ and arg_28_1.time_ < var_31_7 + var_31_8 then
				local var_31_9 = (arg_28_1.time_ - var_31_7) / var_31_8
				local var_31_10 = Vector3.New(0, 100, 0)

				var_31_6.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1050ui_story, var_31_10, var_31_9)

				local var_31_11 = manager.ui.mainCamera.transform.position - var_31_6.position

				var_31_6.forward = Vector3.New(var_31_11.x, var_31_11.y, var_31_11.z)

				local var_31_12 = var_31_6.localEulerAngles

				var_31_12.z = 0
				var_31_12.x = 0
				var_31_6.localEulerAngles = var_31_12
			end

			if arg_28_1.time_ >= var_31_7 + var_31_8 and arg_28_1.time_ < var_31_7 + var_31_8 + arg_31_0 then
				var_31_6.localPosition = Vector3.New(0, 100, 0)

				local var_31_13 = manager.ui.mainCamera.transform.position - var_31_6.position

				var_31_6.forward = Vector3.New(var_31_13.x, var_31_13.y, var_31_13.z)

				local var_31_14 = var_31_6.localEulerAngles

				var_31_14.z = 0
				var_31_14.x = 0
				var_31_6.localEulerAngles = var_31_14
			end

			local var_31_15 = 0
			local var_31_16 = 0.725

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

				local var_31_17 = arg_28_1:GetWordFromCfg(106031007)
				local var_31_18 = arg_28_1:FormatText(var_31_17.content)

				arg_28_1.text_.text = var_31_18

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_19 = 29
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
				actorName = "1050ui_story",
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
	Play106031008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 106031008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play106031009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 1

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_2 = arg_32_1:GetWordFromCfg(106031008)
				local var_35_3 = arg_32_1:FormatText(var_35_2.content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 40
				local var_35_5 = utf8.len(var_35_3)
				local var_35_6 = var_35_4 <= 0 and var_35_1 or var_35_1 * (var_35_5 / var_35_4)

				if var_35_6 > 0 and var_35_1 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6

					if var_35_6 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_7 and arg_32_1.time_ < var_35_0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play106031009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 106031009
		arg_36_1.duration_ = 2.6

		local var_36_0 = {
			ja = 2.6,
			ko = 2.533,
			zh = 2.266,
			en = 2.2
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
				arg_36_0:Play106031010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.mask_.enabled = true
				arg_36_1.mask_.raycastTarget = true

				arg_36_1:SetGaussion(false)
			end

			local var_39_1 = 0.5

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_1 then
				local var_39_2 = (arg_36_1.time_ - var_39_0) / var_39_1
				local var_39_3 = Color.New(1, 1, 1)

				var_39_3.a = Mathf.Lerp(1, 0, var_39_2)
				arg_36_1.mask_.color = var_39_3
			end

			if arg_36_1.time_ >= var_39_0 + var_39_1 and arg_36_1.time_ < var_39_0 + var_39_1 + arg_39_0 then
				local var_39_4 = Color.New(1, 1, 1)
				local var_39_5 = 0

				arg_36_1.mask_.enabled = false
				var_39_4.a = var_39_5
				arg_36_1.mask_.color = var_39_4
			end

			local var_39_6 = manager.ui.mainCamera.transform
			local var_39_7 = 0

			if var_39_7 < arg_36_1.time_ and arg_36_1.time_ <= var_39_7 + arg_39_0 then
				arg_36_1.var_.shakeOldPosMainCamera = var_39_6.localPosition
			end

			local var_39_8 = 0.600000023841858

			if var_39_7 <= arg_36_1.time_ and arg_36_1.time_ < var_39_7 + var_39_8 then
				local var_39_9 = (arg_36_1.time_ - var_39_7) / 0.066
				local var_39_10, var_39_11 = math.modf(var_39_9)

				var_39_6.localPosition = Vector3.New(var_39_11 * 0.13, var_39_11 * 0.13, var_39_11 * 0.13) + arg_36_1.var_.shakeOldPosMainCamera
			end

			if arg_36_1.time_ >= var_39_7 + var_39_8 and arg_36_1.time_ < var_39_7 + var_39_8 + arg_39_0 then
				var_39_6.localPosition = arg_36_1.var_.shakeOldPosMainCamera
			end

			local var_39_12 = 0
			local var_39_13 = 0.175

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_14 = arg_36_1:FormatText(StoryNameCfg[76].name)

				arg_36_1.leftNameTxt_.text = var_39_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_15 = arg_36_1:GetWordFromCfg(106031009)
				local var_39_16 = arg_36_1:FormatText(var_39_15.content)

				arg_36_1.text_.text = var_39_16

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_106031", "106031009", "story_v_out_106031.awb") ~= 0 then
					local var_39_20 = manager.audio:GetVoiceLength("story_v_out_106031", "106031009", "story_v_out_106031.awb") / 1000

					if var_39_20 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_20 + var_39_12
					end

					if var_39_15.prefab_name ~= "" and arg_36_1.actors_[var_39_15.prefab_name] ~= nil then
						local var_39_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_15.prefab_name].transform, "story_v_out_106031", "106031009", "story_v_out_106031.awb")

						arg_36_1:RecordAudio("106031009", var_39_21)
						arg_36_1:RecordAudio("106031009", var_39_21)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_106031", "106031009", "story_v_out_106031.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_106031", "106031009", "story_v_out_106031.awb")
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
	Play106031010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 106031010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play106031011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.9

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

				local var_43_2 = arg_40_1:GetWordFromCfg(106031010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 36
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
	Play106031011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 106031011
		arg_44_1.duration_ = 3.93

		local var_44_0 = {
			ja = 2.8,
			ko = 3.266,
			zh = 2.933,
			en = 3.933
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
				arg_44_0:Play106031012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1050ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1050ui_story == nil then
				arg_44_1.var_.characterEffect1050ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1050ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1050ui_story then
				arg_44_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["1050ui_story"].transform
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.var_.moveOldPos1050ui_story = var_47_4.localPosition
			end

			local var_47_6 = 0.001

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6
				local var_47_8 = Vector3.New(0, -1, -6.1)

				var_47_4.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1050ui_story, var_47_8, var_47_7)

				local var_47_9 = manager.ui.mainCamera.transform.position - var_47_4.position

				var_47_4.forward = Vector3.New(var_47_9.x, var_47_9.y, var_47_9.z)

				local var_47_10 = var_47_4.localEulerAngles

				var_47_10.z = 0
				var_47_10.x = 0
				var_47_4.localEulerAngles = var_47_10
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 then
				var_47_4.localPosition = Vector3.New(0, -1, -6.1)

				local var_47_11 = manager.ui.mainCamera.transform.position - var_47_4.position

				var_47_4.forward = Vector3.New(var_47_11.x, var_47_11.y, var_47_11.z)

				local var_47_12 = var_47_4.localEulerAngles

				var_47_12.z = 0
				var_47_12.x = 0
				var_47_4.localEulerAngles = var_47_12
			end

			local var_47_13 = 0

			if var_47_13 < arg_44_1.time_ and arg_44_1.time_ <= var_47_13 + arg_47_0 then
				arg_44_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			local var_47_14 = 0

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_47_15 = 0
			local var_47_16 = 0.325

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_17 = arg_44_1:FormatText(StoryNameCfg[74].name)

				arg_44_1.leftNameTxt_.text = var_47_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_18 = arg_44_1:GetWordFromCfg(106031011)
				local var_47_19 = arg_44_1:FormatText(var_47_18.content)

				arg_44_1.text_.text = var_47_19

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_20 = 13
				local var_47_21 = utf8.len(var_47_19)
				local var_47_22 = var_47_20 <= 0 and var_47_16 or var_47_16 * (var_47_21 / var_47_20)

				if var_47_22 > 0 and var_47_16 < var_47_22 then
					arg_44_1.talkMaxDuration = var_47_22

					if var_47_22 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_22 + var_47_15
					end
				end

				arg_44_1.text_.text = var_47_19
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106031", "106031011", "story_v_out_106031.awb") ~= 0 then
					local var_47_23 = manager.audio:GetVoiceLength("story_v_out_106031", "106031011", "story_v_out_106031.awb") / 1000

					if var_47_23 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_15
					end

					if var_47_18.prefab_name ~= "" and arg_44_1.actors_[var_47_18.prefab_name] ~= nil then
						local var_47_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_18.prefab_name].transform, "story_v_out_106031", "106031011", "story_v_out_106031.awb")

						arg_44_1:RecordAudio("106031011", var_47_24)
						arg_44_1:RecordAudio("106031011", var_47_24)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_106031", "106031011", "story_v_out_106031.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_106031", "106031011", "story_v_out_106031.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_25 = math.max(var_47_16, arg_44_1.talkMaxDuration)

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_25 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_15) / var_47_25

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_15 + var_47_25 and arg_44_1.time_ < var_47_15 + var_47_25 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play106031012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 106031012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play106031013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1050ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1050ui_story == nil then
				arg_48_1.var_.characterEffect1050ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1050ui_story and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1050ui_story.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1050ui_story then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1050ui_story.fillRatio = var_51_5
			end

			local var_51_6 = manager.ui.mainCamera.transform
			local var_51_7 = 0

			if var_51_7 < arg_48_1.time_ and arg_48_1.time_ <= var_51_7 + arg_51_0 then
				arg_48_1.var_.shakeOldPosMainCamera = var_51_6.localPosition
			end

			local var_51_8 = 0.600000023841858

			if var_51_7 <= arg_48_1.time_ and arg_48_1.time_ < var_51_7 + var_51_8 then
				local var_51_9 = (arg_48_1.time_ - var_51_7) / 0.066
				local var_51_10, var_51_11 = math.modf(var_51_9)

				var_51_6.localPosition = Vector3.New(var_51_11 * 0.13, var_51_11 * 0.13, var_51_11 * 0.13) + arg_48_1.var_.shakeOldPosMainCamera
			end

			if arg_48_1.time_ >= var_51_7 + var_51_8 and arg_48_1.time_ < var_51_7 + var_51_8 + arg_51_0 then
				var_51_6.localPosition = arg_48_1.var_.shakeOldPosMainCamera
			end

			local var_51_12 = arg_48_1.actors_["1050ui_story"].transform
			local var_51_13 = 0

			if var_51_13 < arg_48_1.time_ and arg_48_1.time_ <= var_51_13 + arg_51_0 then
				arg_48_1.var_.moveOldPos1050ui_story = var_51_12.localPosition
			end

			local var_51_14 = 0.001

			if var_51_13 <= arg_48_1.time_ and arg_48_1.time_ < var_51_13 + var_51_14 then
				local var_51_15 = (arg_48_1.time_ - var_51_13) / var_51_14
				local var_51_16 = Vector3.New(0, 100, 0)

				var_51_12.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1050ui_story, var_51_16, var_51_15)

				local var_51_17 = manager.ui.mainCamera.transform.position - var_51_12.position

				var_51_12.forward = Vector3.New(var_51_17.x, var_51_17.y, var_51_17.z)

				local var_51_18 = var_51_12.localEulerAngles

				var_51_18.z = 0
				var_51_18.x = 0
				var_51_12.localEulerAngles = var_51_18
			end

			if arg_48_1.time_ >= var_51_13 + var_51_14 and arg_48_1.time_ < var_51_13 + var_51_14 + arg_51_0 then
				var_51_12.localPosition = Vector3.New(0, 100, 0)

				local var_51_19 = manager.ui.mainCamera.transform.position - var_51_12.position

				var_51_12.forward = Vector3.New(var_51_19.x, var_51_19.y, var_51_19.z)

				local var_51_20 = var_51_12.localEulerAngles

				var_51_20.z = 0
				var_51_20.x = 0
				var_51_12.localEulerAngles = var_51_20
			end

			local var_51_21 = 1
			local var_51_22 = 1

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 then
				local var_51_23 = "play"
				local var_51_24 = "effect"

				arg_48_1:AudioAction(var_51_23, var_51_24, "se_story_6", "se_story_6_split_flash", "")
			end

			local var_51_25 = 0
			local var_51_26 = 1.3

			if var_51_25 < arg_48_1.time_ and arg_48_1.time_ <= var_51_25 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_27 = arg_48_1:GetWordFromCfg(106031012)
				local var_51_28 = arg_48_1:FormatText(var_51_27.content)

				arg_48_1.text_.text = var_51_28

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_29 = 52
				local var_51_30 = utf8.len(var_51_28)
				local var_51_31 = var_51_29 <= 0 and var_51_26 or var_51_26 * (var_51_30 / var_51_29)

				if var_51_31 > 0 and var_51_26 < var_51_31 then
					arg_48_1.talkMaxDuration = var_51_31

					if var_51_31 + var_51_25 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_31 + var_51_25
					end
				end

				arg_48_1.text_.text = var_51_28
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_32 = math.max(var_51_26, arg_48_1.talkMaxDuration)

			if var_51_25 <= arg_48_1.time_ and arg_48_1.time_ < var_51_25 + var_51_32 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_25) / var_51_32

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_25 + var_51_32 and arg_48_1.time_ < var_51_25 + var_51_32 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play106031013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 106031013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play106031014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 1.05

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(106031013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 42
				local var_55_5 = utf8.len(var_55_3)
				local var_55_6 = var_55_4 <= 0 and var_55_1 or var_55_1 * (var_55_5 / var_55_4)

				if var_55_6 > 0 and var_55_1 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_7 and arg_52_1.time_ < var_55_0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play106031014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 106031014
		arg_56_1.duration_ = 3.1

		local var_56_0 = {
			ja = 2.8,
			ko = 2.6,
			zh = 3.1,
			en = 2.9
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
				arg_56_0:Play106031015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = "2032_tpose"

			if arg_56_1.actors_[var_59_0] == nil then
				local var_59_1 = Asset.Load("Char/" .. "2032_tpose")

				if not isNil(var_59_1) then
					local var_59_2 = Object.Instantiate(Asset.Load("Char/" .. "2032_tpose"), arg_56_1.stage_.transform)

					var_59_2.name = var_59_0
					var_59_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_56_1.actors_[var_59_0] = var_59_2

					local var_59_3 = var_59_2:GetComponentInChildren(typeof(CharacterEffect))

					var_59_3.enabled = true

					local var_59_4 = GameObjectTools.GetOrAddComponent(var_59_2, typeof(DynamicBoneHelper))

					if var_59_4 then
						var_59_4:EnableDynamicBone(false)
					end

					arg_56_1:ShowWeapon(var_59_3.transform, false)

					arg_56_1.var_[var_59_0 .. "Animator"] = var_59_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_56_1.var_[var_59_0 .. "Animator"].applyRootMotion = true
					arg_56_1.var_[var_59_0 .. "LipSync"] = var_59_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_59_5 = arg_56_1.actors_["2032_tpose"]
			local var_59_6 = 0

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 and not isNil(var_59_5) and arg_56_1.var_.characterEffect2032_tpose == nil then
				arg_56_1.var_.characterEffect2032_tpose = var_59_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_7 = 0.1

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_7 and not isNil(var_59_5) then
				local var_59_8 = (arg_56_1.time_ - var_59_6) / var_59_7

				if arg_56_1.var_.characterEffect2032_tpose and not isNil(var_59_5) then
					arg_56_1.var_.characterEffect2032_tpose.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_6 + var_59_7 and arg_56_1.time_ < var_59_6 + var_59_7 + arg_59_0 and not isNil(var_59_5) and arg_56_1.var_.characterEffect2032_tpose then
				arg_56_1.var_.characterEffect2032_tpose.fillFlat = false
			end

			local var_59_9 = arg_56_1.actors_["2032_tpose"].transform
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.var_.moveOldPos2032_tpose = var_59_9.localPosition

				local var_59_11 = GameObjectTools.GetOrAddComponent(var_59_9.gameObject, typeof(DynamicBoneHelper))

				if var_59_11 then
					var_59_11:EnableDynamicBone(false)
				end
			end

			local var_59_12 = 0.001

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_12 then
				local var_59_13 = (arg_56_1.time_ - var_59_10) / var_59_12
				local var_59_14 = Vector3.New(-0.7, -1.15, -4.2)

				var_59_9.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos2032_tpose, var_59_14, var_59_13)

				local var_59_15 = manager.ui.mainCamera.transform.position - var_59_9.position

				var_59_9.forward = Vector3.New(var_59_15.x, var_59_15.y, var_59_15.z)

				local var_59_16 = var_59_9.localEulerAngles

				var_59_16.z = 0
				var_59_16.x = 0
				var_59_9.localEulerAngles = var_59_16
			end

			if arg_56_1.time_ >= var_59_10 + var_59_12 and arg_56_1.time_ < var_59_10 + var_59_12 + arg_59_0 then
				var_59_9.localPosition = Vector3.New(-0.7, -1.15, -4.2)

				local var_59_17 = manager.ui.mainCamera.transform.position - var_59_9.position

				var_59_9.forward = Vector3.New(var_59_17.x, var_59_17.y, var_59_17.z)

				local var_59_18 = var_59_9.localEulerAngles

				var_59_18.z = 0
				var_59_18.x = 0
				var_59_9.localEulerAngles = var_59_18

				local var_59_19 = GameObjectTools.GetOrAddComponent(var_59_9.gameObject, typeof(DynamicBoneHelper))

				if var_59_19 then
					var_59_19:EnableDynamicBone(true)
				end
			end

			local var_59_20 = 0

			if var_59_20 < arg_56_1.time_ and arg_56_1.time_ <= var_59_20 + arg_59_0 then
				arg_56_1:PlayTimeline("2032_tpose", "StoryTimeline/CharAction/story2032/story2032action/2032action1_1")
			end

			local var_59_21 = "2033_tpose"

			if arg_56_1.actors_[var_59_21] == nil then
				local var_59_22 = Asset.Load("Char/" .. "2033_tpose")

				if not isNil(var_59_22) then
					local var_59_23 = Object.Instantiate(Asset.Load("Char/" .. "2033_tpose"), arg_56_1.stage_.transform)

					var_59_23.name = var_59_21
					var_59_23.transform.localPosition = Vector3.New(0, 100, 0)
					arg_56_1.actors_[var_59_21] = var_59_23

					local var_59_24 = var_59_23:GetComponentInChildren(typeof(CharacterEffect))

					var_59_24.enabled = true

					local var_59_25 = GameObjectTools.GetOrAddComponent(var_59_23, typeof(DynamicBoneHelper))

					if var_59_25 then
						var_59_25:EnableDynamicBone(false)
					end

					arg_56_1:ShowWeapon(var_59_24.transform, false)

					arg_56_1.var_[var_59_21 .. "Animator"] = var_59_24.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_56_1.var_[var_59_21 .. "Animator"].applyRootMotion = true
					arg_56_1.var_[var_59_21 .. "LipSync"] = var_59_24.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_59_26 = arg_56_1.actors_["2033_tpose"].transform
			local var_59_27 = 0

			if var_59_27 < arg_56_1.time_ and arg_56_1.time_ <= var_59_27 + arg_59_0 then
				arg_56_1.var_.moveOldPos2033_tpose = var_59_26.localPosition

				local var_59_28 = GameObjectTools.GetOrAddComponent(var_59_26.gameObject, typeof(DynamicBoneHelper))

				if var_59_28 then
					var_59_28:EnableDynamicBone(false)
				end
			end

			local var_59_29 = 0.001

			if var_59_27 <= arg_56_1.time_ and arg_56_1.time_ < var_59_27 + var_59_29 then
				local var_59_30 = (arg_56_1.time_ - var_59_27) / var_59_29
				local var_59_31 = Vector3.New(0.7, -1.37, -4.9)

				var_59_26.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos2033_tpose, var_59_31, var_59_30)

				local var_59_32 = manager.ui.mainCamera.transform.position - var_59_26.position

				var_59_26.forward = Vector3.New(var_59_32.x, var_59_32.y, var_59_32.z)

				local var_59_33 = var_59_26.localEulerAngles

				var_59_33.z = 0
				var_59_33.x = 0
				var_59_26.localEulerAngles = var_59_33
			end

			if arg_56_1.time_ >= var_59_27 + var_59_29 and arg_56_1.time_ < var_59_27 + var_59_29 + arg_59_0 then
				var_59_26.localPosition = Vector3.New(0.7, -1.37, -4.9)

				local var_59_34 = manager.ui.mainCamera.transform.position - var_59_26.position

				var_59_26.forward = Vector3.New(var_59_34.x, var_59_34.y, var_59_34.z)

				local var_59_35 = var_59_26.localEulerAngles

				var_59_35.z = 0
				var_59_35.x = 0
				var_59_26.localEulerAngles = var_59_35

				local var_59_36 = GameObjectTools.GetOrAddComponent(var_59_26.gameObject, typeof(DynamicBoneHelper))

				if var_59_36 then
					var_59_36:EnableDynamicBone(true)
				end
			end

			local var_59_37 = 0

			if var_59_37 < arg_56_1.time_ and arg_56_1.time_ <= var_59_37 + arg_59_0 then
				arg_56_1:PlayTimeline("2033_tpose", "StoryTimeline/CharAction/story2033/story2033action/2033action1_1")
			end

			local var_59_38 = 0
			local var_59_39 = 0.175

			if var_59_38 < arg_56_1.time_ and arg_56_1.time_ <= var_59_38 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_40 = arg_56_1:FormatText(StoryNameCfg[78].name)

				arg_56_1.leftNameTxt_.text = var_59_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_41 = arg_56_1:GetWordFromCfg(106031014)
				local var_59_42 = arg_56_1:FormatText(var_59_41.content)

				arg_56_1.text_.text = var_59_42

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_43 = 7
				local var_59_44 = utf8.len(var_59_42)
				local var_59_45 = var_59_43 <= 0 and var_59_39 or var_59_39 * (var_59_44 / var_59_43)

				if var_59_45 > 0 and var_59_39 < var_59_45 then
					arg_56_1.talkMaxDuration = var_59_45

					if var_59_45 + var_59_38 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_45 + var_59_38
					end
				end

				arg_56_1.text_.text = var_59_42
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106031", "106031014", "story_v_out_106031.awb") ~= 0 then
					local var_59_46 = manager.audio:GetVoiceLength("story_v_out_106031", "106031014", "story_v_out_106031.awb") / 1000

					if var_59_46 + var_59_38 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_46 + var_59_38
					end

					if var_59_41.prefab_name ~= "" and arg_56_1.actors_[var_59_41.prefab_name] ~= nil then
						local var_59_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_41.prefab_name].transform, "story_v_out_106031", "106031014", "story_v_out_106031.awb")

						arg_56_1:RecordAudio("106031014", var_59_47)
						arg_56_1:RecordAudio("106031014", var_59_47)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_106031", "106031014", "story_v_out_106031.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_106031", "106031014", "story_v_out_106031.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_48 = math.max(var_59_39, arg_56_1.talkMaxDuration)

			if var_59_38 <= arg_56_1.time_ and arg_56_1.time_ < var_59_38 + var_59_48 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_38) / var_59_48

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_38 + var_59_48 and arg_56_1.time_ < var_59_38 + var_59_48 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2032_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2033_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play106031015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 106031015
		arg_60_1.duration_ = 2.27

		local var_60_0 = {
			ja = 1.633,
			ko = 1.8,
			zh = 2.266,
			en = 2.066
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
				arg_60_0:Play106031016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["2033_tpose"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect2033_tpose == nil then
				arg_60_1.var_.characterEffect2033_tpose = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect2033_tpose and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect2033_tpose.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect2033_tpose then
				arg_60_1.var_.characterEffect2033_tpose.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["2032_tpose"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect2032_tpose == nil then
				arg_60_1.var_.characterEffect2032_tpose = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.1

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect2032_tpose and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect2032_tpose.fillFlat = true
					arg_60_1.var_.characterEffect2032_tpose.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect2032_tpose then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect2032_tpose.fillFlat = true
				arg_60_1.var_.characterEffect2032_tpose.fillRatio = var_63_9
			end

			local var_63_10 = 0
			local var_63_11 = 0.15

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_12 = arg_60_1:FormatText(StoryNameCfg[79].name)

				arg_60_1.leftNameTxt_.text = var_63_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_13 = arg_60_1:GetWordFromCfg(106031015)
				local var_63_14 = arg_60_1:FormatText(var_63_13.content)

				arg_60_1.text_.text = var_63_14

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_15 = 6
				local var_63_16 = utf8.len(var_63_14)
				local var_63_17 = var_63_15 <= 0 and var_63_11 or var_63_11 * (var_63_16 / var_63_15)

				if var_63_17 > 0 and var_63_11 < var_63_17 then
					arg_60_1.talkMaxDuration = var_63_17

					if var_63_17 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_17 + var_63_10
					end
				end

				arg_60_1.text_.text = var_63_14
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106031", "106031015", "story_v_out_106031.awb") ~= 0 then
					local var_63_18 = manager.audio:GetVoiceLength("story_v_out_106031", "106031015", "story_v_out_106031.awb") / 1000

					if var_63_18 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_18 + var_63_10
					end

					if var_63_13.prefab_name ~= "" and arg_60_1.actors_[var_63_13.prefab_name] ~= nil then
						local var_63_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_13.prefab_name].transform, "story_v_out_106031", "106031015", "story_v_out_106031.awb")

						arg_60_1:RecordAudio("106031015", var_63_19)
						arg_60_1:RecordAudio("106031015", var_63_19)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_106031", "106031015", "story_v_out_106031.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_106031", "106031015", "story_v_out_106031.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_20 = math.max(var_63_11, arg_60_1.talkMaxDuration)

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_20 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_10) / var_63_20

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_10 + var_63_20 and arg_60_1.time_ < var_63_10 + var_63_20 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play106031016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 106031016
		arg_64_1.duration_ = 3.53

		local var_64_0 = {
			ja = 2.6,
			ko = 3.2,
			zh = 2.533,
			en = 3.533
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
				arg_64_0:Play106031017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1050ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1050ui_story == nil then
				arg_64_1.var_.characterEffect1050ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1050ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1050ui_story then
				arg_64_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["2033_tpose"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect2033_tpose == nil then
				arg_64_1.var_.characterEffect2033_tpose = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect2033_tpose and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect2033_tpose.fillFlat = true
					arg_64_1.var_.characterEffect2033_tpose.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect2033_tpose then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect2033_tpose.fillFlat = true
				arg_64_1.var_.characterEffect2033_tpose.fillRatio = var_67_9
			end

			local var_67_10 = arg_64_1.actors_["2032_tpose"].transform
			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.var_.moveOldPos2032_tpose = var_67_10.localPosition

				local var_67_12 = GameObjectTools.GetOrAddComponent(var_67_10.gameObject, typeof(DynamicBoneHelper))

				if var_67_12 then
					var_67_12:EnableDynamicBone(false)
				end
			end

			local var_67_13 = 0.001

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_13 then
				local var_67_14 = (arg_64_1.time_ - var_67_11) / var_67_13
				local var_67_15 = Vector3.New(0, 100, 0)

				var_67_10.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos2032_tpose, var_67_15, var_67_14)

				local var_67_16 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_16.x, var_67_16.y, var_67_16.z)

				local var_67_17 = var_67_10.localEulerAngles

				var_67_17.z = 0
				var_67_17.x = 0
				var_67_10.localEulerAngles = var_67_17
			end

			if arg_64_1.time_ >= var_67_11 + var_67_13 and arg_64_1.time_ < var_67_11 + var_67_13 + arg_67_0 then
				var_67_10.localPosition = Vector3.New(0, 100, 0)

				local var_67_18 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_18.x, var_67_18.y, var_67_18.z)

				local var_67_19 = var_67_10.localEulerAngles

				var_67_19.z = 0
				var_67_19.x = 0
				var_67_10.localEulerAngles = var_67_19

				local var_67_20 = GameObjectTools.GetOrAddComponent(var_67_10.gameObject, typeof(DynamicBoneHelper))

				if var_67_20 then
					var_67_20:EnableDynamicBone(true)
				end
			end

			local var_67_21 = arg_64_1.actors_["2033_tpose"].transform
			local var_67_22 = 0

			if var_67_22 < arg_64_1.time_ and arg_64_1.time_ <= var_67_22 + arg_67_0 then
				arg_64_1.var_.moveOldPos2033_tpose = var_67_21.localPosition

				local var_67_23 = GameObjectTools.GetOrAddComponent(var_67_21.gameObject, typeof(DynamicBoneHelper))

				if var_67_23 then
					var_67_23:EnableDynamicBone(false)
				end
			end

			local var_67_24 = 0.001

			if var_67_22 <= arg_64_1.time_ and arg_64_1.time_ < var_67_22 + var_67_24 then
				local var_67_25 = (arg_64_1.time_ - var_67_22) / var_67_24
				local var_67_26 = Vector3.New(0, 100, 0)

				var_67_21.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos2033_tpose, var_67_26, var_67_25)

				local var_67_27 = manager.ui.mainCamera.transform.position - var_67_21.position

				var_67_21.forward = Vector3.New(var_67_27.x, var_67_27.y, var_67_27.z)

				local var_67_28 = var_67_21.localEulerAngles

				var_67_28.z = 0
				var_67_28.x = 0
				var_67_21.localEulerAngles = var_67_28
			end

			if arg_64_1.time_ >= var_67_22 + var_67_24 and arg_64_1.time_ < var_67_22 + var_67_24 + arg_67_0 then
				var_67_21.localPosition = Vector3.New(0, 100, 0)

				local var_67_29 = manager.ui.mainCamera.transform.position - var_67_21.position

				var_67_21.forward = Vector3.New(var_67_29.x, var_67_29.y, var_67_29.z)

				local var_67_30 = var_67_21.localEulerAngles

				var_67_30.z = 0
				var_67_30.x = 0
				var_67_21.localEulerAngles = var_67_30

				local var_67_31 = GameObjectTools.GetOrAddComponent(var_67_21.gameObject, typeof(DynamicBoneHelper))

				if var_67_31 then
					var_67_31:EnableDynamicBone(true)
				end
			end

			local var_67_32 = 0

			if var_67_32 < arg_64_1.time_ and arg_64_1.time_ <= var_67_32 + arg_67_0 then
				arg_64_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			local var_67_33 = arg_64_1.actors_["1050ui_story"].transform
			local var_67_34 = 0

			if var_67_34 < arg_64_1.time_ and arg_64_1.time_ <= var_67_34 + arg_67_0 then
				arg_64_1.var_.moveOldPos1050ui_story = var_67_33.localPosition
			end

			local var_67_35 = 0.001

			if var_67_34 <= arg_64_1.time_ and arg_64_1.time_ < var_67_34 + var_67_35 then
				local var_67_36 = (arg_64_1.time_ - var_67_34) / var_67_35
				local var_67_37 = Vector3.New(0, -1, -6.1)

				var_67_33.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1050ui_story, var_67_37, var_67_36)

				local var_67_38 = manager.ui.mainCamera.transform.position - var_67_33.position

				var_67_33.forward = Vector3.New(var_67_38.x, var_67_38.y, var_67_38.z)

				local var_67_39 = var_67_33.localEulerAngles

				var_67_39.z = 0
				var_67_39.x = 0
				var_67_33.localEulerAngles = var_67_39
			end

			if arg_64_1.time_ >= var_67_34 + var_67_35 and arg_64_1.time_ < var_67_34 + var_67_35 + arg_67_0 then
				var_67_33.localPosition = Vector3.New(0, -1, -6.1)

				local var_67_40 = manager.ui.mainCamera.transform.position - var_67_33.position

				var_67_33.forward = Vector3.New(var_67_40.x, var_67_40.y, var_67_40.z)

				local var_67_41 = var_67_33.localEulerAngles

				var_67_41.z = 0
				var_67_41.x = 0
				var_67_33.localEulerAngles = var_67_41
			end

			local var_67_42 = 0

			if var_67_42 < arg_64_1.time_ and arg_64_1.time_ <= var_67_42 + arg_67_0 then
				arg_64_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_67_43 = 0
			local var_67_44 = 0.325

			if var_67_43 < arg_64_1.time_ and arg_64_1.time_ <= var_67_43 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_45 = arg_64_1:FormatText(StoryNameCfg[74].name)

				arg_64_1.leftNameTxt_.text = var_67_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_46 = arg_64_1:GetWordFromCfg(106031016)
				local var_67_47 = arg_64_1:FormatText(var_67_46.content)

				arg_64_1.text_.text = var_67_47

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_48 = 13
				local var_67_49 = utf8.len(var_67_47)
				local var_67_50 = var_67_48 <= 0 and var_67_44 or var_67_44 * (var_67_49 / var_67_48)

				if var_67_50 > 0 and var_67_44 < var_67_50 then
					arg_64_1.talkMaxDuration = var_67_50

					if var_67_50 + var_67_43 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_50 + var_67_43
					end
				end

				arg_64_1.text_.text = var_67_47
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106031", "106031016", "story_v_out_106031.awb") ~= 0 then
					local var_67_51 = manager.audio:GetVoiceLength("story_v_out_106031", "106031016", "story_v_out_106031.awb") / 1000

					if var_67_51 + var_67_43 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_51 + var_67_43
					end

					if var_67_46.prefab_name ~= "" and arg_64_1.actors_[var_67_46.prefab_name] ~= nil then
						local var_67_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_46.prefab_name].transform, "story_v_out_106031", "106031016", "story_v_out_106031.awb")

						arg_64_1:RecordAudio("106031016", var_67_52)
						arg_64_1:RecordAudio("106031016", var_67_52)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_106031", "106031016", "story_v_out_106031.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_106031", "106031016", "story_v_out_106031.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_53 = math.max(var_67_44, arg_64_1.talkMaxDuration)

			if var_67_43 <= arg_64_1.time_ and arg_64_1.time_ < var_67_43 + var_67_53 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_43) / var_67_53

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_43 + var_67_53 and arg_64_1.time_ < var_67_43 + var_67_53 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2032_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2033_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play106031017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 106031017
		arg_68_1.duration_ = 3.57

		local var_68_0 = {
			ja = 2.7,
			ko = 2.6,
			zh = 3.2,
			en = 3.566
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
				arg_68_0:Play106031018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action6_1")
			end

			local var_71_1 = arg_68_1.actors_["1050ui_story"].transform
			local var_71_2 = 0

			if var_71_2 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.var_.moveOldPos1050ui_story = var_71_1.localPosition

				local var_71_3 = "1050ui_story"

				arg_68_1:ShowWeapon(arg_68_1.var_[var_71_3 .. "Animator"].transform, true)
			end

			local var_71_4 = 0.1

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_4 then
				local var_71_5 = (arg_68_1.time_ - var_71_2) / var_71_4
				local var_71_6 = Vector3.New(0, -1, -6.1)

				var_71_1.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1050ui_story, var_71_6, var_71_5)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_1.position

				var_71_1.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_1.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_1.localEulerAngles = var_71_8
			end

			if arg_68_1.time_ >= var_71_2 + var_71_4 and arg_68_1.time_ < var_71_2 + var_71_4 + arg_71_0 then
				var_71_1.localPosition = Vector3.New(0, -1, -6.1)

				local var_71_9 = manager.ui.mainCamera.transform.position - var_71_1.position

				var_71_1.forward = Vector3.New(var_71_9.x, var_71_9.y, var_71_9.z)

				local var_71_10 = var_71_1.localEulerAngles

				var_71_10.z = 0
				var_71_10.x = 0
				var_71_1.localEulerAngles = var_71_10
			end

			local var_71_11 = 0

			if var_71_11 < arg_68_1.time_ and arg_68_1.time_ <= var_71_11 + arg_71_0 then
				arg_68_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_71_12 = 0
			local var_71_13 = 0.325

			if var_71_12 < arg_68_1.time_ and arg_68_1.time_ <= var_71_12 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_14 = arg_68_1:FormatText(StoryNameCfg[74].name)

				arg_68_1.leftNameTxt_.text = var_71_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_15 = arg_68_1:GetWordFromCfg(106031017)
				local var_71_16 = arg_68_1:FormatText(var_71_15.content)

				arg_68_1.text_.text = var_71_16

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_17 = 13
				local var_71_18 = utf8.len(var_71_16)
				local var_71_19 = var_71_17 <= 0 and var_71_13 or var_71_13 * (var_71_18 / var_71_17)

				if var_71_19 > 0 and var_71_13 < var_71_19 then
					arg_68_1.talkMaxDuration = var_71_19

					if var_71_19 + var_71_12 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_19 + var_71_12
					end
				end

				arg_68_1.text_.text = var_71_16
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106031", "106031017", "story_v_out_106031.awb") ~= 0 then
					local var_71_20 = manager.audio:GetVoiceLength("story_v_out_106031", "106031017", "story_v_out_106031.awb") / 1000

					if var_71_20 + var_71_12 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_20 + var_71_12
					end

					if var_71_15.prefab_name ~= "" and arg_68_1.actors_[var_71_15.prefab_name] ~= nil then
						local var_71_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_15.prefab_name].transform, "story_v_out_106031", "106031017", "story_v_out_106031.awb")

						arg_68_1:RecordAudio("106031017", var_71_21)
						arg_68_1:RecordAudio("106031017", var_71_21)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_106031", "106031017", "story_v_out_106031.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_106031", "106031017", "story_v_out_106031.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_22 = math.max(var_71_13, arg_68_1.talkMaxDuration)

			if var_71_12 <= arg_68_1.time_ and arg_68_1.time_ < var_71_12 + var_71_22 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_12) / var_71_22

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_12 + var_71_22 and arg_68_1.time_ < var_71_12 + var_71_22 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play106031018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 106031018
		arg_72_1.duration_ = 6.5

		local var_72_0 = {
			ja = 5.566,
			ko = 6.5,
			zh = 6.033,
			en = 5.633
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
				arg_72_0:Play106031019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1050ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1050ui_story == nil then
				arg_72_1.var_.characterEffect1050ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1050ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1050ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1050ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1050ui_story.fillRatio = var_75_5
			end

			local var_75_6 = arg_72_1.actors_["1050ui_story"].transform
			local var_75_7 = 0

			if var_75_7 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 then
				arg_72_1.var_.moveOldPos1050ui_story = var_75_6.localPosition
			end

			local var_75_8 = 0.001

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_8 then
				local var_75_9 = (arg_72_1.time_ - var_75_7) / var_75_8
				local var_75_10 = Vector3.New(0, 100, 0)

				var_75_6.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1050ui_story, var_75_10, var_75_9)

				local var_75_11 = manager.ui.mainCamera.transform.position - var_75_6.position

				var_75_6.forward = Vector3.New(var_75_11.x, var_75_11.y, var_75_11.z)

				local var_75_12 = var_75_6.localEulerAngles

				var_75_12.z = 0
				var_75_12.x = 0
				var_75_6.localEulerAngles = var_75_12
			end

			if arg_72_1.time_ >= var_75_7 + var_75_8 and arg_72_1.time_ < var_75_7 + var_75_8 + arg_75_0 then
				var_75_6.localPosition = Vector3.New(0, 100, 0)

				local var_75_13 = manager.ui.mainCamera.transform.position - var_75_6.position

				var_75_6.forward = Vector3.New(var_75_13.x, var_75_13.y, var_75_13.z)

				local var_75_14 = var_75_6.localEulerAngles

				var_75_14.z = 0
				var_75_14.x = 0
				var_75_6.localEulerAngles = var_75_14
			end

			local var_75_15 = 0
			local var_75_16 = 0.7

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_17 = arg_72_1:FormatText(StoryNameCfg[76].name)

				arg_72_1.leftNameTxt_.text = var_75_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_18 = arg_72_1:GetWordFromCfg(106031018)
				local var_75_19 = arg_72_1:FormatText(var_75_18.content)

				arg_72_1.text_.text = var_75_19

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_20 = 28
				local var_75_21 = utf8.len(var_75_19)
				local var_75_22 = var_75_20 <= 0 and var_75_16 or var_75_16 * (var_75_21 / var_75_20)

				if var_75_22 > 0 and var_75_16 < var_75_22 then
					arg_72_1.talkMaxDuration = var_75_22

					if var_75_22 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_22 + var_75_15
					end
				end

				arg_72_1.text_.text = var_75_19
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106031", "106031018", "story_v_out_106031.awb") ~= 0 then
					local var_75_23 = manager.audio:GetVoiceLength("story_v_out_106031", "106031018", "story_v_out_106031.awb") / 1000

					if var_75_23 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_23 + var_75_15
					end

					if var_75_18.prefab_name ~= "" and arg_72_1.actors_[var_75_18.prefab_name] ~= nil then
						local var_75_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_18.prefab_name].transform, "story_v_out_106031", "106031018", "story_v_out_106031.awb")

						arg_72_1:RecordAudio("106031018", var_75_24)
						arg_72_1:RecordAudio("106031018", var_75_24)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_106031", "106031018", "story_v_out_106031.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_106031", "106031018", "story_v_out_106031.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_25 = math.max(var_75_16, arg_72_1.talkMaxDuration)

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_25 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_15) / var_75_25

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_15 + var_75_25 and arg_72_1.time_ < var_75_15 + var_75_25 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
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
	Play106031019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 106031019
		arg_76_1.duration_ = 3

		local var_76_0 = {
			ja = 3,
			ko = 2.733,
			zh = 2.366,
			en = 2.7
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
				arg_76_0:Play106031020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["2032_tpose"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect2032_tpose == nil then
				arg_76_1.var_.characterEffect2032_tpose = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect2032_tpose and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect2032_tpose.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect2032_tpose then
				arg_76_1.var_.characterEffect2032_tpose.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["2032_tpose"].transform
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 then
				arg_76_1.var_.moveOldPos2032_tpose = var_79_4.localPosition

				local var_79_6 = GameObjectTools.GetOrAddComponent(var_79_4.gameObject, typeof(DynamicBoneHelper))

				if var_79_6 then
					var_79_6:EnableDynamicBone(false)
				end
			end

			local var_79_7 = 0.001

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_7 then
				local var_79_8 = (arg_76_1.time_ - var_79_5) / var_79_7
				local var_79_9 = Vector3.New(-0.7, -1.15, -4.2)

				var_79_4.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos2032_tpose, var_79_9, var_79_8)

				local var_79_10 = manager.ui.mainCamera.transform.position - var_79_4.position

				var_79_4.forward = Vector3.New(var_79_10.x, var_79_10.y, var_79_10.z)

				local var_79_11 = var_79_4.localEulerAngles

				var_79_11.z = 0
				var_79_11.x = 0
				var_79_4.localEulerAngles = var_79_11
			end

			if arg_76_1.time_ >= var_79_5 + var_79_7 and arg_76_1.time_ < var_79_5 + var_79_7 + arg_79_0 then
				var_79_4.localPosition = Vector3.New(-0.7, -1.15, -4.2)

				local var_79_12 = manager.ui.mainCamera.transform.position - var_79_4.position

				var_79_4.forward = Vector3.New(var_79_12.x, var_79_12.y, var_79_12.z)

				local var_79_13 = var_79_4.localEulerAngles

				var_79_13.z = 0
				var_79_13.x = 0
				var_79_4.localEulerAngles = var_79_13

				local var_79_14 = GameObjectTools.GetOrAddComponent(var_79_4.gameObject, typeof(DynamicBoneHelper))

				if var_79_14 then
					var_79_14:EnableDynamicBone(true)
				end
			end

			local var_79_15 = 0

			if var_79_15 < arg_76_1.time_ and arg_76_1.time_ <= var_79_15 + arg_79_0 then
				arg_76_1:PlayTimeline("2032_tpose", "StoryTimeline/CharAction/story2032/story2032action/2032action1_1")
			end

			local var_79_16 = arg_76_1.actors_["2033_tpose"].transform
			local var_79_17 = 0

			if var_79_17 < arg_76_1.time_ and arg_76_1.time_ <= var_79_17 + arg_79_0 then
				arg_76_1.var_.moveOldPos2033_tpose = var_79_16.localPosition

				local var_79_18 = GameObjectTools.GetOrAddComponent(var_79_16.gameObject, typeof(DynamicBoneHelper))

				if var_79_18 then
					var_79_18:EnableDynamicBone(false)
				end
			end

			local var_79_19 = 0.001

			if var_79_17 <= arg_76_1.time_ and arg_76_1.time_ < var_79_17 + var_79_19 then
				local var_79_20 = (arg_76_1.time_ - var_79_17) / var_79_19
				local var_79_21 = Vector3.New(0.7, -1.37, -4.9)

				var_79_16.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos2033_tpose, var_79_21, var_79_20)

				local var_79_22 = manager.ui.mainCamera.transform.position - var_79_16.position

				var_79_16.forward = Vector3.New(var_79_22.x, var_79_22.y, var_79_22.z)

				local var_79_23 = var_79_16.localEulerAngles

				var_79_23.z = 0
				var_79_23.x = 0
				var_79_16.localEulerAngles = var_79_23
			end

			if arg_76_1.time_ >= var_79_17 + var_79_19 and arg_76_1.time_ < var_79_17 + var_79_19 + arg_79_0 then
				var_79_16.localPosition = Vector3.New(0.7, -1.37, -4.9)

				local var_79_24 = manager.ui.mainCamera.transform.position - var_79_16.position

				var_79_16.forward = Vector3.New(var_79_24.x, var_79_24.y, var_79_24.z)

				local var_79_25 = var_79_16.localEulerAngles

				var_79_25.z = 0
				var_79_25.x = 0
				var_79_16.localEulerAngles = var_79_25

				local var_79_26 = GameObjectTools.GetOrAddComponent(var_79_16.gameObject, typeof(DynamicBoneHelper))

				if var_79_26 then
					var_79_26:EnableDynamicBone(true)
				end
			end

			local var_79_27 = 0

			if var_79_27 < arg_76_1.time_ and arg_76_1.time_ <= var_79_27 + arg_79_0 then
				arg_76_1:PlayTimeline("2033_tpose", "StoryTimeline/CharAction/story2033/story2033action/2033action1_1")
			end

			local var_79_28 = 0
			local var_79_29 = 0.175

			if var_79_28 < arg_76_1.time_ and arg_76_1.time_ <= var_79_28 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_30 = arg_76_1:FormatText(StoryNameCfg[78].name)

				arg_76_1.leftNameTxt_.text = var_79_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_31 = arg_76_1:GetWordFromCfg(106031019)
				local var_79_32 = arg_76_1:FormatText(var_79_31.content)

				arg_76_1.text_.text = var_79_32

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_33 = 7
				local var_79_34 = utf8.len(var_79_32)
				local var_79_35 = var_79_33 <= 0 and var_79_29 or var_79_29 * (var_79_34 / var_79_33)

				if var_79_35 > 0 and var_79_29 < var_79_35 then
					arg_76_1.talkMaxDuration = var_79_35

					if var_79_35 + var_79_28 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_35 + var_79_28
					end
				end

				arg_76_1.text_.text = var_79_32
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106031", "106031019", "story_v_out_106031.awb") ~= 0 then
					local var_79_36 = manager.audio:GetVoiceLength("story_v_out_106031", "106031019", "story_v_out_106031.awb") / 1000

					if var_79_36 + var_79_28 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_36 + var_79_28
					end

					if var_79_31.prefab_name ~= "" and arg_76_1.actors_[var_79_31.prefab_name] ~= nil then
						local var_79_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_31.prefab_name].transform, "story_v_out_106031", "106031019", "story_v_out_106031.awb")

						arg_76_1:RecordAudio("106031019", var_79_37)
						arg_76_1:RecordAudio("106031019", var_79_37)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_106031", "106031019", "story_v_out_106031.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_106031", "106031019", "story_v_out_106031.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_38 = math.max(var_79_29, arg_76_1.talkMaxDuration)

			if var_79_28 <= arg_76_1.time_ and arg_76_1.time_ < var_79_28 + var_79_38 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_28) / var_79_38

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_28 + var_79_38 and arg_76_1.time_ < var_79_28 + var_79_38 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2032_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2033_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play106031020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 106031020
		arg_80_1.duration_ = 2.3

		local var_80_0 = {
			ja = 1.733,
			ko = 1.866,
			zh = 2.233,
			en = 2.3
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
			arg_80_1.auto_ = false
		end

		function arg_80_1.playNext_(arg_82_0)
			arg_80_1.onStoryFinished_()
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["2033_tpose"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect2033_tpose == nil then
				arg_80_1.var_.characterEffect2033_tpose = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect2033_tpose and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect2033_tpose.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect2033_tpose then
				arg_80_1.var_.characterEffect2033_tpose.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["2032_tpose"]
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect2032_tpose == nil then
				arg_80_1.var_.characterEffect2032_tpose = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.1

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 and not isNil(var_83_4) then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6

				if arg_80_1.var_.characterEffect2032_tpose and not isNil(var_83_4) then
					local var_83_8 = Mathf.Lerp(0, 0.5, var_83_7)

					arg_80_1.var_.characterEffect2032_tpose.fillFlat = true
					arg_80_1.var_.characterEffect2032_tpose.fillRatio = var_83_8
				end
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect2032_tpose then
				local var_83_9 = 0.5

				arg_80_1.var_.characterEffect2032_tpose.fillFlat = true
				arg_80_1.var_.characterEffect2032_tpose.fillRatio = var_83_9
			end

			local var_83_10 = 0
			local var_83_11 = 0.15

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_12 = arg_80_1:FormatText(StoryNameCfg[79].name)

				arg_80_1.leftNameTxt_.text = var_83_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_13 = arg_80_1:GetWordFromCfg(106031020)
				local var_83_14 = arg_80_1:FormatText(var_83_13.content)

				arg_80_1.text_.text = var_83_14

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_15 = 6
				local var_83_16 = utf8.len(var_83_14)
				local var_83_17 = var_83_15 <= 0 and var_83_11 or var_83_11 * (var_83_16 / var_83_15)

				if var_83_17 > 0 and var_83_11 < var_83_17 then
					arg_80_1.talkMaxDuration = var_83_17

					if var_83_17 + var_83_10 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_17 + var_83_10
					end
				end

				arg_80_1.text_.text = var_83_14
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106031", "106031020", "story_v_out_106031.awb") ~= 0 then
					local var_83_18 = manager.audio:GetVoiceLength("story_v_out_106031", "106031020", "story_v_out_106031.awb") / 1000

					if var_83_18 + var_83_10 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_18 + var_83_10
					end

					if var_83_13.prefab_name ~= "" and arg_80_1.actors_[var_83_13.prefab_name] ~= nil then
						local var_83_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_13.prefab_name].transform, "story_v_out_106031", "106031020", "story_v_out_106031.awb")

						arg_80_1:RecordAudio("106031020", var_83_19)
						arg_80_1:RecordAudio("106031020", var_83_19)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_106031", "106031020", "story_v_out_106031.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_106031", "106031020", "story_v_out_106031.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_20 = math.max(var_83_11, arg_80_1.talkMaxDuration)

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_20 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_10) / var_83_20

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_10 + var_83_20 and arg_80_1.time_ < var_83_10 + var_83_20 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C06b"
	},
	voices = {
		"story_v_out_106031.awb"
	}
}
