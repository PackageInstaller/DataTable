return {
	Play114111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114111001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F04"

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
				local var_4_5 = arg_1_1.bgs_.F04

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
					if iter_4_0 ~= "F04" then
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
			local var_4_23 = 1

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

			local var_4_28 = 2
			local var_4_29 = 0.5

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

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

			local var_4_34 = 1.999999999999
			local var_4_35 = 0.25

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(114111001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 10
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play114111002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114111002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play114111003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.275

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(114111002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 51
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play114111003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114111003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play114111004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.3

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(114111003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 52
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play114111004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114111004
		arg_17_1.duration_ = 7.77

		local var_17_0 = {
			ja = 5.866,
			ko = 7.233,
			zh = 7.766,
			en = 5.533
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
				arg_17_0:Play114111005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1067ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1067ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_17_1.stage_.transform)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

					var_20_3.enabled = true

					local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

					if var_20_4 then
						var_20_4:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_3.transform, false)

					arg_17_1.var_[var_20_0 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_0 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_0 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_5 = arg_17_1.actors_["1067ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1067ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(-0.7, -1.06, -6.2)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1067ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = 0

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_20_16 = arg_17_1.actors_["1067ui_story"]
			local var_20_17 = 0

			if var_20_17 < arg_17_1.time_ and arg_17_1.time_ <= var_20_17 + arg_20_0 and not isNil(var_20_16) and arg_17_1.var_.characterEffect1067ui_story == nil then
				arg_17_1.var_.characterEffect1067ui_story = var_20_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_18 = 0.2

			if var_20_17 <= arg_17_1.time_ and arg_17_1.time_ < var_20_17 + var_20_18 and not isNil(var_20_16) then
				local var_20_19 = (arg_17_1.time_ - var_20_17) / var_20_18

				if arg_17_1.var_.characterEffect1067ui_story and not isNil(var_20_16) then
					arg_17_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_17 + var_20_18 and arg_17_1.time_ < var_20_17 + var_20_18 + arg_20_0 and not isNil(var_20_16) and arg_17_1.var_.characterEffect1067ui_story then
				arg_17_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_20_20 = 0
			local var_20_21 = 0.7

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_22 = arg_17_1:FormatText(StoryNameCfg[206].name)

				arg_17_1.leftNameTxt_.text = var_20_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_23 = arg_17_1:GetWordFromCfg(114111004)
				local var_20_24 = arg_17_1:FormatText(var_20_23.content)

				arg_17_1.text_.text = var_20_24

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_25 = 28
				local var_20_26 = utf8.len(var_20_24)
				local var_20_27 = var_20_25 <= 0 and var_20_21 or var_20_21 * (var_20_26 / var_20_25)

				if var_20_27 > 0 and var_20_21 < var_20_27 then
					arg_17_1.talkMaxDuration = var_20_27

					if var_20_27 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_20
					end
				end

				arg_17_1.text_.text = var_20_24
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111004", "story_v_out_114111.awb") ~= 0 then
					local var_20_28 = manager.audio:GetVoiceLength("story_v_out_114111", "114111004", "story_v_out_114111.awb") / 1000

					if var_20_28 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_20
					end

					if var_20_23.prefab_name ~= "" and arg_17_1.actors_[var_20_23.prefab_name] ~= nil then
						local var_20_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_23.prefab_name].transform, "story_v_out_114111", "114111004", "story_v_out_114111.awb")

						arg_17_1:RecordAudio("114111004", var_20_29)
						arg_17_1:RecordAudio("114111004", var_20_29)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_114111", "114111004", "story_v_out_114111.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_114111", "114111004", "story_v_out_114111.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_30 = math.max(var_20_21, arg_17_1.talkMaxDuration)

			if var_20_20 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_30 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_20) / var_20_30

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_20 + var_20_30 and arg_17_1.time_ < var_20_20 + var_20_30 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play114111005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114111005
		arg_21_1.duration_ = 7.13

		local var_21_0 = {
			ja = 7.133,
			ko = 4.566,
			zh = 3.9,
			en = 4.133
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
				arg_21_0:Play114111006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1042ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = arg_21_1.actors_["1042ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos1042ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(0.7, -1.06, -6.2)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1042ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = 0

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_24_16 = arg_21_1.actors_["1042ui_story"]
			local var_24_17 = 0

			if var_24_17 < arg_21_1.time_ and arg_21_1.time_ <= var_24_17 + arg_24_0 and not isNil(var_24_16) and arg_21_1.var_.characterEffect1042ui_story == nil then
				arg_21_1.var_.characterEffect1042ui_story = var_24_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_18 = 0.2

			if var_24_17 <= arg_21_1.time_ and arg_21_1.time_ < var_24_17 + var_24_18 and not isNil(var_24_16) then
				local var_24_19 = (arg_21_1.time_ - var_24_17) / var_24_18

				if arg_21_1.var_.characterEffect1042ui_story and not isNil(var_24_16) then
					arg_21_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_17 + var_24_18 and arg_21_1.time_ < var_24_17 + var_24_18 + arg_24_0 and not isNil(var_24_16) and arg_21_1.var_.characterEffect1042ui_story then
				arg_21_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_24_20 = arg_21_1.actors_["1067ui_story"]
			local var_24_21 = 0

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 and not isNil(var_24_20) and arg_21_1.var_.characterEffect1067ui_story == nil then
				arg_21_1.var_.characterEffect1067ui_story = var_24_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_22 = 0.2

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 and not isNil(var_24_20) then
				local var_24_23 = (arg_21_1.time_ - var_24_21) / var_24_22

				if arg_21_1.var_.characterEffect1067ui_story and not isNil(var_24_20) then
					local var_24_24 = Mathf.Lerp(0, 0.5, var_24_23)

					arg_21_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1067ui_story.fillRatio = var_24_24
				end
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 and not isNil(var_24_20) and arg_21_1.var_.characterEffect1067ui_story then
				local var_24_25 = 0.5

				arg_21_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1067ui_story.fillRatio = var_24_25
			end

			local var_24_26 = 0
			local var_24_27 = 0.45

			if var_24_26 < arg_21_1.time_ and arg_21_1.time_ <= var_24_26 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_28 = arg_21_1:FormatText(StoryNameCfg[205].name)

				arg_21_1.leftNameTxt_.text = var_24_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_29 = arg_21_1:GetWordFromCfg(114111005)
				local var_24_30 = arg_21_1:FormatText(var_24_29.content)

				arg_21_1.text_.text = var_24_30

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_31 = 18
				local var_24_32 = utf8.len(var_24_30)
				local var_24_33 = var_24_31 <= 0 and var_24_27 or var_24_27 * (var_24_32 / var_24_31)

				if var_24_33 > 0 and var_24_27 < var_24_33 then
					arg_21_1.talkMaxDuration = var_24_33

					if var_24_33 + var_24_26 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_33 + var_24_26
					end
				end

				arg_21_1.text_.text = var_24_30
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111005", "story_v_out_114111.awb") ~= 0 then
					local var_24_34 = manager.audio:GetVoiceLength("story_v_out_114111", "114111005", "story_v_out_114111.awb") / 1000

					if var_24_34 + var_24_26 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_34 + var_24_26
					end

					if var_24_29.prefab_name ~= "" and arg_21_1.actors_[var_24_29.prefab_name] ~= nil then
						local var_24_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_29.prefab_name].transform, "story_v_out_114111", "114111005", "story_v_out_114111.awb")

						arg_21_1:RecordAudio("114111005", var_24_35)
						arg_21_1:RecordAudio("114111005", var_24_35)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_114111", "114111005", "story_v_out_114111.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_114111", "114111005", "story_v_out_114111.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_36 = math.max(var_24_27, arg_21_1.talkMaxDuration)

			if var_24_26 <= arg_21_1.time_ and arg_21_1.time_ < var_24_26 + var_24_36 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_26) / var_24_36

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_26 + var_24_36 and arg_21_1.time_ < var_24_26 + var_24_36 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play114111006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114111006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play114111007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1067ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1067ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1067ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1042ui_story"].transform
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.var_.moveOldPos1042ui_story = var_28_9.localPosition
			end

			local var_28_11 = 0.001

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11
				local var_28_13 = Vector3.New(0, 100, 0)

				var_28_9.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1042ui_story, var_28_13, var_28_12)

				local var_28_14 = manager.ui.mainCamera.transform.position - var_28_9.position

				var_28_9.forward = Vector3.New(var_28_14.x, var_28_14.y, var_28_14.z)

				local var_28_15 = var_28_9.localEulerAngles

				var_28_15.z = 0
				var_28_15.x = 0
				var_28_9.localEulerAngles = var_28_15
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 then
				var_28_9.localPosition = Vector3.New(0, 100, 0)

				local var_28_16 = manager.ui.mainCamera.transform.position - var_28_9.position

				var_28_9.forward = Vector3.New(var_28_16.x, var_28_16.y, var_28_16.z)

				local var_28_17 = var_28_9.localEulerAngles

				var_28_17.z = 0
				var_28_17.x = 0
				var_28_9.localEulerAngles = var_28_17
			end

			local var_28_18 = 0
			local var_28_19 = 0.875

			if var_28_18 < arg_25_1.time_ and arg_25_1.time_ <= var_28_18 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_20 = arg_25_1:GetWordFromCfg(114111006)
				local var_28_21 = arg_25_1:FormatText(var_28_20.content)

				arg_25_1.text_.text = var_28_21

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_22 = 35
				local var_28_23 = utf8.len(var_28_21)
				local var_28_24 = var_28_22 <= 0 and var_28_19 or var_28_19 * (var_28_23 / var_28_22)

				if var_28_24 > 0 and var_28_19 < var_28_24 then
					arg_25_1.talkMaxDuration = var_28_24

					if var_28_24 + var_28_18 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_24 + var_28_18
					end
				end

				arg_25_1.text_.text = var_28_21
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_25 = math.max(var_28_19, arg_25_1.talkMaxDuration)

			if var_28_18 <= arg_25_1.time_ and arg_25_1.time_ < var_28_18 + var_28_25 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_18) / var_28_25

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_18 + var_28_25 and arg_25_1.time_ < var_28_18 + var_28_25 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play114111007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114111007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play114111008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.65

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(114111007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 26
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114111008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114111008
		arg_33_1.duration_ = 16.63

		local var_33_0 = {
			ja = 16.633,
			ko = 8.7,
			zh = 9.833,
			en = 10.5
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
				arg_33_0:Play114111009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1067ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1067ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1067ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1042ui_story"].transform
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.var_.moveOldPos1042ui_story = var_36_9.localPosition
			end

			local var_36_11 = 0.001

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11
				local var_36_13 = Vector3.New(0.7, -1.06, -6.2)

				var_36_9.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1042ui_story, var_36_13, var_36_12)

				local var_36_14 = manager.ui.mainCamera.transform.position - var_36_9.position

				var_36_9.forward = Vector3.New(var_36_14.x, var_36_14.y, var_36_14.z)

				local var_36_15 = var_36_9.localEulerAngles

				var_36_15.z = 0
				var_36_15.x = 0
				var_36_9.localEulerAngles = var_36_15
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 then
				var_36_9.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_36_16 = manager.ui.mainCamera.transform.position - var_36_9.position

				var_36_9.forward = Vector3.New(var_36_16.x, var_36_16.y, var_36_16.z)

				local var_36_17 = var_36_9.localEulerAngles

				var_36_17.z = 0
				var_36_17.x = 0
				var_36_9.localEulerAngles = var_36_17
			end

			local var_36_18 = 0

			if var_36_18 < arg_33_1.time_ and arg_33_1.time_ <= var_36_18 + arg_36_0 then
				arg_33_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			local var_36_19 = 0

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 then
				arg_33_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_36_20 = arg_33_1.actors_["1067ui_story"]
			local var_36_21 = 0

			if var_36_21 < arg_33_1.time_ and arg_33_1.time_ <= var_36_21 + arg_36_0 and not isNil(var_36_20) and arg_33_1.var_.characterEffect1067ui_story == nil then
				arg_33_1.var_.characterEffect1067ui_story = var_36_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_22 = 0.2

			if var_36_21 <= arg_33_1.time_ and arg_33_1.time_ < var_36_21 + var_36_22 and not isNil(var_36_20) then
				local var_36_23 = (arg_33_1.time_ - var_36_21) / var_36_22

				if arg_33_1.var_.characterEffect1067ui_story and not isNil(var_36_20) then
					arg_33_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_21 + var_36_22 and arg_33_1.time_ < var_36_21 + var_36_22 + arg_36_0 and not isNil(var_36_20) and arg_33_1.var_.characterEffect1067ui_story then
				arg_33_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_36_24 = arg_33_1.actors_["1042ui_story"]
			local var_36_25 = 0

			if var_36_25 < arg_33_1.time_ and arg_33_1.time_ <= var_36_25 + arg_36_0 and not isNil(var_36_24) and arg_33_1.var_.characterEffect1042ui_story == nil then
				arg_33_1.var_.characterEffect1042ui_story = var_36_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_26 = 0.2

			if var_36_25 <= arg_33_1.time_ and arg_33_1.time_ < var_36_25 + var_36_26 and not isNil(var_36_24) then
				local var_36_27 = (arg_33_1.time_ - var_36_25) / var_36_26

				if arg_33_1.var_.characterEffect1042ui_story and not isNil(var_36_24) then
					local var_36_28 = Mathf.Lerp(0, 0.5, var_36_27)

					arg_33_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1042ui_story.fillRatio = var_36_28
				end
			end

			if arg_33_1.time_ >= var_36_25 + var_36_26 and arg_33_1.time_ < var_36_25 + var_36_26 + arg_36_0 and not isNil(var_36_24) and arg_33_1.var_.characterEffect1042ui_story then
				local var_36_29 = 0.5

				arg_33_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1042ui_story.fillRatio = var_36_29
			end

			local var_36_30 = 0
			local var_36_31 = 1.1

			if var_36_30 < arg_33_1.time_ and arg_33_1.time_ <= var_36_30 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_32 = arg_33_1:FormatText(StoryNameCfg[206].name)

				arg_33_1.leftNameTxt_.text = var_36_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_33 = arg_33_1:GetWordFromCfg(114111008)
				local var_36_34 = arg_33_1:FormatText(var_36_33.content)

				arg_33_1.text_.text = var_36_34

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_35 = 44
				local var_36_36 = utf8.len(var_36_34)
				local var_36_37 = var_36_35 <= 0 and var_36_31 or var_36_31 * (var_36_36 / var_36_35)

				if var_36_37 > 0 and var_36_31 < var_36_37 then
					arg_33_1.talkMaxDuration = var_36_37

					if var_36_37 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_37 + var_36_30
					end
				end

				arg_33_1.text_.text = var_36_34
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111008", "story_v_out_114111.awb") ~= 0 then
					local var_36_38 = manager.audio:GetVoiceLength("story_v_out_114111", "114111008", "story_v_out_114111.awb") / 1000

					if var_36_38 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_38 + var_36_30
					end

					if var_36_33.prefab_name ~= "" and arg_33_1.actors_[var_36_33.prefab_name] ~= nil then
						local var_36_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_33.prefab_name].transform, "story_v_out_114111", "114111008", "story_v_out_114111.awb")

						arg_33_1:RecordAudio("114111008", var_36_39)
						arg_33_1:RecordAudio("114111008", var_36_39)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_114111", "114111008", "story_v_out_114111.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_114111", "114111008", "story_v_out_114111.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_40 = math.max(var_36_31, arg_33_1.talkMaxDuration)

			if var_36_30 <= arg_33_1.time_ and arg_33_1.time_ < var_36_30 + var_36_40 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_30) / var_36_40

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_30 + var_36_40 and arg_33_1.time_ < var_36_30 + var_36_40 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play114111009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114111009
		arg_37_1.duration_ = 10.37

		local var_37_0 = {
			ja = 10.366,
			ko = 6.4,
			zh = 7.266,
			en = 7.433
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
				arg_37_0:Play114111010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1067ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1067ui_story == nil then
				arg_37_1.var_.characterEffect1067ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1067ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1067ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1067ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1067ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			local var_40_7 = 0

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_40_8 = arg_37_1.actors_["1042ui_story"]
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.characterEffect1042ui_story == nil then
				arg_37_1.var_.characterEffect1042ui_story = var_40_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_10 = 0.2

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_10 and not isNil(var_40_8) then
				local var_40_11 = (arg_37_1.time_ - var_40_9) / var_40_10

				if arg_37_1.var_.characterEffect1042ui_story and not isNil(var_40_8) then
					arg_37_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_9 + var_40_10 and arg_37_1.time_ < var_40_9 + var_40_10 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.characterEffect1042ui_story then
				arg_37_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_40_12 = 0
			local var_40_13 = 0.675

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_14 = arg_37_1:FormatText(StoryNameCfg[205].name)

				arg_37_1.leftNameTxt_.text = var_40_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_15 = arg_37_1:GetWordFromCfg(114111009)
				local var_40_16 = arg_37_1:FormatText(var_40_15.content)

				arg_37_1.text_.text = var_40_16

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 27
				local var_40_18 = utf8.len(var_40_16)
				local var_40_19 = var_40_17 <= 0 and var_40_13 or var_40_13 * (var_40_18 / var_40_17)

				if var_40_19 > 0 and var_40_13 < var_40_19 then
					arg_37_1.talkMaxDuration = var_40_19

					if var_40_19 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_16
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111009", "story_v_out_114111.awb") ~= 0 then
					local var_40_20 = manager.audio:GetVoiceLength("story_v_out_114111", "114111009", "story_v_out_114111.awb") / 1000

					if var_40_20 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_12
					end

					if var_40_15.prefab_name ~= "" and arg_37_1.actors_[var_40_15.prefab_name] ~= nil then
						local var_40_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_15.prefab_name].transform, "story_v_out_114111", "114111009", "story_v_out_114111.awb")

						arg_37_1:RecordAudio("114111009", var_40_21)
						arg_37_1:RecordAudio("114111009", var_40_21)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114111", "114111009", "story_v_out_114111.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114111", "114111009", "story_v_out_114111.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_22 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_12) / var_40_22

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_12 + var_40_22 and arg_37_1.time_ < var_40_12 + var_40_22 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play114111010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114111010
		arg_41_1.duration_ = 6.37

		local var_41_0 = {
			ja = 5.7,
			ko = 5.333,
			zh = 4.833,
			en = 6.366
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
				arg_41_0:Play114111011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1042ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1042ui_story == nil then
				arg_41_1.var_.characterEffect1042ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1042ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1042ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1042ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1042ui_story.fillRatio = var_44_5
			end

			local var_44_6 = arg_41_1.actors_["1067ui_story"]
			local var_44_7 = 0

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1067ui_story == nil then
				arg_41_1.var_.characterEffect1067ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_8 = 0.2

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_8 and not isNil(var_44_6) then
				local var_44_9 = (arg_41_1.time_ - var_44_7) / var_44_8

				if arg_41_1.var_.characterEffect1067ui_story and not isNil(var_44_6) then
					arg_41_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_7 + var_44_8 and arg_41_1.time_ < var_44_7 + var_44_8 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1067ui_story then
				arg_41_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			local var_44_11 = 0

			if var_44_11 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_44_12 = 0
			local var_44_13 = 0.55

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_14 = arg_41_1:FormatText(StoryNameCfg[206].name)

				arg_41_1.leftNameTxt_.text = var_44_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:GetWordFromCfg(114111010)
				local var_44_16 = arg_41_1:FormatText(var_44_15.content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 22
				local var_44_18 = utf8.len(var_44_16)
				local var_44_19 = var_44_17 <= 0 and var_44_13 or var_44_13 * (var_44_18 / var_44_17)

				if var_44_19 > 0 and var_44_13 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19

					if var_44_19 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_12
					end
				end

				arg_41_1.text_.text = var_44_16
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111010", "story_v_out_114111.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_114111", "114111010", "story_v_out_114111.awb") / 1000

					if var_44_20 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_12
					end

					if var_44_15.prefab_name ~= "" and arg_41_1.actors_[var_44_15.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_15.prefab_name].transform, "story_v_out_114111", "114111010", "story_v_out_114111.awb")

						arg_41_1:RecordAudio("114111010", var_44_21)
						arg_41_1:RecordAudio("114111010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_114111", "114111010", "story_v_out_114111.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_114111", "114111010", "story_v_out_114111.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_13, arg_41_1.talkMaxDuration)

			if var_44_12 <= arg_41_1.time_ and arg_41_1.time_ < var_44_12 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_12) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_12 + var_44_22 and arg_41_1.time_ < var_44_12 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play114111011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114111011
		arg_45_1.duration_ = 6.03

		local var_45_0 = {
			ja = 6.033,
			ko = 2.9,
			zh = 3.666,
			en = 4.1
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
				arg_45_0:Play114111012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_48_1 = arg_45_1.actors_["1042ui_story"]
			local var_48_2 = 0

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1042ui_story == nil then
				arg_45_1.var_.characterEffect1042ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_3 = 0.2

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_3 and not isNil(var_48_1) then
				local var_48_4 = (arg_45_1.time_ - var_48_2) / var_48_3

				if arg_45_1.var_.characterEffect1042ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_2 + var_48_3 and arg_45_1.time_ < var_48_2 + var_48_3 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1042ui_story then
				arg_45_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_48_5 = arg_45_1.actors_["1067ui_story"]
			local var_48_6 = 0

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect1067ui_story == nil then
				arg_45_1.var_.characterEffect1067ui_story = var_48_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_7 = 0.2

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_7 and not isNil(var_48_5) then
				local var_48_8 = (arg_45_1.time_ - var_48_6) / var_48_7

				if arg_45_1.var_.characterEffect1067ui_story and not isNil(var_48_5) then
					local var_48_9 = Mathf.Lerp(0, 0.5, var_48_8)

					arg_45_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1067ui_story.fillRatio = var_48_9
				end
			end

			if arg_45_1.time_ >= var_48_6 + var_48_7 and arg_45_1.time_ < var_48_6 + var_48_7 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect1067ui_story then
				local var_48_10 = 0.5

				arg_45_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1067ui_story.fillRatio = var_48_10
			end

			local var_48_11 = 0
			local var_48_12 = 0.225

			if var_48_11 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_13 = arg_45_1:FormatText(StoryNameCfg[205].name)

				arg_45_1.leftNameTxt_.text = var_48_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_14 = arg_45_1:GetWordFromCfg(114111011)
				local var_48_15 = arg_45_1:FormatText(var_48_14.content)

				arg_45_1.text_.text = var_48_15

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_16 = 9
				local var_48_17 = utf8.len(var_48_15)
				local var_48_18 = var_48_16 <= 0 and var_48_12 or var_48_12 * (var_48_17 / var_48_16)

				if var_48_18 > 0 and var_48_12 < var_48_18 then
					arg_45_1.talkMaxDuration = var_48_18

					if var_48_18 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_11
					end
				end

				arg_45_1.text_.text = var_48_15
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111011", "story_v_out_114111.awb") ~= 0 then
					local var_48_19 = manager.audio:GetVoiceLength("story_v_out_114111", "114111011", "story_v_out_114111.awb") / 1000

					if var_48_19 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_11
					end

					if var_48_14.prefab_name ~= "" and arg_45_1.actors_[var_48_14.prefab_name] ~= nil then
						local var_48_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_14.prefab_name].transform, "story_v_out_114111", "114111011", "story_v_out_114111.awb")

						arg_45_1:RecordAudio("114111011", var_48_20)
						arg_45_1:RecordAudio("114111011", var_48_20)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_114111", "114111011", "story_v_out_114111.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_114111", "114111011", "story_v_out_114111.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_21 = math.max(var_48_12, arg_45_1.talkMaxDuration)

			if var_48_11 <= arg_45_1.time_ and arg_45_1.time_ < var_48_11 + var_48_21 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_11) / var_48_21

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_11 + var_48_21 and arg_45_1.time_ < var_48_11 + var_48_21 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114111012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114111012
		arg_49_1.duration_ = 14.6

		local var_49_0 = {
			ja = 14.6,
			ko = 10.433,
			zh = 9.966,
			en = 13.1
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play114111013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1067ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1067ui_story == nil then
				arg_49_1.var_.characterEffect1067ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1067ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1067ui_story then
				arg_49_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_52_4 = 0

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_2")
			end

			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_52_6 = arg_49_1.actors_["1042ui_story"]
			local var_52_7 = 0

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1042ui_story == nil then
				arg_49_1.var_.characterEffect1042ui_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_8 = 0.2

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_8 and not isNil(var_52_6) then
				local var_52_9 = (arg_49_1.time_ - var_52_7) / var_52_8

				if arg_49_1.var_.characterEffect1042ui_story and not isNil(var_52_6) then
					local var_52_10 = Mathf.Lerp(0, 0.5, var_52_9)

					arg_49_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1042ui_story.fillRatio = var_52_10
				end
			end

			if arg_49_1.time_ >= var_52_7 + var_52_8 and arg_49_1.time_ < var_52_7 + var_52_8 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1042ui_story then
				local var_52_11 = 0.5

				arg_49_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1042ui_story.fillRatio = var_52_11
			end

			local var_52_12 = 0
			local var_52_13 = 1.075

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_14 = arg_49_1:FormatText(StoryNameCfg[206].name)

				arg_49_1.leftNameTxt_.text = var_52_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_15 = arg_49_1:GetWordFromCfg(114111012)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 43
				local var_52_18 = utf8.len(var_52_16)
				local var_52_19 = var_52_17 <= 0 and var_52_13 or var_52_13 * (var_52_18 / var_52_17)

				if var_52_19 > 0 and var_52_13 < var_52_19 then
					arg_49_1.talkMaxDuration = var_52_19

					if var_52_19 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_16
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111012", "story_v_out_114111.awb") ~= 0 then
					local var_52_20 = manager.audio:GetVoiceLength("story_v_out_114111", "114111012", "story_v_out_114111.awb") / 1000

					if var_52_20 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_20 + var_52_12
					end

					if var_52_15.prefab_name ~= "" and arg_49_1.actors_[var_52_15.prefab_name] ~= nil then
						local var_52_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_15.prefab_name].transform, "story_v_out_114111", "114111012", "story_v_out_114111.awb")

						arg_49_1:RecordAudio("114111012", var_52_21)
						arg_49_1:RecordAudio("114111012", var_52_21)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_114111", "114111012", "story_v_out_114111.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_114111", "114111012", "story_v_out_114111.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_22 and arg_49_1.time_ < var_52_12 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114111013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114111013
		arg_53_1.duration_ = 10.8

		local var_53_0 = {
			ja = 9.533,
			ko = 10.8,
			zh = 10.466,
			en = 10.433
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play114111014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_56_1 = 0
			local var_56_2 = 1

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_3 = arg_53_1:FormatText(StoryNameCfg[206].name)

				arg_53_1.leftNameTxt_.text = var_56_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(114111013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 40
				local var_56_7 = utf8.len(var_56_5)
				local var_56_8 = var_56_6 <= 0 and var_56_2 or var_56_2 * (var_56_7 / var_56_6)

				if var_56_8 > 0 and var_56_2 < var_56_8 then
					arg_53_1.talkMaxDuration = var_56_8

					if var_56_8 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111013", "story_v_out_114111.awb") ~= 0 then
					local var_56_9 = manager.audio:GetVoiceLength("story_v_out_114111", "114111013", "story_v_out_114111.awb") / 1000

					if var_56_9 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_1
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_114111", "114111013", "story_v_out_114111.awb")

						arg_53_1:RecordAudio("114111013", var_56_10)
						arg_53_1:RecordAudio("114111013", var_56_10)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_114111", "114111013", "story_v_out_114111.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_114111", "114111013", "story_v_out_114111.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_11 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_11 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_11

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_11 and arg_53_1.time_ < var_56_1 + var_56_11 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play114111014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114111014
		arg_57_1.duration_ = 13.7

		local var_57_0 = {
			ja = 12.266,
			ko = 13.7,
			zh = 12.366,
			en = 12.533
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play114111015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_1")
			end

			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_60_2 = 0
			local var_60_3 = 1.1

			if var_60_2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_4 = arg_57_1:FormatText(StoryNameCfg[206].name)

				arg_57_1.leftNameTxt_.text = var_60_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:GetWordFromCfg(114111014)
				local var_60_6 = arg_57_1:FormatText(var_60_5.content)

				arg_57_1.text_.text = var_60_6

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 44
				local var_60_8 = utf8.len(var_60_6)
				local var_60_9 = var_60_7 <= 0 and var_60_3 or var_60_3 * (var_60_8 / var_60_7)

				if var_60_9 > 0 and var_60_3 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_6
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111014", "story_v_out_114111.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111014", "story_v_out_114111.awb") / 1000

					if var_60_10 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_2
					end

					if var_60_5.prefab_name ~= "" and arg_57_1.actors_[var_60_5.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_5.prefab_name].transform, "story_v_out_114111", "114111014", "story_v_out_114111.awb")

						arg_57_1:RecordAudio("114111014", var_60_11)
						arg_57_1:RecordAudio("114111014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_114111", "114111014", "story_v_out_114111.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_114111", "114111014", "story_v_out_114111.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_12 and arg_57_1.time_ < var_60_2 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114111015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114111015
		arg_61_1.duration_ = 12.3

		local var_61_0 = {
			ja = 12.3,
			ko = 10.333,
			zh = 11.2,
			en = 10.7
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play114111016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_2")
			end

			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action442")
			end

			local var_64_2 = 0

			if var_64_2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_64_3 = arg_61_1.actors_["1042ui_story"]
			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect1042ui_story == nil then
				arg_61_1.var_.characterEffect1042ui_story = var_64_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_5 = 0.2

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_5 and not isNil(var_64_3) then
				local var_64_6 = (arg_61_1.time_ - var_64_4) / var_64_5

				if arg_61_1.var_.characterEffect1042ui_story and not isNil(var_64_3) then
					arg_61_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_4 + var_64_5 and arg_61_1.time_ < var_64_4 + var_64_5 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect1042ui_story then
				arg_61_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_64_7 = arg_61_1.actors_["1067ui_story"]
			local var_64_8 = 0

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.characterEffect1067ui_story == nil then
				arg_61_1.var_.characterEffect1067ui_story = var_64_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_9 = 0.2

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_9 and not isNil(var_64_7) then
				local var_64_10 = (arg_61_1.time_ - var_64_8) / var_64_9

				if arg_61_1.var_.characterEffect1067ui_story and not isNil(var_64_7) then
					local var_64_11 = Mathf.Lerp(0, 0.5, var_64_10)

					arg_61_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1067ui_story.fillRatio = var_64_11
				end
			end

			if arg_61_1.time_ >= var_64_8 + var_64_9 and arg_61_1.time_ < var_64_8 + var_64_9 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.characterEffect1067ui_story then
				local var_64_12 = 0.5

				arg_61_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1067ui_story.fillRatio = var_64_12
			end

			local var_64_13 = 0
			local var_64_14 = 1.25

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_15 = arg_61_1:FormatText(StoryNameCfg[205].name)

				arg_61_1.leftNameTxt_.text = var_64_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_16 = arg_61_1:GetWordFromCfg(114111015)
				local var_64_17 = arg_61_1:FormatText(var_64_16.content)

				arg_61_1.text_.text = var_64_17

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_18 = 50
				local var_64_19 = utf8.len(var_64_17)
				local var_64_20 = var_64_18 <= 0 and var_64_14 or var_64_14 * (var_64_19 / var_64_18)

				if var_64_20 > 0 and var_64_14 < var_64_20 then
					arg_61_1.talkMaxDuration = var_64_20

					if var_64_20 + var_64_13 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_13
					end
				end

				arg_61_1.text_.text = var_64_17
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111015", "story_v_out_114111.awb") ~= 0 then
					local var_64_21 = manager.audio:GetVoiceLength("story_v_out_114111", "114111015", "story_v_out_114111.awb") / 1000

					if var_64_21 + var_64_13 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_21 + var_64_13
					end

					if var_64_16.prefab_name ~= "" and arg_61_1.actors_[var_64_16.prefab_name] ~= nil then
						local var_64_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_16.prefab_name].transform, "story_v_out_114111", "114111015", "story_v_out_114111.awb")

						arg_61_1:RecordAudio("114111015", var_64_22)
						arg_61_1:RecordAudio("114111015", var_64_22)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_114111", "114111015", "story_v_out_114111.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_114111", "114111015", "story_v_out_114111.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_23 = math.max(var_64_14, arg_61_1.talkMaxDuration)

			if var_64_13 <= arg_61_1.time_ and arg_61_1.time_ < var_64_13 + var_64_23 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_13) / var_64_23

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_13 + var_64_23 and arg_61_1.time_ < var_64_13 + var_64_23 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play114111016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114111016
		arg_65_1.duration_ = 7.13

		local var_65_0 = {
			ja = 5.4,
			ko = 5.366,
			zh = 6.166,
			en = 7.133
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play114111017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1042ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1042ui_story == nil then
				arg_65_1.var_.characterEffect1042ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1042ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1042ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1042ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1042ui_story.fillRatio = var_68_5
			end

			local var_68_6 = arg_65_1.actors_["1067ui_story"]
			local var_68_7 = 0

			if var_68_7 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1067ui_story == nil then
				arg_65_1.var_.characterEffect1067ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.2

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_8 and not isNil(var_68_6) then
				local var_68_9 = (arg_65_1.time_ - var_68_7) / var_68_8

				if arg_65_1.var_.characterEffect1067ui_story and not isNil(var_68_6) then
					arg_65_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_7 + var_68_8 and arg_65_1.time_ < var_68_7 + var_68_8 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1067ui_story then
				arg_65_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_68_11 = 0
			local var_68_12 = 0.65

			if var_68_11 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_13 = arg_65_1:FormatText(StoryNameCfg[206].name)

				arg_65_1.leftNameTxt_.text = var_68_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_14 = arg_65_1:GetWordFromCfg(114111016)
				local var_68_15 = arg_65_1:FormatText(var_68_14.content)

				arg_65_1.text_.text = var_68_15

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_16 = 26
				local var_68_17 = utf8.len(var_68_15)
				local var_68_18 = var_68_16 <= 0 and var_68_12 or var_68_12 * (var_68_17 / var_68_16)

				if var_68_18 > 0 and var_68_12 < var_68_18 then
					arg_65_1.talkMaxDuration = var_68_18

					if var_68_18 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_18 + var_68_11
					end
				end

				arg_65_1.text_.text = var_68_15
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111016", "story_v_out_114111.awb") ~= 0 then
					local var_68_19 = manager.audio:GetVoiceLength("story_v_out_114111", "114111016", "story_v_out_114111.awb") / 1000

					if var_68_19 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_11
					end

					if var_68_14.prefab_name ~= "" and arg_65_1.actors_[var_68_14.prefab_name] ~= nil then
						local var_68_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_14.prefab_name].transform, "story_v_out_114111", "114111016", "story_v_out_114111.awb")

						arg_65_1:RecordAudio("114111016", var_68_20)
						arg_65_1:RecordAudio("114111016", var_68_20)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_114111", "114111016", "story_v_out_114111.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_114111", "114111016", "story_v_out_114111.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_21 = math.max(var_68_12, arg_65_1.talkMaxDuration)

			if var_68_11 <= arg_65_1.time_ and arg_65_1.time_ < var_68_11 + var_68_21 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_11) / var_68_21

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_11 + var_68_21 and arg_65_1.time_ < var_68_11 + var_68_21 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play114111017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114111017
		arg_69_1.duration_ = 10.87

		local var_69_0 = {
			ja = 9.366,
			ko = 10.2,
			zh = 10.866,
			en = 9.833
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play114111018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_72_1 = 0
			local var_72_2 = 1.3

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_3 = arg_69_1:FormatText(StoryNameCfg[206].name)

				arg_69_1.leftNameTxt_.text = var_72_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(114111017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 52
				local var_72_7 = utf8.len(var_72_5)
				local var_72_8 = var_72_6 <= 0 and var_72_2 or var_72_2 * (var_72_7 / var_72_6)

				if var_72_8 > 0 and var_72_2 < var_72_8 then
					arg_69_1.talkMaxDuration = var_72_8

					if var_72_8 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111017", "story_v_out_114111.awb") ~= 0 then
					local var_72_9 = manager.audio:GetVoiceLength("story_v_out_114111", "114111017", "story_v_out_114111.awb") / 1000

					if var_72_9 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_1
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_114111", "114111017", "story_v_out_114111.awb")

						arg_69_1:RecordAudio("114111017", var_72_10)
						arg_69_1:RecordAudio("114111017", var_72_10)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_114111", "114111017", "story_v_out_114111.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_114111", "114111017", "story_v_out_114111.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_11 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_11 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_11

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_11 and arg_69_1.time_ < var_72_1 + var_72_11 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114111018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114111018
		arg_73_1.duration_ = 16.7

		local var_73_0 = {
			ja = 16.7,
			ko = 11.966,
			zh = 11.166,
			en = 12.1
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play114111019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_76_2 = arg_73_1.actors_["1042ui_story"]
			local var_76_3 = 0

			if var_76_3 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1042ui_story == nil then
				arg_73_1.var_.characterEffect1042ui_story = var_76_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_4 = 0.2

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_4 and not isNil(var_76_2) then
				local var_76_5 = (arg_73_1.time_ - var_76_3) / var_76_4

				if arg_73_1.var_.characterEffect1042ui_story and not isNil(var_76_2) then
					arg_73_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_3 + var_76_4 and arg_73_1.time_ < var_76_3 + var_76_4 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1042ui_story then
				arg_73_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_76_6 = arg_73_1.actors_["1067ui_story"]
			local var_76_7 = 0

			if var_76_7 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect1067ui_story == nil then
				arg_73_1.var_.characterEffect1067ui_story = var_76_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_8 = 0.2

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_8 and not isNil(var_76_6) then
				local var_76_9 = (arg_73_1.time_ - var_76_7) / var_76_8

				if arg_73_1.var_.characterEffect1067ui_story and not isNil(var_76_6) then
					local var_76_10 = Mathf.Lerp(0, 0.5, var_76_9)

					arg_73_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1067ui_story.fillRatio = var_76_10
				end
			end

			if arg_73_1.time_ >= var_76_7 + var_76_8 and arg_73_1.time_ < var_76_7 + var_76_8 + arg_76_0 and not isNil(var_76_6) and arg_73_1.var_.characterEffect1067ui_story then
				local var_76_11 = 0.5

				arg_73_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1067ui_story.fillRatio = var_76_11
			end

			local var_76_12 = 0
			local var_76_13 = 1.1

			if var_76_12 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_14 = arg_73_1:FormatText(StoryNameCfg[205].name)

				arg_73_1.leftNameTxt_.text = var_76_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_15 = arg_73_1:GetWordFromCfg(114111018)
				local var_76_16 = arg_73_1:FormatText(var_76_15.content)

				arg_73_1.text_.text = var_76_16

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_17 = 44
				local var_76_18 = utf8.len(var_76_16)
				local var_76_19 = var_76_17 <= 0 and var_76_13 or var_76_13 * (var_76_18 / var_76_17)

				if var_76_19 > 0 and var_76_13 < var_76_19 then
					arg_73_1.talkMaxDuration = var_76_19

					if var_76_19 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_12
					end
				end

				arg_73_1.text_.text = var_76_16
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111018", "story_v_out_114111.awb") ~= 0 then
					local var_76_20 = manager.audio:GetVoiceLength("story_v_out_114111", "114111018", "story_v_out_114111.awb") / 1000

					if var_76_20 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_20 + var_76_12
					end

					if var_76_15.prefab_name ~= "" and arg_73_1.actors_[var_76_15.prefab_name] ~= nil then
						local var_76_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_15.prefab_name].transform, "story_v_out_114111", "114111018", "story_v_out_114111.awb")

						arg_73_1:RecordAudio("114111018", var_76_21)
						arg_73_1:RecordAudio("114111018", var_76_21)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_114111", "114111018", "story_v_out_114111.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_114111", "114111018", "story_v_out_114111.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_22 = math.max(var_76_13, arg_73_1.talkMaxDuration)

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_22 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_12) / var_76_22

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_12 + var_76_22 and arg_73_1.time_ < var_76_12 + var_76_22 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114111019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114111019
		arg_77_1.duration_ = 10.9

		local var_77_0 = {
			ja = 10.9,
			ko = 10.9,
			zh = 10.866,
			en = 8.2
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play114111020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1067ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1067ui_story == nil then
				arg_77_1.var_.characterEffect1067ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1067ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1067ui_story then
				arg_77_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_80_4 = arg_77_1.actors_["1042ui_story"]
			local var_80_5 = 0

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect1042ui_story == nil then
				arg_77_1.var_.characterEffect1042ui_story = var_80_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_6 = 0.2

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_6 and not isNil(var_80_4) then
				local var_80_7 = (arg_77_1.time_ - var_80_5) / var_80_6

				if arg_77_1.var_.characterEffect1042ui_story and not isNil(var_80_4) then
					local var_80_8 = Mathf.Lerp(0, 0.5, var_80_7)

					arg_77_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1042ui_story.fillRatio = var_80_8
				end
			end

			if arg_77_1.time_ >= var_80_5 + var_80_6 and arg_77_1.time_ < var_80_5 + var_80_6 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect1042ui_story then
				local var_80_9 = 0.5

				arg_77_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1042ui_story.fillRatio = var_80_9
			end

			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			local var_80_11 = 0

			if var_80_11 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				arg_77_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_80_12 = 0
			local var_80_13 = 1.175

			if var_80_12 < arg_77_1.time_ and arg_77_1.time_ <= var_80_12 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_14 = arg_77_1:FormatText(StoryNameCfg[206].name)

				arg_77_1.leftNameTxt_.text = var_80_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_15 = arg_77_1:GetWordFromCfg(114111019)
				local var_80_16 = arg_77_1:FormatText(var_80_15.content)

				arg_77_1.text_.text = var_80_16

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_17 = 47
				local var_80_18 = utf8.len(var_80_16)
				local var_80_19 = var_80_17 <= 0 and var_80_13 or var_80_13 * (var_80_18 / var_80_17)

				if var_80_19 > 0 and var_80_13 < var_80_19 then
					arg_77_1.talkMaxDuration = var_80_19

					if var_80_19 + var_80_12 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_19 + var_80_12
					end
				end

				arg_77_1.text_.text = var_80_16
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111019", "story_v_out_114111.awb") ~= 0 then
					local var_80_20 = manager.audio:GetVoiceLength("story_v_out_114111", "114111019", "story_v_out_114111.awb") / 1000

					if var_80_20 + var_80_12 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_20 + var_80_12
					end

					if var_80_15.prefab_name ~= "" and arg_77_1.actors_[var_80_15.prefab_name] ~= nil then
						local var_80_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_15.prefab_name].transform, "story_v_out_114111", "114111019", "story_v_out_114111.awb")

						arg_77_1:RecordAudio("114111019", var_80_21)
						arg_77_1:RecordAudio("114111019", var_80_21)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_114111", "114111019", "story_v_out_114111.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_114111", "114111019", "story_v_out_114111.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_22 = math.max(var_80_13, arg_77_1.talkMaxDuration)

			if var_80_12 <= arg_77_1.time_ and arg_77_1.time_ < var_80_12 + var_80_22 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_12) / var_80_22

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_12 + var_80_22 and arg_77_1.time_ < var_80_12 + var_80_22 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play114111020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114111020
		arg_81_1.duration_ = 10.53

		local var_81_0 = {
			ja = 10.533,
			ko = 8,
			zh = 8.633,
			en = 8.566
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play114111021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1042ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1042ui_story == nil then
				arg_81_1.var_.characterEffect1042ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1042ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1042ui_story then
				arg_81_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_84_4 = arg_81_1.actors_["1067ui_story"]
			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1067ui_story == nil then
				arg_81_1.var_.characterEffect1067ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.2

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_6 and not isNil(var_84_4) then
				local var_84_7 = (arg_81_1.time_ - var_84_5) / var_84_6

				if arg_81_1.var_.characterEffect1067ui_story and not isNil(var_84_4) then
					local var_84_8 = Mathf.Lerp(0, 0.5, var_84_7)

					arg_81_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1067ui_story.fillRatio = var_84_8
				end
			end

			if arg_81_1.time_ >= var_84_5 + var_84_6 and arg_81_1.time_ < var_84_5 + var_84_6 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1067ui_story then
				local var_84_9 = 0.5

				arg_81_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1067ui_story.fillRatio = var_84_9
			end

			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_84_11 = 0
			local var_84_12 = 0.65

			if var_84_11 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_13 = arg_81_1:FormatText(StoryNameCfg[205].name)

				arg_81_1.leftNameTxt_.text = var_84_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_14 = arg_81_1:GetWordFromCfg(114111020)
				local var_84_15 = arg_81_1:FormatText(var_84_14.content)

				arg_81_1.text_.text = var_84_15

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_16 = 26
				local var_84_17 = utf8.len(var_84_15)
				local var_84_18 = var_84_16 <= 0 and var_84_12 or var_84_12 * (var_84_17 / var_84_16)

				if var_84_18 > 0 and var_84_12 < var_84_18 then
					arg_81_1.talkMaxDuration = var_84_18

					if var_84_18 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_18 + var_84_11
					end
				end

				arg_81_1.text_.text = var_84_15
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111020", "story_v_out_114111.awb") ~= 0 then
					local var_84_19 = manager.audio:GetVoiceLength("story_v_out_114111", "114111020", "story_v_out_114111.awb") / 1000

					if var_84_19 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_19 + var_84_11
					end

					if var_84_14.prefab_name ~= "" and arg_81_1.actors_[var_84_14.prefab_name] ~= nil then
						local var_84_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_14.prefab_name].transform, "story_v_out_114111", "114111020", "story_v_out_114111.awb")

						arg_81_1:RecordAudio("114111020", var_84_20)
						arg_81_1:RecordAudio("114111020", var_84_20)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_114111", "114111020", "story_v_out_114111.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_114111", "114111020", "story_v_out_114111.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_21 = math.max(var_84_12, arg_81_1.talkMaxDuration)

			if var_84_11 <= arg_81_1.time_ and arg_81_1.time_ < var_84_11 + var_84_21 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_11) / var_84_21

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_11 + var_84_21 and arg_81_1.time_ < var_84_11 + var_84_21 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play114111021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114111021
		arg_85_1.duration_ = 3.4

		local var_85_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 3.366,
			en = 3.4
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play114111022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action437")
			end

			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_88_2 = arg_85_1.actors_["1042ui_story"]
			local var_88_3 = 0

			if var_88_3 < arg_85_1.time_ and arg_85_1.time_ <= var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect1042ui_story == nil then
				arg_85_1.var_.characterEffect1042ui_story = var_88_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_4 = 0.2

			if var_88_3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_3 + var_88_4 and not isNil(var_88_2) then
				local var_88_5 = (arg_85_1.time_ - var_88_3) / var_88_4

				if arg_85_1.var_.characterEffect1042ui_story and not isNil(var_88_2) then
					local var_88_6 = Mathf.Lerp(0, 0.5, var_88_5)

					arg_85_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1042ui_story.fillRatio = var_88_6
				end
			end

			if arg_85_1.time_ >= var_88_3 + var_88_4 and arg_85_1.time_ < var_88_3 + var_88_4 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect1042ui_story then
				local var_88_7 = 0.5

				arg_85_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1042ui_story.fillRatio = var_88_7
			end

			local var_88_8 = arg_85_1.actors_["1067ui_story"]
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.characterEffect1067ui_story == nil then
				arg_85_1.var_.characterEffect1067ui_story = var_88_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_10 = 0.2

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_10 and not isNil(var_88_8) then
				local var_88_11 = (arg_85_1.time_ - var_88_9) / var_88_10

				if arg_85_1.var_.characterEffect1067ui_story and not isNil(var_88_8) then
					arg_85_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_9 + var_88_10 and arg_85_1.time_ < var_88_9 + var_88_10 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.characterEffect1067ui_story then
				arg_85_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_88_12 = 0
			local var_88_13 = 0.05

			if var_88_12 < arg_85_1.time_ and arg_85_1.time_ <= var_88_12 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_14 = arg_85_1:FormatText(StoryNameCfg[206].name)

				arg_85_1.leftNameTxt_.text = var_88_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_15 = arg_85_1:GetWordFromCfg(114111021)
				local var_88_16 = arg_85_1:FormatText(var_88_15.content)

				arg_85_1.text_.text = var_88_16

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_17 = 2
				local var_88_18 = utf8.len(var_88_16)
				local var_88_19 = var_88_17 <= 0 and var_88_13 or var_88_13 * (var_88_18 / var_88_17)

				if var_88_19 > 0 and var_88_13 < var_88_19 then
					arg_85_1.talkMaxDuration = var_88_19

					if var_88_19 + var_88_12 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_19 + var_88_12
					end
				end

				arg_85_1.text_.text = var_88_16
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111021", "story_v_out_114111.awb") ~= 0 then
					local var_88_20 = manager.audio:GetVoiceLength("story_v_out_114111", "114111021", "story_v_out_114111.awb") / 1000

					if var_88_20 + var_88_12 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_20 + var_88_12
					end

					if var_88_15.prefab_name ~= "" and arg_85_1.actors_[var_88_15.prefab_name] ~= nil then
						local var_88_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_15.prefab_name].transform, "story_v_out_114111", "114111021", "story_v_out_114111.awb")

						arg_85_1:RecordAudio("114111021", var_88_21)
						arg_85_1:RecordAudio("114111021", var_88_21)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_114111", "114111021", "story_v_out_114111.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_114111", "114111021", "story_v_out_114111.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_22 = math.max(var_88_13, arg_85_1.talkMaxDuration)

			if var_88_12 <= arg_85_1.time_ and arg_85_1.time_ < var_88_12 + var_88_22 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_12) / var_88_22

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_12 + var_88_22 and arg_85_1.time_ < var_88_12 + var_88_22 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play114111022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114111022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play114111023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1067ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1067ui_story == nil then
				arg_89_1.var_.characterEffect1067ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1067ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1067ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1067ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1067ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 0.45

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(114111022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 18
				local var_92_11 = utf8.len(var_92_9)
				local var_92_12 = var_92_10 <= 0 and var_92_7 or var_92_7 * (var_92_11 / var_92_10)

				if var_92_12 > 0 and var_92_7 < var_92_12 then
					arg_89_1.talkMaxDuration = var_92_12

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_13 and arg_89_1.time_ < var_92_6 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play114111023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114111023
		arg_93_1.duration_ = 15.5

		local var_93_0 = {
			ja = 14.7,
			ko = 14.633,
			zh = 14.166,
			en = 15.5
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play114111024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action475")
			end

			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_96_2 = arg_93_1.actors_["1067ui_story"]
			local var_96_3 = 0

			if var_96_3 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect1067ui_story == nil then
				arg_93_1.var_.characterEffect1067ui_story = var_96_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_4 = 0.2

			if var_96_3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_3 + var_96_4 and not isNil(var_96_2) then
				local var_96_5 = (arg_93_1.time_ - var_96_3) / var_96_4

				if arg_93_1.var_.characterEffect1067ui_story and not isNil(var_96_2) then
					arg_93_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_3 + var_96_4 and arg_93_1.time_ < var_96_3 + var_96_4 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect1067ui_story then
				arg_93_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_96_6 = 0
			local var_96_7 = 1.475

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_8 = arg_93_1:FormatText(StoryNameCfg[206].name)

				arg_93_1.leftNameTxt_.text = var_96_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_9 = arg_93_1:GetWordFromCfg(114111023)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 59
				local var_96_12 = utf8.len(var_96_10)
				local var_96_13 = var_96_11 <= 0 and var_96_7 or var_96_7 * (var_96_12 / var_96_11)

				if var_96_13 > 0 and var_96_7 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111023", "story_v_out_114111.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_114111", "114111023", "story_v_out_114111.awb") / 1000

					if var_96_14 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_6
					end

					if var_96_9.prefab_name ~= "" and arg_93_1.actors_[var_96_9.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_9.prefab_name].transform, "story_v_out_114111", "114111023", "story_v_out_114111.awb")

						arg_93_1:RecordAudio("114111023", var_96_15)
						arg_93_1:RecordAudio("114111023", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_114111", "114111023", "story_v_out_114111.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_114111", "114111023", "story_v_out_114111.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_16 and arg_93_1.time_ < var_96_6 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play114111024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114111024
		arg_97_1.duration_ = 14.07

		local var_97_0 = {
			ja = 11.3,
			ko = 14.066,
			zh = 12.633,
			en = 12.6
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play114111025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action457")
			end

			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_100_2 = 0
			local var_100_3 = 1.3

			if var_100_2 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_4 = arg_97_1:FormatText(StoryNameCfg[206].name)

				arg_97_1.leftNameTxt_.text = var_100_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_5 = arg_97_1:GetWordFromCfg(114111024)
				local var_100_6 = arg_97_1:FormatText(var_100_5.content)

				arg_97_1.text_.text = var_100_6

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 52
				local var_100_8 = utf8.len(var_100_6)
				local var_100_9 = var_100_7 <= 0 and var_100_3 or var_100_3 * (var_100_8 / var_100_7)

				if var_100_9 > 0 and var_100_3 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_2
					end
				end

				arg_97_1.text_.text = var_100_6
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111024", "story_v_out_114111.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111024", "story_v_out_114111.awb") / 1000

					if var_100_10 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_2
					end

					if var_100_5.prefab_name ~= "" and arg_97_1.actors_[var_100_5.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_5.prefab_name].transform, "story_v_out_114111", "114111024", "story_v_out_114111.awb")

						arg_97_1:RecordAudio("114111024", var_100_11)
						arg_97_1:RecordAudio("114111024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_114111", "114111024", "story_v_out_114111.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_114111", "114111024", "story_v_out_114111.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_3, arg_97_1.talkMaxDuration)

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_2) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_2 + var_100_12 and arg_97_1.time_ < var_100_2 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play114111025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114111025
		arg_101_1.duration_ = 12.23

		local var_101_0 = {
			ja = 12.233,
			ko = 8.933,
			zh = 9.966,
			en = 11.333
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play114111026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1067ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1067ui_story == nil then
				arg_101_1.var_.characterEffect1067ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1067ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1067ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1067ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1067ui_story.fillRatio = var_104_5
			end

			local var_104_6 = 0

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_104_7 = arg_101_1.actors_["1042ui_story"]
			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.characterEffect1042ui_story == nil then
				arg_101_1.var_.characterEffect1042ui_story = var_104_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_9 = 0.2

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_9 and not isNil(var_104_7) then
				local var_104_10 = (arg_101_1.time_ - var_104_8) / var_104_9

				if arg_101_1.var_.characterEffect1042ui_story and not isNil(var_104_7) then
					arg_101_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.characterEffect1042ui_story then
				arg_101_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_104_11 = 0

			if var_104_11 < arg_101_1.time_ and arg_101_1.time_ <= var_104_11 + arg_104_0 then
				arg_101_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_104_12 = 0
			local var_104_13 = 0.975

			if var_104_12 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_14 = arg_101_1:FormatText(StoryNameCfg[205].name)

				arg_101_1.leftNameTxt_.text = var_104_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_15 = arg_101_1:GetWordFromCfg(114111025)
				local var_104_16 = arg_101_1:FormatText(var_104_15.content)

				arg_101_1.text_.text = var_104_16

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_17 = 39
				local var_104_18 = utf8.len(var_104_16)
				local var_104_19 = var_104_17 <= 0 and var_104_13 or var_104_13 * (var_104_18 / var_104_17)

				if var_104_19 > 0 and var_104_13 < var_104_19 then
					arg_101_1.talkMaxDuration = var_104_19

					if var_104_19 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_19 + var_104_12
					end
				end

				arg_101_1.text_.text = var_104_16
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111025", "story_v_out_114111.awb") ~= 0 then
					local var_104_20 = manager.audio:GetVoiceLength("story_v_out_114111", "114111025", "story_v_out_114111.awb") / 1000

					if var_104_20 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_20 + var_104_12
					end

					if var_104_15.prefab_name ~= "" and arg_101_1.actors_[var_104_15.prefab_name] ~= nil then
						local var_104_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_15.prefab_name].transform, "story_v_out_114111", "114111025", "story_v_out_114111.awb")

						arg_101_1:RecordAudio("114111025", var_104_21)
						arg_101_1:RecordAudio("114111025", var_104_21)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_114111", "114111025", "story_v_out_114111.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_114111", "114111025", "story_v_out_114111.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_22 = math.max(var_104_13, arg_101_1.talkMaxDuration)

			if var_104_12 <= arg_101_1.time_ and arg_101_1.time_ < var_104_12 + var_104_22 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_12) / var_104_22

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_12 + var_104_22 and arg_101_1.time_ < var_104_12 + var_104_22 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play114111026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 114111026
		arg_105_1.duration_ = 12.63

		local var_105_0 = {
			ja = 12.5,
			ko = 9.133,
			zh = 8.966,
			en = 12.633
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play114111027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_108_1 = 0
			local var_108_2 = 1.025

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_3 = arg_105_1:FormatText(StoryNameCfg[205].name)

				arg_105_1.leftNameTxt_.text = var_108_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(114111026)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_6 = 41
				local var_108_7 = utf8.len(var_108_5)
				local var_108_8 = var_108_6 <= 0 and var_108_2 or var_108_2 * (var_108_7 / var_108_6)

				if var_108_8 > 0 and var_108_2 < var_108_8 then
					arg_105_1.talkMaxDuration = var_108_8

					if var_108_8 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111026", "story_v_out_114111.awb") ~= 0 then
					local var_108_9 = manager.audio:GetVoiceLength("story_v_out_114111", "114111026", "story_v_out_114111.awb") / 1000

					if var_108_9 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_1
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_out_114111", "114111026", "story_v_out_114111.awb")

						arg_105_1:RecordAudio("114111026", var_108_10)
						arg_105_1:RecordAudio("114111026", var_108_10)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_114111", "114111026", "story_v_out_114111.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_114111", "114111026", "story_v_out_114111.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_11 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_11 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_11

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_11 and arg_105_1.time_ < var_108_1 + var_108_11 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play114111027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 114111027
		arg_109_1.duration_ = 4.2

		local var_109_0 = {
			ja = 4.2,
			ko = 2.7,
			zh = 3.2,
			en = 3.2
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play114111028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_112_1 = arg_109_1.actors_["1067ui_story"]
			local var_112_2 = 0

			if var_112_2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1067ui_story == nil then
				arg_109_1.var_.characterEffect1067ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_3 = 0.2

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_3 and not isNil(var_112_1) then
				local var_112_4 = (arg_109_1.time_ - var_112_2) / var_112_3

				if arg_109_1.var_.characterEffect1067ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_2 + var_112_3 and arg_109_1.time_ < var_112_2 + var_112_3 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1067ui_story then
				arg_109_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_112_5 = arg_109_1.actors_["1042ui_story"]
			local var_112_6 = 0

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1042ui_story == nil then
				arg_109_1.var_.characterEffect1042ui_story = var_112_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_7 = 0.2

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_7 and not isNil(var_112_5) then
				local var_112_8 = (arg_109_1.time_ - var_112_6) / var_112_7

				if arg_109_1.var_.characterEffect1042ui_story and not isNil(var_112_5) then
					local var_112_9 = Mathf.Lerp(0, 0.5, var_112_8)

					arg_109_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1042ui_story.fillRatio = var_112_9
				end
			end

			if arg_109_1.time_ >= var_112_6 + var_112_7 and arg_109_1.time_ < var_112_6 + var_112_7 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1042ui_story then
				local var_112_10 = 0.5

				arg_109_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1042ui_story.fillRatio = var_112_10
			end

			local var_112_11 = 0
			local var_112_12 = 0.3

			if var_112_11 < arg_109_1.time_ and arg_109_1.time_ <= var_112_11 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_13 = arg_109_1:FormatText(StoryNameCfg[206].name)

				arg_109_1.leftNameTxt_.text = var_112_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_14 = arg_109_1:GetWordFromCfg(114111027)
				local var_112_15 = arg_109_1:FormatText(var_112_14.content)

				arg_109_1.text_.text = var_112_15

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_16 = 12
				local var_112_17 = utf8.len(var_112_15)
				local var_112_18 = var_112_16 <= 0 and var_112_12 or var_112_12 * (var_112_17 / var_112_16)

				if var_112_18 > 0 and var_112_12 < var_112_18 then
					arg_109_1.talkMaxDuration = var_112_18

					if var_112_18 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_18 + var_112_11
					end
				end

				arg_109_1.text_.text = var_112_15
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111027", "story_v_out_114111.awb") ~= 0 then
					local var_112_19 = manager.audio:GetVoiceLength("story_v_out_114111", "114111027", "story_v_out_114111.awb") / 1000

					if var_112_19 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_19 + var_112_11
					end

					if var_112_14.prefab_name ~= "" and arg_109_1.actors_[var_112_14.prefab_name] ~= nil then
						local var_112_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_14.prefab_name].transform, "story_v_out_114111", "114111027", "story_v_out_114111.awb")

						arg_109_1:RecordAudio("114111027", var_112_20)
						arg_109_1:RecordAudio("114111027", var_112_20)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_114111", "114111027", "story_v_out_114111.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_114111", "114111027", "story_v_out_114111.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_21 = math.max(var_112_12, arg_109_1.talkMaxDuration)

			if var_112_11 <= arg_109_1.time_ and arg_109_1.time_ < var_112_11 + var_112_21 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_11) / var_112_21

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_11 + var_112_21 and arg_109_1.time_ < var_112_11 + var_112_21 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play114111028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 114111028
		arg_113_1.duration_ = 7.4

		local var_113_0 = {
			ja = 5.4,
			ko = 7.4,
			zh = 6.8,
			en = 6.733
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play114111029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1067ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1067ui_story == nil then
				arg_113_1.var_.characterEffect1067ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1067ui_story and not isNil(var_116_0) then
					local var_116_4 = Mathf.Lerp(0, 0.5, var_116_3)

					arg_113_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1067ui_story.fillRatio = var_116_4
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1067ui_story then
				local var_116_5 = 0.5

				arg_113_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1067ui_story.fillRatio = var_116_5
			end

			local var_116_6 = 0

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_116_7 = 0

			if var_116_7 < arg_113_1.time_ and arg_113_1.time_ <= var_116_7 + arg_116_0 then
				arg_113_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_116_8 = arg_113_1.actors_["1042ui_story"]
			local var_116_9 = 0

			if var_116_9 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.characterEffect1042ui_story == nil then
				arg_113_1.var_.characterEffect1042ui_story = var_116_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_10 = 0.2

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_10 and not isNil(var_116_8) then
				local var_116_11 = (arg_113_1.time_ - var_116_9) / var_116_10

				if arg_113_1.var_.characterEffect1042ui_story and not isNil(var_116_8) then
					arg_113_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_9 + var_116_10 and arg_113_1.time_ < var_116_9 + var_116_10 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.characterEffect1042ui_story then
				arg_113_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_116_12 = 0
			local var_116_13 = 0.675

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_14 = arg_113_1:FormatText(StoryNameCfg[205].name)

				arg_113_1.leftNameTxt_.text = var_116_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_15 = arg_113_1:GetWordFromCfg(114111028)
				local var_116_16 = arg_113_1:FormatText(var_116_15.content)

				arg_113_1.text_.text = var_116_16

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_17 = 27
				local var_116_18 = utf8.len(var_116_16)
				local var_116_19 = var_116_17 <= 0 and var_116_13 or var_116_13 * (var_116_18 / var_116_17)

				if var_116_19 > 0 and var_116_13 < var_116_19 then
					arg_113_1.talkMaxDuration = var_116_19

					if var_116_19 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_19 + var_116_12
					end
				end

				arg_113_1.text_.text = var_116_16
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111028", "story_v_out_114111.awb") ~= 0 then
					local var_116_20 = manager.audio:GetVoiceLength("story_v_out_114111", "114111028", "story_v_out_114111.awb") / 1000

					if var_116_20 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_20 + var_116_12
					end

					if var_116_15.prefab_name ~= "" and arg_113_1.actors_[var_116_15.prefab_name] ~= nil then
						local var_116_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_15.prefab_name].transform, "story_v_out_114111", "114111028", "story_v_out_114111.awb")

						arg_113_1:RecordAudio("114111028", var_116_21)
						arg_113_1:RecordAudio("114111028", var_116_21)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_114111", "114111028", "story_v_out_114111.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_114111", "114111028", "story_v_out_114111.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_22 = math.max(var_116_13, arg_113_1.talkMaxDuration)

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_22 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_12) / var_116_22

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_12 + var_116_22 and arg_113_1.time_ < var_116_12 + var_116_22 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play114111029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 114111029
		arg_117_1.duration_ = 11

		local var_117_0 = {
			ja = 11,
			ko = 9.3,
			zh = 8.7,
			en = 11
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play114111030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_120_1 = 0
			local var_120_2 = 1.05

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_3 = arg_117_1:FormatText(StoryNameCfg[205].name)

				arg_117_1.leftNameTxt_.text = var_120_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(114111029)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_6 = 42
				local var_120_7 = utf8.len(var_120_5)
				local var_120_8 = var_120_6 <= 0 and var_120_2 or var_120_2 * (var_120_7 / var_120_6)

				if var_120_8 > 0 and var_120_2 < var_120_8 then
					arg_117_1.talkMaxDuration = var_120_8

					if var_120_8 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111029", "story_v_out_114111.awb") ~= 0 then
					local var_120_9 = manager.audio:GetVoiceLength("story_v_out_114111", "114111029", "story_v_out_114111.awb") / 1000

					if var_120_9 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_1
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_out_114111", "114111029", "story_v_out_114111.awb")

						arg_117_1:RecordAudio("114111029", var_120_10)
						arg_117_1:RecordAudio("114111029", var_120_10)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_114111", "114111029", "story_v_out_114111.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_114111", "114111029", "story_v_out_114111.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_11 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_11 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_11

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_11 and arg_117_1.time_ < var_120_1 + var_120_11 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play114111030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 114111030
		arg_121_1.duration_ = 6

		local var_121_0 = {
			ja = 5.933,
			ko = 4.733,
			zh = 6,
			en = 5.7
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play114111031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_124_1 = arg_121_1.actors_["1067ui_story"]
			local var_124_2 = 0

			if var_124_2 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1067ui_story == nil then
				arg_121_1.var_.characterEffect1067ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_3 = 0.2

			if var_124_2 <= arg_121_1.time_ and arg_121_1.time_ < var_124_2 + var_124_3 and not isNil(var_124_1) then
				local var_124_4 = (arg_121_1.time_ - var_124_2) / var_124_3

				if arg_121_1.var_.characterEffect1067ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_2 + var_124_3 and arg_121_1.time_ < var_124_2 + var_124_3 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1067ui_story then
				arg_121_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_124_5 = arg_121_1.actors_["1042ui_story"]
			local var_124_6 = 0

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect1042ui_story == nil then
				arg_121_1.var_.characterEffect1042ui_story = var_124_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_7 = 0.2

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_7 and not isNil(var_124_5) then
				local var_124_8 = (arg_121_1.time_ - var_124_6) / var_124_7

				if arg_121_1.var_.characterEffect1042ui_story and not isNil(var_124_5) then
					local var_124_9 = Mathf.Lerp(0, 0.5, var_124_8)

					arg_121_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1042ui_story.fillRatio = var_124_9
				end
			end

			if arg_121_1.time_ >= var_124_6 + var_124_7 and arg_121_1.time_ < var_124_6 + var_124_7 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect1042ui_story then
				local var_124_10 = 0.5

				arg_121_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1042ui_story.fillRatio = var_124_10
			end

			local var_124_11 = 0
			local var_124_12 = 0.65

			if var_124_11 < arg_121_1.time_ and arg_121_1.time_ <= var_124_11 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_13 = arg_121_1:FormatText(StoryNameCfg[206].name)

				arg_121_1.leftNameTxt_.text = var_124_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_14 = arg_121_1:GetWordFromCfg(114111030)
				local var_124_15 = arg_121_1:FormatText(var_124_14.content)

				arg_121_1.text_.text = var_124_15

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_16 = 26
				local var_124_17 = utf8.len(var_124_15)
				local var_124_18 = var_124_16 <= 0 and var_124_12 or var_124_12 * (var_124_17 / var_124_16)

				if var_124_18 > 0 and var_124_12 < var_124_18 then
					arg_121_1.talkMaxDuration = var_124_18

					if var_124_18 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_18 + var_124_11
					end
				end

				arg_121_1.text_.text = var_124_15
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111030", "story_v_out_114111.awb") ~= 0 then
					local var_124_19 = manager.audio:GetVoiceLength("story_v_out_114111", "114111030", "story_v_out_114111.awb") / 1000

					if var_124_19 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_19 + var_124_11
					end

					if var_124_14.prefab_name ~= "" and arg_121_1.actors_[var_124_14.prefab_name] ~= nil then
						local var_124_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_14.prefab_name].transform, "story_v_out_114111", "114111030", "story_v_out_114111.awb")

						arg_121_1:RecordAudio("114111030", var_124_20)
						arg_121_1:RecordAudio("114111030", var_124_20)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_114111", "114111030", "story_v_out_114111.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_114111", "114111030", "story_v_out_114111.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_21 = math.max(var_124_12, arg_121_1.talkMaxDuration)

			if var_124_11 <= arg_121_1.time_ and arg_121_1.time_ < var_124_11 + var_124_21 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_11) / var_124_21

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_11 + var_124_21 and arg_121_1.time_ < var_124_11 + var_124_21 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play114111031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 114111031
		arg_125_1.duration_ = 11.27

		local var_125_0 = {
			ja = 11.266,
			ko = 10.5,
			zh = 7.8,
			en = 9.866
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play114111032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1042ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1042ui_story == nil then
				arg_125_1.var_.characterEffect1042ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1042ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1042ui_story then
				arg_125_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_128_4 = arg_125_1.actors_["1067ui_story"]
			local var_128_5 = 0

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1067ui_story == nil then
				arg_125_1.var_.characterEffect1067ui_story = var_128_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_6 = 0.2

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_6 and not isNil(var_128_4) then
				local var_128_7 = (arg_125_1.time_ - var_128_5) / var_128_6

				if arg_125_1.var_.characterEffect1067ui_story and not isNil(var_128_4) then
					local var_128_8 = Mathf.Lerp(0, 0.5, var_128_7)

					arg_125_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1067ui_story.fillRatio = var_128_8
				end
			end

			if arg_125_1.time_ >= var_128_5 + var_128_6 and arg_125_1.time_ < var_128_5 + var_128_6 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1067ui_story then
				local var_128_9 = 0.5

				arg_125_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1067ui_story.fillRatio = var_128_9
			end

			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_128_11 = 0

			if var_128_11 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_1")
			end

			local var_128_12 = 0
			local var_128_13 = 0.9

			if var_128_12 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_14 = arg_125_1:FormatText(StoryNameCfg[205].name)

				arg_125_1.leftNameTxt_.text = var_128_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_15 = arg_125_1:GetWordFromCfg(114111031)
				local var_128_16 = arg_125_1:FormatText(var_128_15.content)

				arg_125_1.text_.text = var_128_16

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_17 = 36
				local var_128_18 = utf8.len(var_128_16)
				local var_128_19 = var_128_17 <= 0 and var_128_13 or var_128_13 * (var_128_18 / var_128_17)

				if var_128_19 > 0 and var_128_13 < var_128_19 then
					arg_125_1.talkMaxDuration = var_128_19

					if var_128_19 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_19 + var_128_12
					end
				end

				arg_125_1.text_.text = var_128_16
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111031", "story_v_out_114111.awb") ~= 0 then
					local var_128_20 = manager.audio:GetVoiceLength("story_v_out_114111", "114111031", "story_v_out_114111.awb") / 1000

					if var_128_20 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_20 + var_128_12
					end

					if var_128_15.prefab_name ~= "" and arg_125_1.actors_[var_128_15.prefab_name] ~= nil then
						local var_128_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_15.prefab_name].transform, "story_v_out_114111", "114111031", "story_v_out_114111.awb")

						arg_125_1:RecordAudio("114111031", var_128_21)
						arg_125_1:RecordAudio("114111031", var_128_21)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_114111", "114111031", "story_v_out_114111.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_114111", "114111031", "story_v_out_114111.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_22 = math.max(var_128_13, arg_125_1.talkMaxDuration)

			if var_128_12 <= arg_125_1.time_ and arg_125_1.time_ < var_128_12 + var_128_22 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_12) / var_128_22

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_12 + var_128_22 and arg_125_1.time_ < var_128_12 + var_128_22 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play114111032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 114111032
		arg_129_1.duration_ = 5.57

		local var_129_0 = {
			ja = 4.266,
			ko = 3.433,
			zh = 5.566,
			en = 3.766
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play114111033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_132_1 = arg_129_1.actors_["1067ui_story"]
			local var_132_2 = 0

			if var_132_2 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1067ui_story == nil then
				arg_129_1.var_.characterEffect1067ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_3 = 0.2

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_3 and not isNil(var_132_1) then
				local var_132_4 = (arg_129_1.time_ - var_132_2) / var_132_3

				if arg_129_1.var_.characterEffect1067ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_2 + var_132_3 and arg_129_1.time_ < var_132_2 + var_132_3 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1067ui_story then
				arg_129_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_132_5 = arg_129_1.actors_["1042ui_story"]
			local var_132_6 = 0

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1042ui_story == nil then
				arg_129_1.var_.characterEffect1042ui_story = var_132_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_7 = 0.2

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_7 and not isNil(var_132_5) then
				local var_132_8 = (arg_129_1.time_ - var_132_6) / var_132_7

				if arg_129_1.var_.characterEffect1042ui_story and not isNil(var_132_5) then
					local var_132_9 = Mathf.Lerp(0, 0.5, var_132_8)

					arg_129_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1042ui_story.fillRatio = var_132_9
				end
			end

			if arg_129_1.time_ >= var_132_6 + var_132_7 and arg_129_1.time_ < var_132_6 + var_132_7 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1042ui_story then
				local var_132_10 = 0.5

				arg_129_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1042ui_story.fillRatio = var_132_10
			end

			local var_132_11 = 0
			local var_132_12 = 0.45

			if var_132_11 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_13 = arg_129_1:FormatText(StoryNameCfg[206].name)

				arg_129_1.leftNameTxt_.text = var_132_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_14 = arg_129_1:GetWordFromCfg(114111032)
				local var_132_15 = arg_129_1:FormatText(var_132_14.content)

				arg_129_1.text_.text = var_132_15

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_16 = 18
				local var_132_17 = utf8.len(var_132_15)
				local var_132_18 = var_132_16 <= 0 and var_132_12 or var_132_12 * (var_132_17 / var_132_16)

				if var_132_18 > 0 and var_132_12 < var_132_18 then
					arg_129_1.talkMaxDuration = var_132_18

					if var_132_18 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_18 + var_132_11
					end
				end

				arg_129_1.text_.text = var_132_15
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111032", "story_v_out_114111.awb") ~= 0 then
					local var_132_19 = manager.audio:GetVoiceLength("story_v_out_114111", "114111032", "story_v_out_114111.awb") / 1000

					if var_132_19 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_19 + var_132_11
					end

					if var_132_14.prefab_name ~= "" and arg_129_1.actors_[var_132_14.prefab_name] ~= nil then
						local var_132_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_14.prefab_name].transform, "story_v_out_114111", "114111032", "story_v_out_114111.awb")

						arg_129_1:RecordAudio("114111032", var_132_20)
						arg_129_1:RecordAudio("114111032", var_132_20)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_114111", "114111032", "story_v_out_114111.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_114111", "114111032", "story_v_out_114111.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_21 = math.max(var_132_12, arg_129_1.talkMaxDuration)

			if var_132_11 <= arg_129_1.time_ and arg_129_1.time_ < var_132_11 + var_132_21 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_11) / var_132_21

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_11 + var_132_21 and arg_129_1.time_ < var_132_11 + var_132_21 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play114111033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 114111033
		arg_133_1.duration_ = 7.6

		local var_133_0 = {
			ja = 7.366,
			ko = 4.533,
			zh = 5.766,
			en = 7.6
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play114111034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1067ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1067ui_story == nil then
				arg_133_1.var_.characterEffect1067ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1067ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1067ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1067ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1067ui_story.fillRatio = var_136_5
			end

			local var_136_6 = 0

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_136_7 = 0

			if var_136_7 < arg_133_1.time_ and arg_133_1.time_ <= var_136_7 + arg_136_0 then
				arg_133_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_2")
			end

			local var_136_8 = arg_133_1.actors_["1042ui_story"]
			local var_136_9 = 0

			if var_136_9 < arg_133_1.time_ and arg_133_1.time_ <= var_136_9 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.characterEffect1042ui_story == nil then
				arg_133_1.var_.characterEffect1042ui_story = var_136_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_10 = 0.2

			if var_136_9 <= arg_133_1.time_ and arg_133_1.time_ < var_136_9 + var_136_10 and not isNil(var_136_8) then
				local var_136_11 = (arg_133_1.time_ - var_136_9) / var_136_10

				if arg_133_1.var_.characterEffect1042ui_story and not isNil(var_136_8) then
					arg_133_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_9 + var_136_10 and arg_133_1.time_ < var_136_9 + var_136_10 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.characterEffect1042ui_story then
				arg_133_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_136_12 = 0
			local var_136_13 = 0.65

			if var_136_12 < arg_133_1.time_ and arg_133_1.time_ <= var_136_12 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_14 = arg_133_1:FormatText(StoryNameCfg[205].name)

				arg_133_1.leftNameTxt_.text = var_136_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_15 = arg_133_1:GetWordFromCfg(114111033)
				local var_136_16 = arg_133_1:FormatText(var_136_15.content)

				arg_133_1.text_.text = var_136_16

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_17 = 26
				local var_136_18 = utf8.len(var_136_16)
				local var_136_19 = var_136_17 <= 0 and var_136_13 or var_136_13 * (var_136_18 / var_136_17)

				if var_136_19 > 0 and var_136_13 < var_136_19 then
					arg_133_1.talkMaxDuration = var_136_19

					if var_136_19 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_19 + var_136_12
					end
				end

				arg_133_1.text_.text = var_136_16
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111033", "story_v_out_114111.awb") ~= 0 then
					local var_136_20 = manager.audio:GetVoiceLength("story_v_out_114111", "114111033", "story_v_out_114111.awb") / 1000

					if var_136_20 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_20 + var_136_12
					end

					if var_136_15.prefab_name ~= "" and arg_133_1.actors_[var_136_15.prefab_name] ~= nil then
						local var_136_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_15.prefab_name].transform, "story_v_out_114111", "114111033", "story_v_out_114111.awb")

						arg_133_1:RecordAudio("114111033", var_136_21)
						arg_133_1:RecordAudio("114111033", var_136_21)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_114111", "114111033", "story_v_out_114111.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_114111", "114111033", "story_v_out_114111.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_22 = math.max(var_136_13, arg_133_1.talkMaxDuration)

			if var_136_12 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_22 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_12) / var_136_22

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_12 + var_136_22 and arg_133_1.time_ < var_136_12 + var_136_22 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play114111034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 114111034
		arg_137_1.duration_ = 5.2

		local var_137_0 = {
			ja = 5.2,
			ko = 3.566,
			zh = 3.2,
			en = 3.333
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play114111035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_140_1 = arg_137_1.actors_["1067ui_story"]
			local var_140_2 = 0

			if var_140_2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1067ui_story == nil then
				arg_137_1.var_.characterEffect1067ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_3 = 0.2

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_3 and not isNil(var_140_1) then
				local var_140_4 = (arg_137_1.time_ - var_140_2) / var_140_3

				if arg_137_1.var_.characterEffect1067ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_2 + var_140_3 and arg_137_1.time_ < var_140_2 + var_140_3 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1067ui_story then
				arg_137_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_140_5 = arg_137_1.actors_["1042ui_story"]
			local var_140_6 = 0

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.characterEffect1042ui_story == nil then
				arg_137_1.var_.characterEffect1042ui_story = var_140_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_7 = 0.2

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_7 and not isNil(var_140_5) then
				local var_140_8 = (arg_137_1.time_ - var_140_6) / var_140_7

				if arg_137_1.var_.characterEffect1042ui_story and not isNil(var_140_5) then
					local var_140_9 = Mathf.Lerp(0, 0.5, var_140_8)

					arg_137_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1042ui_story.fillRatio = var_140_9
				end
			end

			if arg_137_1.time_ >= var_140_6 + var_140_7 and arg_137_1.time_ < var_140_6 + var_140_7 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.characterEffect1042ui_story then
				local var_140_10 = 0.5

				arg_137_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1042ui_story.fillRatio = var_140_10
			end

			local var_140_11 = 0
			local var_140_12 = 0.325

			if var_140_11 < arg_137_1.time_ and arg_137_1.time_ <= var_140_11 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_13 = arg_137_1:FormatText(StoryNameCfg[206].name)

				arg_137_1.leftNameTxt_.text = var_140_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_14 = arg_137_1:GetWordFromCfg(114111034)
				local var_140_15 = arg_137_1:FormatText(var_140_14.content)

				arg_137_1.text_.text = var_140_15

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_16 = 13
				local var_140_17 = utf8.len(var_140_15)
				local var_140_18 = var_140_16 <= 0 and var_140_12 or var_140_12 * (var_140_17 / var_140_16)

				if var_140_18 > 0 and var_140_12 < var_140_18 then
					arg_137_1.talkMaxDuration = var_140_18

					if var_140_18 + var_140_11 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_18 + var_140_11
					end
				end

				arg_137_1.text_.text = var_140_15
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111034", "story_v_out_114111.awb") ~= 0 then
					local var_140_19 = manager.audio:GetVoiceLength("story_v_out_114111", "114111034", "story_v_out_114111.awb") / 1000

					if var_140_19 + var_140_11 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_19 + var_140_11
					end

					if var_140_14.prefab_name ~= "" and arg_137_1.actors_[var_140_14.prefab_name] ~= nil then
						local var_140_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_14.prefab_name].transform, "story_v_out_114111", "114111034", "story_v_out_114111.awb")

						arg_137_1:RecordAudio("114111034", var_140_20)
						arg_137_1:RecordAudio("114111034", var_140_20)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_114111", "114111034", "story_v_out_114111.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_114111", "114111034", "story_v_out_114111.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_21 = math.max(var_140_12, arg_137_1.talkMaxDuration)

			if var_140_11 <= arg_137_1.time_ and arg_137_1.time_ < var_140_11 + var_140_21 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_11) / var_140_21

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_11 + var_140_21 and arg_137_1.time_ < var_140_11 + var_140_21 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play114111035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 114111035
		arg_141_1.duration_ = 8.5

		local var_141_0 = {
			ja = 8.5,
			ko = 4.366,
			zh = 6.7,
			en = 7.433
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play114111036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_144_2 = arg_141_1.actors_["1042ui_story"]
			local var_144_3 = 0

			if var_144_3 < arg_141_1.time_ and arg_141_1.time_ <= var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1042ui_story == nil then
				arg_141_1.var_.characterEffect1042ui_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_4 = 0.2

			if var_144_3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_3 + var_144_4 and not isNil(var_144_2) then
				local var_144_5 = (arg_141_1.time_ - var_144_3) / var_144_4

				if arg_141_1.var_.characterEffect1042ui_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_3 + var_144_4 and arg_141_1.time_ < var_144_3 + var_144_4 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1042ui_story then
				arg_141_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_144_6 = arg_141_1.actors_["1067ui_story"]
			local var_144_7 = 0

			if var_144_7 < arg_141_1.time_ and arg_141_1.time_ <= var_144_7 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1067ui_story == nil then
				arg_141_1.var_.characterEffect1067ui_story = var_144_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_8 = 0.2

			if var_144_7 <= arg_141_1.time_ and arg_141_1.time_ < var_144_7 + var_144_8 and not isNil(var_144_6) then
				local var_144_9 = (arg_141_1.time_ - var_144_7) / var_144_8

				if arg_141_1.var_.characterEffect1067ui_story and not isNil(var_144_6) then
					local var_144_10 = Mathf.Lerp(0, 0.5, var_144_9)

					arg_141_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1067ui_story.fillRatio = var_144_10
				end
			end

			if arg_141_1.time_ >= var_144_7 + var_144_8 and arg_141_1.time_ < var_144_7 + var_144_8 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1067ui_story then
				local var_144_11 = 0.5

				arg_141_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1067ui_story.fillRatio = var_144_11
			end

			local var_144_12 = 0
			local var_144_13 = 0.55

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_14 = arg_141_1:FormatText(StoryNameCfg[205].name)

				arg_141_1.leftNameTxt_.text = var_144_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_15 = arg_141_1:GetWordFromCfg(114111035)
				local var_144_16 = arg_141_1:FormatText(var_144_15.content)

				arg_141_1.text_.text = var_144_16

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_17 = 22
				local var_144_18 = utf8.len(var_144_16)
				local var_144_19 = var_144_17 <= 0 and var_144_13 or var_144_13 * (var_144_18 / var_144_17)

				if var_144_19 > 0 and var_144_13 < var_144_19 then
					arg_141_1.talkMaxDuration = var_144_19

					if var_144_19 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_19 + var_144_12
					end
				end

				arg_141_1.text_.text = var_144_16
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111035", "story_v_out_114111.awb") ~= 0 then
					local var_144_20 = manager.audio:GetVoiceLength("story_v_out_114111", "114111035", "story_v_out_114111.awb") / 1000

					if var_144_20 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_20 + var_144_12
					end

					if var_144_15.prefab_name ~= "" and arg_141_1.actors_[var_144_15.prefab_name] ~= nil then
						local var_144_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_15.prefab_name].transform, "story_v_out_114111", "114111035", "story_v_out_114111.awb")

						arg_141_1:RecordAudio("114111035", var_144_21)
						arg_141_1:RecordAudio("114111035", var_144_21)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_114111", "114111035", "story_v_out_114111.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_114111", "114111035", "story_v_out_114111.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_22 = math.max(var_144_13, arg_141_1.talkMaxDuration)

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_22 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_12) / var_144_22

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_12 + var_144_22 and arg_141_1.time_ < var_144_12 + var_144_22 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play114111036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 114111036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play114111037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1067ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1067ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, 100, 0)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1067ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, 100, 0)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["1042ui_story"].transform
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.var_.moveOldPos1042ui_story = var_148_9.localPosition
			end

			local var_148_11 = 0.001

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11
				local var_148_13 = Vector3.New(0, 100, 0)

				var_148_9.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1042ui_story, var_148_13, var_148_12)

				local var_148_14 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_14.x, var_148_14.y, var_148_14.z)

				local var_148_15 = var_148_9.localEulerAngles

				var_148_15.z = 0
				var_148_15.x = 0
				var_148_9.localEulerAngles = var_148_15
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 then
				var_148_9.localPosition = Vector3.New(0, 100, 0)

				local var_148_16 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_16.x, var_148_16.y, var_148_16.z)

				local var_148_17 = var_148_9.localEulerAngles

				var_148_17.z = 0
				var_148_17.x = 0
				var_148_9.localEulerAngles = var_148_17
			end

			local var_148_18 = 0
			local var_148_19 = 1.075

			if var_148_18 < arg_145_1.time_ and arg_145_1.time_ <= var_148_18 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_20 = arg_145_1:GetWordFromCfg(114111036)
				local var_148_21 = arg_145_1:FormatText(var_148_20.content)

				arg_145_1.text_.text = var_148_21

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_22 = 43
				local var_148_23 = utf8.len(var_148_21)
				local var_148_24 = var_148_22 <= 0 and var_148_19 or var_148_19 * (var_148_23 / var_148_22)

				if var_148_24 > 0 and var_148_19 < var_148_24 then
					arg_145_1.talkMaxDuration = var_148_24

					if var_148_24 + var_148_18 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_24 + var_148_18
					end
				end

				arg_145_1.text_.text = var_148_21
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_25 = math.max(var_148_19, arg_145_1.talkMaxDuration)

			if var_148_18 <= arg_145_1.time_ and arg_145_1.time_ < var_148_18 + var_148_25 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_18) / var_148_25

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_18 + var_148_25 and arg_145_1.time_ < var_148_18 + var_148_25 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play114111037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 114111037
		arg_149_1.duration_ = 15.17

		local var_149_0 = {
			ja = 13.333,
			ko = 11.933,
			zh = 13.566,
			en = 15.166
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
				arg_149_0:Play114111038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1067ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1067ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1067ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = 0

			if var_152_9 < arg_149_1.time_ and arg_149_1.time_ <= var_152_9 + arg_152_0 then
				arg_149_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_152_11 = arg_149_1.actors_["1067ui_story"]
			local var_152_12 = 0

			if var_152_12 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 and not isNil(var_152_11) and arg_149_1.var_.characterEffect1067ui_story == nil then
				arg_149_1.var_.characterEffect1067ui_story = var_152_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_13 = 0.2

			if var_152_12 <= arg_149_1.time_ and arg_149_1.time_ < var_152_12 + var_152_13 and not isNil(var_152_11) then
				local var_152_14 = (arg_149_1.time_ - var_152_12) / var_152_13

				if arg_149_1.var_.characterEffect1067ui_story and not isNil(var_152_11) then
					arg_149_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_12 + var_152_13 and arg_149_1.time_ < var_152_12 + var_152_13 + arg_152_0 and not isNil(var_152_11) and arg_149_1.var_.characterEffect1067ui_story then
				arg_149_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_152_15 = arg_149_1.actors_["1042ui_story"].transform
			local var_152_16 = 0

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.var_.moveOldPos1042ui_story = var_152_15.localPosition
			end

			local var_152_17 = 0.001

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_17 then
				local var_152_18 = (arg_149_1.time_ - var_152_16) / var_152_17
				local var_152_19 = Vector3.New(0.7, -1.06, -6.2)

				var_152_15.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1042ui_story, var_152_19, var_152_18)

				local var_152_20 = manager.ui.mainCamera.transform.position - var_152_15.position

				var_152_15.forward = Vector3.New(var_152_20.x, var_152_20.y, var_152_20.z)

				local var_152_21 = var_152_15.localEulerAngles

				var_152_21.z = 0
				var_152_21.x = 0
				var_152_15.localEulerAngles = var_152_21
			end

			if arg_149_1.time_ >= var_152_16 + var_152_17 and arg_149_1.time_ < var_152_16 + var_152_17 + arg_152_0 then
				var_152_15.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_152_22 = manager.ui.mainCamera.transform.position - var_152_15.position

				var_152_15.forward = Vector3.New(var_152_22.x, var_152_22.y, var_152_22.z)

				local var_152_23 = var_152_15.localEulerAngles

				var_152_23.z = 0
				var_152_23.x = 0
				var_152_15.localEulerAngles = var_152_23
			end

			local var_152_24 = 0

			if var_152_24 < arg_149_1.time_ and arg_149_1.time_ <= var_152_24 + arg_152_0 then
				arg_149_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_152_25 = arg_149_1.actors_["1042ui_story"]
			local var_152_26 = 0

			if var_152_26 < arg_149_1.time_ and arg_149_1.time_ <= var_152_26 + arg_152_0 and not isNil(var_152_25) and arg_149_1.var_.characterEffect1042ui_story == nil then
				arg_149_1.var_.characterEffect1042ui_story = var_152_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_27 = 0.2

			if var_152_26 <= arg_149_1.time_ and arg_149_1.time_ < var_152_26 + var_152_27 and not isNil(var_152_25) then
				local var_152_28 = (arg_149_1.time_ - var_152_26) / var_152_27

				if arg_149_1.var_.characterEffect1042ui_story and not isNil(var_152_25) then
					local var_152_29 = Mathf.Lerp(0, 0.5, var_152_28)

					arg_149_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1042ui_story.fillRatio = var_152_29
				end
			end

			if arg_149_1.time_ >= var_152_26 + var_152_27 and arg_149_1.time_ < var_152_26 + var_152_27 + arg_152_0 and not isNil(var_152_25) and arg_149_1.var_.characterEffect1042ui_story then
				local var_152_30 = 0.5

				arg_149_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1042ui_story.fillRatio = var_152_30
			end

			local var_152_31 = 0
			local var_152_32 = 1.325

			if var_152_31 < arg_149_1.time_ and arg_149_1.time_ <= var_152_31 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_33 = arg_149_1:FormatText(StoryNameCfg[206].name)

				arg_149_1.leftNameTxt_.text = var_152_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_34 = arg_149_1:GetWordFromCfg(114111037)
				local var_152_35 = arg_149_1:FormatText(var_152_34.content)

				arg_149_1.text_.text = var_152_35

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_36 = 53
				local var_152_37 = utf8.len(var_152_35)
				local var_152_38 = var_152_36 <= 0 and var_152_32 or var_152_32 * (var_152_37 / var_152_36)

				if var_152_38 > 0 and var_152_32 < var_152_38 then
					arg_149_1.talkMaxDuration = var_152_38

					if var_152_38 + var_152_31 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_38 + var_152_31
					end
				end

				arg_149_1.text_.text = var_152_35
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111037", "story_v_out_114111.awb") ~= 0 then
					local var_152_39 = manager.audio:GetVoiceLength("story_v_out_114111", "114111037", "story_v_out_114111.awb") / 1000

					if var_152_39 + var_152_31 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_39 + var_152_31
					end

					if var_152_34.prefab_name ~= "" and arg_149_1.actors_[var_152_34.prefab_name] ~= nil then
						local var_152_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_34.prefab_name].transform, "story_v_out_114111", "114111037", "story_v_out_114111.awb")

						arg_149_1:RecordAudio("114111037", var_152_40)
						arg_149_1:RecordAudio("114111037", var_152_40)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_114111", "114111037", "story_v_out_114111.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_114111", "114111037", "story_v_out_114111.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_41 = math.max(var_152_32, arg_149_1.talkMaxDuration)

			if var_152_31 <= arg_149_1.time_ and arg_149_1.time_ < var_152_31 + var_152_41 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_31) / var_152_41

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_31 + var_152_41 and arg_149_1.time_ < var_152_31 + var_152_41 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play114111038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 114111038
		arg_153_1.duration_ = 9.27

		local var_153_0 = {
			ja = 8.166,
			ko = 9.266,
			zh = 8.2,
			en = 6.7
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
				arg_153_0:Play114111039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			local var_156_1 = arg_153_1.actors_["1042ui_story"]
			local var_156_2 = 0

			if var_156_2 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1042ui_story == nil then
				arg_153_1.var_.characterEffect1042ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.2

			if var_156_2 <= arg_153_1.time_ and arg_153_1.time_ < var_156_2 + var_156_3 and not isNil(var_156_1) then
				local var_156_4 = (arg_153_1.time_ - var_156_2) / var_156_3

				if arg_153_1.var_.characterEffect1042ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_2 + var_156_3 and arg_153_1.time_ < var_156_2 + var_156_3 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1042ui_story then
				arg_153_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_156_5 = arg_153_1.actors_["1067ui_story"]
			local var_156_6 = 0

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect1067ui_story == nil then
				arg_153_1.var_.characterEffect1067ui_story = var_156_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_7 = 0.2

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_7 and not isNil(var_156_5) then
				local var_156_8 = (arg_153_1.time_ - var_156_6) / var_156_7

				if arg_153_1.var_.characterEffect1067ui_story and not isNil(var_156_5) then
					local var_156_9 = Mathf.Lerp(0, 0.5, var_156_8)

					arg_153_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1067ui_story.fillRatio = var_156_9
				end
			end

			if arg_153_1.time_ >= var_156_6 + var_156_7 and arg_153_1.time_ < var_156_6 + var_156_7 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect1067ui_story then
				local var_156_10 = 0.5

				arg_153_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1067ui_story.fillRatio = var_156_10
			end

			local var_156_11 = 0

			if var_156_11 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				arg_153_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_156_12 = 0
			local var_156_13 = 0.8

			if var_156_12 < arg_153_1.time_ and arg_153_1.time_ <= var_156_12 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_14 = arg_153_1:FormatText(StoryNameCfg[205].name)

				arg_153_1.leftNameTxt_.text = var_156_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_15 = arg_153_1:GetWordFromCfg(114111038)
				local var_156_16 = arg_153_1:FormatText(var_156_15.content)

				arg_153_1.text_.text = var_156_16

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_17 = 32
				local var_156_18 = utf8.len(var_156_16)
				local var_156_19 = var_156_17 <= 0 and var_156_13 or var_156_13 * (var_156_18 / var_156_17)

				if var_156_19 > 0 and var_156_13 < var_156_19 then
					arg_153_1.talkMaxDuration = var_156_19

					if var_156_19 + var_156_12 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_12
					end
				end

				arg_153_1.text_.text = var_156_16
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111038", "story_v_out_114111.awb") ~= 0 then
					local var_156_20 = manager.audio:GetVoiceLength("story_v_out_114111", "114111038", "story_v_out_114111.awb") / 1000

					if var_156_20 + var_156_12 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_20 + var_156_12
					end

					if var_156_15.prefab_name ~= "" and arg_153_1.actors_[var_156_15.prefab_name] ~= nil then
						local var_156_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_15.prefab_name].transform, "story_v_out_114111", "114111038", "story_v_out_114111.awb")

						arg_153_1:RecordAudio("114111038", var_156_21)
						arg_153_1:RecordAudio("114111038", var_156_21)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_114111", "114111038", "story_v_out_114111.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_114111", "114111038", "story_v_out_114111.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_22 = math.max(var_156_13, arg_153_1.talkMaxDuration)

			if var_156_12 <= arg_153_1.time_ and arg_153_1.time_ < var_156_12 + var_156_22 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_12) / var_156_22

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_12 + var_156_22 and arg_153_1.time_ < var_156_12 + var_156_22 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play114111039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 114111039
		arg_157_1.duration_ = 6.33

		local var_157_0 = {
			ja = 5.166,
			ko = 6.333,
			zh = 6.1,
			en = 6.3
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
				arg_157_0:Play114111040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_2")
			end

			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_160_2 = arg_157_1.actors_["1067ui_story"]
			local var_160_3 = 0

			if var_160_3 < arg_157_1.time_ and arg_157_1.time_ <= var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect1067ui_story == nil then
				arg_157_1.var_.characterEffect1067ui_story = var_160_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_4 = 0.2

			if var_160_3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_3 + var_160_4 and not isNil(var_160_2) then
				local var_160_5 = (arg_157_1.time_ - var_160_3) / var_160_4

				if arg_157_1.var_.characterEffect1067ui_story and not isNil(var_160_2) then
					arg_157_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_3 + var_160_4 and arg_157_1.time_ < var_160_3 + var_160_4 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect1067ui_story then
				arg_157_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_160_6 = arg_157_1.actors_["1042ui_story"]
			local var_160_7 = 0

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect1042ui_story == nil then
				arg_157_1.var_.characterEffect1042ui_story = var_160_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_8 = 0.2

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_8 and not isNil(var_160_6) then
				local var_160_9 = (arg_157_1.time_ - var_160_7) / var_160_8

				if arg_157_1.var_.characterEffect1042ui_story and not isNil(var_160_6) then
					local var_160_10 = Mathf.Lerp(0, 0.5, var_160_9)

					arg_157_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1042ui_story.fillRatio = var_160_10
				end
			end

			if arg_157_1.time_ >= var_160_7 + var_160_8 and arg_157_1.time_ < var_160_7 + var_160_8 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect1042ui_story then
				local var_160_11 = 0.5

				arg_157_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1042ui_story.fillRatio = var_160_11
			end

			local var_160_12 = 0
			local var_160_13 = 0.625

			if var_160_12 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_14 = arg_157_1:FormatText(StoryNameCfg[206].name)

				arg_157_1.leftNameTxt_.text = var_160_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_15 = arg_157_1:GetWordFromCfg(114111039)
				local var_160_16 = arg_157_1:FormatText(var_160_15.content)

				arg_157_1.text_.text = var_160_16

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_17 = 25
				local var_160_18 = utf8.len(var_160_16)
				local var_160_19 = var_160_17 <= 0 and var_160_13 or var_160_13 * (var_160_18 / var_160_17)

				if var_160_19 > 0 and var_160_13 < var_160_19 then
					arg_157_1.talkMaxDuration = var_160_19

					if var_160_19 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_19 + var_160_12
					end
				end

				arg_157_1.text_.text = var_160_16
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111039", "story_v_out_114111.awb") ~= 0 then
					local var_160_20 = manager.audio:GetVoiceLength("story_v_out_114111", "114111039", "story_v_out_114111.awb") / 1000

					if var_160_20 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_20 + var_160_12
					end

					if var_160_15.prefab_name ~= "" and arg_157_1.actors_[var_160_15.prefab_name] ~= nil then
						local var_160_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_15.prefab_name].transform, "story_v_out_114111", "114111039", "story_v_out_114111.awb")

						arg_157_1:RecordAudio("114111039", var_160_21)
						arg_157_1:RecordAudio("114111039", var_160_21)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_114111", "114111039", "story_v_out_114111.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_114111", "114111039", "story_v_out_114111.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_22 = math.max(var_160_13, arg_157_1.talkMaxDuration)

			if var_160_12 <= arg_157_1.time_ and arg_157_1.time_ < var_160_12 + var_160_22 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_12) / var_160_22

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_12 + var_160_22 and arg_157_1.time_ < var_160_12 + var_160_22 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play114111040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 114111040
		arg_161_1.duration_ = 10.47

		local var_161_0 = {
			ja = 4.233,
			ko = 10.466,
			zh = 7.5,
			en = 7.5
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
				arg_161_0:Play114111041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_164_1 = 0
			local var_164_2 = 0.825

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_3 = arg_161_1:FormatText(StoryNameCfg[206].name)

				arg_161_1.leftNameTxt_.text = var_164_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_4 = arg_161_1:GetWordFromCfg(114111040)
				local var_164_5 = arg_161_1:FormatText(var_164_4.content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_6 = 33
				local var_164_7 = utf8.len(var_164_5)
				local var_164_8 = var_164_6 <= 0 and var_164_2 or var_164_2 * (var_164_7 / var_164_6)

				if var_164_8 > 0 and var_164_2 < var_164_8 then
					arg_161_1.talkMaxDuration = var_164_8

					if var_164_8 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_1
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111040", "story_v_out_114111.awb") ~= 0 then
					local var_164_9 = manager.audio:GetVoiceLength("story_v_out_114111", "114111040", "story_v_out_114111.awb") / 1000

					if var_164_9 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_1
					end

					if var_164_4.prefab_name ~= "" and arg_161_1.actors_[var_164_4.prefab_name] ~= nil then
						local var_164_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_4.prefab_name].transform, "story_v_out_114111", "114111040", "story_v_out_114111.awb")

						arg_161_1:RecordAudio("114111040", var_164_10)
						arg_161_1:RecordAudio("114111040", var_164_10)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_114111", "114111040", "story_v_out_114111.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_114111", "114111040", "story_v_out_114111.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_11 = math.max(var_164_2, arg_161_1.talkMaxDuration)

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_11 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_1) / var_164_11

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_1 + var_164_11 and arg_161_1.time_ < var_164_1 + var_164_11 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play114111041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 114111041
		arg_165_1.duration_ = 7.9

		local var_165_0 = {
			ja = 7.9,
			ko = 4.333,
			zh = 5.4,
			en = 6.033
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
				arg_165_0:Play114111042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action442")
			end

			local var_168_1 = arg_165_1.actors_["1042ui_story"]
			local var_168_2 = 0

			if var_168_2 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1042ui_story == nil then
				arg_165_1.var_.characterEffect1042ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_3 = 0.2

			if var_168_2 <= arg_165_1.time_ and arg_165_1.time_ < var_168_2 + var_168_3 and not isNil(var_168_1) then
				local var_168_4 = (arg_165_1.time_ - var_168_2) / var_168_3

				if arg_165_1.var_.characterEffect1042ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_2 + var_168_3 and arg_165_1.time_ < var_168_2 + var_168_3 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1042ui_story then
				arg_165_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_168_5 = arg_165_1.actors_["1067ui_story"]
			local var_168_6 = 0

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.characterEffect1067ui_story == nil then
				arg_165_1.var_.characterEffect1067ui_story = var_168_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_7 = 0.2

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_7 and not isNil(var_168_5) then
				local var_168_8 = (arg_165_1.time_ - var_168_6) / var_168_7

				if arg_165_1.var_.characterEffect1067ui_story and not isNil(var_168_5) then
					local var_168_9 = Mathf.Lerp(0, 0.5, var_168_8)

					arg_165_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1067ui_story.fillRatio = var_168_9
				end
			end

			if arg_165_1.time_ >= var_168_6 + var_168_7 and arg_165_1.time_ < var_168_6 + var_168_7 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.characterEffect1067ui_story then
				local var_168_10 = 0.5

				arg_165_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1067ui_story.fillRatio = var_168_10
			end

			local var_168_11 = 0

			if var_168_11 < arg_165_1.time_ and arg_165_1.time_ <= var_168_11 + arg_168_0 then
				arg_165_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_168_12 = 0
			local var_168_13 = 0.425

			if var_168_12 < arg_165_1.time_ and arg_165_1.time_ <= var_168_12 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_14 = arg_165_1:FormatText(StoryNameCfg[205].name)

				arg_165_1.leftNameTxt_.text = var_168_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_15 = arg_165_1:GetWordFromCfg(114111041)
				local var_168_16 = arg_165_1:FormatText(var_168_15.content)

				arg_165_1.text_.text = var_168_16

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_17 = 17
				local var_168_18 = utf8.len(var_168_16)
				local var_168_19 = var_168_17 <= 0 and var_168_13 or var_168_13 * (var_168_18 / var_168_17)

				if var_168_19 > 0 and var_168_13 < var_168_19 then
					arg_165_1.talkMaxDuration = var_168_19

					if var_168_19 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_19 + var_168_12
					end
				end

				arg_165_1.text_.text = var_168_16
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111041", "story_v_out_114111.awb") ~= 0 then
					local var_168_20 = manager.audio:GetVoiceLength("story_v_out_114111", "114111041", "story_v_out_114111.awb") / 1000

					if var_168_20 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_20 + var_168_12
					end

					if var_168_15.prefab_name ~= "" and arg_165_1.actors_[var_168_15.prefab_name] ~= nil then
						local var_168_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_15.prefab_name].transform, "story_v_out_114111", "114111041", "story_v_out_114111.awb")

						arg_165_1:RecordAudio("114111041", var_168_21)
						arg_165_1:RecordAudio("114111041", var_168_21)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_114111", "114111041", "story_v_out_114111.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_114111", "114111041", "story_v_out_114111.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_22 = math.max(var_168_13, arg_165_1.talkMaxDuration)

			if var_168_12 <= arg_165_1.time_ and arg_165_1.time_ < var_168_12 + var_168_22 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_12) / var_168_22

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_12 + var_168_22 and arg_165_1.time_ < var_168_12 + var_168_22 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play114111042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 114111042
		arg_169_1.duration_ = 2.87

		local var_169_0 = {
			ja = 2.4,
			ko = 2.8,
			zh = 2.866,
			en = 2.7
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
				arg_169_0:Play114111043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action2_1")
			end

			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_172_2 = arg_169_1.actors_["1067ui_story"]
			local var_172_3 = 0

			if var_172_3 < arg_169_1.time_ and arg_169_1.time_ <= var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect1067ui_story == nil then
				arg_169_1.var_.characterEffect1067ui_story = var_172_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_4 = 0.2

			if var_172_3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_3 + var_172_4 and not isNil(var_172_2) then
				local var_172_5 = (arg_169_1.time_ - var_172_3) / var_172_4

				if arg_169_1.var_.characterEffect1067ui_story and not isNil(var_172_2) then
					arg_169_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_3 + var_172_4 and arg_169_1.time_ < var_172_3 + var_172_4 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect1067ui_story then
				arg_169_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_172_6 = arg_169_1.actors_["1042ui_story"]
			local var_172_7 = 0

			if var_172_7 < arg_169_1.time_ and arg_169_1.time_ <= var_172_7 + arg_172_0 and not isNil(var_172_6) and arg_169_1.var_.characterEffect1042ui_story == nil then
				arg_169_1.var_.characterEffect1042ui_story = var_172_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_8 = 0.2

			if var_172_7 <= arg_169_1.time_ and arg_169_1.time_ < var_172_7 + var_172_8 and not isNil(var_172_6) then
				local var_172_9 = (arg_169_1.time_ - var_172_7) / var_172_8

				if arg_169_1.var_.characterEffect1042ui_story and not isNil(var_172_6) then
					local var_172_10 = Mathf.Lerp(0, 0.5, var_172_9)

					arg_169_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1042ui_story.fillRatio = var_172_10
				end
			end

			if arg_169_1.time_ >= var_172_7 + var_172_8 and arg_169_1.time_ < var_172_7 + var_172_8 + arg_172_0 and not isNil(var_172_6) and arg_169_1.var_.characterEffect1042ui_story then
				local var_172_11 = 0.5

				arg_169_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1042ui_story.fillRatio = var_172_11
			end

			local var_172_12 = 0

			if var_172_12 < arg_169_1.time_ and arg_169_1.time_ <= var_172_12 + arg_172_0 then
				arg_169_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_172_13 = 0
			local var_172_14 = 0.325

			if var_172_13 < arg_169_1.time_ and arg_169_1.time_ <= var_172_13 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_15 = arg_169_1:FormatText(StoryNameCfg[206].name)

				arg_169_1.leftNameTxt_.text = var_172_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_16 = arg_169_1:GetWordFromCfg(114111042)
				local var_172_17 = arg_169_1:FormatText(var_172_16.content)

				arg_169_1.text_.text = var_172_17

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_18 = 13
				local var_172_19 = utf8.len(var_172_17)
				local var_172_20 = var_172_18 <= 0 and var_172_14 or var_172_14 * (var_172_19 / var_172_18)

				if var_172_20 > 0 and var_172_14 < var_172_20 then
					arg_169_1.talkMaxDuration = var_172_20

					if var_172_20 + var_172_13 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_20 + var_172_13
					end
				end

				arg_169_1.text_.text = var_172_17
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111042", "story_v_out_114111.awb") ~= 0 then
					local var_172_21 = manager.audio:GetVoiceLength("story_v_out_114111", "114111042", "story_v_out_114111.awb") / 1000

					if var_172_21 + var_172_13 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_21 + var_172_13
					end

					if var_172_16.prefab_name ~= "" and arg_169_1.actors_[var_172_16.prefab_name] ~= nil then
						local var_172_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_16.prefab_name].transform, "story_v_out_114111", "114111042", "story_v_out_114111.awb")

						arg_169_1:RecordAudio("114111042", var_172_22)
						arg_169_1:RecordAudio("114111042", var_172_22)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_114111", "114111042", "story_v_out_114111.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_114111", "114111042", "story_v_out_114111.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_23 = math.max(var_172_14, arg_169_1.talkMaxDuration)

			if var_172_13 <= arg_169_1.time_ and arg_169_1.time_ < var_172_13 + var_172_23 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_13) / var_172_23

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_13 + var_172_23 and arg_169_1.time_ < var_172_13 + var_172_23 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play114111043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 114111043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play114111044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1042ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1042ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0, 100, 0)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1042ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, 100, 0)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["1067ui_story"].transform
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1.var_.moveOldPos1067ui_story = var_176_9.localPosition
			end

			local var_176_11 = 0.001

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11
				local var_176_13 = Vector3.New(0, 100, 0)

				var_176_9.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1067ui_story, var_176_13, var_176_12)

				local var_176_14 = manager.ui.mainCamera.transform.position - var_176_9.position

				var_176_9.forward = Vector3.New(var_176_14.x, var_176_14.y, var_176_14.z)

				local var_176_15 = var_176_9.localEulerAngles

				var_176_15.z = 0
				var_176_15.x = 0
				var_176_9.localEulerAngles = var_176_15
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 then
				var_176_9.localPosition = Vector3.New(0, 100, 0)

				local var_176_16 = manager.ui.mainCamera.transform.position - var_176_9.position

				var_176_9.forward = Vector3.New(var_176_16.x, var_176_16.y, var_176_16.z)

				local var_176_17 = var_176_9.localEulerAngles

				var_176_17.z = 0
				var_176_17.x = 0
				var_176_9.localEulerAngles = var_176_17
			end

			local var_176_18 = 0
			local var_176_19 = 0.675

			if var_176_18 < arg_173_1.time_ and arg_173_1.time_ <= var_176_18 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_20 = arg_173_1:GetWordFromCfg(114111043)
				local var_176_21 = arg_173_1:FormatText(var_176_20.content)

				arg_173_1.text_.text = var_176_21

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_22 = 27
				local var_176_23 = utf8.len(var_176_21)
				local var_176_24 = var_176_22 <= 0 and var_176_19 or var_176_19 * (var_176_23 / var_176_22)

				if var_176_24 > 0 and var_176_19 < var_176_24 then
					arg_173_1.talkMaxDuration = var_176_24

					if var_176_24 + var_176_18 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_24 + var_176_18
					end
				end

				arg_173_1.text_.text = var_176_21
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_25 = math.max(var_176_19, arg_173_1.talkMaxDuration)

			if var_176_18 <= arg_173_1.time_ and arg_173_1.time_ < var_176_18 + var_176_25 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_18) / var_176_25

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_18 + var_176_25 and arg_173_1.time_ < var_176_18 + var_176_25 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play114111044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 114111044
		arg_177_1.duration_ = 6.9

		local var_177_0 = {
			ja = 6.9,
			ko = 3,
			zh = 5,
			en = 4
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
				arg_177_0:Play114111045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1042ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1042ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, -1.06, -6.2)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1042ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = 0

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 then
				arg_177_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 then
				arg_177_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_180_11 = arg_177_1.actors_["1042ui_story"]
			local var_180_12 = 0

			if var_180_12 < arg_177_1.time_ and arg_177_1.time_ <= var_180_12 + arg_180_0 and not isNil(var_180_11) and arg_177_1.var_.characterEffect1042ui_story == nil then
				arg_177_1.var_.characterEffect1042ui_story = var_180_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_13 = 0.2

			if var_180_12 <= arg_177_1.time_ and arg_177_1.time_ < var_180_12 + var_180_13 and not isNil(var_180_11) then
				local var_180_14 = (arg_177_1.time_ - var_180_12) / var_180_13

				if arg_177_1.var_.characterEffect1042ui_story and not isNil(var_180_11) then
					arg_177_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_12 + var_180_13 and arg_177_1.time_ < var_180_12 + var_180_13 + arg_180_0 and not isNil(var_180_11) and arg_177_1.var_.characterEffect1042ui_story then
				arg_177_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_180_15 = 0
			local var_180_16 = 0.325

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_17 = arg_177_1:FormatText(StoryNameCfg[205].name)

				arg_177_1.leftNameTxt_.text = var_180_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_18 = arg_177_1:GetWordFromCfg(114111044)
				local var_180_19 = arg_177_1:FormatText(var_180_18.content)

				arg_177_1.text_.text = var_180_19

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_20 = 13
				local var_180_21 = utf8.len(var_180_19)
				local var_180_22 = var_180_20 <= 0 and var_180_16 or var_180_16 * (var_180_21 / var_180_20)

				if var_180_22 > 0 and var_180_16 < var_180_22 then
					arg_177_1.talkMaxDuration = var_180_22

					if var_180_22 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_22 + var_180_15
					end
				end

				arg_177_1.text_.text = var_180_19
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111044", "story_v_out_114111.awb") ~= 0 then
					local var_180_23 = manager.audio:GetVoiceLength("story_v_out_114111", "114111044", "story_v_out_114111.awb") / 1000

					if var_180_23 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_23 + var_180_15
					end

					if var_180_18.prefab_name ~= "" and arg_177_1.actors_[var_180_18.prefab_name] ~= nil then
						local var_180_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_18.prefab_name].transform, "story_v_out_114111", "114111044", "story_v_out_114111.awb")

						arg_177_1:RecordAudio("114111044", var_180_24)
						arg_177_1:RecordAudio("114111044", var_180_24)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_114111", "114111044", "story_v_out_114111.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_114111", "114111044", "story_v_out_114111.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_25 = math.max(var_180_16, arg_177_1.talkMaxDuration)

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_25 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_15) / var_180_25

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_15 + var_180_25 and arg_177_1.time_ < var_180_15 + var_180_25 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play114111045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 114111045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play114111046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1042ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1042ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, 100, 0)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1042ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, 100, 0)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = 0
			local var_184_10 = 0.85

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_11 = arg_181_1:GetWordFromCfg(114111045)
				local var_184_12 = arg_181_1:FormatText(var_184_11.content)

				arg_181_1.text_.text = var_184_12

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 34
				local var_184_14 = utf8.len(var_184_12)
				local var_184_15 = var_184_13 <= 0 and var_184_10 or var_184_10 * (var_184_14 / var_184_13)

				if var_184_15 > 0 and var_184_10 < var_184_15 then
					arg_181_1.talkMaxDuration = var_184_15

					if var_184_15 + var_184_9 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_15 + var_184_9
					end
				end

				arg_181_1.text_.text = var_184_12
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_10, arg_181_1.talkMaxDuration)

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_9) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_9 + var_184_16 and arg_181_1.time_ < var_184_9 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play114111046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 114111046
		arg_185_1.duration_ = 7.47

		local var_185_0 = {
			ja = 7.466,
			ko = 7.333,
			zh = 4.6,
			en = 5.233
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play114111047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1067ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1067ui_story = var_188_0.localPosition
			end

			local var_188_2 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1067ui_story, var_188_4, var_188_3)

				local var_188_5 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_5.x, var_188_5.y, var_188_5.z)

				local var_188_6 = var_188_0.localEulerAngles

				var_188_6.z = 0
				var_188_6.x = 0
				var_188_0.localEulerAngles = var_188_6
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_188_7 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_7.x, var_188_7.y, var_188_7.z)

				local var_188_8 = var_188_0.localEulerAngles

				var_188_8.z = 0
				var_188_8.x = 0
				var_188_0.localEulerAngles = var_188_8
			end

			local var_188_9 = arg_185_1.actors_["1042ui_story"].transform
			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 then
				arg_185_1.var_.moveOldPos1042ui_story = var_188_9.localPosition
			end

			local var_188_11 = 0.001

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_11 then
				local var_188_12 = (arg_185_1.time_ - var_188_10) / var_188_11
				local var_188_13 = Vector3.New(0.7, -1.06, -6.2)

				var_188_9.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1042ui_story, var_188_13, var_188_12)

				local var_188_14 = manager.ui.mainCamera.transform.position - var_188_9.position

				var_188_9.forward = Vector3.New(var_188_14.x, var_188_14.y, var_188_14.z)

				local var_188_15 = var_188_9.localEulerAngles

				var_188_15.z = 0
				var_188_15.x = 0
				var_188_9.localEulerAngles = var_188_15
			end

			if arg_185_1.time_ >= var_188_10 + var_188_11 and arg_185_1.time_ < var_188_10 + var_188_11 + arg_188_0 then
				var_188_9.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_188_16 = manager.ui.mainCamera.transform.position - var_188_9.position

				var_188_9.forward = Vector3.New(var_188_16.x, var_188_16.y, var_188_16.z)

				local var_188_17 = var_188_9.localEulerAngles

				var_188_17.z = 0
				var_188_17.x = 0
				var_188_9.localEulerAngles = var_188_17
			end

			local var_188_18 = 0

			if var_188_18 < arg_185_1.time_ and arg_185_1.time_ <= var_188_18 + arg_188_0 then
				arg_185_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			local var_188_19 = 0

			if var_188_19 < arg_185_1.time_ and arg_185_1.time_ <= var_188_19 + arg_188_0 then
				arg_185_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_188_20 = arg_185_1.actors_["1067ui_story"]
			local var_188_21 = 0

			if var_188_21 < arg_185_1.time_ and arg_185_1.time_ <= var_188_21 + arg_188_0 and not isNil(var_188_20) and arg_185_1.var_.characterEffect1067ui_story == nil then
				arg_185_1.var_.characterEffect1067ui_story = var_188_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_22 = 0.2

			if var_188_21 <= arg_185_1.time_ and arg_185_1.time_ < var_188_21 + var_188_22 and not isNil(var_188_20) then
				local var_188_23 = (arg_185_1.time_ - var_188_21) / var_188_22

				if arg_185_1.var_.characterEffect1067ui_story and not isNil(var_188_20) then
					arg_185_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_21 + var_188_22 and arg_185_1.time_ < var_188_21 + var_188_22 + arg_188_0 and not isNil(var_188_20) and arg_185_1.var_.characterEffect1067ui_story then
				arg_185_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_188_24 = arg_185_1.actors_["1042ui_story"]
			local var_188_25 = 0

			if var_188_25 < arg_185_1.time_ and arg_185_1.time_ <= var_188_25 + arg_188_0 and not isNil(var_188_24) and arg_185_1.var_.characterEffect1042ui_story == nil then
				arg_185_1.var_.characterEffect1042ui_story = var_188_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_26 = 0.2

			if var_188_25 <= arg_185_1.time_ and arg_185_1.time_ < var_188_25 + var_188_26 and not isNil(var_188_24) then
				local var_188_27 = (arg_185_1.time_ - var_188_25) / var_188_26

				if arg_185_1.var_.characterEffect1042ui_story and not isNil(var_188_24) then
					local var_188_28 = Mathf.Lerp(0, 0.5, var_188_27)

					arg_185_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1042ui_story.fillRatio = var_188_28
				end
			end

			if arg_185_1.time_ >= var_188_25 + var_188_26 and arg_185_1.time_ < var_188_25 + var_188_26 + arg_188_0 and not isNil(var_188_24) and arg_185_1.var_.characterEffect1042ui_story then
				local var_188_29 = 0.5

				arg_185_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1042ui_story.fillRatio = var_188_29
			end

			local var_188_30 = 0
			local var_188_31 = 0.5

			if var_188_30 < arg_185_1.time_ and arg_185_1.time_ <= var_188_30 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_32 = arg_185_1:FormatText(StoryNameCfg[206].name)

				arg_185_1.leftNameTxt_.text = var_188_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_33 = arg_185_1:GetWordFromCfg(114111046)
				local var_188_34 = arg_185_1:FormatText(var_188_33.content)

				arg_185_1.text_.text = var_188_34

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_35 = 20
				local var_188_36 = utf8.len(var_188_34)
				local var_188_37 = var_188_35 <= 0 and var_188_31 or var_188_31 * (var_188_36 / var_188_35)

				if var_188_37 > 0 and var_188_31 < var_188_37 then
					arg_185_1.talkMaxDuration = var_188_37

					if var_188_37 + var_188_30 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_37 + var_188_30
					end
				end

				arg_185_1.text_.text = var_188_34
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111046", "story_v_out_114111.awb") ~= 0 then
					local var_188_38 = manager.audio:GetVoiceLength("story_v_out_114111", "114111046", "story_v_out_114111.awb") / 1000

					if var_188_38 + var_188_30 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_38 + var_188_30
					end

					if var_188_33.prefab_name ~= "" and arg_185_1.actors_[var_188_33.prefab_name] ~= nil then
						local var_188_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_33.prefab_name].transform, "story_v_out_114111", "114111046", "story_v_out_114111.awb")

						arg_185_1:RecordAudio("114111046", var_188_39)
						arg_185_1:RecordAudio("114111046", var_188_39)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_114111", "114111046", "story_v_out_114111.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_114111", "114111046", "story_v_out_114111.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_40 = math.max(var_188_31, arg_185_1.talkMaxDuration)

			if var_188_30 <= arg_185_1.time_ and arg_185_1.time_ < var_188_30 + var_188_40 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_30) / var_188_40

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_30 + var_188_40 and arg_185_1.time_ < var_188_30 + var_188_40 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play114111047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 114111047
		arg_189_1.duration_ = 12.3

		local var_189_0 = {
			ja = 8.333,
			ko = 10.3,
			zh = 9.8,
			en = 12.3
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play114111048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1042ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1042ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0.7, -1.06, -6.2)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1042ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = 0

			if var_192_9 < arg_189_1.time_ and arg_189_1.time_ <= var_192_9 + arg_192_0 then
				arg_189_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_192_10 = arg_189_1.actors_["1042ui_story"]
			local var_192_11 = 0

			if var_192_11 < arg_189_1.time_ and arg_189_1.time_ <= var_192_11 + arg_192_0 and not isNil(var_192_10) and arg_189_1.var_.characterEffect1042ui_story == nil then
				arg_189_1.var_.characterEffect1042ui_story = var_192_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_12 = 0.2

			if var_192_11 <= arg_189_1.time_ and arg_189_1.time_ < var_192_11 + var_192_12 and not isNil(var_192_10) then
				local var_192_13 = (arg_189_1.time_ - var_192_11) / var_192_12

				if arg_189_1.var_.characterEffect1042ui_story and not isNil(var_192_10) then
					arg_189_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_11 + var_192_12 and arg_189_1.time_ < var_192_11 + var_192_12 + arg_192_0 and not isNil(var_192_10) and arg_189_1.var_.characterEffect1042ui_story then
				arg_189_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_192_14 = arg_189_1.actors_["1067ui_story"]
			local var_192_15 = 0

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 and not isNil(var_192_14) and arg_189_1.var_.characterEffect1067ui_story == nil then
				arg_189_1.var_.characterEffect1067ui_story = var_192_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_16 = 0.2

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_16 and not isNil(var_192_14) then
				local var_192_17 = (arg_189_1.time_ - var_192_15) / var_192_16

				if arg_189_1.var_.characterEffect1067ui_story and not isNil(var_192_14) then
					local var_192_18 = Mathf.Lerp(0, 0.5, var_192_17)

					arg_189_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1067ui_story.fillRatio = var_192_18
				end
			end

			if arg_189_1.time_ >= var_192_15 + var_192_16 and arg_189_1.time_ < var_192_15 + var_192_16 + arg_192_0 and not isNil(var_192_14) and arg_189_1.var_.characterEffect1067ui_story then
				local var_192_19 = 0.5

				arg_189_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1067ui_story.fillRatio = var_192_19
			end

			local var_192_20 = 0
			local var_192_21 = 0.875

			if var_192_20 < arg_189_1.time_ and arg_189_1.time_ <= var_192_20 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_22 = arg_189_1:FormatText(StoryNameCfg[205].name)

				arg_189_1.leftNameTxt_.text = var_192_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_23 = arg_189_1:GetWordFromCfg(114111047)
				local var_192_24 = arg_189_1:FormatText(var_192_23.content)

				arg_189_1.text_.text = var_192_24

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_25 = 35
				local var_192_26 = utf8.len(var_192_24)
				local var_192_27 = var_192_25 <= 0 and var_192_21 or var_192_21 * (var_192_26 / var_192_25)

				if var_192_27 > 0 and var_192_21 < var_192_27 then
					arg_189_1.talkMaxDuration = var_192_27

					if var_192_27 + var_192_20 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_27 + var_192_20
					end
				end

				arg_189_1.text_.text = var_192_24
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111047", "story_v_out_114111.awb") ~= 0 then
					local var_192_28 = manager.audio:GetVoiceLength("story_v_out_114111", "114111047", "story_v_out_114111.awb") / 1000

					if var_192_28 + var_192_20 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_28 + var_192_20
					end

					if var_192_23.prefab_name ~= "" and arg_189_1.actors_[var_192_23.prefab_name] ~= nil then
						local var_192_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_23.prefab_name].transform, "story_v_out_114111", "114111047", "story_v_out_114111.awb")

						arg_189_1:RecordAudio("114111047", var_192_29)
						arg_189_1:RecordAudio("114111047", var_192_29)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_114111", "114111047", "story_v_out_114111.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_114111", "114111047", "story_v_out_114111.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_30 = math.max(var_192_21, arg_189_1.talkMaxDuration)

			if var_192_20 <= arg_189_1.time_ and arg_189_1.time_ < var_192_20 + var_192_30 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_20) / var_192_30

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_20 + var_192_30 and arg_189_1.time_ < var_192_20 + var_192_30 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play114111048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 114111048
		arg_193_1.duration_ = 9

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play114111049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = "OM0206"

			if arg_193_1.bgs_[var_196_0] == nil then
				local var_196_1 = Object.Instantiate(arg_193_1.paintGo_)

				var_196_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_196_0)
				var_196_1.name = var_196_0
				var_196_1.transform.parent = arg_193_1.stage_.transform
				var_196_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_[var_196_0] = var_196_1
			end

			local var_196_2 = 2

			if var_196_2 < arg_193_1.time_ and arg_193_1.time_ <= var_196_2 + arg_196_0 then
				local var_196_3 = manager.ui.mainCamera.transform.localPosition
				local var_196_4 = Vector3.New(0, 0, 10) + Vector3.New(var_196_3.x, var_196_3.y, 0)
				local var_196_5 = arg_193_1.bgs_.OM0206

				var_196_5.transform.localPosition = var_196_4
				var_196_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_6 = var_196_5:GetComponent("SpriteRenderer")

				if var_196_6 and var_196_6.sprite then
					local var_196_7 = (var_196_5.transform.localPosition - var_196_3).z
					local var_196_8 = manager.ui.mainCameraCom_
					local var_196_9 = 2 * var_196_7 * Mathf.Tan(var_196_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_196_10 = var_196_9 * var_196_8.aspect
					local var_196_11 = var_196_6.sprite.bounds.size.x
					local var_196_12 = var_196_6.sprite.bounds.size.y
					local var_196_13 = var_196_10 / var_196_11
					local var_196_14 = var_196_9 / var_196_12
					local var_196_15 = var_196_14 < var_196_13 and var_196_13 or var_196_14

					var_196_5.transform.localScale = Vector3.New(var_196_15, var_196_15, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "OM0206" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_16 = 0

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_17 = 2

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 then
				local var_196_18 = (arg_193_1.time_ - var_196_16) / var_196_17
				local var_196_19 = Color.New(0, 0, 0)

				var_196_19.a = Mathf.Lerp(0, 1, var_196_18)
				arg_193_1.mask_.color = var_196_19
			end

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 then
				local var_196_20 = Color.New(0, 0, 0)

				var_196_20.a = 1
				arg_193_1.mask_.color = var_196_20
			end

			local var_196_21 = 2

			if var_196_21 < arg_193_1.time_ and arg_193_1.time_ <= var_196_21 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_22 = 2

			if var_196_21 <= arg_193_1.time_ and arg_193_1.time_ < var_196_21 + var_196_22 then
				local var_196_23 = (arg_193_1.time_ - var_196_21) / var_196_22
				local var_196_24 = Color.New(0, 0, 0)

				var_196_24.a = Mathf.Lerp(1, 0, var_196_23)
				arg_193_1.mask_.color = var_196_24
			end

			if arg_193_1.time_ >= var_196_21 + var_196_22 and arg_193_1.time_ < var_196_21 + var_196_22 + arg_196_0 then
				local var_196_25 = Color.New(0, 0, 0)
				local var_196_26 = 0

				arg_193_1.mask_.enabled = false
				var_196_25.a = var_196_26
				arg_193_1.mask_.color = var_196_25
			end

			local var_196_27 = arg_193_1.actors_["1042ui_story"].transform
			local var_196_28 = 1.966

			if var_196_28 < arg_193_1.time_ and arg_193_1.time_ <= var_196_28 + arg_196_0 then
				arg_193_1.var_.moveOldPos1042ui_story = var_196_27.localPosition
			end

			local var_196_29 = 0.001

			if var_196_28 <= arg_193_1.time_ and arg_193_1.time_ < var_196_28 + var_196_29 then
				local var_196_30 = (arg_193_1.time_ - var_196_28) / var_196_29
				local var_196_31 = Vector3.New(0, 100, 0)

				var_196_27.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1042ui_story, var_196_31, var_196_30)

				local var_196_32 = manager.ui.mainCamera.transform.position - var_196_27.position

				var_196_27.forward = Vector3.New(var_196_32.x, var_196_32.y, var_196_32.z)

				local var_196_33 = var_196_27.localEulerAngles

				var_196_33.z = 0
				var_196_33.x = 0
				var_196_27.localEulerAngles = var_196_33
			end

			if arg_193_1.time_ >= var_196_28 + var_196_29 and arg_193_1.time_ < var_196_28 + var_196_29 + arg_196_0 then
				var_196_27.localPosition = Vector3.New(0, 100, 0)

				local var_196_34 = manager.ui.mainCamera.transform.position - var_196_27.position

				var_196_27.forward = Vector3.New(var_196_34.x, var_196_34.y, var_196_34.z)

				local var_196_35 = var_196_27.localEulerAngles

				var_196_35.z = 0
				var_196_35.x = 0
				var_196_27.localEulerAngles = var_196_35
			end

			local var_196_36 = arg_193_1.actors_["1067ui_story"].transform
			local var_196_37 = 1.966

			if var_196_37 < arg_193_1.time_ and arg_193_1.time_ <= var_196_37 + arg_196_0 then
				arg_193_1.var_.moveOldPos1067ui_story = var_196_36.localPosition
			end

			local var_196_38 = 0.001

			if var_196_37 <= arg_193_1.time_ and arg_193_1.time_ < var_196_37 + var_196_38 then
				local var_196_39 = (arg_193_1.time_ - var_196_37) / var_196_38
				local var_196_40 = Vector3.New(0, 100, 0)

				var_196_36.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1067ui_story, var_196_40, var_196_39)

				local var_196_41 = manager.ui.mainCamera.transform.position - var_196_36.position

				var_196_36.forward = Vector3.New(var_196_41.x, var_196_41.y, var_196_41.z)

				local var_196_42 = var_196_36.localEulerAngles

				var_196_42.z = 0
				var_196_42.x = 0
				var_196_36.localEulerAngles = var_196_42
			end

			if arg_193_1.time_ >= var_196_37 + var_196_38 and arg_193_1.time_ < var_196_37 + var_196_38 + arg_196_0 then
				var_196_36.localPosition = Vector3.New(0, 100, 0)

				local var_196_43 = manager.ui.mainCamera.transform.position - var_196_36.position

				var_196_36.forward = Vector3.New(var_196_43.x, var_196_43.y, var_196_43.z)

				local var_196_44 = var_196_36.localEulerAngles

				var_196_44.z = 0
				var_196_44.x = 0
				var_196_36.localEulerAngles = var_196_44
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_45 = 4
			local var_196_46 = 1.675

			if var_196_45 < arg_193_1.time_ and arg_193_1.time_ <= var_196_45 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_47 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_47:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_48 = arg_193_1:GetWordFromCfg(114111048)
				local var_196_49 = arg_193_1:FormatText(var_196_48.content)

				arg_193_1.text_.text = var_196_49

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_50 = 67
				local var_196_51 = utf8.len(var_196_49)
				local var_196_52 = var_196_50 <= 0 and var_196_46 or var_196_46 * (var_196_51 / var_196_50)

				if var_196_52 > 0 and var_196_46 < var_196_52 then
					arg_193_1.talkMaxDuration = var_196_52
					var_196_45 = var_196_45 + 0.3

					if var_196_52 + var_196_45 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_52 + var_196_45
					end
				end

				arg_193_1.text_.text = var_196_49
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_53 = var_196_45 + 0.3
			local var_196_54 = math.max(var_196_46, arg_193_1.talkMaxDuration)

			if var_196_53 <= arg_193_1.time_ and arg_193_1.time_ < var_196_53 + var_196_54 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_53) / var_196_54

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_53 + var_196_54 and arg_193_1.time_ < var_196_53 + var_196_54 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play114111049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 114111049
		arg_199_1.duration_ = 9.17

		local var_199_0 = {
			ja = 8.666,
			ko = 8.933,
			zh = 8.1,
			en = 9.166
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
				arg_199_0:Play114111050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 1.1

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[104].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(114111049)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111049", "story_v_out_114111.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_114111", "114111049", "story_v_out_114111.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_114111", "114111049", "story_v_out_114111.awb")

						arg_199_1:RecordAudio("114111049", var_202_9)
						arg_199_1:RecordAudio("114111049", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_114111", "114111049", "story_v_out_114111.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_114111", "114111049", "story_v_out_114111.awb")
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
	Play114111050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 114111050
		arg_203_1.duration_ = 6.93

		local var_203_0 = {
			ja = 3.833,
			ko = 3.633,
			zh = 4.166,
			en = 6.933
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play114111051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.5

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[104].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:GetWordFromCfg(114111050)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111050", "story_v_out_114111.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_114111", "114111050", "story_v_out_114111.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_114111", "114111050", "story_v_out_114111.awb")

						arg_203_1:RecordAudio("114111050", var_206_9)
						arg_203_1:RecordAudio("114111050", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_114111", "114111050", "story_v_out_114111.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_114111", "114111050", "story_v_out_114111.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_10 and arg_203_1.time_ < var_206_0 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play114111051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 114111051
		arg_207_1.duration_ = 8.07

		local var_207_0 = {
			ja = 5.2,
			ko = 7.4,
			zh = 7.033,
			en = 8.066
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
				arg_207_0:Play114111052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.875

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[105].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(114111051)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 35
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111051", "story_v_out_114111.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_114111", "114111051", "story_v_out_114111.awb") / 1000

					if var_210_8 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_0
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_114111", "114111051", "story_v_out_114111.awb")

						arg_207_1:RecordAudio("114111051", var_210_9)
						arg_207_1:RecordAudio("114111051", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_114111", "114111051", "story_v_out_114111.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_114111", "114111051", "story_v_out_114111.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_10 and arg_207_1.time_ < var_210_0 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play114111052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 114111052
		arg_211_1.duration_ = 11.83

		local var_211_0 = {
			ja = 10.9,
			ko = 9.433,
			zh = 10,
			en = 11.833
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
				arg_211_0:Play114111053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 1.35

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[104].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:GetWordFromCfg(114111052)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 54
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

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111052", "story_v_out_114111.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_114111", "114111052", "story_v_out_114111.awb") / 1000

					if var_214_8 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_0
					end

					if var_214_3.prefab_name ~= "" and arg_211_1.actors_[var_214_3.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_3.prefab_name].transform, "story_v_out_114111", "114111052", "story_v_out_114111.awb")

						arg_211_1:RecordAudio("114111052", var_214_9)
						arg_211_1:RecordAudio("114111052", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_114111", "114111052", "story_v_out_114111.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_114111", "114111052", "story_v_out_114111.awb")
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
	Play114111053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 114111053
		arg_215_1.duration_ = 5

		local var_215_0 = {
			ja = 4.466,
			ko = 5,
			zh = 4.4,
			en = 4.333
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play114111054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.525

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[105].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(114111053)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111053", "story_v_out_114111.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_114111", "114111053", "story_v_out_114111.awb") / 1000

					if var_218_8 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_0
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_out_114111", "114111053", "story_v_out_114111.awb")

						arg_215_1:RecordAudio("114111053", var_218_9)
						arg_215_1:RecordAudio("114111053", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_114111", "114111053", "story_v_out_114111.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_114111", "114111053", "story_v_out_114111.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_10 and arg_215_1.time_ < var_218_0 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play114111054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 114111054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play114111055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 1.3

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(114111054)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 52
				local var_222_5 = utf8.len(var_222_3)
				local var_222_6 = var_222_4 <= 0 and var_222_1 or var_222_1 * (var_222_5 / var_222_4)

				if var_222_6 > 0 and var_222_1 < var_222_6 then
					arg_219_1.talkMaxDuration = var_222_6

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_7 and arg_219_1.time_ < var_222_0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play114111055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 114111055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play114111056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 1.75

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_2 = arg_223_1:GetWordFromCfg(114111055)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 70
				local var_226_5 = utf8.len(var_226_3)
				local var_226_6 = var_226_4 <= 0 and var_226_1 or var_226_1 * (var_226_5 / var_226_4)

				if var_226_6 > 0 and var_226_1 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_7 and arg_223_1.time_ < var_226_0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play114111056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 114111056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play114111057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 1.6

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(114111056)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 64
				local var_230_5 = utf8.len(var_230_3)
				local var_230_6 = var_230_4 <= 0 and var_230_1 or var_230_1 * (var_230_5 / var_230_4)

				if var_230_6 > 0 and var_230_1 < var_230_6 then
					arg_227_1.talkMaxDuration = var_230_6

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_7 and arg_227_1.time_ < var_230_0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play114111057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 114111057
		arg_231_1.duration_ = 4.77

		local var_231_0 = {
			ja = 3.3,
			ko = 2.666,
			zh = 3.8,
			en = 4.766
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
				arg_231_0:Play114111058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.25

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[205].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:GetWordFromCfg(114111057)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111057", "story_v_out_114111.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_114111", "114111057", "story_v_out_114111.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_114111", "114111057", "story_v_out_114111.awb")

						arg_231_1:RecordAudio("114111057", var_234_9)
						arg_231_1:RecordAudio("114111057", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_114111", "114111057", "story_v_out_114111.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_114111", "114111057", "story_v_out_114111.awb")
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
	Play114111058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 114111058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play114111059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 1.225

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_2 = arg_235_1:GetWordFromCfg(114111058)
				local var_238_3 = arg_235_1:FormatText(var_238_2.content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 49
				local var_238_5 = utf8.len(var_238_3)
				local var_238_6 = var_238_4 <= 0 and var_238_1 or var_238_1 * (var_238_5 / var_238_4)

				if var_238_6 > 0 and var_238_1 < var_238_6 then
					arg_235_1.talkMaxDuration = var_238_6

					if var_238_6 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_7 and arg_235_1.time_ < var_238_0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play114111059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 114111059
		arg_239_1.duration_ = 9.3

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play114111060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = "F05_1"

			if arg_239_1.bgs_[var_242_0] == nil then
				local var_242_1 = Object.Instantiate(arg_239_1.paintGo_)

				var_242_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_242_0)
				var_242_1.name = var_242_0
				var_242_1.transform.parent = arg_239_1.stage_.transform
				var_242_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_239_1.bgs_[var_242_0] = var_242_1
			end

			local var_242_2 = 2

			if var_242_2 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
				local var_242_3 = manager.ui.mainCamera.transform.localPosition
				local var_242_4 = Vector3.New(0, 0, 10) + Vector3.New(var_242_3.x, var_242_3.y, 0)
				local var_242_5 = arg_239_1.bgs_.F05_1

				var_242_5.transform.localPosition = var_242_4
				var_242_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_242_6 = var_242_5:GetComponent("SpriteRenderer")

				if var_242_6 and var_242_6.sprite then
					local var_242_7 = (var_242_5.transform.localPosition - var_242_3).z
					local var_242_8 = manager.ui.mainCameraCom_
					local var_242_9 = 2 * var_242_7 * Mathf.Tan(var_242_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_242_10 = var_242_9 * var_242_8.aspect
					local var_242_11 = var_242_6.sprite.bounds.size.x
					local var_242_12 = var_242_6.sprite.bounds.size.y
					local var_242_13 = var_242_10 / var_242_11
					local var_242_14 = var_242_9 / var_242_12
					local var_242_15 = var_242_14 < var_242_13 and var_242_13 or var_242_14

					var_242_5.transform.localScale = Vector3.New(var_242_15, var_242_15, 0)
				end

				for iter_242_0, iter_242_1 in pairs(arg_239_1.bgs_) do
					if iter_242_0 ~= "F05_1" then
						iter_242_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_242_16 = 0

			if var_242_16 < arg_239_1.time_ and arg_239_1.time_ <= var_242_16 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_17 = 2

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

			local var_242_21 = 2

			if var_242_21 < arg_239_1.time_ and arg_239_1.time_ <= var_242_21 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_22 = 2

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

			local var_242_27 = arg_239_1.bgs_.F05_1.transform
			local var_242_28 = 2

			if var_242_28 < arg_239_1.time_ and arg_239_1.time_ <= var_242_28 + arg_242_0 then
				arg_239_1.var_.moveOldPosF05_1 = var_242_27.localPosition
			end

			local var_242_29 = 0.001

			if var_242_28 <= arg_239_1.time_ and arg_239_1.time_ < var_242_28 + var_242_29 then
				local var_242_30 = (arg_239_1.time_ - var_242_28) / var_242_29
				local var_242_31 = Vector3.New(0, 1, 10)

				var_242_27.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPosF05_1, var_242_31, var_242_30)
			end

			if arg_239_1.time_ >= var_242_28 + var_242_29 and arg_239_1.time_ < var_242_28 + var_242_29 + arg_242_0 then
				var_242_27.localPosition = Vector3.New(0, 1, 10)
			end

			local var_242_32 = arg_239_1.bgs_.F05_1.transform
			local var_242_33 = 2.034

			if var_242_33 < arg_239_1.time_ and arg_239_1.time_ <= var_242_33 + arg_242_0 then
				arg_239_1.var_.moveOldPosF05_1 = var_242_32.localPosition
			end

			local var_242_34 = 2.5

			if var_242_33 <= arg_239_1.time_ and arg_239_1.time_ < var_242_33 + var_242_34 then
				local var_242_35 = (arg_239_1.time_ - var_242_33) / var_242_34
				local var_242_36 = Vector3.New(0, 1, 9.5)

				var_242_32.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPosF05_1, var_242_36, var_242_35)
			end

			if arg_239_1.time_ >= var_242_33 + var_242_34 and arg_239_1.time_ < var_242_33 + var_242_34 + arg_242_0 then
				var_242_32.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_242_37 = 4

			if var_242_37 < arg_239_1.time_ and arg_239_1.time_ <= var_242_37 + arg_242_0 then
				arg_239_1.allBtn_.enabled = false
			end

			local var_242_38 = 0.534

			if arg_239_1.time_ >= var_242_37 + var_242_38 and arg_239_1.time_ < var_242_37 + var_242_38 + arg_242_0 then
				arg_239_1.allBtn_.enabled = true
			end

			local var_242_39 = 0
			local var_242_40 = 5.43333333333333

			if var_242_39 < arg_239_1.time_ and arg_239_1.time_ <= var_242_39 + arg_242_0 then
				local var_242_41 = "play"
				local var_242_42 = "music"

				arg_239_1:AudioAction(var_242_41, var_242_42, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_242_43 = ""
				local var_242_44 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if var_242_44 ~= "" then
					if arg_239_1.bgmTxt_.text ~= var_242_44 and arg_239_1.bgmTxt_.text ~= "" then
						if arg_239_1.bgmTxt2_.text ~= "" then
							arg_239_1.bgmTxt_.text = arg_239_1.bgmTxt2_.text
						end

						arg_239_1.bgmTxt2_.text = var_242_44

						arg_239_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_239_1.bgmTxt_.text = var_242_44
						arg_239_1.bgmTxt2_.text = var_242_44
					end

					if arg_239_1.bgmTimer then
						arg_239_1.bgmTimer:Stop()

						arg_239_1.bgmTimer = nil
					end

					if arg_239_1.settingData.show_music_name == 1 then
						arg_239_1.musicController:SetSelectedState("show")
						arg_239_1.musicAnimator_:Play("open", 0, 0)

						if arg_239_1.settingData.music_time ~= 0 then
							arg_239_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_239_1.settingData.music_time), function()
								if arg_239_1 == nil or isNil(arg_239_1.bgmTxt_) then
									return
								end

								arg_239_1.musicController:SetSelectedState("hide")
								arg_239_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_45 = 4.3
			local var_242_46 = 0.95

			if var_242_45 < arg_239_1.time_ and arg_239_1.time_ <= var_242_45 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_47 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_47:setOnUpdate(LuaHelper.FloatAction(function(arg_244_0)
					arg_239_1.dialogCg_.alpha = arg_244_0
				end))
				var_242_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_48 = arg_239_1:GetWordFromCfg(114111059)
				local var_242_49 = arg_239_1:FormatText(var_242_48.content)

				arg_239_1.text_.text = var_242_49

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_50 = 38
				local var_242_51 = utf8.len(var_242_49)
				local var_242_52 = var_242_50 <= 0 and var_242_46 or var_242_46 * (var_242_51 / var_242_50)

				if var_242_52 > 0 and var_242_46 < var_242_52 then
					arg_239_1.talkMaxDuration = var_242_52
					var_242_45 = var_242_45 + 0.3

					if var_242_52 + var_242_45 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_52 + var_242_45
					end
				end

				arg_239_1.text_.text = var_242_49
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_53 = var_242_45 + 0.3
			local var_242_54 = math.max(var_242_46, arg_239_1.talkMaxDuration)

			if var_242_53 <= arg_239_1.time_ and arg_239_1.time_ < var_242_53 + var_242_54 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_53) / var_242_54

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_53 + var_242_54 and arg_239_1.time_ < var_242_53 + var_242_54 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "F05_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "F05_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play114111060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 114111060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play114111061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 0.125

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_2 = arg_246_1:FormatText(StoryNameCfg[7].name)

				arg_246_1.leftNameTxt_.text = var_249_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_3 = arg_246_1:GetWordFromCfg(114111060)
				local var_249_4 = arg_246_1:FormatText(var_249_3.content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 5
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
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_8 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_8 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_8

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_8 and arg_246_1.time_ < var_249_0 + var_249_8 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play114111061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 114111061
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play114111062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 1.775

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_2 = arg_250_1:GetWordFromCfg(114111061)
				local var_253_3 = arg_250_1:FormatText(var_253_2.content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 71
				local var_253_5 = utf8.len(var_253_3)
				local var_253_6 = var_253_4 <= 0 and var_253_1 or var_253_1 * (var_253_5 / var_253_4)

				if var_253_6 > 0 and var_253_1 < var_253_6 then
					arg_250_1.talkMaxDuration = var_253_6

					if var_253_6 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_6 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_7 and arg_250_1.time_ < var_253_0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play114111062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 114111062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play114111063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0
			local var_257_1 = 1.525

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_2 = arg_254_1:GetWordFromCfg(114111062)
				local var_257_3 = arg_254_1:FormatText(var_257_2.content)

				arg_254_1.text_.text = var_257_3

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_4 = 61
				local var_257_5 = utf8.len(var_257_3)
				local var_257_6 = var_257_4 <= 0 and var_257_1 or var_257_1 * (var_257_5 / var_257_4)

				if var_257_6 > 0 and var_257_1 < var_257_6 then
					arg_254_1.talkMaxDuration = var_257_6

					if var_257_6 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_6 + var_257_0
					end
				end

				arg_254_1.text_.text = var_257_3
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_7 = math.max(var_257_1, arg_254_1.talkMaxDuration)

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_7 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_0) / var_257_7

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_0 + var_257_7 and arg_254_1.time_ < var_257_0 + var_257_7 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play114111063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 114111063
		arg_258_1.duration_ = 3.2

		local var_258_0 = {
			ja = 3.2,
			ko = 2.6,
			zh = 3,
			en = 3.133
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play114111064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = "1097ui_story"

			if arg_258_1.actors_[var_261_0] == nil then
				local var_261_1 = Asset.Load("Char/" .. "1097ui_story")

				if not isNil(var_261_1) then
					local var_261_2 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_258_1.stage_.transform)

					var_261_2.name = var_261_0
					var_261_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_258_1.actors_[var_261_0] = var_261_2

					local var_261_3 = var_261_2:GetComponentInChildren(typeof(CharacterEffect))

					var_261_3.enabled = true

					local var_261_4 = GameObjectTools.GetOrAddComponent(var_261_2, typeof(DynamicBoneHelper))

					if var_261_4 then
						var_261_4:EnableDynamicBone(false)
					end

					arg_258_1:ShowWeapon(var_261_3.transform, false)

					arg_258_1.var_[var_261_0 .. "Animator"] = var_261_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_258_1.var_[var_261_0 .. "Animator"].applyRootMotion = true
					arg_258_1.var_[var_261_0 .. "LipSync"] = var_261_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_261_5 = arg_258_1.actors_["1097ui_story"].transform
			local var_261_6 = 0

			if var_261_6 < arg_258_1.time_ and arg_258_1.time_ <= var_261_6 + arg_261_0 then
				arg_258_1.var_.moveOldPos1097ui_story = var_261_5.localPosition
			end

			local var_261_7 = 0.001

			if var_261_6 <= arg_258_1.time_ and arg_258_1.time_ < var_261_6 + var_261_7 then
				local var_261_8 = (arg_258_1.time_ - var_261_6) / var_261_7
				local var_261_9 = Vector3.New(-0.7, -0.54, -6.3)

				var_261_5.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1097ui_story, var_261_9, var_261_8)

				local var_261_10 = manager.ui.mainCamera.transform.position - var_261_5.position

				var_261_5.forward = Vector3.New(var_261_10.x, var_261_10.y, var_261_10.z)

				local var_261_11 = var_261_5.localEulerAngles

				var_261_11.z = 0
				var_261_11.x = 0
				var_261_5.localEulerAngles = var_261_11
			end

			if arg_258_1.time_ >= var_261_6 + var_261_7 and arg_258_1.time_ < var_261_6 + var_261_7 + arg_261_0 then
				var_261_5.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_261_12 = manager.ui.mainCamera.transform.position - var_261_5.position

				var_261_5.forward = Vector3.New(var_261_12.x, var_261_12.y, var_261_12.z)

				local var_261_13 = var_261_5.localEulerAngles

				var_261_13.z = 0
				var_261_13.x = 0
				var_261_5.localEulerAngles = var_261_13
			end

			local var_261_14 = 0

			if var_261_14 < arg_258_1.time_ and arg_258_1.time_ <= var_261_14 + arg_261_0 then
				arg_258_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_261_15 = 0

			if var_261_15 < arg_258_1.time_ and arg_258_1.time_ <= var_261_15 + arg_261_0 then
				arg_258_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_261_16 = arg_258_1.actors_["1097ui_story"]
			local var_261_17 = 0

			if var_261_17 < arg_258_1.time_ and arg_258_1.time_ <= var_261_17 + arg_261_0 and not isNil(var_261_16) and arg_258_1.var_.characterEffect1097ui_story == nil then
				arg_258_1.var_.characterEffect1097ui_story = var_261_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_18 = 0.2

			if var_261_17 <= arg_258_1.time_ and arg_258_1.time_ < var_261_17 + var_261_18 and not isNil(var_261_16) then
				local var_261_19 = (arg_258_1.time_ - var_261_17) / var_261_18

				if arg_258_1.var_.characterEffect1097ui_story and not isNil(var_261_16) then
					arg_258_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_17 + var_261_18 and arg_258_1.time_ < var_261_17 + var_261_18 + arg_261_0 and not isNil(var_261_16) and arg_258_1.var_.characterEffect1097ui_story then
				arg_258_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_261_20 = 0
			local var_261_21 = 0.175

			if var_261_20 < arg_258_1.time_ and arg_258_1.time_ <= var_261_20 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_22 = arg_258_1:FormatText(StoryNameCfg[216].name)

				arg_258_1.leftNameTxt_.text = var_261_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_23 = arg_258_1:GetWordFromCfg(114111063)
				local var_261_24 = arg_258_1:FormatText(var_261_23.content)

				arg_258_1.text_.text = var_261_24

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_25 = 7
				local var_261_26 = utf8.len(var_261_24)
				local var_261_27 = var_261_25 <= 0 and var_261_21 or var_261_21 * (var_261_26 / var_261_25)

				if var_261_27 > 0 and var_261_21 < var_261_27 then
					arg_258_1.talkMaxDuration = var_261_27

					if var_261_27 + var_261_20 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_27 + var_261_20
					end
				end

				arg_258_1.text_.text = var_261_24
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111063", "story_v_out_114111.awb") ~= 0 then
					local var_261_28 = manager.audio:GetVoiceLength("story_v_out_114111", "114111063", "story_v_out_114111.awb") / 1000

					if var_261_28 + var_261_20 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_28 + var_261_20
					end

					if var_261_23.prefab_name ~= "" and arg_258_1.actors_[var_261_23.prefab_name] ~= nil then
						local var_261_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_23.prefab_name].transform, "story_v_out_114111", "114111063", "story_v_out_114111.awb")

						arg_258_1:RecordAudio("114111063", var_261_29)
						arg_258_1:RecordAudio("114111063", var_261_29)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_114111", "114111063", "story_v_out_114111.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_114111", "114111063", "story_v_out_114111.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_30 = math.max(var_261_21, arg_258_1.talkMaxDuration)

			if var_261_20 <= arg_258_1.time_ and arg_258_1.time_ < var_261_20 + var_261_30 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_20) / var_261_30

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_20 + var_261_30 and arg_258_1.time_ < var_261_20 + var_261_30 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play114111064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 114111064
		arg_262_1.duration_ = 6.03

		local var_262_0 = {
			ja = 4.166,
			ko = 6.033,
			zh = 4.7,
			en = 5.533
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play114111065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1097ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1097ui_story == nil then
				arg_262_1.var_.characterEffect1097ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.2

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect1097ui_story and not isNil(var_265_0) then
					local var_265_4 = Mathf.Lerp(0, 0.5, var_265_3)

					arg_262_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1097ui_story.fillRatio = var_265_4
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1097ui_story then
				local var_265_5 = 0.5

				arg_262_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1097ui_story.fillRatio = var_265_5
			end

			local var_265_6 = "1184ui_story"

			if arg_262_1.actors_[var_265_6] == nil then
				local var_265_7 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_265_7) then
					local var_265_8 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_262_1.stage_.transform)

					var_265_8.name = var_265_6
					var_265_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_262_1.actors_[var_265_6] = var_265_8

					local var_265_9 = var_265_8:GetComponentInChildren(typeof(CharacterEffect))

					var_265_9.enabled = true

					local var_265_10 = GameObjectTools.GetOrAddComponent(var_265_8, typeof(DynamicBoneHelper))

					if var_265_10 then
						var_265_10:EnableDynamicBone(false)
					end

					arg_262_1:ShowWeapon(var_265_9.transform, false)

					arg_262_1.var_[var_265_6 .. "Animator"] = var_265_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_262_1.var_[var_265_6 .. "Animator"].applyRootMotion = true
					arg_262_1.var_[var_265_6 .. "LipSync"] = var_265_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_265_11 = arg_262_1.actors_["1184ui_story"].transform
			local var_265_12 = 0

			if var_265_12 < arg_262_1.time_ and arg_262_1.time_ <= var_265_12 + arg_265_0 then
				arg_262_1.var_.moveOldPos1184ui_story = var_265_11.localPosition

				local var_265_13 = "1184ui_story"

				arg_262_1:ShowWeapon(arg_262_1.var_[var_265_13 .. "Animator"].transform, true)
			end

			local var_265_14 = 0.001

			if var_265_12 <= arg_262_1.time_ and arg_262_1.time_ < var_265_12 + var_265_14 then
				local var_265_15 = (arg_262_1.time_ - var_265_12) / var_265_14
				local var_265_16 = Vector3.New(0.7, -0.97, -6)

				var_265_11.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1184ui_story, var_265_16, var_265_15)

				local var_265_17 = manager.ui.mainCamera.transform.position - var_265_11.position

				var_265_11.forward = Vector3.New(var_265_17.x, var_265_17.y, var_265_17.z)

				local var_265_18 = var_265_11.localEulerAngles

				var_265_18.z = 0
				var_265_18.x = 0
				var_265_11.localEulerAngles = var_265_18
			end

			if arg_262_1.time_ >= var_265_12 + var_265_14 and arg_262_1.time_ < var_265_12 + var_265_14 + arg_265_0 then
				var_265_11.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_265_19 = manager.ui.mainCamera.transform.position - var_265_11.position

				var_265_11.forward = Vector3.New(var_265_19.x, var_265_19.y, var_265_19.z)

				local var_265_20 = var_265_11.localEulerAngles

				var_265_20.z = 0
				var_265_20.x = 0
				var_265_11.localEulerAngles = var_265_20
			end

			local var_265_21 = 0

			if var_265_21 < arg_262_1.time_ and arg_262_1.time_ <= var_265_21 + arg_265_0 then
				arg_262_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_265_22 = 0

			if var_265_22 < arg_262_1.time_ and arg_262_1.time_ <= var_265_22 + arg_265_0 then
				arg_262_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_265_23 = arg_262_1.actors_["1184ui_story"]
			local var_265_24 = 0

			if var_265_24 < arg_262_1.time_ and arg_262_1.time_ <= var_265_24 + arg_265_0 and not isNil(var_265_23) and arg_262_1.var_.characterEffect1184ui_story == nil then
				arg_262_1.var_.characterEffect1184ui_story = var_265_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_25 = 0.2

			if var_265_24 <= arg_262_1.time_ and arg_262_1.time_ < var_265_24 + var_265_25 and not isNil(var_265_23) then
				local var_265_26 = (arg_262_1.time_ - var_265_24) / var_265_25

				if arg_262_1.var_.characterEffect1184ui_story and not isNil(var_265_23) then
					arg_262_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_24 + var_265_25 and arg_262_1.time_ < var_265_24 + var_265_25 + arg_265_0 and not isNil(var_265_23) and arg_262_1.var_.characterEffect1184ui_story then
				arg_262_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_265_27 = 0
			local var_265_28 = 0.7

			if var_265_27 < arg_262_1.time_ and arg_262_1.time_ <= var_265_27 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_29 = arg_262_1:FormatText(StoryNameCfg[6].name)

				arg_262_1.leftNameTxt_.text = var_265_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_30 = arg_262_1:GetWordFromCfg(114111064)
				local var_265_31 = arg_262_1:FormatText(var_265_30.content)

				arg_262_1.text_.text = var_265_31

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_32 = 28
				local var_265_33 = utf8.len(var_265_31)
				local var_265_34 = var_265_32 <= 0 and var_265_28 or var_265_28 * (var_265_33 / var_265_32)

				if var_265_34 > 0 and var_265_28 < var_265_34 then
					arg_262_1.talkMaxDuration = var_265_34

					if var_265_34 + var_265_27 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_34 + var_265_27
					end
				end

				arg_262_1.text_.text = var_265_31
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111064", "story_v_out_114111.awb") ~= 0 then
					local var_265_35 = manager.audio:GetVoiceLength("story_v_out_114111", "114111064", "story_v_out_114111.awb") / 1000

					if var_265_35 + var_265_27 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_35 + var_265_27
					end

					if var_265_30.prefab_name ~= "" and arg_262_1.actors_[var_265_30.prefab_name] ~= nil then
						local var_265_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_30.prefab_name].transform, "story_v_out_114111", "114111064", "story_v_out_114111.awb")

						arg_262_1:RecordAudio("114111064", var_265_36)
						arg_262_1:RecordAudio("114111064", var_265_36)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_114111", "114111064", "story_v_out_114111.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_114111", "114111064", "story_v_out_114111.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_37 = math.max(var_265_28, arg_262_1.talkMaxDuration)

			if var_265_27 <= arg_262_1.time_ and arg_262_1.time_ < var_265_27 + var_265_37 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_27) / var_265_37

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_27 + var_265_37 and arg_262_1.time_ < var_265_27 + var_265_37 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play114111065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 114111065
		arg_266_1.duration_ = 6.7

		local var_266_0 = {
			ja = 3.333,
			ko = 6.7,
			zh = 4.633,
			en = 3.466
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play114111066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1184ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos1184ui_story = var_269_0.localPosition
			end

			local var_269_2 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2
				local var_269_4 = Vector3.New(0, 100, 0)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1184ui_story, var_269_4, var_269_3)

				local var_269_5 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_5.x, var_269_5.y, var_269_5.z)

				local var_269_6 = var_269_0.localEulerAngles

				var_269_6.z = 0
				var_269_6.x = 0
				var_269_0.localEulerAngles = var_269_6
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(0, 100, 0)

				local var_269_7 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_7.x, var_269_7.y, var_269_7.z)

				local var_269_8 = var_269_0.localEulerAngles

				var_269_8.z = 0
				var_269_8.x = 0
				var_269_0.localEulerAngles = var_269_8
			end

			local var_269_9 = arg_266_1.actors_["1097ui_story"].transform
			local var_269_10 = 0

			if var_269_10 < arg_266_1.time_ and arg_266_1.time_ <= var_269_10 + arg_269_0 then
				arg_266_1.var_.moveOldPos1097ui_story = var_269_9.localPosition

				local var_269_11 = "1097ui_story"

				arg_266_1:ShowWeapon(arg_266_1.var_[var_269_11 .. "Animator"].transform, true)
			end

			local var_269_12 = 0.001

			if var_269_10 <= arg_266_1.time_ and arg_266_1.time_ < var_269_10 + var_269_12 then
				local var_269_13 = (arg_266_1.time_ - var_269_10) / var_269_12
				local var_269_14 = Vector3.New(0, 100, 0)

				var_269_9.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1097ui_story, var_269_14, var_269_13)

				local var_269_15 = manager.ui.mainCamera.transform.position - var_269_9.position

				var_269_9.forward = Vector3.New(var_269_15.x, var_269_15.y, var_269_15.z)

				local var_269_16 = var_269_9.localEulerAngles

				var_269_16.z = 0
				var_269_16.x = 0
				var_269_9.localEulerAngles = var_269_16
			end

			if arg_266_1.time_ >= var_269_10 + var_269_12 and arg_266_1.time_ < var_269_10 + var_269_12 + arg_269_0 then
				var_269_9.localPosition = Vector3.New(0, 100, 0)

				local var_269_17 = manager.ui.mainCamera.transform.position - var_269_9.position

				var_269_9.forward = Vector3.New(var_269_17.x, var_269_17.y, var_269_17.z)

				local var_269_18 = var_269_9.localEulerAngles

				var_269_18.z = 0
				var_269_18.x = 0
				var_269_9.localEulerAngles = var_269_18
			end

			local var_269_19 = "1041ui_story"

			if arg_266_1.actors_[var_269_19] == nil then
				local var_269_20 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_269_20) then
					local var_269_21 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_266_1.stage_.transform)

					var_269_21.name = var_269_19
					var_269_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_266_1.actors_[var_269_19] = var_269_21

					local var_269_22 = var_269_21:GetComponentInChildren(typeof(CharacterEffect))

					var_269_22.enabled = true

					local var_269_23 = GameObjectTools.GetOrAddComponent(var_269_21, typeof(DynamicBoneHelper))

					if var_269_23 then
						var_269_23:EnableDynamicBone(false)
					end

					arg_266_1:ShowWeapon(var_269_22.transform, false)

					arg_266_1.var_[var_269_19 .. "Animator"] = var_269_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_266_1.var_[var_269_19 .. "Animator"].applyRootMotion = true
					arg_266_1.var_[var_269_19 .. "LipSync"] = var_269_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_269_24 = arg_266_1.actors_["1041ui_story"].transform
			local var_269_25 = 0

			if var_269_25 < arg_266_1.time_ and arg_266_1.time_ <= var_269_25 + arg_269_0 then
				arg_266_1.var_.moveOldPos1041ui_story = var_269_24.localPosition

				local var_269_26 = "1041ui_story"

				arg_266_1:ShowWeapon(arg_266_1.var_[var_269_26 .. "Animator"].transform, true)
			end

			local var_269_27 = 0.001

			if var_269_25 <= arg_266_1.time_ and arg_266_1.time_ < var_269_25 + var_269_27 then
				local var_269_28 = (arg_266_1.time_ - var_269_25) / var_269_27
				local var_269_29 = Vector3.New(-0.7, -1.11, -5.9)

				var_269_24.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1041ui_story, var_269_29, var_269_28)

				local var_269_30 = manager.ui.mainCamera.transform.position - var_269_24.position

				var_269_24.forward = Vector3.New(var_269_30.x, var_269_30.y, var_269_30.z)

				local var_269_31 = var_269_24.localEulerAngles

				var_269_31.z = 0
				var_269_31.x = 0
				var_269_24.localEulerAngles = var_269_31
			end

			if arg_266_1.time_ >= var_269_25 + var_269_27 and arg_266_1.time_ < var_269_25 + var_269_27 + arg_269_0 then
				var_269_24.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_269_32 = manager.ui.mainCamera.transform.position - var_269_24.position

				var_269_24.forward = Vector3.New(var_269_32.x, var_269_32.y, var_269_32.z)

				local var_269_33 = var_269_24.localEulerAngles

				var_269_33.z = 0
				var_269_33.x = 0
				var_269_24.localEulerAngles = var_269_33
			end

			local var_269_34 = 0

			if var_269_34 < arg_266_1.time_ and arg_266_1.time_ <= var_269_34 + arg_269_0 then
				arg_266_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_269_35 = 0

			if var_269_35 < arg_266_1.time_ and arg_266_1.time_ <= var_269_35 + arg_269_0 then
				arg_266_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_269_36 = arg_266_1.actors_["1041ui_story"]
			local var_269_37 = 0

			if var_269_37 < arg_266_1.time_ and arg_266_1.time_ <= var_269_37 + arg_269_0 and not isNil(var_269_36) and arg_266_1.var_.characterEffect1041ui_story == nil then
				arg_266_1.var_.characterEffect1041ui_story = var_269_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_38 = 0.2

			if var_269_37 <= arg_266_1.time_ and arg_266_1.time_ < var_269_37 + var_269_38 and not isNil(var_269_36) then
				local var_269_39 = (arg_266_1.time_ - var_269_37) / var_269_38

				if arg_266_1.var_.characterEffect1041ui_story and not isNil(var_269_36) then
					arg_266_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_37 + var_269_38 and arg_266_1.time_ < var_269_37 + var_269_38 + arg_269_0 and not isNil(var_269_36) and arg_266_1.var_.characterEffect1041ui_story then
				arg_266_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_269_40 = 0
			local var_269_41 = 0.6

			if var_269_40 < arg_266_1.time_ and arg_266_1.time_ <= var_269_40 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_42 = arg_266_1:FormatText(StoryNameCfg[208].name)

				arg_266_1.leftNameTxt_.text = var_269_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_43 = arg_266_1:GetWordFromCfg(114111065)
				local var_269_44 = arg_266_1:FormatText(var_269_43.content)

				arg_266_1.text_.text = var_269_44

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_45 = 24
				local var_269_46 = utf8.len(var_269_44)
				local var_269_47 = var_269_45 <= 0 and var_269_41 or var_269_41 * (var_269_46 / var_269_45)

				if var_269_47 > 0 and var_269_41 < var_269_47 then
					arg_266_1.talkMaxDuration = var_269_47

					if var_269_47 + var_269_40 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_47 + var_269_40
					end
				end

				arg_266_1.text_.text = var_269_44
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111065", "story_v_out_114111.awb") ~= 0 then
					local var_269_48 = manager.audio:GetVoiceLength("story_v_out_114111", "114111065", "story_v_out_114111.awb") / 1000

					if var_269_48 + var_269_40 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_48 + var_269_40
					end

					if var_269_43.prefab_name ~= "" and arg_266_1.actors_[var_269_43.prefab_name] ~= nil then
						local var_269_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_43.prefab_name].transform, "story_v_out_114111", "114111065", "story_v_out_114111.awb")

						arg_266_1:RecordAudio("114111065", var_269_49)
						arg_266_1:RecordAudio("114111065", var_269_49)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_114111", "114111065", "story_v_out_114111.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_114111", "114111065", "story_v_out_114111.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_50 = math.max(var_269_41, arg_266_1.talkMaxDuration)

			if var_269_40 <= arg_266_1.time_ and arg_266_1.time_ < var_269_40 + var_269_50 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_40) / var_269_50

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_40 + var_269_50 and arg_266_1.time_ < var_269_40 + var_269_50 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play114111066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 114111066
		arg_270_1.duration_ = 5.17

		local var_270_0 = {
			ja = 5.166,
			ko = 5,
			zh = 4.366,
			en = 2.2
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
				arg_270_0:Play114111067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = "1038ui_story"

			if arg_270_1.actors_[var_273_0] == nil then
				local var_273_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_273_1) then
					local var_273_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_270_1.stage_.transform)

					var_273_2.name = var_273_0
					var_273_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_270_1.actors_[var_273_0] = var_273_2

					local var_273_3 = var_273_2:GetComponentInChildren(typeof(CharacterEffect))

					var_273_3.enabled = true

					local var_273_4 = GameObjectTools.GetOrAddComponent(var_273_2, typeof(DynamicBoneHelper))

					if var_273_4 then
						var_273_4:EnableDynamicBone(false)
					end

					arg_270_1:ShowWeapon(var_273_3.transform, false)

					arg_270_1.var_[var_273_0 .. "Animator"] = var_273_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_270_1.var_[var_273_0 .. "Animator"].applyRootMotion = true
					arg_270_1.var_[var_273_0 .. "LipSync"] = var_273_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_273_5 = arg_270_1.actors_["1038ui_story"].transform
			local var_273_6 = 0

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.var_.moveOldPos1038ui_story = var_273_5.localPosition
			end

			local var_273_7 = 0.001

			if var_273_6 <= arg_270_1.time_ and arg_270_1.time_ < var_273_6 + var_273_7 then
				local var_273_8 = (arg_270_1.time_ - var_273_6) / var_273_7
				local var_273_9 = Vector3.New(0.7, -1.11, -5.9)

				var_273_5.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1038ui_story, var_273_9, var_273_8)

				local var_273_10 = manager.ui.mainCamera.transform.position - var_273_5.position

				var_273_5.forward = Vector3.New(var_273_10.x, var_273_10.y, var_273_10.z)

				local var_273_11 = var_273_5.localEulerAngles

				var_273_11.z = 0
				var_273_11.x = 0
				var_273_5.localEulerAngles = var_273_11
			end

			if arg_270_1.time_ >= var_273_6 + var_273_7 and arg_270_1.time_ < var_273_6 + var_273_7 + arg_273_0 then
				var_273_5.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_273_12 = manager.ui.mainCamera.transform.position - var_273_5.position

				var_273_5.forward = Vector3.New(var_273_12.x, var_273_12.y, var_273_12.z)

				local var_273_13 = var_273_5.localEulerAngles

				var_273_13.z = 0
				var_273_13.x = 0
				var_273_5.localEulerAngles = var_273_13
			end

			local var_273_14 = 0

			if var_273_14 < arg_270_1.time_ and arg_270_1.time_ <= var_273_14 + arg_273_0 then
				arg_270_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_273_15 = 0

			if var_273_15 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 then
				arg_270_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_273_16 = arg_270_1.actors_["1038ui_story"]
			local var_273_17 = 0

			if var_273_17 < arg_270_1.time_ and arg_270_1.time_ <= var_273_17 + arg_273_0 and not isNil(var_273_16) and arg_270_1.var_.characterEffect1038ui_story == nil then
				arg_270_1.var_.characterEffect1038ui_story = var_273_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_18 = 0.2

			if var_273_17 <= arg_270_1.time_ and arg_270_1.time_ < var_273_17 + var_273_18 and not isNil(var_273_16) then
				local var_273_19 = (arg_270_1.time_ - var_273_17) / var_273_18

				if arg_270_1.var_.characterEffect1038ui_story and not isNil(var_273_16) then
					arg_270_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_17 + var_273_18 and arg_270_1.time_ < var_273_17 + var_273_18 + arg_273_0 and not isNil(var_273_16) and arg_270_1.var_.characterEffect1038ui_story then
				arg_270_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_273_20 = arg_270_1.actors_["1041ui_story"]
			local var_273_21 = 0

			if var_273_21 < arg_270_1.time_ and arg_270_1.time_ <= var_273_21 + arg_273_0 and not isNil(var_273_20) and arg_270_1.var_.characterEffect1041ui_story == nil then
				arg_270_1.var_.characterEffect1041ui_story = var_273_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_22 = 0.2

			if var_273_21 <= arg_270_1.time_ and arg_270_1.time_ < var_273_21 + var_273_22 and not isNil(var_273_20) then
				local var_273_23 = (arg_270_1.time_ - var_273_21) / var_273_22

				if arg_270_1.var_.characterEffect1041ui_story and not isNil(var_273_20) then
					local var_273_24 = Mathf.Lerp(0, 0.5, var_273_23)

					arg_270_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1041ui_story.fillRatio = var_273_24
				end
			end

			if arg_270_1.time_ >= var_273_21 + var_273_22 and arg_270_1.time_ < var_273_21 + var_273_22 + arg_273_0 and not isNil(var_273_20) and arg_270_1.var_.characterEffect1041ui_story then
				local var_273_25 = 0.5

				arg_270_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1041ui_story.fillRatio = var_273_25
			end

			local var_273_26 = 0
			local var_273_27 = 0.575

			if var_273_26 < arg_270_1.time_ and arg_270_1.time_ <= var_273_26 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_28 = arg_270_1:FormatText(StoryNameCfg[94].name)

				arg_270_1.leftNameTxt_.text = var_273_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_29 = arg_270_1:GetWordFromCfg(114111066)
				local var_273_30 = arg_270_1:FormatText(var_273_29.content)

				arg_270_1.text_.text = var_273_30

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_31 = 23
				local var_273_32 = utf8.len(var_273_30)
				local var_273_33 = var_273_31 <= 0 and var_273_27 or var_273_27 * (var_273_32 / var_273_31)

				if var_273_33 > 0 and var_273_27 < var_273_33 then
					arg_270_1.talkMaxDuration = var_273_33

					if var_273_33 + var_273_26 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_33 + var_273_26
					end
				end

				arg_270_1.text_.text = var_273_30
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111066", "story_v_out_114111.awb") ~= 0 then
					local var_273_34 = manager.audio:GetVoiceLength("story_v_out_114111", "114111066", "story_v_out_114111.awb") / 1000

					if var_273_34 + var_273_26 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_34 + var_273_26
					end

					if var_273_29.prefab_name ~= "" and arg_270_1.actors_[var_273_29.prefab_name] ~= nil then
						local var_273_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_29.prefab_name].transform, "story_v_out_114111", "114111066", "story_v_out_114111.awb")

						arg_270_1:RecordAudio("114111066", var_273_35)
						arg_270_1:RecordAudio("114111066", var_273_35)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_114111", "114111066", "story_v_out_114111.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_114111", "114111066", "story_v_out_114111.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_36 = math.max(var_273_27, arg_270_1.talkMaxDuration)

			if var_273_26 <= arg_270_1.time_ and arg_270_1.time_ < var_273_26 + var_273_36 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_26) / var_273_36

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_26 + var_273_36 and arg_270_1.time_ < var_273_26 + var_273_36 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play114111067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 114111067
		arg_274_1.duration_ = 5.83

		local var_274_0 = {
			ja = 5.833,
			ko = 4.7,
			zh = 4.766,
			en = 4.733
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play114111068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action8_1")
			end

			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_277_2 = arg_274_1.actors_["1041ui_story"]
			local var_277_3 = 0

			if var_277_3 < arg_274_1.time_ and arg_274_1.time_ <= var_277_3 + arg_277_0 and not isNil(var_277_2) and arg_274_1.var_.characterEffect1041ui_story == nil then
				arg_274_1.var_.characterEffect1041ui_story = var_277_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_4 = 0.2

			if var_277_3 <= arg_274_1.time_ and arg_274_1.time_ < var_277_3 + var_277_4 and not isNil(var_277_2) then
				local var_277_5 = (arg_274_1.time_ - var_277_3) / var_277_4

				if arg_274_1.var_.characterEffect1041ui_story and not isNil(var_277_2) then
					arg_274_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_3 + var_277_4 and arg_274_1.time_ < var_277_3 + var_277_4 + arg_277_0 and not isNil(var_277_2) and arg_274_1.var_.characterEffect1041ui_story then
				arg_274_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_277_6 = arg_274_1.actors_["1041ui_story"].transform
			local var_277_7 = 0

			if var_277_7 < arg_274_1.time_ and arg_274_1.time_ <= var_277_7 + arg_277_0 then
				arg_274_1.var_.moveOldPos1041ui_story = var_277_6.localPosition

				local var_277_8 = "1041ui_story"

				arg_274_1:ShowWeapon(arg_274_1.var_[var_277_8 .. "Animator"].transform, true)
			end

			local var_277_9 = 0.001

			if var_277_7 <= arg_274_1.time_ and arg_274_1.time_ < var_277_7 + var_277_9 then
				local var_277_10 = (arg_274_1.time_ - var_277_7) / var_277_9
				local var_277_11 = Vector3.New(-0.7, -1.11, -5.9)

				var_277_6.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1041ui_story, var_277_11, var_277_10)

				local var_277_12 = manager.ui.mainCamera.transform.position - var_277_6.position

				var_277_6.forward = Vector3.New(var_277_12.x, var_277_12.y, var_277_12.z)

				local var_277_13 = var_277_6.localEulerAngles

				var_277_13.z = 0
				var_277_13.x = 0
				var_277_6.localEulerAngles = var_277_13
			end

			if arg_274_1.time_ >= var_277_7 + var_277_9 and arg_274_1.time_ < var_277_7 + var_277_9 + arg_277_0 then
				var_277_6.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_277_14 = manager.ui.mainCamera.transform.position - var_277_6.position

				var_277_6.forward = Vector3.New(var_277_14.x, var_277_14.y, var_277_14.z)

				local var_277_15 = var_277_6.localEulerAngles

				var_277_15.z = 0
				var_277_15.x = 0
				var_277_6.localEulerAngles = var_277_15
			end

			local var_277_16 = arg_274_1.actors_["1038ui_story"]
			local var_277_17 = 0

			if var_277_17 < arg_274_1.time_ and arg_274_1.time_ <= var_277_17 + arg_277_0 and not isNil(var_277_16) and arg_274_1.var_.characterEffect1038ui_story == nil then
				arg_274_1.var_.characterEffect1038ui_story = var_277_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_18 = 0.2

			if var_277_17 <= arg_274_1.time_ and arg_274_1.time_ < var_277_17 + var_277_18 and not isNil(var_277_16) then
				local var_277_19 = (arg_274_1.time_ - var_277_17) / var_277_18

				if arg_274_1.var_.characterEffect1038ui_story and not isNil(var_277_16) then
					local var_277_20 = Mathf.Lerp(0, 0.5, var_277_19)

					arg_274_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1038ui_story.fillRatio = var_277_20
				end
			end

			if arg_274_1.time_ >= var_277_17 + var_277_18 and arg_274_1.time_ < var_277_17 + var_277_18 + arg_277_0 and not isNil(var_277_16) and arg_274_1.var_.characterEffect1038ui_story then
				local var_277_21 = 0.5

				arg_274_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1038ui_story.fillRatio = var_277_21
			end

			local var_277_22 = 0
			local var_277_23 = 0.525

			if var_277_22 < arg_274_1.time_ and arg_274_1.time_ <= var_277_22 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_24 = arg_274_1:FormatText(StoryNameCfg[208].name)

				arg_274_1.leftNameTxt_.text = var_277_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_25 = arg_274_1:GetWordFromCfg(114111067)
				local var_277_26 = arg_274_1:FormatText(var_277_25.content)

				arg_274_1.text_.text = var_277_26

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_27 = 21
				local var_277_28 = utf8.len(var_277_26)
				local var_277_29 = var_277_27 <= 0 and var_277_23 or var_277_23 * (var_277_28 / var_277_27)

				if var_277_29 > 0 and var_277_23 < var_277_29 then
					arg_274_1.talkMaxDuration = var_277_29

					if var_277_29 + var_277_22 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_29 + var_277_22
					end
				end

				arg_274_1.text_.text = var_277_26
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111067", "story_v_out_114111.awb") ~= 0 then
					local var_277_30 = manager.audio:GetVoiceLength("story_v_out_114111", "114111067", "story_v_out_114111.awb") / 1000

					if var_277_30 + var_277_22 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_30 + var_277_22
					end

					if var_277_25.prefab_name ~= "" and arg_274_1.actors_[var_277_25.prefab_name] ~= nil then
						local var_277_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_25.prefab_name].transform, "story_v_out_114111", "114111067", "story_v_out_114111.awb")

						arg_274_1:RecordAudio("114111067", var_277_31)
						arg_274_1:RecordAudio("114111067", var_277_31)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_114111", "114111067", "story_v_out_114111.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_114111", "114111067", "story_v_out_114111.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_32 = math.max(var_277_23, arg_274_1.talkMaxDuration)

			if var_277_22 <= arg_274_1.time_ and arg_274_1.time_ < var_277_22 + var_277_32 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_22) / var_277_32

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_22 + var_277_32 and arg_274_1.time_ < var_277_22 + var_277_32 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play114111068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 114111068
		arg_278_1.duration_ = 9

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play114111069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_1 = 2

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_1 then
				local var_281_2 = (arg_278_1.time_ - var_281_0) / var_281_1
				local var_281_3 = Color.New(0, 0, 0)

				var_281_3.a = Mathf.Lerp(0, 1, var_281_2)
				arg_278_1.mask_.color = var_281_3
			end

			if arg_278_1.time_ >= var_281_0 + var_281_1 and arg_278_1.time_ < var_281_0 + var_281_1 + arg_281_0 then
				local var_281_4 = Color.New(0, 0, 0)

				var_281_4.a = 1
				arg_278_1.mask_.color = var_281_4
			end

			local var_281_5 = 2

			if var_281_5 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_6 = 2

			if var_281_5 <= arg_278_1.time_ and arg_278_1.time_ < var_281_5 + var_281_6 then
				local var_281_7 = (arg_278_1.time_ - var_281_5) / var_281_6
				local var_281_8 = Color.New(0, 0, 0)

				var_281_8.a = Mathf.Lerp(1, 0, var_281_7)
				arg_278_1.mask_.color = var_281_8
			end

			if arg_278_1.time_ >= var_281_5 + var_281_6 and arg_278_1.time_ < var_281_5 + var_281_6 + arg_281_0 then
				local var_281_9 = Color.New(0, 0, 0)
				local var_281_10 = 0

				arg_278_1.mask_.enabled = false
				var_281_9.a = var_281_10
				arg_278_1.mask_.color = var_281_9
			end

			local var_281_11 = arg_278_1.actors_["1041ui_story"].transform
			local var_281_12 = 1.966

			if var_281_12 < arg_278_1.time_ and arg_278_1.time_ <= var_281_12 + arg_281_0 then
				arg_278_1.var_.moveOldPos1041ui_story = var_281_11.localPosition

				local var_281_13 = "1041ui_story"

				arg_278_1:ShowWeapon(arg_278_1.var_[var_281_13 .. "Animator"].transform, false)
			end

			local var_281_14 = 0.001

			if var_281_12 <= arg_278_1.time_ and arg_278_1.time_ < var_281_12 + var_281_14 then
				local var_281_15 = (arg_278_1.time_ - var_281_12) / var_281_14
				local var_281_16 = Vector3.New(0, 100, 0)

				var_281_11.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1041ui_story, var_281_16, var_281_15)

				local var_281_17 = manager.ui.mainCamera.transform.position - var_281_11.position

				var_281_11.forward = Vector3.New(var_281_17.x, var_281_17.y, var_281_17.z)

				local var_281_18 = var_281_11.localEulerAngles

				var_281_18.z = 0
				var_281_18.x = 0
				var_281_11.localEulerAngles = var_281_18
			end

			if arg_278_1.time_ >= var_281_12 + var_281_14 and arg_278_1.time_ < var_281_12 + var_281_14 + arg_281_0 then
				var_281_11.localPosition = Vector3.New(0, 100, 0)

				local var_281_19 = manager.ui.mainCamera.transform.position - var_281_11.position

				var_281_11.forward = Vector3.New(var_281_19.x, var_281_19.y, var_281_19.z)

				local var_281_20 = var_281_11.localEulerAngles

				var_281_20.z = 0
				var_281_20.x = 0
				var_281_11.localEulerAngles = var_281_20
			end

			local var_281_21 = arg_278_1.actors_["1038ui_story"].transform
			local var_281_22 = 1.966

			if var_281_22 < arg_278_1.time_ and arg_278_1.time_ <= var_281_22 + arg_281_0 then
				arg_278_1.var_.moveOldPos1038ui_story = var_281_21.localPosition
			end

			local var_281_23 = 0.001

			if var_281_22 <= arg_278_1.time_ and arg_278_1.time_ < var_281_22 + var_281_23 then
				local var_281_24 = (arg_278_1.time_ - var_281_22) / var_281_23
				local var_281_25 = Vector3.New(0, 100, 0)

				var_281_21.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1038ui_story, var_281_25, var_281_24)

				local var_281_26 = manager.ui.mainCamera.transform.position - var_281_21.position

				var_281_21.forward = Vector3.New(var_281_26.x, var_281_26.y, var_281_26.z)

				local var_281_27 = var_281_21.localEulerAngles

				var_281_27.z = 0
				var_281_27.x = 0
				var_281_21.localEulerAngles = var_281_27
			end

			if arg_278_1.time_ >= var_281_22 + var_281_23 and arg_278_1.time_ < var_281_22 + var_281_23 + arg_281_0 then
				var_281_21.localPosition = Vector3.New(0, 100, 0)

				local var_281_28 = manager.ui.mainCamera.transform.position - var_281_21.position

				var_281_21.forward = Vector3.New(var_281_28.x, var_281_28.y, var_281_28.z)

				local var_281_29 = var_281_21.localEulerAngles

				var_281_29.z = 0
				var_281_29.x = 0
				var_281_21.localEulerAngles = var_281_29
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_30 = 4
			local var_281_31 = 0.6

			if var_281_30 < arg_278_1.time_ and arg_278_1.time_ <= var_281_30 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_32 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_32:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_33 = arg_278_1:GetWordFromCfg(114111068)
				local var_281_34 = arg_278_1:FormatText(var_281_33.content)

				arg_278_1.text_.text = var_281_34

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_35 = 24
				local var_281_36 = utf8.len(var_281_34)
				local var_281_37 = var_281_35 <= 0 and var_281_31 or var_281_31 * (var_281_36 / var_281_35)

				if var_281_37 > 0 and var_281_31 < var_281_37 then
					arg_278_1.talkMaxDuration = var_281_37
					var_281_30 = var_281_30 + 0.3

					if var_281_37 + var_281_30 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_37 + var_281_30
					end
				end

				arg_278_1.text_.text = var_281_34
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_38 = var_281_30 + 0.3
			local var_281_39 = math.max(var_281_31, arg_278_1.talkMaxDuration)

			if var_281_38 <= arg_278_1.time_ and arg_278_1.time_ < var_281_38 + var_281_39 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_38) / var_281_39

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_38 + var_281_39 and arg_278_1.time_ < var_281_38 + var_281_39 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play114111069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 114111069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play114111070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0
			local var_287_1 = 0.775

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_2 = arg_284_1:GetWordFromCfg(114111069)
				local var_287_3 = arg_284_1:FormatText(var_287_2.content)

				arg_284_1.text_.text = var_287_3

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 31
				local var_287_5 = utf8.len(var_287_3)
				local var_287_6 = var_287_4 <= 0 and var_287_1 or var_287_1 * (var_287_5 / var_287_4)

				if var_287_6 > 0 and var_287_1 < var_287_6 then
					arg_284_1.talkMaxDuration = var_287_6

					if var_287_6 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_6 + var_287_0
					end
				end

				arg_284_1.text_.text = var_287_3
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_1, arg_284_1.talkMaxDuration)

			if var_287_0 <= arg_284_1.time_ and arg_284_1.time_ < var_287_0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_0 + var_287_7 and arg_284_1.time_ < var_287_0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play114111070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 114111070
		arg_288_1.duration_ = 6.37

		local var_288_0 = {
			ja = 6.2,
			ko = 4.633,
			zh = 6.366,
			en = 4.6
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play114111071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0
			local var_291_1 = 0.35

			if var_291_0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_2 = arg_288_1:FormatText(StoryNameCfg[212].name)

				arg_288_1.leftNameTxt_.text = var_291_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_3 = arg_288_1:GetWordFromCfg(114111070)
				local var_291_4 = arg_288_1:FormatText(var_291_3.content)

				arg_288_1.text_.text = var_291_4

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 14
				local var_291_6 = utf8.len(var_291_4)
				local var_291_7 = var_291_5 <= 0 and var_291_1 or var_291_1 * (var_291_6 / var_291_5)

				if var_291_7 > 0 and var_291_1 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_0
					end
				end

				arg_288_1.text_.text = var_291_4
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111070", "story_v_out_114111.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_out_114111", "114111070", "story_v_out_114111.awb") / 1000

					if var_291_8 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_0
					end

					if var_291_3.prefab_name ~= "" and arg_288_1.actors_[var_291_3.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_3.prefab_name].transform, "story_v_out_114111", "114111070", "story_v_out_114111.awb")

						arg_288_1:RecordAudio("114111070", var_291_9)
						arg_288_1:RecordAudio("114111070", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_114111", "114111070", "story_v_out_114111.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_114111", "114111070", "story_v_out_114111.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_1, arg_288_1.talkMaxDuration)

			if var_291_0 <= arg_288_1.time_ and arg_288_1.time_ < var_291_0 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_0) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_0 + var_291_10 and arg_288_1.time_ < var_291_0 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play114111071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 114111071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play114111072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0
			local var_295_1 = 1.25

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_2 = arg_292_1:GetWordFromCfg(114111071)
				local var_295_3 = arg_292_1:FormatText(var_295_2.content)

				arg_292_1.text_.text = var_295_3

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_4 = 51
				local var_295_5 = utf8.len(var_295_3)
				local var_295_6 = var_295_4 <= 0 and var_295_1 or var_295_1 * (var_295_5 / var_295_4)

				if var_295_6 > 0 and var_295_1 < var_295_6 then
					arg_292_1.talkMaxDuration = var_295_6

					if var_295_6 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_6 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_3
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_7 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_7 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_7

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_7 and arg_292_1.time_ < var_295_0 + var_295_7 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play114111072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 114111072
		arg_296_1.duration_ = 13.3

		local var_296_0 = {
			ja = 7.966,
			ko = 9.4,
			zh = 13.3,
			en = 8.366
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
				arg_296_0:Play114111073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = "10006ui_story"

			if arg_296_1.actors_[var_299_0] == nil then
				local var_299_1 = Asset.Load("Char/" .. "10006ui_story")

				if not isNil(var_299_1) then
					local var_299_2 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_story"), arg_296_1.stage_.transform)

					var_299_2.name = var_299_0
					var_299_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_296_1.actors_[var_299_0] = var_299_2

					local var_299_3 = var_299_2:GetComponentInChildren(typeof(CharacterEffect))

					var_299_3.enabled = true

					local var_299_4 = GameObjectTools.GetOrAddComponent(var_299_2, typeof(DynamicBoneHelper))

					if var_299_4 then
						var_299_4:EnableDynamicBone(false)
					end

					arg_296_1:ShowWeapon(var_299_3.transform, false)

					arg_296_1.var_[var_299_0 .. "Animator"] = var_299_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_296_1.var_[var_299_0 .. "Animator"].applyRootMotion = true
					arg_296_1.var_[var_299_0 .. "LipSync"] = var_299_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_299_5 = arg_296_1.actors_["10006ui_story"].transform
			local var_299_6 = 0

			if var_299_6 < arg_296_1.time_ and arg_296_1.time_ <= var_299_6 + arg_299_0 then
				arg_296_1.var_.moveOldPos10006ui_story = var_299_5.localPosition
			end

			local var_299_7 = 0.001

			if var_299_6 <= arg_296_1.time_ and arg_296_1.time_ < var_299_6 + var_299_7 then
				local var_299_8 = (arg_296_1.time_ - var_299_6) / var_299_7
				local var_299_9 = Vector3.New(-0.7, -0.98, -5.65)

				var_299_5.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10006ui_story, var_299_9, var_299_8)

				local var_299_10 = manager.ui.mainCamera.transform.position - var_299_5.position

				var_299_5.forward = Vector3.New(var_299_10.x, var_299_10.y, var_299_10.z)

				local var_299_11 = var_299_5.localEulerAngles

				var_299_11.z = 0
				var_299_11.x = 0
				var_299_5.localEulerAngles = var_299_11
			end

			if arg_296_1.time_ >= var_299_6 + var_299_7 and arg_296_1.time_ < var_299_6 + var_299_7 + arg_299_0 then
				var_299_5.localPosition = Vector3.New(-0.7, -0.98, -5.65)

				local var_299_12 = manager.ui.mainCamera.transform.position - var_299_5.position

				var_299_5.forward = Vector3.New(var_299_12.x, var_299_12.y, var_299_12.z)

				local var_299_13 = var_299_5.localEulerAngles

				var_299_13.z = 0
				var_299_13.x = 0
				var_299_5.localEulerAngles = var_299_13
			end

			local var_299_14 = 0

			if var_299_14 < arg_296_1.time_ and arg_296_1.time_ <= var_299_14 + arg_299_0 then
				arg_296_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			local var_299_15 = 0

			if var_299_15 < arg_296_1.time_ and arg_296_1.time_ <= var_299_15 + arg_299_0 then
				arg_296_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_299_16 = arg_296_1.actors_["10006ui_story"]
			local var_299_17 = 0

			if var_299_17 < arg_296_1.time_ and arg_296_1.time_ <= var_299_17 + arg_299_0 and not isNil(var_299_16) and arg_296_1.var_.characterEffect10006ui_story == nil then
				arg_296_1.var_.characterEffect10006ui_story = var_299_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_18 = 0.2

			if var_299_17 <= arg_296_1.time_ and arg_296_1.time_ < var_299_17 + var_299_18 and not isNil(var_299_16) then
				local var_299_19 = (arg_296_1.time_ - var_299_17) / var_299_18

				if arg_296_1.var_.characterEffect10006ui_story and not isNil(var_299_16) then
					arg_296_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= var_299_17 + var_299_18 and arg_296_1.time_ < var_299_17 + var_299_18 + arg_299_0 and not isNil(var_299_16) and arg_296_1.var_.characterEffect10006ui_story then
				arg_296_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_299_20 = 0
			local var_299_21 = 0.775

			if var_299_20 < arg_296_1.time_ and arg_296_1.time_ <= var_299_20 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_22 = arg_296_1:FormatText(StoryNameCfg[212].name)

				arg_296_1.leftNameTxt_.text = var_299_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_23 = arg_296_1:GetWordFromCfg(114111072)
				local var_299_24 = arg_296_1:FormatText(var_299_23.content)

				arg_296_1.text_.text = var_299_24

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_25 = 31
				local var_299_26 = utf8.len(var_299_24)
				local var_299_27 = var_299_25 <= 0 and var_299_21 or var_299_21 * (var_299_26 / var_299_25)

				if var_299_27 > 0 and var_299_21 < var_299_27 then
					arg_296_1.talkMaxDuration = var_299_27

					if var_299_27 + var_299_20 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_27 + var_299_20
					end
				end

				arg_296_1.text_.text = var_299_24
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111072", "story_v_out_114111.awb") ~= 0 then
					local var_299_28 = manager.audio:GetVoiceLength("story_v_out_114111", "114111072", "story_v_out_114111.awb") / 1000

					if var_299_28 + var_299_20 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_28 + var_299_20
					end

					if var_299_23.prefab_name ~= "" and arg_296_1.actors_[var_299_23.prefab_name] ~= nil then
						local var_299_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_23.prefab_name].transform, "story_v_out_114111", "114111072", "story_v_out_114111.awb")

						arg_296_1:RecordAudio("114111072", var_299_29)
						arg_296_1:RecordAudio("114111072", var_299_29)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_114111", "114111072", "story_v_out_114111.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_114111", "114111072", "story_v_out_114111.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_30 = math.max(var_299_21, arg_296_1.talkMaxDuration)

			if var_299_20 <= arg_296_1.time_ and arg_296_1.time_ < var_299_20 + var_299_30 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_20) / var_299_30

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_20 + var_299_30 and arg_296_1.time_ < var_299_20 + var_299_30 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play114111073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 114111073
		arg_300_1.duration_ = 13.3

		local var_300_0 = {
			ja = 13.3,
			ko = 9.5,
			zh = 7.466,
			en = 8.666
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
				arg_300_0:Play114111074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action5_1")
			end

			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_303_2 = 0
			local var_303_3 = 0.725

			if var_303_2 < arg_300_1.time_ and arg_300_1.time_ <= var_303_2 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_4 = arg_300_1:FormatText(StoryNameCfg[212].name)

				arg_300_1.leftNameTxt_.text = var_303_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_5 = arg_300_1:GetWordFromCfg(114111073)
				local var_303_6 = arg_300_1:FormatText(var_303_5.content)

				arg_300_1.text_.text = var_303_6

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_7 = 29
				local var_303_8 = utf8.len(var_303_6)
				local var_303_9 = var_303_7 <= 0 and var_303_3 or var_303_3 * (var_303_8 / var_303_7)

				if var_303_9 > 0 and var_303_3 < var_303_9 then
					arg_300_1.talkMaxDuration = var_303_9

					if var_303_9 + var_303_2 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_9 + var_303_2
					end
				end

				arg_300_1.text_.text = var_303_6
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111073", "story_v_out_114111.awb") ~= 0 then
					local var_303_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111073", "story_v_out_114111.awb") / 1000

					if var_303_10 + var_303_2 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_10 + var_303_2
					end

					if var_303_5.prefab_name ~= "" and arg_300_1.actors_[var_303_5.prefab_name] ~= nil then
						local var_303_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_5.prefab_name].transform, "story_v_out_114111", "114111073", "story_v_out_114111.awb")

						arg_300_1:RecordAudio("114111073", var_303_11)
						arg_300_1:RecordAudio("114111073", var_303_11)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_114111", "114111073", "story_v_out_114111.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_114111", "114111073", "story_v_out_114111.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_12 = math.max(var_303_3, arg_300_1.talkMaxDuration)

			if var_303_2 <= arg_300_1.time_ and arg_300_1.time_ < var_303_2 + var_303_12 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_2) / var_303_12

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_2 + var_303_12 and arg_300_1.time_ < var_303_2 + var_303_12 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play114111074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 114111074
		arg_304_1.duration_ = 5.33

		local var_304_0 = {
			ja = 5.333,
			ko = 3.266,
			zh = 4.566,
			en = 4.9
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play114111075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action5_2")
			end

			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_307_2 = 0
			local var_307_3 = 0.325

			if var_307_2 < arg_304_1.time_ and arg_304_1.time_ <= var_307_2 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_4 = arg_304_1:FormatText(StoryNameCfg[212].name)

				arg_304_1.leftNameTxt_.text = var_307_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_5 = arg_304_1:GetWordFromCfg(114111074)
				local var_307_6 = arg_304_1:FormatText(var_307_5.content)

				arg_304_1.text_.text = var_307_6

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_7 = 13
				local var_307_8 = utf8.len(var_307_6)
				local var_307_9 = var_307_7 <= 0 and var_307_3 or var_307_3 * (var_307_8 / var_307_7)

				if var_307_9 > 0 and var_307_3 < var_307_9 then
					arg_304_1.talkMaxDuration = var_307_9

					if var_307_9 + var_307_2 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_9 + var_307_2
					end
				end

				arg_304_1.text_.text = var_307_6
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111074", "story_v_out_114111.awb") ~= 0 then
					local var_307_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111074", "story_v_out_114111.awb") / 1000

					if var_307_10 + var_307_2 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_10 + var_307_2
					end

					if var_307_5.prefab_name ~= "" and arg_304_1.actors_[var_307_5.prefab_name] ~= nil then
						local var_307_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_5.prefab_name].transform, "story_v_out_114111", "114111074", "story_v_out_114111.awb")

						arg_304_1:RecordAudio("114111074", var_307_11)
						arg_304_1:RecordAudio("114111074", var_307_11)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_114111", "114111074", "story_v_out_114111.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_114111", "114111074", "story_v_out_114111.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_12 = math.max(var_307_3, arg_304_1.talkMaxDuration)

			if var_307_2 <= arg_304_1.time_ and arg_304_1.time_ < var_307_2 + var_307_12 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_2) / var_307_12

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_2 + var_307_12 and arg_304_1.time_ < var_307_2 + var_307_12 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play114111075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 114111075
		arg_308_1.duration_ = 3.07

		local var_308_0 = {
			ja = 1.999999999999,
			ko = 3.066,
			zh = 2.6,
			en = 2.266
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play114111076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1097ui_story"].transform
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.var_.moveOldPos1097ui_story = var_311_0.localPosition
			end

			local var_311_2 = 0.001

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2
				local var_311_4 = Vector3.New(0.7, -0.54, -6.3)

				var_311_0.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1097ui_story, var_311_4, var_311_3)

				local var_311_5 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_5.x, var_311_5.y, var_311_5.z)

				local var_311_6 = var_311_0.localEulerAngles

				var_311_6.z = 0
				var_311_6.x = 0
				var_311_0.localEulerAngles = var_311_6
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 then
				var_311_0.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_311_7 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_7.x, var_311_7.y, var_311_7.z)

				local var_311_8 = var_311_0.localEulerAngles

				var_311_8.z = 0
				var_311_8.x = 0
				var_311_0.localEulerAngles = var_311_8
			end

			local var_311_9 = 0

			if var_311_9 < arg_308_1.time_ and arg_308_1.time_ <= var_311_9 + arg_311_0 then
				arg_308_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_311_10 = 0

			if var_311_10 < arg_308_1.time_ and arg_308_1.time_ <= var_311_10 + arg_311_0 then
				arg_308_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_311_11 = arg_308_1.actors_["1097ui_story"]
			local var_311_12 = 0

			if var_311_12 < arg_308_1.time_ and arg_308_1.time_ <= var_311_12 + arg_311_0 and not isNil(var_311_11) and arg_308_1.var_.characterEffect1097ui_story == nil then
				arg_308_1.var_.characterEffect1097ui_story = var_311_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_13 = 0.2

			if var_311_12 <= arg_308_1.time_ and arg_308_1.time_ < var_311_12 + var_311_13 and not isNil(var_311_11) then
				local var_311_14 = (arg_308_1.time_ - var_311_12) / var_311_13

				if arg_308_1.var_.characterEffect1097ui_story and not isNil(var_311_11) then
					arg_308_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= var_311_12 + var_311_13 and arg_308_1.time_ < var_311_12 + var_311_13 + arg_311_0 and not isNil(var_311_11) and arg_308_1.var_.characterEffect1097ui_story then
				arg_308_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_311_15 = arg_308_1.actors_["10006ui_story"]
			local var_311_16 = 0

			if var_311_16 < arg_308_1.time_ and arg_308_1.time_ <= var_311_16 + arg_311_0 and not isNil(var_311_15) and arg_308_1.var_.characterEffect10006ui_story == nil then
				arg_308_1.var_.characterEffect10006ui_story = var_311_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_17 = 0.2

			if var_311_16 <= arg_308_1.time_ and arg_308_1.time_ < var_311_16 + var_311_17 and not isNil(var_311_15) then
				local var_311_18 = (arg_308_1.time_ - var_311_16) / var_311_17

				if arg_308_1.var_.characterEffect10006ui_story and not isNil(var_311_15) then
					local var_311_19 = Mathf.Lerp(0, 0.5, var_311_18)

					arg_308_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_308_1.var_.characterEffect10006ui_story.fillRatio = var_311_19
				end
			end

			if arg_308_1.time_ >= var_311_16 + var_311_17 and arg_308_1.time_ < var_311_16 + var_311_17 + arg_311_0 and not isNil(var_311_15) and arg_308_1.var_.characterEffect10006ui_story then
				local var_311_20 = 0.5

				arg_308_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_308_1.var_.characterEffect10006ui_story.fillRatio = var_311_20
			end

			local var_311_21 = 0
			local var_311_22 = 0.2

			if var_311_21 < arg_308_1.time_ and arg_308_1.time_ <= var_311_21 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_23 = arg_308_1:FormatText(StoryNameCfg[216].name)

				arg_308_1.leftNameTxt_.text = var_311_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_24 = arg_308_1:GetWordFromCfg(114111075)
				local var_311_25 = arg_308_1:FormatText(var_311_24.content)

				arg_308_1.text_.text = var_311_25

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_26 = 8
				local var_311_27 = utf8.len(var_311_25)
				local var_311_28 = var_311_26 <= 0 and var_311_22 or var_311_22 * (var_311_27 / var_311_26)

				if var_311_28 > 0 and var_311_22 < var_311_28 then
					arg_308_1.talkMaxDuration = var_311_28

					if var_311_28 + var_311_21 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_28 + var_311_21
					end
				end

				arg_308_1.text_.text = var_311_25
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111075", "story_v_out_114111.awb") ~= 0 then
					local var_311_29 = manager.audio:GetVoiceLength("story_v_out_114111", "114111075", "story_v_out_114111.awb") / 1000

					if var_311_29 + var_311_21 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_29 + var_311_21
					end

					if var_311_24.prefab_name ~= "" and arg_308_1.actors_[var_311_24.prefab_name] ~= nil then
						local var_311_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_24.prefab_name].transform, "story_v_out_114111", "114111075", "story_v_out_114111.awb")

						arg_308_1:RecordAudio("114111075", var_311_30)
						arg_308_1:RecordAudio("114111075", var_311_30)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_114111", "114111075", "story_v_out_114111.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_114111", "114111075", "story_v_out_114111.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_31 = math.max(var_311_22, arg_308_1.talkMaxDuration)

			if var_311_21 <= arg_308_1.time_ and arg_308_1.time_ < var_311_21 + var_311_31 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_21) / var_311_31

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_21 + var_311_31 and arg_308_1.time_ < var_311_21 + var_311_31 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play114111076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 114111076
		arg_312_1.duration_ = 9.43

		local var_312_0 = {
			ja = 7.9,
			ko = 7.3,
			zh = 9.433,
			en = 7.3
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play114111077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["10006ui_story"].transform
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.var_.moveOldPos10006ui_story = var_315_0.localPosition
			end

			local var_315_2 = 0.001

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2
				local var_315_4 = Vector3.New(0, 100, 0)

				var_315_0.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10006ui_story, var_315_4, var_315_3)

				local var_315_5 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_5.x, var_315_5.y, var_315_5.z)

				local var_315_6 = var_315_0.localEulerAngles

				var_315_6.z = 0
				var_315_6.x = 0
				var_315_0.localEulerAngles = var_315_6
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 then
				var_315_0.localPosition = Vector3.New(0, 100, 0)

				local var_315_7 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_7.x, var_315_7.y, var_315_7.z)

				local var_315_8 = var_315_0.localEulerAngles

				var_315_8.z = 0
				var_315_8.x = 0
				var_315_0.localEulerAngles = var_315_8
			end

			local var_315_9 = arg_312_1.actors_["1097ui_story"].transform
			local var_315_10 = 0

			if var_315_10 < arg_312_1.time_ and arg_312_1.time_ <= var_315_10 + arg_315_0 then
				arg_312_1.var_.moveOldPos1097ui_story = var_315_9.localPosition
			end

			local var_315_11 = 0.001

			if var_315_10 <= arg_312_1.time_ and arg_312_1.time_ < var_315_10 + var_315_11 then
				local var_315_12 = (arg_312_1.time_ - var_315_10) / var_315_11
				local var_315_13 = Vector3.New(0, 100, 0)

				var_315_9.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1097ui_story, var_315_13, var_315_12)

				local var_315_14 = manager.ui.mainCamera.transform.position - var_315_9.position

				var_315_9.forward = Vector3.New(var_315_14.x, var_315_14.y, var_315_14.z)

				local var_315_15 = var_315_9.localEulerAngles

				var_315_15.z = 0
				var_315_15.x = 0
				var_315_9.localEulerAngles = var_315_15
			end

			if arg_312_1.time_ >= var_315_10 + var_315_11 and arg_312_1.time_ < var_315_10 + var_315_11 + arg_315_0 then
				var_315_9.localPosition = Vector3.New(0, 100, 0)

				local var_315_16 = manager.ui.mainCamera.transform.position - var_315_9.position

				var_315_9.forward = Vector3.New(var_315_16.x, var_315_16.y, var_315_16.z)

				local var_315_17 = var_315_9.localEulerAngles

				var_315_17.z = 0
				var_315_17.x = 0
				var_315_9.localEulerAngles = var_315_17
			end

			local var_315_18 = 0
			local var_315_19 = 0.575

			if var_315_18 < arg_312_1.time_ and arg_312_1.time_ <= var_315_18 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_20 = arg_312_1:FormatText(StoryNameCfg[212].name)

				arg_312_1.leftNameTxt_.text = var_315_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_21 = arg_312_1:GetWordFromCfg(114111076)
				local var_315_22 = arg_312_1:FormatText(var_315_21.content)

				arg_312_1.text_.text = var_315_22

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_23 = 23
				local var_315_24 = utf8.len(var_315_22)
				local var_315_25 = var_315_23 <= 0 and var_315_19 or var_315_19 * (var_315_24 / var_315_23)

				if var_315_25 > 0 and var_315_19 < var_315_25 then
					arg_312_1.talkMaxDuration = var_315_25

					if var_315_25 + var_315_18 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_25 + var_315_18
					end
				end

				arg_312_1.text_.text = var_315_22
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111076", "story_v_out_114111.awb") ~= 0 then
					local var_315_26 = manager.audio:GetVoiceLength("story_v_out_114111", "114111076", "story_v_out_114111.awb") / 1000

					if var_315_26 + var_315_18 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_26 + var_315_18
					end

					if var_315_21.prefab_name ~= "" and arg_312_1.actors_[var_315_21.prefab_name] ~= nil then
						local var_315_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_21.prefab_name].transform, "story_v_out_114111", "114111076", "story_v_out_114111.awb")

						arg_312_1:RecordAudio("114111076", var_315_27)
						arg_312_1:RecordAudio("114111076", var_315_27)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_114111", "114111076", "story_v_out_114111.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_114111", "114111076", "story_v_out_114111.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_28 = math.max(var_315_19, arg_312_1.talkMaxDuration)

			if var_315_18 <= arg_312_1.time_ and arg_312_1.time_ < var_315_18 + var_315_28 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_18) / var_315_28

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_18 + var_315_28 and arg_312_1.time_ < var_315_18 + var_315_28 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play114111077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 114111077
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play114111078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.95

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_2 = arg_316_1:GetWordFromCfg(114111077)
				local var_319_3 = arg_316_1:FormatText(var_319_2.content)

				arg_316_1.text_.text = var_319_3

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 38
				local var_319_5 = utf8.len(var_319_3)
				local var_319_6 = var_319_4 <= 0 and var_319_1 or var_319_1 * (var_319_5 / var_319_4)

				if var_319_6 > 0 and var_319_1 < var_319_6 then
					arg_316_1.talkMaxDuration = var_319_6

					if var_319_6 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_6 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_3
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_7 and arg_316_1.time_ < var_319_0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play114111078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 114111078
		arg_320_1.duration_ = 9.9

		local var_320_0 = {
			ja = 8.966,
			ko = 9.9,
			zh = 8.8,
			en = 8.133
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play114111079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["1041ui_story"].transform
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.var_.moveOldPos1041ui_story = var_323_0.localPosition
			end

			local var_323_2 = 0.001

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2
				local var_323_4 = Vector3.New(-0.7, -1.11, -5.9)

				var_323_0.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1041ui_story, var_323_4, var_323_3)

				local var_323_5 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_5.x, var_323_5.y, var_323_5.z)

				local var_323_6 = var_323_0.localEulerAngles

				var_323_6.z = 0
				var_323_6.x = 0
				var_323_0.localEulerAngles = var_323_6
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 then
				var_323_0.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_323_7 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_7.x, var_323_7.y, var_323_7.z)

				local var_323_8 = var_323_0.localEulerAngles

				var_323_8.z = 0
				var_323_8.x = 0
				var_323_0.localEulerAngles = var_323_8
			end

			local var_323_9 = 0

			if var_323_9 < arg_320_1.time_ and arg_320_1.time_ <= var_323_9 + arg_323_0 then
				arg_320_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_323_10 = 0

			if var_323_10 < arg_320_1.time_ and arg_320_1.time_ <= var_323_10 + arg_323_0 then
				arg_320_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_323_11 = arg_320_1.actors_["1041ui_story"]
			local var_323_12 = 0

			if var_323_12 < arg_320_1.time_ and arg_320_1.time_ <= var_323_12 + arg_323_0 and not isNil(var_323_11) and arg_320_1.var_.characterEffect1041ui_story == nil then
				arg_320_1.var_.characterEffect1041ui_story = var_323_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_13 = 0.2

			if var_323_12 <= arg_320_1.time_ and arg_320_1.time_ < var_323_12 + var_323_13 and not isNil(var_323_11) then
				local var_323_14 = (arg_320_1.time_ - var_323_12) / var_323_13

				if arg_320_1.var_.characterEffect1041ui_story and not isNil(var_323_11) then
					arg_320_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= var_323_12 + var_323_13 and arg_320_1.time_ < var_323_12 + var_323_13 + arg_323_0 and not isNil(var_323_11) and arg_320_1.var_.characterEffect1041ui_story then
				arg_320_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_323_15 = 0
			local var_323_16 = 0.95

			if var_323_15 < arg_320_1.time_ and arg_320_1.time_ <= var_323_15 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_17 = arg_320_1:FormatText(StoryNameCfg[208].name)

				arg_320_1.leftNameTxt_.text = var_323_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_18 = arg_320_1:GetWordFromCfg(114111078)
				local var_323_19 = arg_320_1:FormatText(var_323_18.content)

				arg_320_1.text_.text = var_323_19

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_20 = 38
				local var_323_21 = utf8.len(var_323_19)
				local var_323_22 = var_323_20 <= 0 and var_323_16 or var_323_16 * (var_323_21 / var_323_20)

				if var_323_22 > 0 and var_323_16 < var_323_22 then
					arg_320_1.talkMaxDuration = var_323_22

					if var_323_22 + var_323_15 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_22 + var_323_15
					end
				end

				arg_320_1.text_.text = var_323_19
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111078", "story_v_out_114111.awb") ~= 0 then
					local var_323_23 = manager.audio:GetVoiceLength("story_v_out_114111", "114111078", "story_v_out_114111.awb") / 1000

					if var_323_23 + var_323_15 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_23 + var_323_15
					end

					if var_323_18.prefab_name ~= "" and arg_320_1.actors_[var_323_18.prefab_name] ~= nil then
						local var_323_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_18.prefab_name].transform, "story_v_out_114111", "114111078", "story_v_out_114111.awb")

						arg_320_1:RecordAudio("114111078", var_323_24)
						arg_320_1:RecordAudio("114111078", var_323_24)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_114111", "114111078", "story_v_out_114111.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_114111", "114111078", "story_v_out_114111.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_25 = math.max(var_323_16, arg_320_1.talkMaxDuration)

			if var_323_15 <= arg_320_1.time_ and arg_320_1.time_ < var_323_15 + var_323_25 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_15) / var_323_25

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_15 + var_323_25 and arg_320_1.time_ < var_323_15 + var_323_25 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play114111079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 114111079
		arg_324_1.duration_ = 2.5

		local var_324_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.5,
			en = 1.999999999999
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play114111080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["1041ui_story"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1041ui_story == nil then
				arg_324_1.var_.characterEffect1041ui_story = var_327_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.2

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.characterEffect1041ui_story and not isNil(var_327_0) then
					local var_327_4 = Mathf.Lerp(0, 0.5, var_327_3)

					arg_324_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1041ui_story.fillRatio = var_327_4
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1041ui_story then
				local var_327_5 = 0.5

				arg_324_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1041ui_story.fillRatio = var_327_5
			end

			local var_327_6 = arg_324_1.actors_["10006ui_story"].transform
			local var_327_7 = 0

			if var_327_7 < arg_324_1.time_ and arg_324_1.time_ <= var_327_7 + arg_327_0 then
				arg_324_1.var_.moveOldPos10006ui_story = var_327_6.localPosition
			end

			local var_327_8 = 0.001

			if var_327_7 <= arg_324_1.time_ and arg_324_1.time_ < var_327_7 + var_327_8 then
				local var_327_9 = (arg_324_1.time_ - var_327_7) / var_327_8
				local var_327_10 = Vector3.New(0.7, -0.98, -5.65)

				var_327_6.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos10006ui_story, var_327_10, var_327_9)

				local var_327_11 = manager.ui.mainCamera.transform.position - var_327_6.position

				var_327_6.forward = Vector3.New(var_327_11.x, var_327_11.y, var_327_11.z)

				local var_327_12 = var_327_6.localEulerAngles

				var_327_12.z = 0
				var_327_12.x = 0
				var_327_6.localEulerAngles = var_327_12
			end

			if arg_324_1.time_ >= var_327_7 + var_327_8 and arg_324_1.time_ < var_327_7 + var_327_8 + arg_327_0 then
				var_327_6.localPosition = Vector3.New(0.7, -0.98, -5.65)

				local var_327_13 = manager.ui.mainCamera.transform.position - var_327_6.position

				var_327_6.forward = Vector3.New(var_327_13.x, var_327_13.y, var_327_13.z)

				local var_327_14 = var_327_6.localEulerAngles

				var_327_14.z = 0
				var_327_14.x = 0
				var_327_6.localEulerAngles = var_327_14
			end

			local var_327_15 = 0

			if var_327_15 < arg_324_1.time_ and arg_324_1.time_ <= var_327_15 + arg_327_0 then
				arg_324_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			local var_327_16 = 0

			if var_327_16 < arg_324_1.time_ and arg_324_1.time_ <= var_327_16 + arg_327_0 then
				arg_324_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_327_17 = arg_324_1.actors_["10006ui_story"]
			local var_327_18 = 0

			if var_327_18 < arg_324_1.time_ and arg_324_1.time_ <= var_327_18 + arg_327_0 and not isNil(var_327_17) and arg_324_1.var_.characterEffect10006ui_story == nil then
				arg_324_1.var_.characterEffect10006ui_story = var_327_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_19 = 0.2

			if var_327_18 <= arg_324_1.time_ and arg_324_1.time_ < var_327_18 + var_327_19 and not isNil(var_327_17) then
				local var_327_20 = (arg_324_1.time_ - var_327_18) / var_327_19

				if arg_324_1.var_.characterEffect10006ui_story and not isNil(var_327_17) then
					arg_324_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= var_327_18 + var_327_19 and arg_324_1.time_ < var_327_18 + var_327_19 + arg_327_0 and not isNil(var_327_17) and arg_324_1.var_.characterEffect10006ui_story then
				arg_324_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_327_21 = 0
			local var_327_22 = 0.175

			if var_327_21 < arg_324_1.time_ and arg_324_1.time_ <= var_327_21 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_23 = arg_324_1:FormatText(StoryNameCfg[212].name)

				arg_324_1.leftNameTxt_.text = var_327_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_24 = arg_324_1:GetWordFromCfg(114111079)
				local var_327_25 = arg_324_1:FormatText(var_327_24.content)

				arg_324_1.text_.text = var_327_25

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_26 = 7
				local var_327_27 = utf8.len(var_327_25)
				local var_327_28 = var_327_26 <= 0 and var_327_22 or var_327_22 * (var_327_27 / var_327_26)

				if var_327_28 > 0 and var_327_22 < var_327_28 then
					arg_324_1.talkMaxDuration = var_327_28

					if var_327_28 + var_327_21 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_28 + var_327_21
					end
				end

				arg_324_1.text_.text = var_327_25
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111079", "story_v_out_114111.awb") ~= 0 then
					local var_327_29 = manager.audio:GetVoiceLength("story_v_out_114111", "114111079", "story_v_out_114111.awb") / 1000

					if var_327_29 + var_327_21 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_29 + var_327_21
					end

					if var_327_24.prefab_name ~= "" and arg_324_1.actors_[var_327_24.prefab_name] ~= nil then
						local var_327_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_24.prefab_name].transform, "story_v_out_114111", "114111079", "story_v_out_114111.awb")

						arg_324_1:RecordAudio("114111079", var_327_30)
						arg_324_1:RecordAudio("114111079", var_327_30)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_114111", "114111079", "story_v_out_114111.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_114111", "114111079", "story_v_out_114111.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_31 = math.max(var_327_22, arg_324_1.talkMaxDuration)

			if var_327_21 <= arg_324_1.time_ and arg_324_1.time_ < var_327_21 + var_327_31 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_21) / var_327_31

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_21 + var_327_31 and arg_324_1.time_ < var_327_21 + var_327_31 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play114111080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 114111080
		arg_328_1.duration_ = 11.13

		local var_328_0 = {
			ja = 11.133,
			ko = 9.8,
			zh = 8.5,
			en = 8
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play114111081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_331_1 = arg_328_1.actors_["1041ui_story"]
			local var_331_2 = 0

			if var_331_2 < arg_328_1.time_ and arg_328_1.time_ <= var_331_2 + arg_331_0 and not isNil(var_331_1) and arg_328_1.var_.characterEffect1041ui_story == nil then
				arg_328_1.var_.characterEffect1041ui_story = var_331_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_3 = 0.2

			if var_331_2 <= arg_328_1.time_ and arg_328_1.time_ < var_331_2 + var_331_3 and not isNil(var_331_1) then
				local var_331_4 = (arg_328_1.time_ - var_331_2) / var_331_3

				if arg_328_1.var_.characterEffect1041ui_story and not isNil(var_331_1) then
					arg_328_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= var_331_2 + var_331_3 and arg_328_1.time_ < var_331_2 + var_331_3 + arg_331_0 and not isNil(var_331_1) and arg_328_1.var_.characterEffect1041ui_story then
				arg_328_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_331_5 = arg_328_1.actors_["10006ui_story"]
			local var_331_6 = 0

			if var_331_6 < arg_328_1.time_ and arg_328_1.time_ <= var_331_6 + arg_331_0 and not isNil(var_331_5) and arg_328_1.var_.characterEffect10006ui_story == nil then
				arg_328_1.var_.characterEffect10006ui_story = var_331_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_7 = 0.2

			if var_331_6 <= arg_328_1.time_ and arg_328_1.time_ < var_331_6 + var_331_7 and not isNil(var_331_5) then
				local var_331_8 = (arg_328_1.time_ - var_331_6) / var_331_7

				if arg_328_1.var_.characterEffect10006ui_story and not isNil(var_331_5) then
					local var_331_9 = Mathf.Lerp(0, 0.5, var_331_8)

					arg_328_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_328_1.var_.characterEffect10006ui_story.fillRatio = var_331_9
				end
			end

			if arg_328_1.time_ >= var_331_6 + var_331_7 and arg_328_1.time_ < var_331_6 + var_331_7 + arg_331_0 and not isNil(var_331_5) and arg_328_1.var_.characterEffect10006ui_story then
				local var_331_10 = 0.5

				arg_328_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_328_1.var_.characterEffect10006ui_story.fillRatio = var_331_10
			end

			local var_331_11 = 0
			local var_331_12 = 1.075

			if var_331_11 < arg_328_1.time_ and arg_328_1.time_ <= var_331_11 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_13 = arg_328_1:FormatText(StoryNameCfg[208].name)

				arg_328_1.leftNameTxt_.text = var_331_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_14 = arg_328_1:GetWordFromCfg(114111080)
				local var_331_15 = arg_328_1:FormatText(var_331_14.content)

				arg_328_1.text_.text = var_331_15

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_16 = 43
				local var_331_17 = utf8.len(var_331_15)
				local var_331_18 = var_331_16 <= 0 and var_331_12 or var_331_12 * (var_331_17 / var_331_16)

				if var_331_18 > 0 and var_331_12 < var_331_18 then
					arg_328_1.talkMaxDuration = var_331_18

					if var_331_18 + var_331_11 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_18 + var_331_11
					end
				end

				arg_328_1.text_.text = var_331_15
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111080", "story_v_out_114111.awb") ~= 0 then
					local var_331_19 = manager.audio:GetVoiceLength("story_v_out_114111", "114111080", "story_v_out_114111.awb") / 1000

					if var_331_19 + var_331_11 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_19 + var_331_11
					end

					if var_331_14.prefab_name ~= "" and arg_328_1.actors_[var_331_14.prefab_name] ~= nil then
						local var_331_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_14.prefab_name].transform, "story_v_out_114111", "114111080", "story_v_out_114111.awb")

						arg_328_1:RecordAudio("114111080", var_331_20)
						arg_328_1:RecordAudio("114111080", var_331_20)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_114111", "114111080", "story_v_out_114111.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_114111", "114111080", "story_v_out_114111.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_21 = math.max(var_331_12, arg_328_1.talkMaxDuration)

			if var_331_11 <= arg_328_1.time_ and arg_328_1.time_ < var_331_11 + var_331_21 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_11) / var_331_21

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_11 + var_331_21 and arg_328_1.time_ < var_331_11 + var_331_21 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play114111081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 114111081
		arg_332_1.duration_ = 12.53

		local var_332_0 = {
			ja = 8.7,
			ko = 12.533,
			zh = 8.433,
			en = 9.6
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play114111082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["10006ui_story"].transform
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.var_.moveOldPos10006ui_story = var_335_0.localPosition
			end

			local var_335_2 = 0.001

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2
				local var_335_4 = Vector3.New(0, 100, 0)

				var_335_0.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10006ui_story, var_335_4, var_335_3)

				local var_335_5 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_5.x, var_335_5.y, var_335_5.z)

				local var_335_6 = var_335_0.localEulerAngles

				var_335_6.z = 0
				var_335_6.x = 0
				var_335_0.localEulerAngles = var_335_6
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 then
				var_335_0.localPosition = Vector3.New(0, 100, 0)

				local var_335_7 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_7.x, var_335_7.y, var_335_7.z)

				local var_335_8 = var_335_0.localEulerAngles

				var_335_8.z = 0
				var_335_8.x = 0
				var_335_0.localEulerAngles = var_335_8
			end

			local var_335_9 = arg_332_1.actors_["1041ui_story"].transform
			local var_335_10 = 0

			if var_335_10 < arg_332_1.time_ and arg_332_1.time_ <= var_335_10 + arg_335_0 then
				arg_332_1.var_.moveOldPos1041ui_story = var_335_9.localPosition
			end

			local var_335_11 = 0.001

			if var_335_10 <= arg_332_1.time_ and arg_332_1.time_ < var_335_10 + var_335_11 then
				local var_335_12 = (arg_332_1.time_ - var_335_10) / var_335_11
				local var_335_13 = Vector3.New(0, 100, 0)

				var_335_9.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1041ui_story, var_335_13, var_335_12)

				local var_335_14 = manager.ui.mainCamera.transform.position - var_335_9.position

				var_335_9.forward = Vector3.New(var_335_14.x, var_335_14.y, var_335_14.z)

				local var_335_15 = var_335_9.localEulerAngles

				var_335_15.z = 0
				var_335_15.x = 0
				var_335_9.localEulerAngles = var_335_15
			end

			if arg_332_1.time_ >= var_335_10 + var_335_11 and arg_332_1.time_ < var_335_10 + var_335_11 + arg_335_0 then
				var_335_9.localPosition = Vector3.New(0, 100, 0)

				local var_335_16 = manager.ui.mainCamera.transform.position - var_335_9.position

				var_335_9.forward = Vector3.New(var_335_16.x, var_335_16.y, var_335_16.z)

				local var_335_17 = var_335_9.localEulerAngles

				var_335_17.z = 0
				var_335_17.x = 0
				var_335_9.localEulerAngles = var_335_17
			end

			local var_335_18 = arg_332_1.actors_["1038ui_story"].transform
			local var_335_19 = 0

			if var_335_19 < arg_332_1.time_ and arg_332_1.time_ <= var_335_19 + arg_335_0 then
				arg_332_1.var_.moveOldPos1038ui_story = var_335_18.localPosition
			end

			local var_335_20 = 0.001

			if var_335_19 <= arg_332_1.time_ and arg_332_1.time_ < var_335_19 + var_335_20 then
				local var_335_21 = (arg_332_1.time_ - var_335_19) / var_335_20
				local var_335_22 = Vector3.New(-0.7, -1.11, -5.9)

				var_335_18.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1038ui_story, var_335_22, var_335_21)

				local var_335_23 = manager.ui.mainCamera.transform.position - var_335_18.position

				var_335_18.forward = Vector3.New(var_335_23.x, var_335_23.y, var_335_23.z)

				local var_335_24 = var_335_18.localEulerAngles

				var_335_24.z = 0
				var_335_24.x = 0
				var_335_18.localEulerAngles = var_335_24
			end

			if arg_332_1.time_ >= var_335_19 + var_335_20 and arg_332_1.time_ < var_335_19 + var_335_20 + arg_335_0 then
				var_335_18.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_335_25 = manager.ui.mainCamera.transform.position - var_335_18.position

				var_335_18.forward = Vector3.New(var_335_25.x, var_335_25.y, var_335_25.z)

				local var_335_26 = var_335_18.localEulerAngles

				var_335_26.z = 0
				var_335_26.x = 0
				var_335_18.localEulerAngles = var_335_26
			end

			local var_335_27 = 0

			if var_335_27 < arg_332_1.time_ and arg_332_1.time_ <= var_335_27 + arg_335_0 then
				arg_332_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_335_28 = 0

			if var_335_28 < arg_332_1.time_ and arg_332_1.time_ <= var_335_28 + arg_335_0 then
				arg_332_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_335_29 = arg_332_1.actors_["1038ui_story"]
			local var_335_30 = 0

			if var_335_30 < arg_332_1.time_ and arg_332_1.time_ <= var_335_30 + arg_335_0 and not isNil(var_335_29) and arg_332_1.var_.characterEffect1038ui_story == nil then
				arg_332_1.var_.characterEffect1038ui_story = var_335_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_31 = 0.2

			if var_335_30 <= arg_332_1.time_ and arg_332_1.time_ < var_335_30 + var_335_31 and not isNil(var_335_29) then
				local var_335_32 = (arg_332_1.time_ - var_335_30) / var_335_31

				if arg_332_1.var_.characterEffect1038ui_story and not isNil(var_335_29) then
					arg_332_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= var_335_30 + var_335_31 and arg_332_1.time_ < var_335_30 + var_335_31 + arg_335_0 and not isNil(var_335_29) and arg_332_1.var_.characterEffect1038ui_story then
				arg_332_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_335_33 = 0
			local var_335_34 = 1.15

			if var_335_33 < arg_332_1.time_ and arg_332_1.time_ <= var_335_33 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_35 = arg_332_1:FormatText(StoryNameCfg[94].name)

				arg_332_1.leftNameTxt_.text = var_335_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_36 = arg_332_1:GetWordFromCfg(114111081)
				local var_335_37 = arg_332_1:FormatText(var_335_36.content)

				arg_332_1.text_.text = var_335_37

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_38 = 46
				local var_335_39 = utf8.len(var_335_37)
				local var_335_40 = var_335_38 <= 0 and var_335_34 or var_335_34 * (var_335_39 / var_335_38)

				if var_335_40 > 0 and var_335_34 < var_335_40 then
					arg_332_1.talkMaxDuration = var_335_40

					if var_335_40 + var_335_33 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_40 + var_335_33
					end
				end

				arg_332_1.text_.text = var_335_37
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111081", "story_v_out_114111.awb") ~= 0 then
					local var_335_41 = manager.audio:GetVoiceLength("story_v_out_114111", "114111081", "story_v_out_114111.awb") / 1000

					if var_335_41 + var_335_33 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_41 + var_335_33
					end

					if var_335_36.prefab_name ~= "" and arg_332_1.actors_[var_335_36.prefab_name] ~= nil then
						local var_335_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_36.prefab_name].transform, "story_v_out_114111", "114111081", "story_v_out_114111.awb")

						arg_332_1:RecordAudio("114111081", var_335_42)
						arg_332_1:RecordAudio("114111081", var_335_42)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_114111", "114111081", "story_v_out_114111.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_114111", "114111081", "story_v_out_114111.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_43 = math.max(var_335_34, arg_332_1.talkMaxDuration)

			if var_335_33 <= arg_332_1.time_ and arg_332_1.time_ < var_335_33 + var_335_43 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_33) / var_335_43

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_33 + var_335_43 and arg_332_1.time_ < var_335_33 + var_335_43 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play114111082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 114111082
		arg_336_1.duration_ = 11.83

		local var_336_0 = {
			ja = 9.8,
			ko = 9.933,
			zh = 9.466,
			en = 11.833
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play114111083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_339_2 = 0
			local var_339_3 = 1.15

			if var_339_2 < arg_336_1.time_ and arg_336_1.time_ <= var_339_2 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_4 = arg_336_1:FormatText(StoryNameCfg[94].name)

				arg_336_1.leftNameTxt_.text = var_339_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_5 = arg_336_1:GetWordFromCfg(114111082)
				local var_339_6 = arg_336_1:FormatText(var_339_5.content)

				arg_336_1.text_.text = var_339_6

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_7 = 46
				local var_339_8 = utf8.len(var_339_6)
				local var_339_9 = var_339_7 <= 0 and var_339_3 or var_339_3 * (var_339_8 / var_339_7)

				if var_339_9 > 0 and var_339_3 < var_339_9 then
					arg_336_1.talkMaxDuration = var_339_9

					if var_339_9 + var_339_2 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_9 + var_339_2
					end
				end

				arg_336_1.text_.text = var_339_6
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111082", "story_v_out_114111.awb") ~= 0 then
					local var_339_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111082", "story_v_out_114111.awb") / 1000

					if var_339_10 + var_339_2 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_10 + var_339_2
					end

					if var_339_5.prefab_name ~= "" and arg_336_1.actors_[var_339_5.prefab_name] ~= nil then
						local var_339_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_5.prefab_name].transform, "story_v_out_114111", "114111082", "story_v_out_114111.awb")

						arg_336_1:RecordAudio("114111082", var_339_11)
						arg_336_1:RecordAudio("114111082", var_339_11)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_114111", "114111082", "story_v_out_114111.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_114111", "114111082", "story_v_out_114111.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_12 = math.max(var_339_3, arg_336_1.talkMaxDuration)

			if var_339_2 <= arg_336_1.time_ and arg_336_1.time_ < var_339_2 + var_339_12 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_2) / var_339_12

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_2 + var_339_12 and arg_336_1.time_ < var_339_2 + var_339_12 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play114111083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 114111083
		arg_340_1.duration_ = 5.17

		local var_340_0 = {
			ja = 5.166,
			ko = 3.5,
			zh = 3.166,
			en = 4.033
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play114111084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["1097ui_story"].transform
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.var_.moveOldPos1097ui_story = var_343_0.localPosition
			end

			local var_343_2 = 0.001

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2
				local var_343_4 = Vector3.New(0.7, -0.54, -6.3)

				var_343_0.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1097ui_story, var_343_4, var_343_3)

				local var_343_5 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_5.x, var_343_5.y, var_343_5.z)

				local var_343_6 = var_343_0.localEulerAngles

				var_343_6.z = 0
				var_343_6.x = 0
				var_343_0.localEulerAngles = var_343_6
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 then
				var_343_0.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_343_7 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_7.x, var_343_7.y, var_343_7.z)

				local var_343_8 = var_343_0.localEulerAngles

				var_343_8.z = 0
				var_343_8.x = 0
				var_343_0.localEulerAngles = var_343_8
			end

			local var_343_9 = 0

			if var_343_9 < arg_340_1.time_ and arg_340_1.time_ <= var_343_9 + arg_343_0 then
				arg_340_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_343_10 = 0

			if var_343_10 < arg_340_1.time_ and arg_340_1.time_ <= var_343_10 + arg_343_0 then
				arg_340_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_343_11 = arg_340_1.actors_["1097ui_story"]
			local var_343_12 = 0

			if var_343_12 < arg_340_1.time_ and arg_340_1.time_ <= var_343_12 + arg_343_0 and not isNil(var_343_11) and arg_340_1.var_.characterEffect1097ui_story == nil then
				arg_340_1.var_.characterEffect1097ui_story = var_343_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_13 = 0.2

			if var_343_12 <= arg_340_1.time_ and arg_340_1.time_ < var_343_12 + var_343_13 and not isNil(var_343_11) then
				local var_343_14 = (arg_340_1.time_ - var_343_12) / var_343_13

				if arg_340_1.var_.characterEffect1097ui_story and not isNil(var_343_11) then
					arg_340_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= var_343_12 + var_343_13 and arg_340_1.time_ < var_343_12 + var_343_13 + arg_343_0 and not isNil(var_343_11) and arg_340_1.var_.characterEffect1097ui_story then
				arg_340_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_343_15 = arg_340_1.actors_["1038ui_story"]
			local var_343_16 = 0

			if var_343_16 < arg_340_1.time_ and arg_340_1.time_ <= var_343_16 + arg_343_0 and not isNil(var_343_15) and arg_340_1.var_.characterEffect1038ui_story == nil then
				arg_340_1.var_.characterEffect1038ui_story = var_343_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_17 = 0.2

			if var_343_16 <= arg_340_1.time_ and arg_340_1.time_ < var_343_16 + var_343_17 and not isNil(var_343_15) then
				local var_343_18 = (arg_340_1.time_ - var_343_16) / var_343_17

				if arg_340_1.var_.characterEffect1038ui_story and not isNil(var_343_15) then
					local var_343_19 = Mathf.Lerp(0, 0.5, var_343_18)

					arg_340_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1038ui_story.fillRatio = var_343_19
				end
			end

			if arg_340_1.time_ >= var_343_16 + var_343_17 and arg_340_1.time_ < var_343_16 + var_343_17 + arg_343_0 and not isNil(var_343_15) and arg_340_1.var_.characterEffect1038ui_story then
				local var_343_20 = 0.5

				arg_340_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1038ui_story.fillRatio = var_343_20
			end

			local var_343_21 = 0
			local var_343_22 = 0.325

			if var_343_21 < arg_340_1.time_ and arg_340_1.time_ <= var_343_21 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_23 = arg_340_1:FormatText(StoryNameCfg[216].name)

				arg_340_1.leftNameTxt_.text = var_343_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_24 = arg_340_1:GetWordFromCfg(114111083)
				local var_343_25 = arg_340_1:FormatText(var_343_24.content)

				arg_340_1.text_.text = var_343_25

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_26 = 13
				local var_343_27 = utf8.len(var_343_25)
				local var_343_28 = var_343_26 <= 0 and var_343_22 or var_343_22 * (var_343_27 / var_343_26)

				if var_343_28 > 0 and var_343_22 < var_343_28 then
					arg_340_1.talkMaxDuration = var_343_28

					if var_343_28 + var_343_21 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_28 + var_343_21
					end
				end

				arg_340_1.text_.text = var_343_25
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111083", "story_v_out_114111.awb") ~= 0 then
					local var_343_29 = manager.audio:GetVoiceLength("story_v_out_114111", "114111083", "story_v_out_114111.awb") / 1000

					if var_343_29 + var_343_21 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_29 + var_343_21
					end

					if var_343_24.prefab_name ~= "" and arg_340_1.actors_[var_343_24.prefab_name] ~= nil then
						local var_343_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_24.prefab_name].transform, "story_v_out_114111", "114111083", "story_v_out_114111.awb")

						arg_340_1:RecordAudio("114111083", var_343_30)
						arg_340_1:RecordAudio("114111083", var_343_30)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_114111", "114111083", "story_v_out_114111.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_114111", "114111083", "story_v_out_114111.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_31 = math.max(var_343_22, arg_340_1.talkMaxDuration)

			if var_343_21 <= arg_340_1.time_ and arg_340_1.time_ < var_343_21 + var_343_31 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_21) / var_343_31

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_21 + var_343_31 and arg_340_1.time_ < var_343_21 + var_343_31 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play114111084 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 114111084
		arg_344_1.duration_ = 3.27

		local var_344_0 = {
			ja = 3.266,
			ko = 2.166,
			zh = 1.566,
			en = 1.366
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play114111085(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1097ui_story"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1097ui_story == nil then
				arg_344_1.var_.characterEffect1097ui_story = var_347_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.2

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.characterEffect1097ui_story and not isNil(var_347_0) then
					local var_347_4 = Mathf.Lerp(0, 0.5, var_347_3)

					arg_344_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1097ui_story.fillRatio = var_347_4
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1097ui_story then
				local var_347_5 = 0.5

				arg_344_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1097ui_story.fillRatio = var_347_5
			end

			local var_347_6 = 0
			local var_347_7 = 0.075

			if var_347_6 < arg_344_1.time_ and arg_344_1.time_ <= var_347_6 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_8 = arg_344_1:FormatText(StoryNameCfg[212].name)

				arg_344_1.leftNameTxt_.text = var_347_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_9 = arg_344_1:GetWordFromCfg(114111084)
				local var_347_10 = arg_344_1:FormatText(var_347_9.content)

				arg_344_1.text_.text = var_347_10

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_11 = 3
				local var_347_12 = utf8.len(var_347_10)
				local var_347_13 = var_347_11 <= 0 and var_347_7 or var_347_7 * (var_347_12 / var_347_11)

				if var_347_13 > 0 and var_347_7 < var_347_13 then
					arg_344_1.talkMaxDuration = var_347_13

					if var_347_13 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_13 + var_347_6
					end
				end

				arg_344_1.text_.text = var_347_10
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111084", "story_v_out_114111.awb") ~= 0 then
					local var_347_14 = manager.audio:GetVoiceLength("story_v_out_114111", "114111084", "story_v_out_114111.awb") / 1000

					if var_347_14 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_14 + var_347_6
					end

					if var_347_9.prefab_name ~= "" and arg_344_1.actors_[var_347_9.prefab_name] ~= nil then
						local var_347_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_9.prefab_name].transform, "story_v_out_114111", "114111084", "story_v_out_114111.awb")

						arg_344_1:RecordAudio("114111084", var_347_15)
						arg_344_1:RecordAudio("114111084", var_347_15)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_114111", "114111084", "story_v_out_114111.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_114111", "114111084", "story_v_out_114111.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_16 = math.max(var_347_7, arg_344_1.talkMaxDuration)

			if var_347_6 <= arg_344_1.time_ and arg_344_1.time_ < var_347_6 + var_347_16 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_6) / var_347_16

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_6 + var_347_16 and arg_344_1.time_ < var_347_6 + var_347_16 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play114111085 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 114111085
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play114111086(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1038ui_story"].transform
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.var_.moveOldPos1038ui_story = var_351_0.localPosition
			end

			local var_351_2 = 0.001

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2
				local var_351_4 = Vector3.New(0, 100, 0)

				var_351_0.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1038ui_story, var_351_4, var_351_3)

				local var_351_5 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_5.x, var_351_5.y, var_351_5.z)

				local var_351_6 = var_351_0.localEulerAngles

				var_351_6.z = 0
				var_351_6.x = 0
				var_351_0.localEulerAngles = var_351_6
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 then
				var_351_0.localPosition = Vector3.New(0, 100, 0)

				local var_351_7 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_7.x, var_351_7.y, var_351_7.z)

				local var_351_8 = var_351_0.localEulerAngles

				var_351_8.z = 0
				var_351_8.x = 0
				var_351_0.localEulerAngles = var_351_8
			end

			local var_351_9 = arg_348_1.actors_["1097ui_story"].transform
			local var_351_10 = 0

			if var_351_10 < arg_348_1.time_ and arg_348_1.time_ <= var_351_10 + arg_351_0 then
				arg_348_1.var_.moveOldPos1097ui_story = var_351_9.localPosition
			end

			local var_351_11 = 0.001

			if var_351_10 <= arg_348_1.time_ and arg_348_1.time_ < var_351_10 + var_351_11 then
				local var_351_12 = (arg_348_1.time_ - var_351_10) / var_351_11
				local var_351_13 = Vector3.New(0, 100, 0)

				var_351_9.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1097ui_story, var_351_13, var_351_12)

				local var_351_14 = manager.ui.mainCamera.transform.position - var_351_9.position

				var_351_9.forward = Vector3.New(var_351_14.x, var_351_14.y, var_351_14.z)

				local var_351_15 = var_351_9.localEulerAngles

				var_351_15.z = 0
				var_351_15.x = 0
				var_351_9.localEulerAngles = var_351_15
			end

			if arg_348_1.time_ >= var_351_10 + var_351_11 and arg_348_1.time_ < var_351_10 + var_351_11 + arg_351_0 then
				var_351_9.localPosition = Vector3.New(0, 100, 0)

				local var_351_16 = manager.ui.mainCamera.transform.position - var_351_9.position

				var_351_9.forward = Vector3.New(var_351_16.x, var_351_16.y, var_351_16.z)

				local var_351_17 = var_351_9.localEulerAngles

				var_351_17.z = 0
				var_351_17.x = 0
				var_351_9.localEulerAngles = var_351_17
			end

			local var_351_18 = 0
			local var_351_19 = 0.675

			if var_351_18 < arg_348_1.time_ and arg_348_1.time_ <= var_351_18 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_20 = arg_348_1:GetWordFromCfg(114111085)
				local var_351_21 = arg_348_1:FormatText(var_351_20.content)

				arg_348_1.text_.text = var_351_21

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_22 = 27
				local var_351_23 = utf8.len(var_351_21)
				local var_351_24 = var_351_22 <= 0 and var_351_19 or var_351_19 * (var_351_23 / var_351_22)

				if var_351_24 > 0 and var_351_19 < var_351_24 then
					arg_348_1.talkMaxDuration = var_351_24

					if var_351_24 + var_351_18 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_24 + var_351_18
					end
				end

				arg_348_1.text_.text = var_351_21
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_25 = math.max(var_351_19, arg_348_1.talkMaxDuration)

			if var_351_18 <= arg_348_1.time_ and arg_348_1.time_ < var_351_18 + var_351_25 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_18) / var_351_25

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_18 + var_351_25 and arg_348_1.time_ < var_351_18 + var_351_25 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play114111086 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 114111086
		arg_352_1.duration_ = 10.1

		local var_352_0 = {
			ja = 7.466,
			ko = 6.533,
			zh = 6.7,
			en = 10.1
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play114111087(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1184ui_story"].transform
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.var_.moveOldPos1184ui_story = var_355_0.localPosition

				local var_355_2 = "1184ui_story"

				arg_352_1:ShowWeapon(arg_352_1.var_[var_355_2 .. "Animator"].transform, false)
			end

			local var_355_3 = 0.001

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_3 then
				local var_355_4 = (arg_352_1.time_ - var_355_1) / var_355_3
				local var_355_5 = Vector3.New(0, -0.97, -6)

				var_355_0.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1184ui_story, var_355_5, var_355_4)

				local var_355_6 = manager.ui.mainCamera.transform.position - var_355_0.position

				var_355_0.forward = Vector3.New(var_355_6.x, var_355_6.y, var_355_6.z)

				local var_355_7 = var_355_0.localEulerAngles

				var_355_7.z = 0
				var_355_7.x = 0
				var_355_0.localEulerAngles = var_355_7
			end

			if arg_352_1.time_ >= var_355_1 + var_355_3 and arg_352_1.time_ < var_355_1 + var_355_3 + arg_355_0 then
				var_355_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_355_8 = manager.ui.mainCamera.transform.position - var_355_0.position

				var_355_0.forward = Vector3.New(var_355_8.x, var_355_8.y, var_355_8.z)

				local var_355_9 = var_355_0.localEulerAngles

				var_355_9.z = 0
				var_355_9.x = 0
				var_355_0.localEulerAngles = var_355_9
			end

			local var_355_10 = 0

			if var_355_10 < arg_352_1.time_ and arg_352_1.time_ <= var_355_10 + arg_355_0 then
				arg_352_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_355_11 = 0

			if var_355_11 < arg_352_1.time_ and arg_352_1.time_ <= var_355_11 + arg_355_0 then
				arg_352_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_355_12 = arg_352_1.actors_["1184ui_story"]
			local var_355_13 = 0

			if var_355_13 < arg_352_1.time_ and arg_352_1.time_ <= var_355_13 + arg_355_0 and not isNil(var_355_12) and arg_352_1.var_.characterEffect1184ui_story == nil then
				arg_352_1.var_.characterEffect1184ui_story = var_355_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_14 = 0.2

			if var_355_13 <= arg_352_1.time_ and arg_352_1.time_ < var_355_13 + var_355_14 and not isNil(var_355_12) then
				local var_355_15 = (arg_352_1.time_ - var_355_13) / var_355_14

				if arg_352_1.var_.characterEffect1184ui_story and not isNil(var_355_12) then
					arg_352_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_13 + var_355_14 and arg_352_1.time_ < var_355_13 + var_355_14 + arg_355_0 and not isNil(var_355_12) and arg_352_1.var_.characterEffect1184ui_story then
				arg_352_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_355_16 = 0
			local var_355_17 = 0.725

			if var_355_16 < arg_352_1.time_ and arg_352_1.time_ <= var_355_16 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_18 = arg_352_1:FormatText(StoryNameCfg[6].name)

				arg_352_1.leftNameTxt_.text = var_355_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_19 = arg_352_1:GetWordFromCfg(114111086)
				local var_355_20 = arg_352_1:FormatText(var_355_19.content)

				arg_352_1.text_.text = var_355_20

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_21 = 29
				local var_355_22 = utf8.len(var_355_20)
				local var_355_23 = var_355_21 <= 0 and var_355_17 or var_355_17 * (var_355_22 / var_355_21)

				if var_355_23 > 0 and var_355_17 < var_355_23 then
					arg_352_1.talkMaxDuration = var_355_23

					if var_355_23 + var_355_16 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_23 + var_355_16
					end
				end

				arg_352_1.text_.text = var_355_20
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111086", "story_v_out_114111.awb") ~= 0 then
					local var_355_24 = manager.audio:GetVoiceLength("story_v_out_114111", "114111086", "story_v_out_114111.awb") / 1000

					if var_355_24 + var_355_16 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_24 + var_355_16
					end

					if var_355_19.prefab_name ~= "" and arg_352_1.actors_[var_355_19.prefab_name] ~= nil then
						local var_355_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_19.prefab_name].transform, "story_v_out_114111", "114111086", "story_v_out_114111.awb")

						arg_352_1:RecordAudio("114111086", var_355_25)
						arg_352_1:RecordAudio("114111086", var_355_25)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_114111", "114111086", "story_v_out_114111.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_114111", "114111086", "story_v_out_114111.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_26 = math.max(var_355_17, arg_352_1.talkMaxDuration)

			if var_355_16 <= arg_352_1.time_ and arg_352_1.time_ < var_355_16 + var_355_26 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_16) / var_355_26

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_16 + var_355_26 and arg_352_1.time_ < var_355_16 + var_355_26 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play114111087 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 114111087
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play114111088(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["1184ui_story"].transform
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.var_.moveOldPos1184ui_story = var_359_0.localPosition
			end

			local var_359_2 = 0.001

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2
				local var_359_4 = Vector3.New(0, 100, 0)

				var_359_0.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1184ui_story, var_359_4, var_359_3)

				local var_359_5 = manager.ui.mainCamera.transform.position - var_359_0.position

				var_359_0.forward = Vector3.New(var_359_5.x, var_359_5.y, var_359_5.z)

				local var_359_6 = var_359_0.localEulerAngles

				var_359_6.z = 0
				var_359_6.x = 0
				var_359_0.localEulerAngles = var_359_6
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 then
				var_359_0.localPosition = Vector3.New(0, 100, 0)

				local var_359_7 = manager.ui.mainCamera.transform.position - var_359_0.position

				var_359_0.forward = Vector3.New(var_359_7.x, var_359_7.y, var_359_7.z)

				local var_359_8 = var_359_0.localEulerAngles

				var_359_8.z = 0
				var_359_8.x = 0
				var_359_0.localEulerAngles = var_359_8
			end

			local var_359_9 = 0
			local var_359_10 = 0.475

			if var_359_9 < arg_356_1.time_ and arg_356_1.time_ <= var_359_9 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_11 = arg_356_1:FormatText(StoryNameCfg[7].name)

				arg_356_1.leftNameTxt_.text = var_359_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_12 = arg_356_1:GetWordFromCfg(114111087)
				local var_359_13 = arg_356_1:FormatText(var_359_12.content)

				arg_356_1.text_.text = var_359_13

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_14 = 19
				local var_359_15 = utf8.len(var_359_13)
				local var_359_16 = var_359_14 <= 0 and var_359_10 or var_359_10 * (var_359_15 / var_359_14)

				if var_359_16 > 0 and var_359_10 < var_359_16 then
					arg_356_1.talkMaxDuration = var_359_16

					if var_359_16 + var_359_9 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_16 + var_359_9
					end
				end

				arg_356_1.text_.text = var_359_13
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_17 = math.max(var_359_10, arg_356_1.talkMaxDuration)

			if var_359_9 <= arg_356_1.time_ and arg_356_1.time_ < var_359_9 + var_359_17 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_9) / var_359_17

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_9 + var_359_17 and arg_356_1.time_ < var_359_9 + var_359_17 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play114111088 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 114111088
		arg_360_1.duration_ = 13.63

		local var_360_0 = {
			ja = 13.633,
			ko = 8.033,
			zh = 8.233,
			en = 6.833
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play114111089(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["10006ui_story"].transform
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.var_.moveOldPos10006ui_story = var_363_0.localPosition
			end

			local var_363_2 = 0.001

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2
				local var_363_4 = Vector3.New(0, -0.98, -5.65)

				var_363_0.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos10006ui_story, var_363_4, var_363_3)

				local var_363_5 = manager.ui.mainCamera.transform.position - var_363_0.position

				var_363_0.forward = Vector3.New(var_363_5.x, var_363_5.y, var_363_5.z)

				local var_363_6 = var_363_0.localEulerAngles

				var_363_6.z = 0
				var_363_6.x = 0
				var_363_0.localEulerAngles = var_363_6
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 then
				var_363_0.localPosition = Vector3.New(0, -0.98, -5.65)

				local var_363_7 = manager.ui.mainCamera.transform.position - var_363_0.position

				var_363_0.forward = Vector3.New(var_363_7.x, var_363_7.y, var_363_7.z)

				local var_363_8 = var_363_0.localEulerAngles

				var_363_8.z = 0
				var_363_8.x = 0
				var_363_0.localEulerAngles = var_363_8
			end

			local var_363_9 = 0

			if var_363_9 < arg_360_1.time_ and arg_360_1.time_ <= var_363_9 + arg_363_0 then
				arg_360_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			local var_363_10 = 0

			if var_363_10 < arg_360_1.time_ and arg_360_1.time_ <= var_363_10 + arg_363_0 then
				arg_360_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_363_11 = arg_360_1.actors_["10006ui_story"]
			local var_363_12 = 0

			if var_363_12 < arg_360_1.time_ and arg_360_1.time_ <= var_363_12 + arg_363_0 and not isNil(var_363_11) and arg_360_1.var_.characterEffect10006ui_story == nil then
				arg_360_1.var_.characterEffect10006ui_story = var_363_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_13 = 0.2

			if var_363_12 <= arg_360_1.time_ and arg_360_1.time_ < var_363_12 + var_363_13 and not isNil(var_363_11) then
				local var_363_14 = (arg_360_1.time_ - var_363_12) / var_363_13

				if arg_360_1.var_.characterEffect10006ui_story and not isNil(var_363_11) then
					arg_360_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= var_363_12 + var_363_13 and arg_360_1.time_ < var_363_12 + var_363_13 + arg_363_0 and not isNil(var_363_11) and arg_360_1.var_.characterEffect10006ui_story then
				arg_360_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_363_15 = 0
			local var_363_16 = 0.85

			if var_363_15 < arg_360_1.time_ and arg_360_1.time_ <= var_363_15 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_17 = arg_360_1:FormatText(StoryNameCfg[212].name)

				arg_360_1.leftNameTxt_.text = var_363_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_18 = arg_360_1:GetWordFromCfg(114111088)
				local var_363_19 = arg_360_1:FormatText(var_363_18.content)

				arg_360_1.text_.text = var_363_19

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_20 = 34
				local var_363_21 = utf8.len(var_363_19)
				local var_363_22 = var_363_20 <= 0 and var_363_16 or var_363_16 * (var_363_21 / var_363_20)

				if var_363_22 > 0 and var_363_16 < var_363_22 then
					arg_360_1.talkMaxDuration = var_363_22

					if var_363_22 + var_363_15 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_22 + var_363_15
					end
				end

				arg_360_1.text_.text = var_363_19
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111088", "story_v_out_114111.awb") ~= 0 then
					local var_363_23 = manager.audio:GetVoiceLength("story_v_out_114111", "114111088", "story_v_out_114111.awb") / 1000

					if var_363_23 + var_363_15 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_23 + var_363_15
					end

					if var_363_18.prefab_name ~= "" and arg_360_1.actors_[var_363_18.prefab_name] ~= nil then
						local var_363_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_18.prefab_name].transform, "story_v_out_114111", "114111088", "story_v_out_114111.awb")

						arg_360_1:RecordAudio("114111088", var_363_24)
						arg_360_1:RecordAudio("114111088", var_363_24)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_114111", "114111088", "story_v_out_114111.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_114111", "114111088", "story_v_out_114111.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_25 = math.max(var_363_16, arg_360_1.talkMaxDuration)

			if var_363_15 <= arg_360_1.time_ and arg_360_1.time_ < var_363_15 + var_363_25 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_15) / var_363_25

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_15 + var_363_25 and arg_360_1.time_ < var_363_15 + var_363_25 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_360_1:InitPlayNodeList()
	end,
	Play114111089 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 114111089
		arg_364_1.duration_ = 14.63

		local var_364_0 = {
			ja = 14.633,
			ko = 11.3,
			zh = 8.6,
			en = 10.1
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play114111090(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_367_1 = 0
			local var_367_2 = 1.05

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_3 = arg_364_1:FormatText(StoryNameCfg[212].name)

				arg_364_1.leftNameTxt_.text = var_367_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_4 = arg_364_1:GetWordFromCfg(114111089)
				local var_367_5 = arg_364_1:FormatText(var_367_4.content)

				arg_364_1.text_.text = var_367_5

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_6 = 42
				local var_367_7 = utf8.len(var_367_5)
				local var_367_8 = var_367_6 <= 0 and var_367_2 or var_367_2 * (var_367_7 / var_367_6)

				if var_367_8 > 0 and var_367_2 < var_367_8 then
					arg_364_1.talkMaxDuration = var_367_8

					if var_367_8 + var_367_1 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_1
					end
				end

				arg_364_1.text_.text = var_367_5
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111089", "story_v_out_114111.awb") ~= 0 then
					local var_367_9 = manager.audio:GetVoiceLength("story_v_out_114111", "114111089", "story_v_out_114111.awb") / 1000

					if var_367_9 + var_367_1 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_9 + var_367_1
					end

					if var_367_4.prefab_name ~= "" and arg_364_1.actors_[var_367_4.prefab_name] ~= nil then
						local var_367_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_4.prefab_name].transform, "story_v_out_114111", "114111089", "story_v_out_114111.awb")

						arg_364_1:RecordAudio("114111089", var_367_10)
						arg_364_1:RecordAudio("114111089", var_367_10)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_114111", "114111089", "story_v_out_114111.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_114111", "114111089", "story_v_out_114111.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_11 = math.max(var_367_2, arg_364_1.talkMaxDuration)

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_11 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_1) / var_367_11

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_1 + var_367_11 and arg_364_1.time_ < var_367_1 + var_367_11 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play114111090 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 114111090
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play114111091(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["10006ui_story"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect10006ui_story == nil then
				arg_368_1.var_.characterEffect10006ui_story = var_371_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.2

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.characterEffect10006ui_story and not isNil(var_371_0) then
					local var_371_4 = Mathf.Lerp(0, 0.5, var_371_3)

					arg_368_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_368_1.var_.characterEffect10006ui_story.fillRatio = var_371_4
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect10006ui_story then
				local var_371_5 = 0.5

				arg_368_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_368_1.var_.characterEffect10006ui_story.fillRatio = var_371_5
			end

			local var_371_6 = 0
			local var_371_7 = 0.575

			if var_371_6 < arg_368_1.time_ and arg_368_1.time_ <= var_371_6 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_8 = arg_368_1:FormatText(StoryNameCfg[7].name)

				arg_368_1.leftNameTxt_.text = var_371_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_9 = arg_368_1:GetWordFromCfg(114111090)
				local var_371_10 = arg_368_1:FormatText(var_371_9.content)

				arg_368_1.text_.text = var_371_10

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_11 = 23
				local var_371_12 = utf8.len(var_371_10)
				local var_371_13 = var_371_11 <= 0 and var_371_7 or var_371_7 * (var_371_12 / var_371_11)

				if var_371_13 > 0 and var_371_7 < var_371_13 then
					arg_368_1.talkMaxDuration = var_371_13

					if var_371_13 + var_371_6 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_13 + var_371_6
					end
				end

				arg_368_1.text_.text = var_371_10
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_14 = math.max(var_371_7, arg_368_1.talkMaxDuration)

			if var_371_6 <= arg_368_1.time_ and arg_368_1.time_ < var_371_6 + var_371_14 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_6) / var_371_14

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_6 + var_371_14 and arg_368_1.time_ < var_371_6 + var_371_14 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play114111091 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 114111091
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play114111092(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["10006ui_story"].transform
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.var_.moveOldPos10006ui_story = var_375_0.localPosition
			end

			local var_375_2 = 0.001

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2
				local var_375_4 = Vector3.New(0, 100, 0)

				var_375_0.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos10006ui_story, var_375_4, var_375_3)

				local var_375_5 = manager.ui.mainCamera.transform.position - var_375_0.position

				var_375_0.forward = Vector3.New(var_375_5.x, var_375_5.y, var_375_5.z)

				local var_375_6 = var_375_0.localEulerAngles

				var_375_6.z = 0
				var_375_6.x = 0
				var_375_0.localEulerAngles = var_375_6
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 then
				var_375_0.localPosition = Vector3.New(0, 100, 0)

				local var_375_7 = manager.ui.mainCamera.transform.position - var_375_0.position

				var_375_0.forward = Vector3.New(var_375_7.x, var_375_7.y, var_375_7.z)

				local var_375_8 = var_375_0.localEulerAngles

				var_375_8.z = 0
				var_375_8.x = 0
				var_375_0.localEulerAngles = var_375_8
			end

			local var_375_9 = 0
			local var_375_10 = 0.775

			if var_375_9 < arg_372_1.time_ and arg_372_1.time_ <= var_375_9 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_11 = arg_372_1:GetWordFromCfg(114111091)
				local var_375_12 = arg_372_1:FormatText(var_375_11.content)

				arg_372_1.text_.text = var_375_12

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_13 = 31
				local var_375_14 = utf8.len(var_375_12)
				local var_375_15 = var_375_13 <= 0 and var_375_10 or var_375_10 * (var_375_14 / var_375_13)

				if var_375_15 > 0 and var_375_10 < var_375_15 then
					arg_372_1.talkMaxDuration = var_375_15

					if var_375_15 + var_375_9 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_15 + var_375_9
					end
				end

				arg_372_1.text_.text = var_375_12
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_16 = math.max(var_375_10, arg_372_1.talkMaxDuration)

			if var_375_9 <= arg_372_1.time_ and arg_372_1.time_ < var_375_9 + var_375_16 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_9) / var_375_16

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_9 + var_375_16 and arg_372_1.time_ < var_375_9 + var_375_16 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play114111092 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 114111092
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play114111093(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 0.175

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_2 = arg_376_1:FormatText(StoryNameCfg[7].name)

				arg_376_1.leftNameTxt_.text = var_379_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_3 = arg_376_1:GetWordFromCfg(114111092)
				local var_379_4 = arg_376_1:FormatText(var_379_3.content)

				arg_376_1.text_.text = var_379_4

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 7
				local var_379_6 = utf8.len(var_379_4)
				local var_379_7 = var_379_5 <= 0 and var_379_1 or var_379_1 * (var_379_6 / var_379_5)

				if var_379_7 > 0 and var_379_1 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_0
					end
				end

				arg_376_1.text_.text = var_379_4
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_8 = math.max(var_379_1, arg_376_1.talkMaxDuration)

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_8 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_0) / var_379_8

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_0 + var_379_8 and arg_376_1.time_ < var_379_0 + var_379_8 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play114111093 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 114111093
		arg_380_1.duration_ = 6.8

		local var_380_0 = {
			ja = 3.633,
			ko = 5.033,
			zh = 5.6,
			en = 6.8
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play114111094(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["1184ui_story"].transform
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.var_.moveOldPos1184ui_story = var_383_0.localPosition

				local var_383_2 = "1184ui_story"

				arg_380_1:ShowWeapon(arg_380_1.var_[var_383_2 .. "Animator"].transform, false)
			end

			local var_383_3 = 0.001

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_3 then
				local var_383_4 = (arg_380_1.time_ - var_383_1) / var_383_3
				local var_383_5 = Vector3.New(0, -0.97, -6)

				var_383_0.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1184ui_story, var_383_5, var_383_4)

				local var_383_6 = manager.ui.mainCamera.transform.position - var_383_0.position

				var_383_0.forward = Vector3.New(var_383_6.x, var_383_6.y, var_383_6.z)

				local var_383_7 = var_383_0.localEulerAngles

				var_383_7.z = 0
				var_383_7.x = 0
				var_383_0.localEulerAngles = var_383_7
			end

			if arg_380_1.time_ >= var_383_1 + var_383_3 and arg_380_1.time_ < var_383_1 + var_383_3 + arg_383_0 then
				var_383_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_383_8 = manager.ui.mainCamera.transform.position - var_383_0.position

				var_383_0.forward = Vector3.New(var_383_8.x, var_383_8.y, var_383_8.z)

				local var_383_9 = var_383_0.localEulerAngles

				var_383_9.z = 0
				var_383_9.x = 0
				var_383_0.localEulerAngles = var_383_9
			end

			local var_383_10 = 0

			if var_383_10 < arg_380_1.time_ and arg_380_1.time_ <= var_383_10 + arg_383_0 then
				arg_380_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_383_11 = 0

			if var_383_11 < arg_380_1.time_ and arg_380_1.time_ <= var_383_11 + arg_383_0 then
				arg_380_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_383_12 = arg_380_1.actors_["1184ui_story"]
			local var_383_13 = 0

			if var_383_13 < arg_380_1.time_ and arg_380_1.time_ <= var_383_13 + arg_383_0 and not isNil(var_383_12) and arg_380_1.var_.characterEffect1184ui_story == nil then
				arg_380_1.var_.characterEffect1184ui_story = var_383_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_14 = 0.2

			if var_383_13 <= arg_380_1.time_ and arg_380_1.time_ < var_383_13 + var_383_14 and not isNil(var_383_12) then
				local var_383_15 = (arg_380_1.time_ - var_383_13) / var_383_14

				if arg_380_1.var_.characterEffect1184ui_story and not isNil(var_383_12) then
					arg_380_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_13 + var_383_14 and arg_380_1.time_ < var_383_13 + var_383_14 + arg_383_0 and not isNil(var_383_12) and arg_380_1.var_.characterEffect1184ui_story then
				arg_380_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_383_16 = 0
			local var_383_17 = 0.5

			if var_383_16 < arg_380_1.time_ and arg_380_1.time_ <= var_383_16 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_18 = arg_380_1:FormatText(StoryNameCfg[6].name)

				arg_380_1.leftNameTxt_.text = var_383_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_19 = arg_380_1:GetWordFromCfg(114111093)
				local var_383_20 = arg_380_1:FormatText(var_383_19.content)

				arg_380_1.text_.text = var_383_20

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_21 = 20
				local var_383_22 = utf8.len(var_383_20)
				local var_383_23 = var_383_21 <= 0 and var_383_17 or var_383_17 * (var_383_22 / var_383_21)

				if var_383_23 > 0 and var_383_17 < var_383_23 then
					arg_380_1.talkMaxDuration = var_383_23

					if var_383_23 + var_383_16 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_23 + var_383_16
					end
				end

				arg_380_1.text_.text = var_383_20
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111093", "story_v_out_114111.awb") ~= 0 then
					local var_383_24 = manager.audio:GetVoiceLength("story_v_out_114111", "114111093", "story_v_out_114111.awb") / 1000

					if var_383_24 + var_383_16 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_24 + var_383_16
					end

					if var_383_19.prefab_name ~= "" and arg_380_1.actors_[var_383_19.prefab_name] ~= nil then
						local var_383_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_19.prefab_name].transform, "story_v_out_114111", "114111093", "story_v_out_114111.awb")

						arg_380_1:RecordAudio("114111093", var_383_25)
						arg_380_1:RecordAudio("114111093", var_383_25)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_114111", "114111093", "story_v_out_114111.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_114111", "114111093", "story_v_out_114111.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_26 = math.max(var_383_17, arg_380_1.talkMaxDuration)

			if var_383_16 <= arg_380_1.time_ and arg_380_1.time_ < var_383_16 + var_383_26 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_16) / var_383_26

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_16 + var_383_26 and arg_380_1.time_ < var_383_16 + var_383_26 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play114111094 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 114111094
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play114111095(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["1184ui_story"].transform
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.var_.moveOldPos1184ui_story = var_387_0.localPosition
			end

			local var_387_2 = 0.001

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2
				local var_387_4 = Vector3.New(0, 100, 0)

				var_387_0.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos1184ui_story, var_387_4, var_387_3)

				local var_387_5 = manager.ui.mainCamera.transform.position - var_387_0.position

				var_387_0.forward = Vector3.New(var_387_5.x, var_387_5.y, var_387_5.z)

				local var_387_6 = var_387_0.localEulerAngles

				var_387_6.z = 0
				var_387_6.x = 0
				var_387_0.localEulerAngles = var_387_6
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 then
				var_387_0.localPosition = Vector3.New(0, 100, 0)

				local var_387_7 = manager.ui.mainCamera.transform.position - var_387_0.position

				var_387_0.forward = Vector3.New(var_387_7.x, var_387_7.y, var_387_7.z)

				local var_387_8 = var_387_0.localEulerAngles

				var_387_8.z = 0
				var_387_8.x = 0
				var_387_0.localEulerAngles = var_387_8
			end

			local var_387_9 = 0
			local var_387_10 = 1.35

			if var_387_9 < arg_384_1.time_ and arg_384_1.time_ <= var_387_9 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_11 = arg_384_1:GetWordFromCfg(114111094)
				local var_387_12 = arg_384_1:FormatText(var_387_11.content)

				arg_384_1.text_.text = var_387_12

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_13 = 54
				local var_387_14 = utf8.len(var_387_12)
				local var_387_15 = var_387_13 <= 0 and var_387_10 or var_387_10 * (var_387_14 / var_387_13)

				if var_387_15 > 0 and var_387_10 < var_387_15 then
					arg_384_1.talkMaxDuration = var_387_15

					if var_387_15 + var_387_9 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_15 + var_387_9
					end
				end

				arg_384_1.text_.text = var_387_12
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_16 = math.max(var_387_10, arg_384_1.talkMaxDuration)

			if var_387_9 <= arg_384_1.time_ and arg_384_1.time_ < var_387_9 + var_387_16 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_9) / var_387_16

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_9 + var_387_16 and arg_384_1.time_ < var_387_9 + var_387_16 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play114111095 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 114111095
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play114111096(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = manager.ui.mainCamera.transform
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.var_.shakeOldPos = var_391_0.localPosition
			end

			local var_391_2 = 1.5

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / 0.066
				local var_391_4, var_391_5 = math.modf(var_391_3)

				var_391_0.localPosition = Vector3.New(var_391_5 * 0.13, var_391_5 * 0.13, var_391_5 * 0.13) + arg_388_1.var_.shakeOldPos
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 then
				var_391_0.localPosition = arg_388_1.var_.shakeOldPos
			end

			local var_391_6 = 0

			if var_391_6 < arg_388_1.time_ and arg_388_1.time_ <= var_391_6 + arg_391_0 then
				arg_388_1.allBtn_.enabled = false
			end

			local var_391_7 = 1.5

			if arg_388_1.time_ >= var_391_6 + var_391_7 and arg_388_1.time_ < var_391_6 + var_391_7 + arg_391_0 then
				arg_388_1.allBtn_.enabled = true
			end

			local var_391_8 = 0
			local var_391_9 = 1

			if var_391_8 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				local var_391_10 = "play"
				local var_391_11 = "effect"

				arg_388_1:AudioAction(var_391_10, var_391_11, "se_story_11", "se_story_11_roar", "")
			end

			local var_391_12 = 0
			local var_391_13 = 0.125

			if var_391_12 < arg_388_1.time_ and arg_388_1.time_ <= var_391_12 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_14 = arg_388_1:GetWordFromCfg(114111095)
				local var_391_15 = arg_388_1:FormatText(var_391_14.content)

				arg_388_1.text_.text = var_391_15

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_16 = 5
				local var_391_17 = utf8.len(var_391_15)
				local var_391_18 = var_391_16 <= 0 and var_391_13 or var_391_13 * (var_391_17 / var_391_16)

				if var_391_18 > 0 and var_391_13 < var_391_18 then
					arg_388_1.talkMaxDuration = var_391_18

					if var_391_18 + var_391_12 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_18 + var_391_12
					end
				end

				arg_388_1.text_.text = var_391_15
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_19 = math.max(var_391_13, arg_388_1.talkMaxDuration)

			if var_391_12 <= arg_388_1.time_ and arg_388_1.time_ < var_391_12 + var_391_19 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_12) / var_391_19

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_12 + var_391_19 and arg_388_1.time_ < var_391_12 + var_391_19 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play114111096 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 114111096
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play114111097(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0
			local var_395_1 = 0.15

			if var_395_0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_2 = arg_392_1:FormatText(StoryNameCfg[7].name)

				arg_392_1.leftNameTxt_.text = var_395_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_3 = arg_392_1:GetWordFromCfg(114111096)
				local var_395_4 = arg_392_1:FormatText(var_395_3.content)

				arg_392_1.text_.text = var_395_4

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_5 = 6
				local var_395_6 = utf8.len(var_395_4)
				local var_395_7 = var_395_5 <= 0 and var_395_1 or var_395_1 * (var_395_6 / var_395_5)

				if var_395_7 > 0 and var_395_1 < var_395_7 then
					arg_392_1.talkMaxDuration = var_395_7

					if var_395_7 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_0
					end
				end

				arg_392_1.text_.text = var_395_4
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_8 = math.max(var_395_1, arg_392_1.talkMaxDuration)

			if var_395_0 <= arg_392_1.time_ and arg_392_1.time_ < var_395_0 + var_395_8 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_0) / var_395_8

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_0 + var_395_8 and arg_392_1.time_ < var_395_0 + var_395_8 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play114111097 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 114111097
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play114111098(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0
			local var_399_1 = 1.075

			if var_399_0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_2 = arg_396_1:GetWordFromCfg(114111097)
				local var_399_3 = arg_396_1:FormatText(var_399_2.content)

				arg_396_1.text_.text = var_399_3

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_4 = 43
				local var_399_5 = utf8.len(var_399_3)
				local var_399_6 = var_399_4 <= 0 and var_399_1 or var_399_1 * (var_399_5 / var_399_4)

				if var_399_6 > 0 and var_399_1 < var_399_6 then
					arg_396_1.talkMaxDuration = var_399_6

					if var_399_6 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_6 + var_399_0
					end
				end

				arg_396_1.text_.text = var_399_3
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_7 = math.max(var_399_1, arg_396_1.talkMaxDuration)

			if var_399_0 <= arg_396_1.time_ and arg_396_1.time_ < var_399_0 + var_399_7 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_0) / var_399_7

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_0 + var_399_7 and arg_396_1.time_ < var_399_0 + var_399_7 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play114111098 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 114111098
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play114111099(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 1.675

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_2 = arg_400_1:GetWordFromCfg(114111098)
				local var_403_3 = arg_400_1:FormatText(var_403_2.content)

				arg_400_1.text_.text = var_403_3

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_4 = 67
				local var_403_5 = utf8.len(var_403_3)
				local var_403_6 = var_403_4 <= 0 and var_403_1 or var_403_1 * (var_403_5 / var_403_4)

				if var_403_6 > 0 and var_403_1 < var_403_6 then
					arg_400_1.talkMaxDuration = var_403_6

					if var_403_6 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_6 + var_403_0
					end
				end

				arg_400_1.text_.text = var_403_3
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_7 = math.max(var_403_1, arg_400_1.talkMaxDuration)

			if var_403_0 <= arg_400_1.time_ and arg_400_1.time_ < var_403_0 + var_403_7 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_0) / var_403_7

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_0 + var_403_7 and arg_400_1.time_ < var_403_0 + var_403_7 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play114111099 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 114111099
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play114111100(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0
			local var_407_1 = 0.325

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_2 = arg_404_1:FormatText(StoryNameCfg[7].name)

				arg_404_1.leftNameTxt_.text = var_407_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_3 = arg_404_1:GetWordFromCfg(114111099)
				local var_407_4 = arg_404_1:FormatText(var_407_3.content)

				arg_404_1.text_.text = var_407_4

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_5 = 13
				local var_407_6 = utf8.len(var_407_4)
				local var_407_7 = var_407_5 <= 0 and var_407_1 or var_407_1 * (var_407_6 / var_407_5)

				if var_407_7 > 0 and var_407_1 < var_407_7 then
					arg_404_1.talkMaxDuration = var_407_7

					if var_407_7 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_7 + var_407_0
					end
				end

				arg_404_1.text_.text = var_407_4
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_8 = math.max(var_407_1, arg_404_1.talkMaxDuration)

			if var_407_0 <= arg_404_1.time_ and arg_404_1.time_ < var_407_0 + var_407_8 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_0) / var_407_8

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_0 + var_407_8 and arg_404_1.time_ < var_407_0 + var_407_8 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play114111100 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 114111100
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play114111101(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 1.775

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_2 = arg_408_1:GetWordFromCfg(114111100)
				local var_411_3 = arg_408_1:FormatText(var_411_2.content)

				arg_408_1.text_.text = var_411_3

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 71
				local var_411_5 = utf8.len(var_411_3)
				local var_411_6 = var_411_4 <= 0 and var_411_1 or var_411_1 * (var_411_5 / var_411_4)

				if var_411_6 > 0 and var_411_1 < var_411_6 then
					arg_408_1.talkMaxDuration = var_411_6

					if var_411_6 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_6 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_3
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_7 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_7 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_7

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_7 and arg_408_1.time_ < var_411_0 + var_411_7 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play114111101 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 114111101
		arg_412_1.duration_ = 4.87

		local var_412_0 = {
			ja = 4.8,
			ko = 4.866,
			zh = 4.633,
			en = 4.366
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play114111102(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 0.5

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_2 = arg_412_1:FormatText(StoryNameCfg[10].name)

				arg_412_1.leftNameTxt_.text = var_415_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_3 = arg_412_1:GetWordFromCfg(114111101)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_5 = 21
				local var_415_6 = utf8.len(var_415_4)
				local var_415_7 = var_415_5 <= 0 and var_415_1 or var_415_1 * (var_415_6 / var_415_5)

				if var_415_7 > 0 and var_415_1 < var_415_7 then
					arg_412_1.talkMaxDuration = var_415_7

					if var_415_7 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_0
					end
				end

				arg_412_1.text_.text = var_415_4
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111101", "story_v_out_114111.awb") ~= 0 then
					local var_415_8 = manager.audio:GetVoiceLength("story_v_out_114111", "114111101", "story_v_out_114111.awb") / 1000

					if var_415_8 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_8 + var_415_0
					end

					if var_415_3.prefab_name ~= "" and arg_412_1.actors_[var_415_3.prefab_name] ~= nil then
						local var_415_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_3.prefab_name].transform, "story_v_out_114111", "114111101", "story_v_out_114111.awb")

						arg_412_1:RecordAudio("114111101", var_415_9)
						arg_412_1:RecordAudio("114111101", var_415_9)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_114111", "114111101", "story_v_out_114111.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_114111", "114111101", "story_v_out_114111.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_10 = math.max(var_415_1, arg_412_1.talkMaxDuration)

			if var_415_0 <= arg_412_1.time_ and arg_412_1.time_ < var_415_0 + var_415_10 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_0) / var_415_10

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_0 + var_415_10 and arg_412_1.time_ < var_415_0 + var_415_10 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play114111102 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 114111102
		arg_416_1.duration_ = 2.53

		local var_416_0 = {
			ja = 2.533,
			ko = 1.999999999999,
			zh = 2.1,
			en = 1.999999999999
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play114111103(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["1041ui_story"].transform
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 then
				arg_416_1.var_.moveOldPos1041ui_story = var_419_0.localPosition

				local var_419_2 = "1041ui_story"

				arg_416_1:ShowWeapon(arg_416_1.var_[var_419_2 .. "Animator"].transform, true)
			end

			local var_419_3 = 0.001

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_3 then
				local var_419_4 = (arg_416_1.time_ - var_419_1) / var_419_3
				local var_419_5 = Vector3.New(-0.7, -1.11, -5.9)

				var_419_0.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos1041ui_story, var_419_5, var_419_4)

				local var_419_6 = manager.ui.mainCamera.transform.position - var_419_0.position

				var_419_0.forward = Vector3.New(var_419_6.x, var_419_6.y, var_419_6.z)

				local var_419_7 = var_419_0.localEulerAngles

				var_419_7.z = 0
				var_419_7.x = 0
				var_419_0.localEulerAngles = var_419_7
			end

			if arg_416_1.time_ >= var_419_1 + var_419_3 and arg_416_1.time_ < var_419_1 + var_419_3 + arg_419_0 then
				var_419_0.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_419_8 = manager.ui.mainCamera.transform.position - var_419_0.position

				var_419_0.forward = Vector3.New(var_419_8.x, var_419_8.y, var_419_8.z)

				local var_419_9 = var_419_0.localEulerAngles

				var_419_9.z = 0
				var_419_9.x = 0
				var_419_0.localEulerAngles = var_419_9
			end

			local var_419_10 = 0

			if var_419_10 < arg_416_1.time_ and arg_416_1.time_ <= var_419_10 + arg_419_0 then
				arg_416_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action8_1")
			end

			local var_419_11 = 0

			if var_419_11 < arg_416_1.time_ and arg_416_1.time_ <= var_419_11 + arg_419_0 then
				arg_416_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_419_12 = arg_416_1.actors_["1041ui_story"]
			local var_419_13 = 0

			if var_419_13 < arg_416_1.time_ and arg_416_1.time_ <= var_419_13 + arg_419_0 and not isNil(var_419_12) and arg_416_1.var_.characterEffect1041ui_story == nil then
				arg_416_1.var_.characterEffect1041ui_story = var_419_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_14 = 0.2

			if var_419_13 <= arg_416_1.time_ and arg_416_1.time_ < var_419_13 + var_419_14 and not isNil(var_419_12) then
				local var_419_15 = (arg_416_1.time_ - var_419_13) / var_419_14

				if arg_416_1.var_.characterEffect1041ui_story and not isNil(var_419_12) then
					arg_416_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= var_419_13 + var_419_14 and arg_416_1.time_ < var_419_13 + var_419_14 + arg_419_0 and not isNil(var_419_12) and arg_416_1.var_.characterEffect1041ui_story then
				arg_416_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_419_16 = 0
			local var_419_17 = 0.2

			if var_419_16 < arg_416_1.time_ and arg_416_1.time_ <= var_419_16 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_18 = arg_416_1:FormatText(StoryNameCfg[208].name)

				arg_416_1.leftNameTxt_.text = var_419_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_19 = arg_416_1:GetWordFromCfg(114111102)
				local var_419_20 = arg_416_1:FormatText(var_419_19.content)

				arg_416_1.text_.text = var_419_20

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_21 = 8
				local var_419_22 = utf8.len(var_419_20)
				local var_419_23 = var_419_21 <= 0 and var_419_17 or var_419_17 * (var_419_22 / var_419_21)

				if var_419_23 > 0 and var_419_17 < var_419_23 then
					arg_416_1.talkMaxDuration = var_419_23

					if var_419_23 + var_419_16 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_23 + var_419_16
					end
				end

				arg_416_1.text_.text = var_419_20
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111102", "story_v_out_114111.awb") ~= 0 then
					local var_419_24 = manager.audio:GetVoiceLength("story_v_out_114111", "114111102", "story_v_out_114111.awb") / 1000

					if var_419_24 + var_419_16 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_24 + var_419_16
					end

					if var_419_19.prefab_name ~= "" and arg_416_1.actors_[var_419_19.prefab_name] ~= nil then
						local var_419_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_19.prefab_name].transform, "story_v_out_114111", "114111102", "story_v_out_114111.awb")

						arg_416_1:RecordAudio("114111102", var_419_25)
						arg_416_1:RecordAudio("114111102", var_419_25)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_114111", "114111102", "story_v_out_114111.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_114111", "114111102", "story_v_out_114111.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_26 = math.max(var_419_17, arg_416_1.talkMaxDuration)

			if var_419_16 <= arg_416_1.time_ and arg_416_1.time_ < var_419_16 + var_419_26 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_16) / var_419_26

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_16 + var_419_26 and arg_416_1.time_ < var_419_16 + var_419_26 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_416_1:InitPlayNodeList()
	end,
	Play114111103 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 114111103
		arg_420_1.duration_ = 3.87

		local var_420_0 = {
			ja = 3.866,
			ko = 2.6,
			zh = 2.333,
			en = 2.4
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play114111104(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["1041ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1041ui_story == nil then
				arg_420_1.var_.characterEffect1041ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.2

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect1041ui_story and not isNil(var_423_0) then
					local var_423_4 = Mathf.Lerp(0, 0.5, var_423_3)

					arg_420_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_420_1.var_.characterEffect1041ui_story.fillRatio = var_423_4
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1041ui_story then
				local var_423_5 = 0.5

				arg_420_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_420_1.var_.characterEffect1041ui_story.fillRatio = var_423_5
			end

			local var_423_6 = arg_420_1.actors_["1038ui_story"].transform
			local var_423_7 = 0

			if var_423_7 < arg_420_1.time_ and arg_420_1.time_ <= var_423_7 + arg_423_0 then
				arg_420_1.var_.moveOldPos1038ui_story = var_423_6.localPosition
			end

			local var_423_8 = 0.001

			if var_423_7 <= arg_420_1.time_ and arg_420_1.time_ < var_423_7 + var_423_8 then
				local var_423_9 = (arg_420_1.time_ - var_423_7) / var_423_8
				local var_423_10 = Vector3.New(0.7, -1.11, -5.9)

				var_423_6.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1038ui_story, var_423_10, var_423_9)

				local var_423_11 = manager.ui.mainCamera.transform.position - var_423_6.position

				var_423_6.forward = Vector3.New(var_423_11.x, var_423_11.y, var_423_11.z)

				local var_423_12 = var_423_6.localEulerAngles

				var_423_12.z = 0
				var_423_12.x = 0
				var_423_6.localEulerAngles = var_423_12
			end

			if arg_420_1.time_ >= var_423_7 + var_423_8 and arg_420_1.time_ < var_423_7 + var_423_8 + arg_423_0 then
				var_423_6.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_423_13 = manager.ui.mainCamera.transform.position - var_423_6.position

				var_423_6.forward = Vector3.New(var_423_13.x, var_423_13.y, var_423_13.z)

				local var_423_14 = var_423_6.localEulerAngles

				var_423_14.z = 0
				var_423_14.x = 0
				var_423_6.localEulerAngles = var_423_14
			end

			local var_423_15 = 0

			if var_423_15 < arg_420_1.time_ and arg_420_1.time_ <= var_423_15 + arg_423_0 then
				arg_420_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			local var_423_16 = 0

			if var_423_16 < arg_420_1.time_ and arg_420_1.time_ <= var_423_16 + arg_423_0 then
				arg_420_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_423_17 = arg_420_1.actors_["1038ui_story"]
			local var_423_18 = 0

			if var_423_18 < arg_420_1.time_ and arg_420_1.time_ <= var_423_18 + arg_423_0 and not isNil(var_423_17) and arg_420_1.var_.characterEffect1038ui_story == nil then
				arg_420_1.var_.characterEffect1038ui_story = var_423_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_19 = 0.2

			if var_423_18 <= arg_420_1.time_ and arg_420_1.time_ < var_423_18 + var_423_19 and not isNil(var_423_17) then
				local var_423_20 = (arg_420_1.time_ - var_423_18) / var_423_19

				if arg_420_1.var_.characterEffect1038ui_story and not isNil(var_423_17) then
					arg_420_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= var_423_18 + var_423_19 and arg_420_1.time_ < var_423_18 + var_423_19 + arg_423_0 and not isNil(var_423_17) and arg_420_1.var_.characterEffect1038ui_story then
				arg_420_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_423_21 = 0
			local var_423_22 = 0.325

			if var_423_21 < arg_420_1.time_ and arg_420_1.time_ <= var_423_21 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_23 = arg_420_1:FormatText(StoryNameCfg[94].name)

				arg_420_1.leftNameTxt_.text = var_423_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_24 = arg_420_1:GetWordFromCfg(114111103)
				local var_423_25 = arg_420_1:FormatText(var_423_24.content)

				arg_420_1.text_.text = var_423_25

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_26 = 13
				local var_423_27 = utf8.len(var_423_25)
				local var_423_28 = var_423_26 <= 0 and var_423_22 or var_423_22 * (var_423_27 / var_423_26)

				if var_423_28 > 0 and var_423_22 < var_423_28 then
					arg_420_1.talkMaxDuration = var_423_28

					if var_423_28 + var_423_21 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_28 + var_423_21
					end
				end

				arg_420_1.text_.text = var_423_25
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111103", "story_v_out_114111.awb") ~= 0 then
					local var_423_29 = manager.audio:GetVoiceLength("story_v_out_114111", "114111103", "story_v_out_114111.awb") / 1000

					if var_423_29 + var_423_21 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_29 + var_423_21
					end

					if var_423_24.prefab_name ~= "" and arg_420_1.actors_[var_423_24.prefab_name] ~= nil then
						local var_423_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_24.prefab_name].transform, "story_v_out_114111", "114111103", "story_v_out_114111.awb")

						arg_420_1:RecordAudio("114111103", var_423_30)
						arg_420_1:RecordAudio("114111103", var_423_30)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_114111", "114111103", "story_v_out_114111.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_114111", "114111103", "story_v_out_114111.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_31 = math.max(var_423_22, arg_420_1.talkMaxDuration)

			if var_423_21 <= arg_420_1.time_ and arg_420_1.time_ < var_423_21 + var_423_31 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_21) / var_423_31

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_21 + var_423_31 and arg_420_1.time_ < var_423_21 + var_423_31 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play114111104 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 114111104
		arg_424_1.duration_ = 4.2

		local var_424_0 = {
			ja = 4.2,
			ko = 2.633,
			zh = 2.133,
			en = 1.999999999999
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play114111105(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["1038ui_story"]
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect1038ui_story == nil then
				arg_424_1.var_.characterEffect1038ui_story = var_427_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.2

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 and not isNil(var_427_0) then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2

				if arg_424_1.var_.characterEffect1038ui_story and not isNil(var_427_0) then
					local var_427_4 = Mathf.Lerp(0, 0.5, var_427_3)

					arg_424_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1038ui_story.fillRatio = var_427_4
				end
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect1038ui_story then
				local var_427_5 = 0.5

				arg_424_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1038ui_story.fillRatio = var_427_5
			end

			local var_427_6 = arg_424_1.actors_["1041ui_story"]
			local var_427_7 = 0

			if var_427_7 < arg_424_1.time_ and arg_424_1.time_ <= var_427_7 + arg_427_0 and not isNil(var_427_6) and arg_424_1.var_.characterEffect1041ui_story == nil then
				arg_424_1.var_.characterEffect1041ui_story = var_427_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_8 = 0.2

			if var_427_7 <= arg_424_1.time_ and arg_424_1.time_ < var_427_7 + var_427_8 and not isNil(var_427_6) then
				local var_427_9 = (arg_424_1.time_ - var_427_7) / var_427_8

				if arg_424_1.var_.characterEffect1041ui_story and not isNil(var_427_6) then
					arg_424_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= var_427_7 + var_427_8 and arg_424_1.time_ < var_427_7 + var_427_8 + arg_427_0 and not isNil(var_427_6) and arg_424_1.var_.characterEffect1041ui_story then
				arg_424_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_427_10 = 0

			if var_427_10 < arg_424_1.time_ and arg_424_1.time_ <= var_427_10 + arg_427_0 then
				arg_424_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_427_11 = 0
			local var_427_12 = 0.175

			if var_427_11 < arg_424_1.time_ and arg_424_1.time_ <= var_427_11 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_13 = arg_424_1:FormatText(StoryNameCfg[208].name)

				arg_424_1.leftNameTxt_.text = var_427_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_14 = arg_424_1:GetWordFromCfg(114111104)
				local var_427_15 = arg_424_1:FormatText(var_427_14.content)

				arg_424_1.text_.text = var_427_15

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_16 = 7
				local var_427_17 = utf8.len(var_427_15)
				local var_427_18 = var_427_16 <= 0 and var_427_12 or var_427_12 * (var_427_17 / var_427_16)

				if var_427_18 > 0 and var_427_12 < var_427_18 then
					arg_424_1.talkMaxDuration = var_427_18

					if var_427_18 + var_427_11 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_18 + var_427_11
					end
				end

				arg_424_1.text_.text = var_427_15
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111104", "story_v_out_114111.awb") ~= 0 then
					local var_427_19 = manager.audio:GetVoiceLength("story_v_out_114111", "114111104", "story_v_out_114111.awb") / 1000

					if var_427_19 + var_427_11 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_19 + var_427_11
					end

					if var_427_14.prefab_name ~= "" and arg_424_1.actors_[var_427_14.prefab_name] ~= nil then
						local var_427_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_14.prefab_name].transform, "story_v_out_114111", "114111104", "story_v_out_114111.awb")

						arg_424_1:RecordAudio("114111104", var_427_20)
						arg_424_1:RecordAudio("114111104", var_427_20)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_114111", "114111104", "story_v_out_114111.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_114111", "114111104", "story_v_out_114111.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_21 = math.max(var_427_12, arg_424_1.talkMaxDuration)

			if var_427_11 <= arg_424_1.time_ and arg_424_1.time_ < var_427_11 + var_427_21 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_11) / var_427_21

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_11 + var_427_21 and arg_424_1.time_ < var_427_11 + var_427_21 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play114111105 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 114111105
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play114111106(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["1038ui_story"].transform
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1.var_.moveOldPos1038ui_story = var_431_0.localPosition
			end

			local var_431_2 = 0.001

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2
				local var_431_4 = Vector3.New(0, 100, 0)

				var_431_0.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1038ui_story, var_431_4, var_431_3)

				local var_431_5 = manager.ui.mainCamera.transform.position - var_431_0.position

				var_431_0.forward = Vector3.New(var_431_5.x, var_431_5.y, var_431_5.z)

				local var_431_6 = var_431_0.localEulerAngles

				var_431_6.z = 0
				var_431_6.x = 0
				var_431_0.localEulerAngles = var_431_6
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 then
				var_431_0.localPosition = Vector3.New(0, 100, 0)

				local var_431_7 = manager.ui.mainCamera.transform.position - var_431_0.position

				var_431_0.forward = Vector3.New(var_431_7.x, var_431_7.y, var_431_7.z)

				local var_431_8 = var_431_0.localEulerAngles

				var_431_8.z = 0
				var_431_8.x = 0
				var_431_0.localEulerAngles = var_431_8
			end

			local var_431_9 = arg_428_1.actors_["1041ui_story"].transform
			local var_431_10 = 0

			if var_431_10 < arg_428_1.time_ and arg_428_1.time_ <= var_431_10 + arg_431_0 then
				arg_428_1.var_.moveOldPos1041ui_story = var_431_9.localPosition
			end

			local var_431_11 = 0.001

			if var_431_10 <= arg_428_1.time_ and arg_428_1.time_ < var_431_10 + var_431_11 then
				local var_431_12 = (arg_428_1.time_ - var_431_10) / var_431_11
				local var_431_13 = Vector3.New(0, 100, 0)

				var_431_9.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1041ui_story, var_431_13, var_431_12)

				local var_431_14 = manager.ui.mainCamera.transform.position - var_431_9.position

				var_431_9.forward = Vector3.New(var_431_14.x, var_431_14.y, var_431_14.z)

				local var_431_15 = var_431_9.localEulerAngles

				var_431_15.z = 0
				var_431_15.x = 0
				var_431_9.localEulerAngles = var_431_15
			end

			if arg_428_1.time_ >= var_431_10 + var_431_11 and arg_428_1.time_ < var_431_10 + var_431_11 + arg_431_0 then
				var_431_9.localPosition = Vector3.New(0, 100, 0)

				local var_431_16 = manager.ui.mainCamera.transform.position - var_431_9.position

				var_431_9.forward = Vector3.New(var_431_16.x, var_431_16.y, var_431_16.z)

				local var_431_17 = var_431_9.localEulerAngles

				var_431_17.z = 0
				var_431_17.x = 0
				var_431_9.localEulerAngles = var_431_17
			end

			local var_431_18 = 0
			local var_431_19 = 1.025

			if var_431_18 < arg_428_1.time_ and arg_428_1.time_ <= var_431_18 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_20 = arg_428_1:GetWordFromCfg(114111105)
				local var_431_21 = arg_428_1:FormatText(var_431_20.content)

				arg_428_1.text_.text = var_431_21

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_22 = 41
				local var_431_23 = utf8.len(var_431_21)
				local var_431_24 = var_431_22 <= 0 and var_431_19 or var_431_19 * (var_431_23 / var_431_22)

				if var_431_24 > 0 and var_431_19 < var_431_24 then
					arg_428_1.talkMaxDuration = var_431_24

					if var_431_24 + var_431_18 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_24 + var_431_18
					end
				end

				arg_428_1.text_.text = var_431_21
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_25 = math.max(var_431_19, arg_428_1.talkMaxDuration)

			if var_431_18 <= arg_428_1.time_ and arg_428_1.time_ < var_431_18 + var_431_25 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_18) / var_431_25

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_18 + var_431_25 and arg_428_1.time_ < var_431_18 + var_431_25 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play114111106 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 114111106
		arg_432_1.duration_ = 9

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play114111107(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.mask_.enabled = true
				arg_432_1.mask_.raycastTarget = true

				arg_432_1:SetGaussion(false)
			end

			local var_435_1 = 2

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_1 then
				local var_435_2 = (arg_432_1.time_ - var_435_0) / var_435_1
				local var_435_3 = Color.New(0, 0, 0)

				var_435_3.a = Mathf.Lerp(0, 1, var_435_2)
				arg_432_1.mask_.color = var_435_3
			end

			if arg_432_1.time_ >= var_435_0 + var_435_1 and arg_432_1.time_ < var_435_0 + var_435_1 + arg_435_0 then
				local var_435_4 = Color.New(0, 0, 0)

				var_435_4.a = 1
				arg_432_1.mask_.color = var_435_4
			end

			local var_435_5 = 2

			if var_435_5 < arg_432_1.time_ and arg_432_1.time_ <= var_435_5 + arg_435_0 then
				arg_432_1.mask_.enabled = true
				arg_432_1.mask_.raycastTarget = true

				arg_432_1:SetGaussion(false)
			end

			local var_435_6 = 2

			if var_435_5 <= arg_432_1.time_ and arg_432_1.time_ < var_435_5 + var_435_6 then
				local var_435_7 = (arg_432_1.time_ - var_435_5) / var_435_6
				local var_435_8 = Color.New(0, 0, 0)

				var_435_8.a = Mathf.Lerp(1, 0, var_435_7)
				arg_432_1.mask_.color = var_435_8
			end

			if arg_432_1.time_ >= var_435_5 + var_435_6 and arg_432_1.time_ < var_435_5 + var_435_6 + arg_435_0 then
				local var_435_9 = Color.New(0, 0, 0)
				local var_435_10 = 0

				arg_432_1.mask_.enabled = false
				var_435_9.a = var_435_10
				arg_432_1.mask_.color = var_435_9
			end

			local var_435_11 = "OM0211"

			if arg_432_1.bgs_[var_435_11] == nil then
				local var_435_12 = Object.Instantiate(arg_432_1.paintGo_)

				var_435_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_435_11)
				var_435_12.name = var_435_11
				var_435_12.transform.parent = arg_432_1.stage_.transform
				var_435_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_432_1.bgs_[var_435_11] = var_435_12
			end

			local var_435_13 = 2

			if var_435_13 < arg_432_1.time_ and arg_432_1.time_ <= var_435_13 + arg_435_0 then
				local var_435_14 = manager.ui.mainCamera.transform.localPosition
				local var_435_15 = Vector3.New(0, 0, 10) + Vector3.New(var_435_14.x, var_435_14.y, 0)
				local var_435_16 = arg_432_1.bgs_.OM0211

				var_435_16.transform.localPosition = var_435_15
				var_435_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_435_17 = var_435_16:GetComponent("SpriteRenderer")

				if var_435_17 and var_435_17.sprite then
					local var_435_18 = (var_435_16.transform.localPosition - var_435_14).z
					local var_435_19 = manager.ui.mainCameraCom_
					local var_435_20 = 2 * var_435_18 * Mathf.Tan(var_435_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_435_21 = var_435_20 * var_435_19.aspect
					local var_435_22 = var_435_17.sprite.bounds.size.x
					local var_435_23 = var_435_17.sprite.bounds.size.y
					local var_435_24 = var_435_21 / var_435_22
					local var_435_25 = var_435_20 / var_435_23
					local var_435_26 = var_435_25 < var_435_24 and var_435_24 or var_435_25

					var_435_16.transform.localScale = Vector3.New(var_435_26, var_435_26, 0)
				end

				for iter_435_0, iter_435_1 in pairs(arg_432_1.bgs_) do
					if iter_435_0 ~= "OM0211" then
						iter_435_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_435_27 = arg_432_1.bgs_.OM0211.transform
			local var_435_28 = 2

			if var_435_28 < arg_432_1.time_ and arg_432_1.time_ <= var_435_28 + arg_435_0 then
				arg_432_1.var_.moveOldPosOM0211 = var_435_27.localPosition
			end

			local var_435_29 = 0.001

			if var_435_28 <= arg_432_1.time_ and arg_432_1.time_ < var_435_28 + var_435_29 then
				local var_435_30 = (arg_432_1.time_ - var_435_28) / var_435_29
				local var_435_31 = Vector3.New(0, 1, 9)

				var_435_27.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPosOM0211, var_435_31, var_435_30)
			end

			if arg_432_1.time_ >= var_435_28 + var_435_29 and arg_432_1.time_ < var_435_28 + var_435_29 + arg_435_0 then
				var_435_27.localPosition = Vector3.New(0, 1, 9)
			end

			local var_435_32 = arg_432_1.bgs_.OM0211.transform
			local var_435_33 = 2.034

			if var_435_33 < arg_432_1.time_ and arg_432_1.time_ <= var_435_33 + arg_435_0 then
				arg_432_1.var_.moveOldPosOM0211 = var_435_32.localPosition
			end

			local var_435_34 = 3.5

			if var_435_33 <= arg_432_1.time_ and arg_432_1.time_ < var_435_33 + var_435_34 then
				local var_435_35 = (arg_432_1.time_ - var_435_33) / var_435_34
				local var_435_36 = Vector3.New(0, 1, 10)

				var_435_32.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPosOM0211, var_435_36, var_435_35)
			end

			if arg_432_1.time_ >= var_435_33 + var_435_34 and arg_432_1.time_ < var_435_33 + var_435_34 + arg_435_0 then
				var_435_32.localPosition = Vector3.New(0, 1, 10)
			end

			local var_435_37 = 4

			if var_435_37 < arg_432_1.time_ and arg_432_1.time_ <= var_435_37 + arg_435_0 then
				arg_432_1.allBtn_.enabled = false
			end

			local var_435_38 = 1.534

			if arg_432_1.time_ >= var_435_37 + var_435_38 and arg_432_1.time_ < var_435_37 + var_435_38 + arg_435_0 then
				arg_432_1.allBtn_.enabled = true
			end

			if arg_432_1.frameCnt_ <= 1 then
				arg_432_1.dialog_:SetActive(false)
			end

			local var_435_39 = 4
			local var_435_40 = 1.55

			if var_435_39 < arg_432_1.time_ and arg_432_1.time_ <= var_435_39 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0

				arg_432_1.dialog_:SetActive(true)

				arg_432_1.dialogCg_.alpha = 0

				local var_435_41 = LeanTween.value(arg_432_1.dialog_, 0, 1, 0.3)

				var_435_41:setOnUpdate(LuaHelper.FloatAction(function(arg_436_0)
					arg_432_1.dialogCg_.alpha = arg_436_0
				end))
				var_435_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_432_1.dialog_)
					var_435_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_432_1.duration_ = arg_432_1.duration_ + 0.3

				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_42 = arg_432_1:GetWordFromCfg(114111106)
				local var_435_43 = arg_432_1:FormatText(var_435_42.content)

				arg_432_1.text_.text = var_435_43

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_44 = 62
				local var_435_45 = utf8.len(var_435_43)
				local var_435_46 = var_435_44 <= 0 and var_435_40 or var_435_40 * (var_435_45 / var_435_44)

				if var_435_46 > 0 and var_435_40 < var_435_46 then
					arg_432_1.talkMaxDuration = var_435_46
					var_435_39 = var_435_39 + 0.3

					if var_435_46 + var_435_39 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_46 + var_435_39
					end
				end

				arg_432_1.text_.text = var_435_43
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_47 = var_435_39 + 0.3
			local var_435_48 = math.max(var_435_40, arg_432_1.talkMaxDuration)

			if var_435_47 <= arg_432_1.time_ and arg_432_1.time_ < var_435_47 + var_435_48 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_47) / var_435_48

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_47 + var_435_48 and arg_432_1.time_ < var_435_47 + var_435_48 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0211",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0211",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play114111107 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 114111107
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play114111108(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0
			local var_441_1 = 0.725

			if var_441_0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_2 = arg_438_1:GetWordFromCfg(114111107)
				local var_441_3 = arg_438_1:FormatText(var_441_2.content)

				arg_438_1.text_.text = var_441_3

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_4 = 29
				local var_441_5 = utf8.len(var_441_3)
				local var_441_6 = var_441_4 <= 0 and var_441_1 or var_441_1 * (var_441_5 / var_441_4)

				if var_441_6 > 0 and var_441_1 < var_441_6 then
					arg_438_1.talkMaxDuration = var_441_6

					if var_441_6 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_6 + var_441_0
					end
				end

				arg_438_1.text_.text = var_441_3
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_7 = math.max(var_441_1, arg_438_1.talkMaxDuration)

			if var_441_0 <= arg_438_1.time_ and arg_438_1.time_ < var_441_0 + var_441_7 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_0) / var_441_7

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_0 + var_441_7 and arg_438_1.time_ < var_441_0 + var_441_7 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play114111108 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 114111108
		arg_442_1.duration_ = 5.57

		local var_442_0 = {
			ja = 5.066,
			ko = 5.566,
			zh = 4.166,
			en = 4.733
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play114111109(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0
			local var_445_1 = 0.55

			if var_445_0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_2 = arg_442_1:FormatText(StoryNameCfg[6].name)

				arg_442_1.leftNameTxt_.text = var_445_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_3 = arg_442_1:GetWordFromCfg(114111108)
				local var_445_4 = arg_442_1:FormatText(var_445_3.content)

				arg_442_1.text_.text = var_445_4

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_5 = 22
				local var_445_6 = utf8.len(var_445_4)
				local var_445_7 = var_445_5 <= 0 and var_445_1 or var_445_1 * (var_445_6 / var_445_5)

				if var_445_7 > 0 and var_445_1 < var_445_7 then
					arg_442_1.talkMaxDuration = var_445_7

					if var_445_7 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_7 + var_445_0
					end
				end

				arg_442_1.text_.text = var_445_4
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111108", "story_v_out_114111.awb") ~= 0 then
					local var_445_8 = manager.audio:GetVoiceLength("story_v_out_114111", "114111108", "story_v_out_114111.awb") / 1000

					if var_445_8 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_8 + var_445_0
					end

					if var_445_3.prefab_name ~= "" and arg_442_1.actors_[var_445_3.prefab_name] ~= nil then
						local var_445_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_3.prefab_name].transform, "story_v_out_114111", "114111108", "story_v_out_114111.awb")

						arg_442_1:RecordAudio("114111108", var_445_9)
						arg_442_1:RecordAudio("114111108", var_445_9)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_114111", "114111108", "story_v_out_114111.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_114111", "114111108", "story_v_out_114111.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_10 = math.max(var_445_1, arg_442_1.talkMaxDuration)

			if var_445_0 <= arg_442_1.time_ and arg_442_1.time_ < var_445_0 + var_445_10 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_0) / var_445_10

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_0 + var_445_10 and arg_442_1.time_ < var_445_0 + var_445_10 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play114111109 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 114111109
		arg_446_1.duration_ = 9.03

		local var_446_0 = {
			ja = 4.866,
			ko = 8.9,
			zh = 7.5,
			en = 9.033
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play114111110(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0
			local var_449_1 = 0.9

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_2 = arg_446_1:FormatText(StoryNameCfg[94].name)

				arg_446_1.leftNameTxt_.text = var_449_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_5")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_3 = arg_446_1:GetWordFromCfg(114111109)
				local var_449_4 = arg_446_1:FormatText(var_449_3.content)

				arg_446_1.text_.text = var_449_4

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_5 = 36
				local var_449_6 = utf8.len(var_449_4)
				local var_449_7 = var_449_5 <= 0 and var_449_1 or var_449_1 * (var_449_6 / var_449_5)

				if var_449_7 > 0 and var_449_1 < var_449_7 then
					arg_446_1.talkMaxDuration = var_449_7

					if var_449_7 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_7 + var_449_0
					end
				end

				arg_446_1.text_.text = var_449_4
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111109", "story_v_out_114111.awb") ~= 0 then
					local var_449_8 = manager.audio:GetVoiceLength("story_v_out_114111", "114111109", "story_v_out_114111.awb") / 1000

					if var_449_8 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_8 + var_449_0
					end

					if var_449_3.prefab_name ~= "" and arg_446_1.actors_[var_449_3.prefab_name] ~= nil then
						local var_449_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_3.prefab_name].transform, "story_v_out_114111", "114111109", "story_v_out_114111.awb")

						arg_446_1:RecordAudio("114111109", var_449_9)
						arg_446_1:RecordAudio("114111109", var_449_9)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_114111", "114111109", "story_v_out_114111.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_114111", "114111109", "story_v_out_114111.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_10 = math.max(var_449_1, arg_446_1.talkMaxDuration)

			if var_449_0 <= arg_446_1.time_ and arg_446_1.time_ < var_449_0 + var_449_10 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_0) / var_449_10

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_0 + var_449_10 and arg_446_1.time_ < var_449_0 + var_449_10 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play114111110 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 114111110
		arg_450_1.duration_ = 7.4

		local var_450_0 = {
			ja = 7.4,
			ko = 5.2,
			zh = 5.966,
			en = 4.966
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play114111111(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0
			local var_453_1 = 0.525

			if var_453_0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_2 = arg_450_1:FormatText(StoryNameCfg[208].name)

				arg_450_1.leftNameTxt_.text = var_453_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_3 = arg_450_1:GetWordFromCfg(114111110)
				local var_453_4 = arg_450_1:FormatText(var_453_3.content)

				arg_450_1.text_.text = var_453_4

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 21
				local var_453_6 = utf8.len(var_453_4)
				local var_453_7 = var_453_5 <= 0 and var_453_1 or var_453_1 * (var_453_6 / var_453_5)

				if var_453_7 > 0 and var_453_1 < var_453_7 then
					arg_450_1.talkMaxDuration = var_453_7

					if var_453_7 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_7 + var_453_0
					end
				end

				arg_450_1.text_.text = var_453_4
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111110", "story_v_out_114111.awb") ~= 0 then
					local var_453_8 = manager.audio:GetVoiceLength("story_v_out_114111", "114111110", "story_v_out_114111.awb") / 1000

					if var_453_8 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_8 + var_453_0
					end

					if var_453_3.prefab_name ~= "" and arg_450_1.actors_[var_453_3.prefab_name] ~= nil then
						local var_453_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_3.prefab_name].transform, "story_v_out_114111", "114111110", "story_v_out_114111.awb")

						arg_450_1:RecordAudio("114111110", var_453_9)
						arg_450_1:RecordAudio("114111110", var_453_9)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_114111", "114111110", "story_v_out_114111.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_114111", "114111110", "story_v_out_114111.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_10 = math.max(var_453_1, arg_450_1.talkMaxDuration)

			if var_453_0 <= arg_450_1.time_ and arg_450_1.time_ < var_453_0 + var_453_10 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_0) / var_453_10

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_0 + var_453_10 and arg_450_1.time_ < var_453_0 + var_453_10 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play114111111 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 114111111
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play114111112(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0
			local var_457_1 = 1.525

			if var_457_0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, false)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_2 = arg_454_1:GetWordFromCfg(114111111)
				local var_457_3 = arg_454_1:FormatText(var_457_2.content)

				arg_454_1.text_.text = var_457_3

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_4 = 61
				local var_457_5 = utf8.len(var_457_3)
				local var_457_6 = var_457_4 <= 0 and var_457_1 or var_457_1 * (var_457_5 / var_457_4)

				if var_457_6 > 0 and var_457_1 < var_457_6 then
					arg_454_1.talkMaxDuration = var_457_6

					if var_457_6 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_6 + var_457_0
					end
				end

				arg_454_1.text_.text = var_457_3
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_7 = math.max(var_457_1, arg_454_1.talkMaxDuration)

			if var_457_0 <= arg_454_1.time_ and arg_454_1.time_ < var_457_0 + var_457_7 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_0) / var_457_7

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_0 + var_457_7 and arg_454_1.time_ < var_457_0 + var_457_7 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play114111112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 114111112
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play114111113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 0
			local var_461_1 = 1.425

			if var_461_0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_0 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_2 = arg_458_1:GetWordFromCfg(114111112)
				local var_461_3 = arg_458_1:FormatText(var_461_2.content)

				arg_458_1.text_.text = var_461_3

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_4 = 57
				local var_461_5 = utf8.len(var_461_3)
				local var_461_6 = var_461_4 <= 0 and var_461_1 or var_461_1 * (var_461_5 / var_461_4)

				if var_461_6 > 0 and var_461_1 < var_461_6 then
					arg_458_1.talkMaxDuration = var_461_6

					if var_461_6 + var_461_0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_6 + var_461_0
					end
				end

				arg_458_1.text_.text = var_461_3
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_7 = math.max(var_461_1, arg_458_1.talkMaxDuration)

			if var_461_0 <= arg_458_1.time_ and arg_458_1.time_ < var_461_0 + var_461_7 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_0) / var_461_7

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_0 + var_461_7 and arg_458_1.time_ < var_461_0 + var_461_7 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play114111113 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 114111113
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
			arg_462_1.auto_ = false
		end

		function arg_462_1.playNext_(arg_464_0)
			arg_462_1.onStoryFinished_()
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0
			local var_465_1 = 1.175

			if var_465_0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, false)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_2 = arg_462_1:GetWordFromCfg(114111113)
				local var_465_3 = arg_462_1:FormatText(var_465_2.content)

				arg_462_1.text_.text = var_465_3

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_4 = 47
				local var_465_5 = utf8.len(var_465_3)
				local var_465_6 = var_465_4 <= 0 and var_465_1 or var_465_1 * (var_465_5 / var_465_4)

				if var_465_6 > 0 and var_465_1 < var_465_6 then
					arg_462_1.talkMaxDuration = var_465_6

					if var_465_6 + var_465_0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_6 + var_465_0
					end
				end

				arg_462_1.text_.text = var_465_3
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_7 = math.max(var_465_1, arg_462_1.talkMaxDuration)

			if var_465_0 <= arg_462_1.time_ and arg_462_1.time_ < var_465_0 + var_465_7 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_0) / var_465_7

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_0 + var_465_7 and arg_462_1.time_ < var_465_0 + var_465_7 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F04",
		"TextureConfig/Background/OM0206",
		"TextureConfig/Background/F05_1",
		"TextureConfig/Background/OM0211"
	},
	voices = {
		"story_v_out_114111.awb"
	}
}
