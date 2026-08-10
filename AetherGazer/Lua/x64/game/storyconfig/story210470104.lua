return {
	Play1104704001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104704001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104704002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST22a"

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
				local var_4_5 = arg_1_1.bgs_.ST22a

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
					if iter_4_0 ~= "ST22a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_4_28 = 1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

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

			local var_4_34 = 2
			local var_4_35 = 0.8

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(1104704001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 32
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
	Play1104704002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1104704002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1104704003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.025

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

				local var_11_2 = arg_8_1:GetWordFromCfg(1104704002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 41
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
	Play1104704003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1104704003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1104704004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.3

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(1104704003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 12
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_8 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_8 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_8

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_8 and arg_12_1.time_ < var_15_0 + var_15_8 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1104704004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1104704004
		arg_16_1.duration_ = 2.07

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1104704005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1047ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["1047ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos1047ui_story = var_19_5.localPosition
			end

			local var_19_7 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7
				local var_19_9 = Vector3.New(0, -1.13, -6.2)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1047ui_story, var_19_9, var_19_8)

				local var_19_10 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_10.x, var_19_10.y, var_19_10.z)

				local var_19_11 = var_19_5.localEulerAngles

				var_19_11.z = 0
				var_19_11.x = 0
				var_19_5.localEulerAngles = var_19_11
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_19_12 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_12.x, var_19_12.y, var_19_12.z)

				local var_19_13 = var_19_5.localEulerAngles

				var_19_13.z = 0
				var_19_13.x = 0
				var_19_5.localEulerAngles = var_19_13
			end

			local var_19_14 = arg_16_1.actors_["1047ui_story"]
			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect1047ui_story == nil then
				arg_16_1.var_.characterEffect1047ui_story = var_19_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_16 = 0.200000002980232

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_16 and not isNil(var_19_14) then
				local var_19_17 = (arg_16_1.time_ - var_19_15) / var_19_16

				if arg_16_1.var_.characterEffect1047ui_story and not isNil(var_19_14) then
					arg_16_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_15 + var_19_16 and arg_16_1.time_ < var_19_15 + var_19_16 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect1047ui_story then
				arg_16_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_19_18 = 0

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_19_19 = 0

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_20 = 0
			local var_19_21 = 0.2

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_22 = arg_16_1:FormatText(StoryNameCfg[1296].name)

				arg_16_1.leftNameTxt_.text = var_19_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_23 = arg_16_1:GetWordFromCfg(1104704004)
				local var_19_24 = arg_16_1:FormatText(var_19_23.content)

				arg_16_1.text_.text = var_19_24

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_25 = 8
				local var_19_26 = utf8.len(var_19_24)
				local var_19_27 = var_19_25 <= 0 and var_19_21 or var_19_21 * (var_19_26 / var_19_25)

				if var_19_27 > 0 and var_19_21 < var_19_27 then
					arg_16_1.talkMaxDuration = var_19_27

					if var_19_27 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_27 + var_19_20
					end
				end

				arg_16_1.text_.text = var_19_24
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704004", "story_v_side_new_1104704.awb") ~= 0 then
					local var_19_28 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704004", "story_v_side_new_1104704.awb") / 1000

					if var_19_28 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_20
					end

					if var_19_23.prefab_name ~= "" and arg_16_1.actors_[var_19_23.prefab_name] ~= nil then
						local var_19_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_23.prefab_name].transform, "story_v_side_new_1104704", "1104704004", "story_v_side_new_1104704.awb")

						arg_16_1:RecordAudio("1104704004", var_19_29)
						arg_16_1:RecordAudio("1104704004", var_19_29)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704004", "story_v_side_new_1104704.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704004", "story_v_side_new_1104704.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_30 = math.max(var_19_21, arg_16_1.talkMaxDuration)

			if var_19_20 <= arg_16_1.time_ and arg_16_1.time_ < var_19_20 + var_19_30 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_20) / var_19_30

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_20 + var_19_30 and arg_16_1.time_ < var_19_20 + var_19_30 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104704005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1104704005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1104704006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1047ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1047ui_story == nil then
				arg_20_1.var_.characterEffect1047ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1047ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1047ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1047ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1047ui_story.fillRatio = var_23_5
			end

			local var_23_6 = arg_20_1.actors_["1047ui_story"].transform
			local var_23_7 = 0

			if var_23_7 < arg_20_1.time_ and arg_20_1.time_ <= var_23_7 + arg_23_0 then
				arg_20_1.var_.moveOldPos1047ui_story = var_23_6.localPosition
			end

			local var_23_8 = 0.001

			if var_23_7 <= arg_20_1.time_ and arg_20_1.time_ < var_23_7 + var_23_8 then
				local var_23_9 = (arg_20_1.time_ - var_23_7) / var_23_8
				local var_23_10 = Vector3.New(0, 100, 0)

				var_23_6.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1047ui_story, var_23_10, var_23_9)

				local var_23_11 = manager.ui.mainCamera.transform.position - var_23_6.position

				var_23_6.forward = Vector3.New(var_23_11.x, var_23_11.y, var_23_11.z)

				local var_23_12 = var_23_6.localEulerAngles

				var_23_12.z = 0
				var_23_12.x = 0
				var_23_6.localEulerAngles = var_23_12
			end

			if arg_20_1.time_ >= var_23_7 + var_23_8 and arg_20_1.time_ < var_23_7 + var_23_8 + arg_23_0 then
				var_23_6.localPosition = Vector3.New(0, 100, 0)

				local var_23_13 = manager.ui.mainCamera.transform.position - var_23_6.position

				var_23_6.forward = Vector3.New(var_23_13.x, var_23_13.y, var_23_13.z)

				local var_23_14 = var_23_6.localEulerAngles

				var_23_14.z = 0
				var_23_14.x = 0
				var_23_6.localEulerAngles = var_23_14
			end

			local var_23_15 = 0
			local var_23_16 = 0.675

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_17 = arg_20_1:GetWordFromCfg(1104704005)
				local var_23_18 = arg_20_1:FormatText(var_23_17.content)

				arg_20_1.text_.text = var_23_18

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_19 = 27
				local var_23_20 = utf8.len(var_23_18)
				local var_23_21 = var_23_19 <= 0 and var_23_16 or var_23_16 * (var_23_20 / var_23_19)

				if var_23_21 > 0 and var_23_16 < var_23_21 then
					arg_20_1.talkMaxDuration = var_23_21

					if var_23_21 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_21 + var_23_15
					end
				end

				arg_20_1.text_.text = var_23_18
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_22 = math.max(var_23_16, arg_20_1.talkMaxDuration)

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_22 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_15) / var_23_22

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_15 + var_23_22 and arg_20_1.time_ < var_23_15 + var_23_22 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104704006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1104704006
		arg_24_1.duration_ = 5.1

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1104704007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1047ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1047ui_story = var_27_0.localPosition
			end

			local var_27_2 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2
				local var_27_4 = Vector3.New(0, -1.13, -6.2)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1047ui_story, var_27_4, var_27_3)

				local var_27_5 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_5.x, var_27_5.y, var_27_5.z)

				local var_27_6 = var_27_0.localEulerAngles

				var_27_6.z = 0
				var_27_6.x = 0
				var_27_0.localEulerAngles = var_27_6
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_27_7 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_7.x, var_27_7.y, var_27_7.z)

				local var_27_8 = var_27_0.localEulerAngles

				var_27_8.z = 0
				var_27_8.x = 0
				var_27_0.localEulerAngles = var_27_8
			end

			local var_27_9 = arg_24_1.actors_["1047ui_story"]
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1047ui_story == nil then
				arg_24_1.var_.characterEffect1047ui_story = var_27_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_11 = 0.200000002980232

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 and not isNil(var_27_9) then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11

				if arg_24_1.var_.characterEffect1047ui_story and not isNil(var_27_9) then
					arg_24_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1047ui_story then
				arg_24_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_27_13 = 0

			if var_27_13 < arg_24_1.time_ and arg_24_1.time_ <= var_27_13 + arg_27_0 then
				arg_24_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			local var_27_14 = 0

			if var_27_14 < arg_24_1.time_ and arg_24_1.time_ <= var_27_14 + arg_27_0 then
				arg_24_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_15 = 0
			local var_27_16 = 0.425

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_17 = arg_24_1:FormatText(StoryNameCfg[1296].name)

				arg_24_1.leftNameTxt_.text = var_27_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_18 = arg_24_1:GetWordFromCfg(1104704006)
				local var_27_19 = arg_24_1:FormatText(var_27_18.content)

				arg_24_1.text_.text = var_27_19

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_20 = 17
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704006", "story_v_side_new_1104704.awb") ~= 0 then
					local var_27_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704006", "story_v_side_new_1104704.awb") / 1000

					if var_27_23 + var_27_15 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_23 + var_27_15
					end

					if var_27_18.prefab_name ~= "" and arg_24_1.actors_[var_27_18.prefab_name] ~= nil then
						local var_27_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_18.prefab_name].transform, "story_v_side_new_1104704", "1104704006", "story_v_side_new_1104704.awb")

						arg_24_1:RecordAudio("1104704006", var_27_24)
						arg_24_1:RecordAudio("1104704006", var_27_24)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704006", "story_v_side_new_1104704.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704006", "story_v_side_new_1104704.awb")
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play1104704007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1104704007
		arg_28_1.duration_ = 1

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"

			SetActive(arg_28_1.choicesGo_, true)

			for iter_29_0, iter_29_1 in ipairs(arg_28_1.choices_) do
				local var_29_0 = iter_29_0 <= 1

				SetActive(iter_29_1.go, var_29_0)
			end

			arg_28_1.choices_[1].txt.text = arg_28_1:FormatText(StoryChoiceCfg[1657].name)
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1104704008(arg_28_1)
			end

			arg_28_1:RecordChoiceLog(1104704007, 1657)
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1047ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1047ui_story == nil then
				arg_28_1.var_.characterEffect1047ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1047ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1047ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1047ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1047ui_story.fillRatio = var_31_5
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play1104704008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1104704008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1104704009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1047ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos1047ui_story = var_35_0.localPosition
			end

			local var_35_2 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2
				local var_35_4 = Vector3.New(0, 100, 0)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1047ui_story, var_35_4, var_35_3)

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
			local var_35_10 = 0.375

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

				local var_35_11 = arg_32_1:GetWordFromCfg(1104704008)
				local var_35_12 = arg_32_1:FormatText(var_35_11.content)

				arg_32_1.text_.text = var_35_12

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 15
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
				actorName = "1047ui_story",
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
	Play1104704009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1104704009
		arg_36_1.duration_ = 4.17

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1104704010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1047ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1047ui_story = var_39_0.localPosition
			end

			local var_39_2 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2
				local var_39_4 = Vector3.New(0, -1.13, -6.2)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1047ui_story, var_39_4, var_39_3)

				local var_39_5 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_5.x, var_39_5.y, var_39_5.z)

				local var_39_6 = var_39_0.localEulerAngles

				var_39_6.z = 0
				var_39_6.x = 0
				var_39_0.localEulerAngles = var_39_6
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_39_7 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_7.x, var_39_7.y, var_39_7.z)

				local var_39_8 = var_39_0.localEulerAngles

				var_39_8.z = 0
				var_39_8.x = 0
				var_39_0.localEulerAngles = var_39_8
			end

			local var_39_9 = arg_36_1.actors_["1047ui_story"]
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.characterEffect1047ui_story == nil then
				arg_36_1.var_.characterEffect1047ui_story = var_39_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_11 = 0.200000002980232

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 and not isNil(var_39_9) then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11

				if arg_36_1.var_.characterEffect1047ui_story and not isNil(var_39_9) then
					arg_36_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.characterEffect1047ui_story then
				arg_36_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_39_13 = 0

			if var_39_13 < arg_36_1.time_ and arg_36_1.time_ <= var_39_13 + arg_39_0 then
				arg_36_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action476")
			end

			local var_39_14 = 0

			if var_39_14 < arg_36_1.time_ and arg_36_1.time_ <= var_39_14 + arg_39_0 then
				arg_36_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_39_15 = 0
			local var_39_16 = 0.375

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_17 = arg_36_1:FormatText(StoryNameCfg[1296].name)

				arg_36_1.leftNameTxt_.text = var_39_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_18 = arg_36_1:GetWordFromCfg(1104704009)
				local var_39_19 = arg_36_1:FormatText(var_39_18.content)

				arg_36_1.text_.text = var_39_19

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_20 = 15
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704009", "story_v_side_new_1104704.awb") ~= 0 then
					local var_39_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704009", "story_v_side_new_1104704.awb") / 1000

					if var_39_23 + var_39_15 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_15
					end

					if var_39_18.prefab_name ~= "" and arg_36_1.actors_[var_39_18.prefab_name] ~= nil then
						local var_39_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_18.prefab_name].transform, "story_v_side_new_1104704", "1104704009", "story_v_side_new_1104704.awb")

						arg_36_1:RecordAudio("1104704009", var_39_24)
						arg_36_1:RecordAudio("1104704009", var_39_24)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704009", "story_v_side_new_1104704.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704009", "story_v_side_new_1104704.awb")
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play1104704010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1104704010
		arg_40_1.duration_ = 1

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"

			SetActive(arg_40_1.choicesGo_, true)

			for iter_41_0, iter_41_1 in ipairs(arg_40_1.choices_) do
				local var_41_0 = iter_41_0 <= 1

				SetActive(iter_41_1.go, var_41_0)
			end

			arg_40_1.choices_[1].txt.text = arg_40_1:FormatText(StoryChoiceCfg[1658].name)
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1104704011(arg_40_1)
			end

			arg_40_1:RecordChoiceLog(1104704010, 1658)
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1047ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1047ui_story == nil then
				arg_40_1.var_.characterEffect1047ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1047ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1047ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1047ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1047ui_story.fillRatio = var_43_5
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1104704011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1104704011
		arg_44_1.duration_ = 5.57

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1104704012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1047ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1047ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, -1.13, -6.2)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1047ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["1047ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1047ui_story == nil then
				arg_44_1.var_.characterEffect1047ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect1047ui_story and not isNil(var_47_9) then
					arg_44_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1047ui_story then
				arg_44_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_47_13 = 0

			if var_47_13 < arg_44_1.time_ and arg_44_1.time_ <= var_47_13 + arg_47_0 then
				arg_44_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			local var_47_14 = 0

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_47_15 = 0
			local var_47_16 = 0.5

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_17 = arg_44_1:FormatText(StoryNameCfg[1296].name)

				arg_44_1.leftNameTxt_.text = var_47_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_18 = arg_44_1:GetWordFromCfg(1104704011)
				local var_47_19 = arg_44_1:FormatText(var_47_18.content)

				arg_44_1.text_.text = var_47_19

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704011", "story_v_side_new_1104704.awb") ~= 0 then
					local var_47_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704011", "story_v_side_new_1104704.awb") / 1000

					if var_47_23 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_15
					end

					if var_47_18.prefab_name ~= "" and arg_44_1.actors_[var_47_18.prefab_name] ~= nil then
						local var_47_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_18.prefab_name].transform, "story_v_side_new_1104704", "1104704011", "story_v_side_new_1104704.awb")

						arg_44_1:RecordAudio("1104704011", var_47_24)
						arg_44_1:RecordAudio("1104704011", var_47_24)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704011", "story_v_side_new_1104704.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704011", "story_v_side_new_1104704.awb")
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
				actorName = "1047ui_story",
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
	Play1104704012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1104704012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1104704013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1047ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1047ui_story == nil then
				arg_48_1.var_.characterEffect1047ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1047ui_story and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1047ui_story.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1047ui_story then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1047ui_story.fillRatio = var_51_5
			end

			local var_51_6 = arg_48_1.actors_["1047ui_story"].transform
			local var_51_7 = 0

			if var_51_7 < arg_48_1.time_ and arg_48_1.time_ <= var_51_7 + arg_51_0 then
				arg_48_1.var_.moveOldPos1047ui_story = var_51_6.localPosition
			end

			local var_51_8 = 0.001

			if var_51_7 <= arg_48_1.time_ and arg_48_1.time_ < var_51_7 + var_51_8 then
				local var_51_9 = (arg_48_1.time_ - var_51_7) / var_51_8
				local var_51_10 = Vector3.New(0, 100, 0)

				var_51_6.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1047ui_story, var_51_10, var_51_9)

				local var_51_11 = manager.ui.mainCamera.transform.position - var_51_6.position

				var_51_6.forward = Vector3.New(var_51_11.x, var_51_11.y, var_51_11.z)

				local var_51_12 = var_51_6.localEulerAngles

				var_51_12.z = 0
				var_51_12.x = 0
				var_51_6.localEulerAngles = var_51_12
			end

			if arg_48_1.time_ >= var_51_7 + var_51_8 and arg_48_1.time_ < var_51_7 + var_51_8 + arg_51_0 then
				var_51_6.localPosition = Vector3.New(0, 100, 0)

				local var_51_13 = manager.ui.mainCamera.transform.position - var_51_6.position

				var_51_6.forward = Vector3.New(var_51_13.x, var_51_13.y, var_51_13.z)

				local var_51_14 = var_51_6.localEulerAngles

				var_51_14.z = 0
				var_51_14.x = 0
				var_51_6.localEulerAngles = var_51_14
			end

			local var_51_15 = 0
			local var_51_16 = 0.375

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_17 = arg_48_1:GetWordFromCfg(1104704012)
				local var_51_18 = arg_48_1:FormatText(var_51_17.content)

				arg_48_1.text_.text = var_51_18

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_19 = 15
				local var_51_20 = utf8.len(var_51_18)
				local var_51_21 = var_51_19 <= 0 and var_51_16 or var_51_16 * (var_51_20 / var_51_19)

				if var_51_21 > 0 and var_51_16 < var_51_21 then
					arg_48_1.talkMaxDuration = var_51_21

					if var_51_21 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_21 + var_51_15
					end
				end

				arg_48_1.text_.text = var_51_18
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_22 = math.max(var_51_16, arg_48_1.talkMaxDuration)

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_22 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_15) / var_51_22

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_15 + var_51_22 and arg_48_1.time_ < var_51_15 + var_51_22 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play1104704013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1104704013
		arg_52_1.duration_ = 2.2

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1104704014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1047ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1047ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, -1.13, -6.2)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1047ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = arg_52_1.actors_["1047ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1047ui_story == nil then
				arg_52_1.var_.characterEffect1047ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.200000002980232

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect1047ui_story and not isNil(var_55_9) then
					arg_52_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1047ui_story then
				arg_52_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_55_13 = 0

			if var_55_13 < arg_52_1.time_ and arg_52_1.time_ <= var_55_13 + arg_55_0 then
				arg_52_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_55_14 = 0

			if var_55_14 < arg_52_1.time_ and arg_52_1.time_ <= var_55_14 + arg_55_0 then
				arg_52_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_55_15 = 0
			local var_55_16 = 0.1

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_17 = arg_52_1:FormatText(StoryNameCfg[1296].name)

				arg_52_1.leftNameTxt_.text = var_55_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_18 = arg_52_1:GetWordFromCfg(1104704013)
				local var_55_19 = arg_52_1:FormatText(var_55_18.content)

				arg_52_1.text_.text = var_55_19

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_20 = 4
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704013", "story_v_side_new_1104704.awb") ~= 0 then
					local var_55_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704013", "story_v_side_new_1104704.awb") / 1000

					if var_55_23 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_15
					end

					if var_55_18.prefab_name ~= "" and arg_52_1.actors_[var_55_18.prefab_name] ~= nil then
						local var_55_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_18.prefab_name].transform, "story_v_side_new_1104704", "1104704013", "story_v_side_new_1104704.awb")

						arg_52_1:RecordAudio("1104704013", var_55_24)
						arg_52_1:RecordAudio("1104704013", var_55_24)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704013", "story_v_side_new_1104704.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704013", "story_v_side_new_1104704.awb")
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play1104704014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1104704014
		arg_56_1.duration_ = 2

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1104704015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1047ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1047ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0, -1.13, -6.2)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1047ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = 0

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_11 = 0
			local var_59_12 = 0.175

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_13 = arg_56_1:FormatText(StoryNameCfg[1296].name)

				arg_56_1.leftNameTxt_.text = var_59_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_14 = arg_56_1:GetWordFromCfg(1104704014)
				local var_59_15 = arg_56_1:FormatText(var_59_14.content)

				arg_56_1.text_.text = var_59_15

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_16 = 7
				local var_59_17 = utf8.len(var_59_15)
				local var_59_18 = var_59_16 <= 0 and var_59_12 or var_59_12 * (var_59_17 / var_59_16)

				if var_59_18 > 0 and var_59_12 < var_59_18 then
					arg_56_1.talkMaxDuration = var_59_18

					if var_59_18 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_11
					end
				end

				arg_56_1.text_.text = var_59_15
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704014", "story_v_side_new_1104704.awb") ~= 0 then
					local var_59_19 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704014", "story_v_side_new_1104704.awb") / 1000

					if var_59_19 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_19 + var_59_11
					end

					if var_59_14.prefab_name ~= "" and arg_56_1.actors_[var_59_14.prefab_name] ~= nil then
						local var_59_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_14.prefab_name].transform, "story_v_side_new_1104704", "1104704014", "story_v_side_new_1104704.awb")

						arg_56_1:RecordAudio("1104704014", var_59_20)
						arg_56_1:RecordAudio("1104704014", var_59_20)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704014", "story_v_side_new_1104704.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704014", "story_v_side_new_1104704.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_21 = math.max(var_59_12, arg_56_1.talkMaxDuration)

			if var_59_11 <= arg_56_1.time_ and arg_56_1.time_ < var_59_11 + var_59_21 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_11) / var_59_21

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_11 + var_59_21 and arg_56_1.time_ < var_59_11 + var_59_21 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play1104704015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1104704015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1104704016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1047ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1047ui_story == nil then
				arg_60_1.var_.characterEffect1047ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1047ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1047ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1047ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1047ui_story.fillRatio = var_63_5
			end

			local var_63_6 = arg_60_1.actors_["1047ui_story"].transform
			local var_63_7 = 0

			if var_63_7 < arg_60_1.time_ and arg_60_1.time_ <= var_63_7 + arg_63_0 then
				arg_60_1.var_.moveOldPos1047ui_story = var_63_6.localPosition
			end

			local var_63_8 = 0.001

			if var_63_7 <= arg_60_1.time_ and arg_60_1.time_ < var_63_7 + var_63_8 then
				local var_63_9 = (arg_60_1.time_ - var_63_7) / var_63_8
				local var_63_10 = Vector3.New(0, 100, 0)

				var_63_6.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1047ui_story, var_63_10, var_63_9)

				local var_63_11 = manager.ui.mainCamera.transform.position - var_63_6.position

				var_63_6.forward = Vector3.New(var_63_11.x, var_63_11.y, var_63_11.z)

				local var_63_12 = var_63_6.localEulerAngles

				var_63_12.z = 0
				var_63_12.x = 0
				var_63_6.localEulerAngles = var_63_12
			end

			if arg_60_1.time_ >= var_63_7 + var_63_8 and arg_60_1.time_ < var_63_7 + var_63_8 + arg_63_0 then
				var_63_6.localPosition = Vector3.New(0, 100, 0)

				local var_63_13 = manager.ui.mainCamera.transform.position - var_63_6.position

				var_63_6.forward = Vector3.New(var_63_13.x, var_63_13.y, var_63_13.z)

				local var_63_14 = var_63_6.localEulerAngles

				var_63_14.z = 0
				var_63_14.x = 0
				var_63_6.localEulerAngles = var_63_14
			end

			local var_63_15 = 0
			local var_63_16 = 1.275

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_17 = arg_60_1:GetWordFromCfg(1104704015)
				local var_63_18 = arg_60_1:FormatText(var_63_17.content)

				arg_60_1.text_.text = var_63_18

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_19 = 51
				local var_63_20 = utf8.len(var_63_18)
				local var_63_21 = var_63_19 <= 0 and var_63_16 or var_63_16 * (var_63_20 / var_63_19)

				if var_63_21 > 0 and var_63_16 < var_63_21 then
					arg_60_1.talkMaxDuration = var_63_21

					if var_63_21 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_21 + var_63_15
					end
				end

				arg_60_1.text_.text = var_63_18
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_22 = math.max(var_63_16, arg_60_1.talkMaxDuration)

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_22 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_15) / var_63_22

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_15 + var_63_22 and arg_60_1.time_ < var_63_15 + var_63_22 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play1104704016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1104704016
		arg_64_1.duration_ = 9.9

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1104704017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1047ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1047ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, -1.13, -6.2)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1047ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["1047ui_story"]
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1047ui_story == nil then
				arg_64_1.var_.characterEffect1047ui_story = var_67_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_11 = 0.200000002980232

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 and not isNil(var_67_9) then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11

				if arg_64_1.var_.characterEffect1047ui_story and not isNil(var_67_9) then
					arg_64_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1047ui_story then
				arg_64_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_67_13 = 0

			if var_67_13 < arg_64_1.time_ and arg_64_1.time_ <= var_67_13 + arg_67_0 then
				arg_64_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action436")
			end

			local var_67_14 = 0

			if var_67_14 < arg_64_1.time_ and arg_64_1.time_ <= var_67_14 + arg_67_0 then
				arg_64_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_15 = 0
			local var_67_16 = 0.85

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_17 = arg_64_1:FormatText(StoryNameCfg[1296].name)

				arg_64_1.leftNameTxt_.text = var_67_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_18 = arg_64_1:GetWordFromCfg(1104704016)
				local var_67_19 = arg_64_1:FormatText(var_67_18.content)

				arg_64_1.text_.text = var_67_19

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_20 = 34
				local var_67_21 = utf8.len(var_67_19)
				local var_67_22 = var_67_20 <= 0 and var_67_16 or var_67_16 * (var_67_21 / var_67_20)

				if var_67_22 > 0 and var_67_16 < var_67_22 then
					arg_64_1.talkMaxDuration = var_67_22

					if var_67_22 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_22 + var_67_15
					end
				end

				arg_64_1.text_.text = var_67_19
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704016", "story_v_side_new_1104704.awb") ~= 0 then
					local var_67_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704016", "story_v_side_new_1104704.awb") / 1000

					if var_67_23 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_23 + var_67_15
					end

					if var_67_18.prefab_name ~= "" and arg_64_1.actors_[var_67_18.prefab_name] ~= nil then
						local var_67_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_18.prefab_name].transform, "story_v_side_new_1104704", "1104704016", "story_v_side_new_1104704.awb")

						arg_64_1:RecordAudio("1104704016", var_67_24)
						arg_64_1:RecordAudio("1104704016", var_67_24)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704016", "story_v_side_new_1104704.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704016", "story_v_side_new_1104704.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_25 = math.max(var_67_16, arg_64_1.talkMaxDuration)

			if var_67_15 <= arg_64_1.time_ and arg_64_1.time_ < var_67_15 + var_67_25 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_15) / var_67_25

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_15 + var_67_25 and arg_64_1.time_ < var_67_15 + var_67_25 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play1104704017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1104704017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1104704018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1047ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1047ui_story == nil then
				arg_68_1.var_.characterEffect1047ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1047ui_story and not isNil(var_71_0) then
					local var_71_4 = Mathf.Lerp(0, 0.5, var_71_3)

					arg_68_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1047ui_story.fillRatio = var_71_4
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1047ui_story then
				local var_71_5 = 0.5

				arg_68_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1047ui_story.fillRatio = var_71_5
			end

			local var_71_6 = 0
			local var_71_7 = 0.575

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_8 = arg_68_1:FormatText(StoryNameCfg[7].name)

				arg_68_1.leftNameTxt_.text = var_71_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_9 = arg_68_1:GetWordFromCfg(1104704017)
				local var_71_10 = arg_68_1:FormatText(var_71_9.content)

				arg_68_1.text_.text = var_71_10

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 23
				local var_71_12 = utf8.len(var_71_10)
				local var_71_13 = var_71_11 <= 0 and var_71_7 or var_71_7 * (var_71_12 / var_71_11)

				if var_71_13 > 0 and var_71_7 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_10
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_14 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_14 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_14

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_14 and arg_68_1.time_ < var_71_6 + var_71_14 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play1104704018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1104704018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1104704019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.625

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[7].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:GetWordFromCfg(1104704018)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 25
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_8 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_8 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_8

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_8 and arg_72_1.time_ < var_75_0 + var_75_8 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1104704019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1104704019
		arg_76_1.duration_ = 5.8

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1104704020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1047ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos1047ui_story = var_79_0.localPosition
			end

			local var_79_2 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2
				local var_79_4 = Vector3.New(0, -1.13, -6.2)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1047ui_story, var_79_4, var_79_3)

				local var_79_5 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_5.x, var_79_5.y, var_79_5.z)

				local var_79_6 = var_79_0.localEulerAngles

				var_79_6.z = 0
				var_79_6.x = 0
				var_79_0.localEulerAngles = var_79_6
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_79_7 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_7.x, var_79_7.y, var_79_7.z)

				local var_79_8 = var_79_0.localEulerAngles

				var_79_8.z = 0
				var_79_8.x = 0
				var_79_0.localEulerAngles = var_79_8
			end

			local var_79_9 = arg_76_1.actors_["1047ui_story"]
			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect1047ui_story == nil then
				arg_76_1.var_.characterEffect1047ui_story = var_79_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_11 = 0.200000002980232

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_11 and not isNil(var_79_9) then
				local var_79_12 = (arg_76_1.time_ - var_79_10) / var_79_11

				if arg_76_1.var_.characterEffect1047ui_story and not isNil(var_79_9) then
					arg_76_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_10 + var_79_11 and arg_76_1.time_ < var_79_10 + var_79_11 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect1047ui_story then
				arg_76_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_79_13 = 0

			if var_79_13 < arg_76_1.time_ and arg_76_1.time_ <= var_79_13 + arg_79_0 then
				arg_76_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action464")
			end

			local var_79_14 = 0

			if var_79_14 < arg_76_1.time_ and arg_76_1.time_ <= var_79_14 + arg_79_0 then
				arg_76_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_15 = 0
			local var_79_16 = 0.6

			if var_79_15 < arg_76_1.time_ and arg_76_1.time_ <= var_79_15 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_17 = arg_76_1:FormatText(StoryNameCfg[1296].name)

				arg_76_1.leftNameTxt_.text = var_79_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_18 = arg_76_1:GetWordFromCfg(1104704019)
				local var_79_19 = arg_76_1:FormatText(var_79_18.content)

				arg_76_1.text_.text = var_79_19

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_20 = 24
				local var_79_21 = utf8.len(var_79_19)
				local var_79_22 = var_79_20 <= 0 and var_79_16 or var_79_16 * (var_79_21 / var_79_20)

				if var_79_22 > 0 and var_79_16 < var_79_22 then
					arg_76_1.talkMaxDuration = var_79_22

					if var_79_22 + var_79_15 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_22 + var_79_15
					end
				end

				arg_76_1.text_.text = var_79_19
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704019", "story_v_side_new_1104704.awb") ~= 0 then
					local var_79_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704019", "story_v_side_new_1104704.awb") / 1000

					if var_79_23 + var_79_15 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_23 + var_79_15
					end

					if var_79_18.prefab_name ~= "" and arg_76_1.actors_[var_79_18.prefab_name] ~= nil then
						local var_79_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_18.prefab_name].transform, "story_v_side_new_1104704", "1104704019", "story_v_side_new_1104704.awb")

						arg_76_1:RecordAudio("1104704019", var_79_24)
						arg_76_1:RecordAudio("1104704019", var_79_24)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704019", "story_v_side_new_1104704.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704019", "story_v_side_new_1104704.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_25 = math.max(var_79_16, arg_76_1.talkMaxDuration)

			if var_79_15 <= arg_76_1.time_ and arg_76_1.time_ < var_79_15 + var_79_25 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_15) / var_79_25

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_15 + var_79_25 and arg_76_1.time_ < var_79_15 + var_79_25 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play1104704020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1104704020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1104704021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1047ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1047ui_story == nil then
				arg_80_1.var_.characterEffect1047ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1047ui_story and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1047ui_story.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1047ui_story then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1047ui_story.fillRatio = var_83_5
			end

			local var_83_6 = 0
			local var_83_7 = 0.65

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_8 = arg_80_1:FormatText(StoryNameCfg[7].name)

				arg_80_1.leftNameTxt_.text = var_83_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_9 = arg_80_1:GetWordFromCfg(1104704020)
				local var_83_10 = arg_80_1:FormatText(var_83_9.content)

				arg_80_1.text_.text = var_83_10

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 26
				local var_83_12 = utf8.len(var_83_10)
				local var_83_13 = var_83_11 <= 0 and var_83_7 or var_83_7 * (var_83_12 / var_83_11)

				if var_83_13 > 0 and var_83_7 < var_83_13 then
					arg_80_1.talkMaxDuration = var_83_13

					if var_83_13 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_6
					end
				end

				arg_80_1.text_.text = var_83_10
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_14 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_14 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_14

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_14 and arg_80_1.time_ < var_83_6 + var_83_14 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play1104704021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1104704021
		arg_84_1.duration_ = 3.07

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1104704022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1047ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1047ui_story = var_87_0.localPosition
			end

			local var_87_2 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2
				local var_87_4 = Vector3.New(0, -1.13, -6.2)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1047ui_story, var_87_4, var_87_3)

				local var_87_5 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_5.x, var_87_5.y, var_87_5.z)

				local var_87_6 = var_87_0.localEulerAngles

				var_87_6.z = 0
				var_87_6.x = 0
				var_87_0.localEulerAngles = var_87_6
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_87_7 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_7.x, var_87_7.y, var_87_7.z)

				local var_87_8 = var_87_0.localEulerAngles

				var_87_8.z = 0
				var_87_8.x = 0
				var_87_0.localEulerAngles = var_87_8
			end

			local var_87_9 = arg_84_1.actors_["1047ui_story"]
			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect1047ui_story == nil then
				arg_84_1.var_.characterEffect1047ui_story = var_87_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_11 = 0.200000002980232

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_11 and not isNil(var_87_9) then
				local var_87_12 = (arg_84_1.time_ - var_87_10) / var_87_11

				if arg_84_1.var_.characterEffect1047ui_story and not isNil(var_87_9) then
					arg_84_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_10 + var_87_11 and arg_84_1.time_ < var_87_10 + var_87_11 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect1047ui_story then
				arg_84_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_87_13 = 0

			if var_87_13 < arg_84_1.time_ and arg_84_1.time_ <= var_87_13 + arg_87_0 then
				arg_84_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action446")
			end

			local var_87_14 = 0

			if var_87_14 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_87_15 = 0
			local var_87_16 = 0.3

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_17 = arg_84_1:FormatText(StoryNameCfg[1296].name)

				arg_84_1.leftNameTxt_.text = var_87_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_18 = arg_84_1:GetWordFromCfg(1104704021)
				local var_87_19 = arg_84_1:FormatText(var_87_18.content)

				arg_84_1.text_.text = var_87_19

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_20 = 12
				local var_87_21 = utf8.len(var_87_19)
				local var_87_22 = var_87_20 <= 0 and var_87_16 or var_87_16 * (var_87_21 / var_87_20)

				if var_87_22 > 0 and var_87_16 < var_87_22 then
					arg_84_1.talkMaxDuration = var_87_22

					if var_87_22 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_22 + var_87_15
					end
				end

				arg_84_1.text_.text = var_87_19
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704021", "story_v_side_new_1104704.awb") ~= 0 then
					local var_87_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704021", "story_v_side_new_1104704.awb") / 1000

					if var_87_23 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_15
					end

					if var_87_18.prefab_name ~= "" and arg_84_1.actors_[var_87_18.prefab_name] ~= nil then
						local var_87_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_18.prefab_name].transform, "story_v_side_new_1104704", "1104704021", "story_v_side_new_1104704.awb")

						arg_84_1:RecordAudio("1104704021", var_87_24)
						arg_84_1:RecordAudio("1104704021", var_87_24)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704021", "story_v_side_new_1104704.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704021", "story_v_side_new_1104704.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_25 = math.max(var_87_16, arg_84_1.talkMaxDuration)

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_25 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_15) / var_87_25

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_15 + var_87_25 and arg_84_1.time_ < var_87_15 + var_87_25 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play1104704022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1104704022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1104704023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1047ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1047ui_story == nil then
				arg_88_1.var_.characterEffect1047ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1047ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1047ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1047ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1047ui_story.fillRatio = var_91_5
			end

			local var_91_6 = arg_88_1.actors_["1047ui_story"].transform
			local var_91_7 = 0

			if var_91_7 < arg_88_1.time_ and arg_88_1.time_ <= var_91_7 + arg_91_0 then
				arg_88_1.var_.moveOldPos1047ui_story = var_91_6.localPosition
			end

			local var_91_8 = 0.001

			if var_91_7 <= arg_88_1.time_ and arg_88_1.time_ < var_91_7 + var_91_8 then
				local var_91_9 = (arg_88_1.time_ - var_91_7) / var_91_8
				local var_91_10 = Vector3.New(0, 100, 0)

				var_91_6.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1047ui_story, var_91_10, var_91_9)

				local var_91_11 = manager.ui.mainCamera.transform.position - var_91_6.position

				var_91_6.forward = Vector3.New(var_91_11.x, var_91_11.y, var_91_11.z)

				local var_91_12 = var_91_6.localEulerAngles

				var_91_12.z = 0
				var_91_12.x = 0
				var_91_6.localEulerAngles = var_91_12
			end

			if arg_88_1.time_ >= var_91_7 + var_91_8 and arg_88_1.time_ < var_91_7 + var_91_8 + arg_91_0 then
				var_91_6.localPosition = Vector3.New(0, 100, 0)

				local var_91_13 = manager.ui.mainCamera.transform.position - var_91_6.position

				var_91_6.forward = Vector3.New(var_91_13.x, var_91_13.y, var_91_13.z)

				local var_91_14 = var_91_6.localEulerAngles

				var_91_14.z = 0
				var_91_14.x = 0
				var_91_6.localEulerAngles = var_91_14
			end

			local var_91_15 = 0
			local var_91_16 = 0.525

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_17 = arg_88_1:GetWordFromCfg(1104704022)
				local var_91_18 = arg_88_1:FormatText(var_91_17.content)

				arg_88_1.text_.text = var_91_18

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_19 = 21
				local var_91_20 = utf8.len(var_91_18)
				local var_91_21 = var_91_19 <= 0 and var_91_16 or var_91_16 * (var_91_20 / var_91_19)

				if var_91_21 > 0 and var_91_16 < var_91_21 then
					arg_88_1.talkMaxDuration = var_91_21

					if var_91_21 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_21 + var_91_15
					end
				end

				arg_88_1.text_.text = var_91_18
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_22 = math.max(var_91_16, arg_88_1.talkMaxDuration)

			if var_91_15 <= arg_88_1.time_ and arg_88_1.time_ < var_91_15 + var_91_22 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_15) / var_91_22

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_15 + var_91_22 and arg_88_1.time_ < var_91_15 + var_91_22 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play1104704023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1104704023
		arg_92_1.duration_ = 6.77

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1104704024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1047ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1047ui_story = var_95_0.localPosition
			end

			local var_95_2 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2
				local var_95_4 = Vector3.New(0, -1.13, -6.2)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1047ui_story, var_95_4, var_95_3)

				local var_95_5 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_5.x, var_95_5.y, var_95_5.z)

				local var_95_6 = var_95_0.localEulerAngles

				var_95_6.z = 0
				var_95_6.x = 0
				var_95_0.localEulerAngles = var_95_6
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_95_7 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_7.x, var_95_7.y, var_95_7.z)

				local var_95_8 = var_95_0.localEulerAngles

				var_95_8.z = 0
				var_95_8.x = 0
				var_95_0.localEulerAngles = var_95_8
			end

			local var_95_9 = arg_92_1.actors_["1047ui_story"]
			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 and not isNil(var_95_9) and arg_92_1.var_.characterEffect1047ui_story == nil then
				arg_92_1.var_.characterEffect1047ui_story = var_95_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_11 = 0.200000002980232

			if var_95_10 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_11 and not isNil(var_95_9) then
				local var_95_12 = (arg_92_1.time_ - var_95_10) / var_95_11

				if arg_92_1.var_.characterEffect1047ui_story and not isNil(var_95_9) then
					arg_92_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_10 + var_95_11 and arg_92_1.time_ < var_95_10 + var_95_11 + arg_95_0 and not isNil(var_95_9) and arg_92_1.var_.characterEffect1047ui_story then
				arg_92_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_95_13 = 0

			if var_95_13 < arg_92_1.time_ and arg_92_1.time_ <= var_95_13 + arg_95_0 then
				arg_92_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			local var_95_14 = 0

			if var_95_14 < arg_92_1.time_ and arg_92_1.time_ <= var_95_14 + arg_95_0 then
				arg_92_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_95_15 = 0
			local var_95_16 = 0.8

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_17 = arg_92_1:FormatText(StoryNameCfg[1296].name)

				arg_92_1.leftNameTxt_.text = var_95_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_18 = arg_92_1:GetWordFromCfg(1104704023)
				local var_95_19 = arg_92_1:FormatText(var_95_18.content)

				arg_92_1.text_.text = var_95_19

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_20 = 32
				local var_95_21 = utf8.len(var_95_19)
				local var_95_22 = var_95_20 <= 0 and var_95_16 or var_95_16 * (var_95_21 / var_95_20)

				if var_95_22 > 0 and var_95_16 < var_95_22 then
					arg_92_1.talkMaxDuration = var_95_22

					if var_95_22 + var_95_15 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_22 + var_95_15
					end
				end

				arg_92_1.text_.text = var_95_19
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704023", "story_v_side_new_1104704.awb") ~= 0 then
					local var_95_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704023", "story_v_side_new_1104704.awb") / 1000

					if var_95_23 + var_95_15 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_23 + var_95_15
					end

					if var_95_18.prefab_name ~= "" and arg_92_1.actors_[var_95_18.prefab_name] ~= nil then
						local var_95_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_18.prefab_name].transform, "story_v_side_new_1104704", "1104704023", "story_v_side_new_1104704.awb")

						arg_92_1:RecordAudio("1104704023", var_95_24)
						arg_92_1:RecordAudio("1104704023", var_95_24)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704023", "story_v_side_new_1104704.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704023", "story_v_side_new_1104704.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_25 = math.max(var_95_16, arg_92_1.talkMaxDuration)

			if var_95_15 <= arg_92_1.time_ and arg_92_1.time_ < var_95_15 + var_95_25 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_15) / var_95_25

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_15 + var_95_25 and arg_92_1.time_ < var_95_15 + var_95_25 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play1104704024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1104704024
		arg_96_1.duration_ = 4.4

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1104704025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1047ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos1047ui_story = var_99_0.localPosition
			end

			local var_99_2 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2
				local var_99_4 = Vector3.New(0, -1.13, -6.2)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1047ui_story, var_99_4, var_99_3)

				local var_99_5 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_5.x, var_99_5.y, var_99_5.z)

				local var_99_6 = var_99_0.localEulerAngles

				var_99_6.z = 0
				var_99_6.x = 0
				var_99_0.localEulerAngles = var_99_6
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_99_7 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_7.x, var_99_7.y, var_99_7.z)

				local var_99_8 = var_99_0.localEulerAngles

				var_99_8.z = 0
				var_99_8.x = 0
				var_99_0.localEulerAngles = var_99_8
			end

			local var_99_9 = 0

			if var_99_9 < arg_96_1.time_ and arg_96_1.time_ <= var_99_9 + arg_99_0 then
				arg_96_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_99_11 = 0
			local var_99_12 = 0.45

			if var_99_11 < arg_96_1.time_ and arg_96_1.time_ <= var_99_11 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_13 = arg_96_1:FormatText(StoryNameCfg[1296].name)

				arg_96_1.leftNameTxt_.text = var_99_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_14 = arg_96_1:GetWordFromCfg(1104704024)
				local var_99_15 = arg_96_1:FormatText(var_99_14.content)

				arg_96_1.text_.text = var_99_15

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_16 = 18
				local var_99_17 = utf8.len(var_99_15)
				local var_99_18 = var_99_16 <= 0 and var_99_12 or var_99_12 * (var_99_17 / var_99_16)

				if var_99_18 > 0 and var_99_12 < var_99_18 then
					arg_96_1.talkMaxDuration = var_99_18

					if var_99_18 + var_99_11 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_18 + var_99_11
					end
				end

				arg_96_1.text_.text = var_99_15
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704024", "story_v_side_new_1104704.awb") ~= 0 then
					local var_99_19 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704024", "story_v_side_new_1104704.awb") / 1000

					if var_99_19 + var_99_11 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_19 + var_99_11
					end

					if var_99_14.prefab_name ~= "" and arg_96_1.actors_[var_99_14.prefab_name] ~= nil then
						local var_99_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_14.prefab_name].transform, "story_v_side_new_1104704", "1104704024", "story_v_side_new_1104704.awb")

						arg_96_1:RecordAudio("1104704024", var_99_20)
						arg_96_1:RecordAudio("1104704024", var_99_20)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704024", "story_v_side_new_1104704.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704024", "story_v_side_new_1104704.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_21 = math.max(var_99_12, arg_96_1.talkMaxDuration)

			if var_99_11 <= arg_96_1.time_ and arg_96_1.time_ < var_99_11 + var_99_21 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_11) / var_99_21

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_11 + var_99_21 and arg_96_1.time_ < var_99_11 + var_99_21 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play1104704025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1104704025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1104704026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1047ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1047ui_story == nil then
				arg_100_1.var_.characterEffect1047ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1047ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1047ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1047ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1047ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 0.55

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_9 = arg_100_1:GetWordFromCfg(1104704025)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 22
				local var_103_12 = utf8.len(var_103_10)
				local var_103_13 = var_103_11 <= 0 and var_103_7 or var_103_7 * (var_103_12 / var_103_11)

				if var_103_13 > 0 and var_103_7 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_10
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_14 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_14 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_14

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_14 and arg_100_1.time_ < var_103_6 + var_103_14 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play1104704026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1104704026
		arg_104_1.duration_ = 5.93

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1104704027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1047ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1047ui_story == nil then
				arg_104_1.var_.characterEffect1047ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1047ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1047ui_story then
				arg_104_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_107_4 = 0

			if var_107_4 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_107_6 = 0
			local var_107_7 = 0.575

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_8 = arg_104_1:FormatText(StoryNameCfg[1296].name)

				arg_104_1.leftNameTxt_.text = var_107_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_9 = arg_104_1:GetWordFromCfg(1104704026)
				local var_107_10 = arg_104_1:FormatText(var_107_9.content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 23
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704026", "story_v_side_new_1104704.awb") ~= 0 then
					local var_107_14 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704026", "story_v_side_new_1104704.awb") / 1000

					if var_107_14 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_6
					end

					if var_107_9.prefab_name ~= "" and arg_104_1.actors_[var_107_9.prefab_name] ~= nil then
						local var_107_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_9.prefab_name].transform, "story_v_side_new_1104704", "1104704026", "story_v_side_new_1104704.awb")

						arg_104_1:RecordAudio("1104704026", var_107_15)
						arg_104_1:RecordAudio("1104704026", var_107_15)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704026", "story_v_side_new_1104704.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704026", "story_v_side_new_1104704.awb")
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
	Play1104704027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1104704027
		arg_108_1.duration_ = 5.63

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1104704028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.675

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[1296].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:GetWordFromCfg(1104704027)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 27
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704027", "story_v_side_new_1104704.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704027", "story_v_side_new_1104704.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_side_new_1104704", "1104704027", "story_v_side_new_1104704.awb")

						arg_108_1:RecordAudio("1104704027", var_111_9)
						arg_108_1:RecordAudio("1104704027", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704027", "story_v_side_new_1104704.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704027", "story_v_side_new_1104704.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_10 and arg_108_1.time_ < var_111_0 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play1104704028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1104704028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1104704029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1047ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1047ui_story == nil then
				arg_112_1.var_.characterEffect1047ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1047ui_story and not isNil(var_115_0) then
					local var_115_4 = Mathf.Lerp(0, 0.5, var_115_3)

					arg_112_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1047ui_story.fillRatio = var_115_4
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1047ui_story then
				local var_115_5 = 0.5

				arg_112_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1047ui_story.fillRatio = var_115_5
			end

			local var_115_6 = arg_112_1.actors_["1047ui_story"].transform
			local var_115_7 = 0

			if var_115_7 < arg_112_1.time_ and arg_112_1.time_ <= var_115_7 + arg_115_0 then
				arg_112_1.var_.moveOldPos1047ui_story = var_115_6.localPosition
			end

			local var_115_8 = 0.001

			if var_115_7 <= arg_112_1.time_ and arg_112_1.time_ < var_115_7 + var_115_8 then
				local var_115_9 = (arg_112_1.time_ - var_115_7) / var_115_8
				local var_115_10 = Vector3.New(0, 100, 0)

				var_115_6.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1047ui_story, var_115_10, var_115_9)

				local var_115_11 = manager.ui.mainCamera.transform.position - var_115_6.position

				var_115_6.forward = Vector3.New(var_115_11.x, var_115_11.y, var_115_11.z)

				local var_115_12 = var_115_6.localEulerAngles

				var_115_12.z = 0
				var_115_12.x = 0
				var_115_6.localEulerAngles = var_115_12
			end

			if arg_112_1.time_ >= var_115_7 + var_115_8 and arg_112_1.time_ < var_115_7 + var_115_8 + arg_115_0 then
				var_115_6.localPosition = Vector3.New(0, 100, 0)

				local var_115_13 = manager.ui.mainCamera.transform.position - var_115_6.position

				var_115_6.forward = Vector3.New(var_115_13.x, var_115_13.y, var_115_13.z)

				local var_115_14 = var_115_6.localEulerAngles

				var_115_14.z = 0
				var_115_14.x = 0
				var_115_6.localEulerAngles = var_115_14
			end

			local var_115_15 = 0
			local var_115_16 = 0.125

			if var_115_15 < arg_112_1.time_ and arg_112_1.time_ <= var_115_15 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_17 = arg_112_1:FormatText(StoryNameCfg[7].name)

				arg_112_1.leftNameTxt_.text = var_115_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_18 = arg_112_1:GetWordFromCfg(1104704028)
				local var_115_19 = arg_112_1:FormatText(var_115_18.content)

				arg_112_1.text_.text = var_115_19

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_20 = 5
				local var_115_21 = utf8.len(var_115_19)
				local var_115_22 = var_115_20 <= 0 and var_115_16 or var_115_16 * (var_115_21 / var_115_20)

				if var_115_22 > 0 and var_115_16 < var_115_22 then
					arg_112_1.talkMaxDuration = var_115_22

					if var_115_22 + var_115_15 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_22 + var_115_15
					end
				end

				arg_112_1.text_.text = var_115_19
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_23 = math.max(var_115_16, arg_112_1.talkMaxDuration)

			if var_115_15 <= arg_112_1.time_ and arg_112_1.time_ < var_115_15 + var_115_23 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_15) / var_115_23

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_15 + var_115_23 and arg_112_1.time_ < var_115_15 + var_115_23 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play1104704029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1104704029
		arg_116_1.duration_ = 5.63

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1104704030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1047ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1047ui_story = var_119_0.localPosition
			end

			local var_119_2 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2
				local var_119_4 = Vector3.New(0, -1.13, -6.2)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1047ui_story, var_119_4, var_119_3)

				local var_119_5 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_5.x, var_119_5.y, var_119_5.z)

				local var_119_6 = var_119_0.localEulerAngles

				var_119_6.z = 0
				var_119_6.x = 0
				var_119_0.localEulerAngles = var_119_6
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_119_7 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_7.x, var_119_7.y, var_119_7.z)

				local var_119_8 = var_119_0.localEulerAngles

				var_119_8.z = 0
				var_119_8.x = 0
				var_119_0.localEulerAngles = var_119_8
			end

			local var_119_9 = arg_116_1.actors_["1047ui_story"]
			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1047ui_story == nil then
				arg_116_1.var_.characterEffect1047ui_story = var_119_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_11 = 0.200000002980232

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_11 and not isNil(var_119_9) then
				local var_119_12 = (arg_116_1.time_ - var_119_10) / var_119_11

				if arg_116_1.var_.characterEffect1047ui_story and not isNil(var_119_9) then
					arg_116_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_10 + var_119_11 and arg_116_1.time_ < var_119_10 + var_119_11 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1047ui_story then
				arg_116_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_119_13 = 0

			if var_119_13 < arg_116_1.time_ and arg_116_1.time_ <= var_119_13 + arg_119_0 then
				arg_116_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			local var_119_14 = 0

			if var_119_14 < arg_116_1.time_ and arg_116_1.time_ <= var_119_14 + arg_119_0 then
				arg_116_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_119_15 = 0
			local var_119_16 = 0.625

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_17 = arg_116_1:FormatText(StoryNameCfg[1296].name)

				arg_116_1.leftNameTxt_.text = var_119_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_18 = arg_116_1:GetWordFromCfg(1104704029)
				local var_119_19 = arg_116_1:FormatText(var_119_18.content)

				arg_116_1.text_.text = var_119_19

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_20 = 25
				local var_119_21 = utf8.len(var_119_19)
				local var_119_22 = var_119_20 <= 0 and var_119_16 or var_119_16 * (var_119_21 / var_119_20)

				if var_119_22 > 0 and var_119_16 < var_119_22 then
					arg_116_1.talkMaxDuration = var_119_22

					if var_119_22 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_22 + var_119_15
					end
				end

				arg_116_1.text_.text = var_119_19
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704029", "story_v_side_new_1104704.awb") ~= 0 then
					local var_119_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704029", "story_v_side_new_1104704.awb") / 1000

					if var_119_23 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_23 + var_119_15
					end

					if var_119_18.prefab_name ~= "" and arg_116_1.actors_[var_119_18.prefab_name] ~= nil then
						local var_119_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_18.prefab_name].transform, "story_v_side_new_1104704", "1104704029", "story_v_side_new_1104704.awb")

						arg_116_1:RecordAudio("1104704029", var_119_24)
						arg_116_1:RecordAudio("1104704029", var_119_24)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704029", "story_v_side_new_1104704.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704029", "story_v_side_new_1104704.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_25 = math.max(var_119_16, arg_116_1.talkMaxDuration)

			if var_119_15 <= arg_116_1.time_ and arg_116_1.time_ < var_119_15 + var_119_25 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_15) / var_119_25

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_15 + var_119_25 and arg_116_1.time_ < var_119_15 + var_119_25 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play1104704030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1104704030
		arg_120_1.duration_ = 10.13

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1104704031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 1.075

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[1296].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_3 = arg_120_1:GetWordFromCfg(1104704030)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 43
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704030", "story_v_side_new_1104704.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704030", "story_v_side_new_1104704.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_side_new_1104704", "1104704030", "story_v_side_new_1104704.awb")

						arg_120_1:RecordAudio("1104704030", var_123_9)
						arg_120_1:RecordAudio("1104704030", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704030", "story_v_side_new_1104704.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704030", "story_v_side_new_1104704.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1104704031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1104704031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1104704032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1047ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1047ui_story == nil then
				arg_124_1.var_.characterEffect1047ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect1047ui_story and not isNil(var_127_0) then
					local var_127_4 = Mathf.Lerp(0, 0.5, var_127_3)

					arg_124_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1047ui_story.fillRatio = var_127_4
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1047ui_story then
				local var_127_5 = 0.5

				arg_124_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1047ui_story.fillRatio = var_127_5
			end

			local var_127_6 = 0
			local var_127_7 = 0.525

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_8 = arg_124_1:FormatText(StoryNameCfg[7].name)

				arg_124_1.leftNameTxt_.text = var_127_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_9 = arg_124_1:GetWordFromCfg(1104704031)
				local var_127_10 = arg_124_1:FormatText(var_127_9.content)

				arg_124_1.text_.text = var_127_10

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_11 = 21
				local var_127_12 = utf8.len(var_127_10)
				local var_127_13 = var_127_11 <= 0 and var_127_7 or var_127_7 * (var_127_12 / var_127_11)

				if var_127_13 > 0 and var_127_7 < var_127_13 then
					arg_124_1.talkMaxDuration = var_127_13

					if var_127_13 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_10
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_14 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_14 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_14

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_14 and arg_124_1.time_ < var_127_6 + var_127_14 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play1104704032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1104704032
		arg_128_1.duration_ = 4

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1104704033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1047ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos1047ui_story = var_131_0.localPosition
			end

			local var_131_2 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2
				local var_131_4 = Vector3.New(0, -1.13, -6.2)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1047ui_story, var_131_4, var_131_3)

				local var_131_5 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_5.x, var_131_5.y, var_131_5.z)

				local var_131_6 = var_131_0.localEulerAngles

				var_131_6.z = 0
				var_131_6.x = 0
				var_131_0.localEulerAngles = var_131_6
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_131_7 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_7.x, var_131_7.y, var_131_7.z)

				local var_131_8 = var_131_0.localEulerAngles

				var_131_8.z = 0
				var_131_8.x = 0
				var_131_0.localEulerAngles = var_131_8
			end

			local var_131_9 = arg_128_1.actors_["1047ui_story"]
			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect1047ui_story == nil then
				arg_128_1.var_.characterEffect1047ui_story = var_131_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_11 = 0.200000002980232

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_11 and not isNil(var_131_9) then
				local var_131_12 = (arg_128_1.time_ - var_131_10) / var_131_11

				if arg_128_1.var_.characterEffect1047ui_story and not isNil(var_131_9) then
					arg_128_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_10 + var_131_11 and arg_128_1.time_ < var_131_10 + var_131_11 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect1047ui_story then
				arg_128_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_131_13 = 0

			if var_131_13 < arg_128_1.time_ and arg_128_1.time_ <= var_131_13 + arg_131_0 then
				arg_128_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action437")
			end

			local var_131_14 = 0

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_131_15 = 0
			local var_131_16 = 0.45

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_17 = arg_128_1:FormatText(StoryNameCfg[1296].name)

				arg_128_1.leftNameTxt_.text = var_131_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_18 = arg_128_1:GetWordFromCfg(1104704032)
				local var_131_19 = arg_128_1:FormatText(var_131_18.content)

				arg_128_1.text_.text = var_131_19

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_20 = 18
				local var_131_21 = utf8.len(var_131_19)
				local var_131_22 = var_131_20 <= 0 and var_131_16 or var_131_16 * (var_131_21 / var_131_20)

				if var_131_22 > 0 and var_131_16 < var_131_22 then
					arg_128_1.talkMaxDuration = var_131_22

					if var_131_22 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_22 + var_131_15
					end
				end

				arg_128_1.text_.text = var_131_19
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704032", "story_v_side_new_1104704.awb") ~= 0 then
					local var_131_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704032", "story_v_side_new_1104704.awb") / 1000

					if var_131_23 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_15
					end

					if var_131_18.prefab_name ~= "" and arg_128_1.actors_[var_131_18.prefab_name] ~= nil then
						local var_131_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_18.prefab_name].transform, "story_v_side_new_1104704", "1104704032", "story_v_side_new_1104704.awb")

						arg_128_1:RecordAudio("1104704032", var_131_24)
						arg_128_1:RecordAudio("1104704032", var_131_24)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704032", "story_v_side_new_1104704.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704032", "story_v_side_new_1104704.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_25 = math.max(var_131_16, arg_128_1.talkMaxDuration)

			if var_131_15 <= arg_128_1.time_ and arg_128_1.time_ < var_131_15 + var_131_25 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_15) / var_131_25

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_15 + var_131_25 and arg_128_1.time_ < var_131_15 + var_131_25 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play1104704033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1104704033
		arg_132_1.duration_ = 12.5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1104704034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1047ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos1047ui_story = var_135_0.localPosition
			end

			local var_135_2 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2
				local var_135_4 = Vector3.New(0, -1.13, -6.2)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1047ui_story, var_135_4, var_135_3)

				local var_135_5 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_5.x, var_135_5.y, var_135_5.z)

				local var_135_6 = var_135_0.localEulerAngles

				var_135_6.z = 0
				var_135_6.x = 0
				var_135_0.localEulerAngles = var_135_6
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_135_7 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_7.x, var_135_7.y, var_135_7.z)

				local var_135_8 = var_135_0.localEulerAngles

				var_135_8.z = 0
				var_135_8.x = 0
				var_135_0.localEulerAngles = var_135_8
			end

			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 then
				arg_132_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_135_11 = 0
			local var_135_12 = 1.475

			if var_135_11 < arg_132_1.time_ and arg_132_1.time_ <= var_135_11 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_13 = arg_132_1:FormatText(StoryNameCfg[1296].name)

				arg_132_1.leftNameTxt_.text = var_135_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_14 = arg_132_1:GetWordFromCfg(1104704033)
				local var_135_15 = arg_132_1:FormatText(var_135_14.content)

				arg_132_1.text_.text = var_135_15

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_16 = 59
				local var_135_17 = utf8.len(var_135_15)
				local var_135_18 = var_135_16 <= 0 and var_135_12 or var_135_12 * (var_135_17 / var_135_16)

				if var_135_18 > 0 and var_135_12 < var_135_18 then
					arg_132_1.talkMaxDuration = var_135_18

					if var_135_18 + var_135_11 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_18 + var_135_11
					end
				end

				arg_132_1.text_.text = var_135_15
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704033", "story_v_side_new_1104704.awb") ~= 0 then
					local var_135_19 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704033", "story_v_side_new_1104704.awb") / 1000

					if var_135_19 + var_135_11 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_19 + var_135_11
					end

					if var_135_14.prefab_name ~= "" and arg_132_1.actors_[var_135_14.prefab_name] ~= nil then
						local var_135_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_14.prefab_name].transform, "story_v_side_new_1104704", "1104704033", "story_v_side_new_1104704.awb")

						arg_132_1:RecordAudio("1104704033", var_135_20)
						arg_132_1:RecordAudio("1104704033", var_135_20)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704033", "story_v_side_new_1104704.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704033", "story_v_side_new_1104704.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_21 = math.max(var_135_12, arg_132_1.talkMaxDuration)

			if var_135_11 <= arg_132_1.time_ and arg_132_1.time_ < var_135_11 + var_135_21 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_11) / var_135_21

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_11 + var_135_21 and arg_132_1.time_ < var_135_11 + var_135_21 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play1104704034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1104704034
		arg_136_1.duration_ = 5.7

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1104704035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.55

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[1296].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:GetWordFromCfg(1104704034)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 22
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704034", "story_v_side_new_1104704.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704034", "story_v_side_new_1104704.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_side_new_1104704", "1104704034", "story_v_side_new_1104704.awb")

						arg_136_1:RecordAudio("1104704034", var_139_9)
						arg_136_1:RecordAudio("1104704034", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704034", "story_v_side_new_1104704.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704034", "story_v_side_new_1104704.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_10 and arg_136_1.time_ < var_139_0 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play1104704035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1104704035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1104704036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1047ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1047ui_story == nil then
				arg_140_1.var_.characterEffect1047ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1047ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1047ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1047ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1047ui_story.fillRatio = var_143_5
			end

			local var_143_6 = 0
			local var_143_7 = 0.05

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_8 = arg_140_1:FormatText(StoryNameCfg[7].name)

				arg_140_1.leftNameTxt_.text = var_143_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_9 = arg_140_1:GetWordFromCfg(1104704035)
				local var_143_10 = arg_140_1:FormatText(var_143_9.content)

				arg_140_1.text_.text = var_143_10

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 2
				local var_143_12 = utf8.len(var_143_10)
				local var_143_13 = var_143_11 <= 0 and var_143_7 or var_143_7 * (var_143_12 / var_143_11)

				if var_143_13 > 0 and var_143_7 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_10
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_14 and arg_140_1.time_ < var_143_6 + var_143_14 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play1104704036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1104704036
		arg_144_1.duration_ = 17.5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1104704037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1047ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1047ui_story == nil then
				arg_144_1.var_.characterEffect1047ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1047ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1047ui_story then
				arg_144_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_147_4 = 0

			if var_147_4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 then
				arg_144_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_147_6 = 0
			local var_147_7 = 1.6

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_8 = arg_144_1:FormatText(StoryNameCfg[1296].name)

				arg_144_1.leftNameTxt_.text = var_147_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_9 = arg_144_1:GetWordFromCfg(1104704036)
				local var_147_10 = arg_144_1:FormatText(var_147_9.content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 64
				local var_147_12 = utf8.len(var_147_10)
				local var_147_13 = var_147_11 <= 0 and var_147_7 or var_147_7 * (var_147_12 / var_147_11)

				if var_147_13 > 0 and var_147_7 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13

					if var_147_13 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_6
					end
				end

				arg_144_1.text_.text = var_147_10
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704036", "story_v_side_new_1104704.awb") ~= 0 then
					local var_147_14 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704036", "story_v_side_new_1104704.awb") / 1000

					if var_147_14 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_14 + var_147_6
					end

					if var_147_9.prefab_name ~= "" and arg_144_1.actors_[var_147_9.prefab_name] ~= nil then
						local var_147_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_9.prefab_name].transform, "story_v_side_new_1104704", "1104704036", "story_v_side_new_1104704.awb")

						arg_144_1:RecordAudio("1104704036", var_147_15)
						arg_144_1:RecordAudio("1104704036", var_147_15)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704036", "story_v_side_new_1104704.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704036", "story_v_side_new_1104704.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_16 = math.max(var_147_7, arg_144_1.talkMaxDuration)

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_16 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_6) / var_147_16

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_6 + var_147_16 and arg_144_1.time_ < var_147_6 + var_147_16 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1104704037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1104704037
		arg_148_1.duration_ = 5.3

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1104704038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1047ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1047ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0, -1.13, -6.2)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1047ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = 0

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 then
				arg_148_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 then
				arg_148_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_151_11 = 0
			local var_151_12 = 0.6

			if var_151_11 < arg_148_1.time_ and arg_148_1.time_ <= var_151_11 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_13 = arg_148_1:FormatText(StoryNameCfg[1296].name)

				arg_148_1.leftNameTxt_.text = var_151_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_14 = arg_148_1:GetWordFromCfg(1104704037)
				local var_151_15 = arg_148_1:FormatText(var_151_14.content)

				arg_148_1.text_.text = var_151_15

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_16 = 24
				local var_151_17 = utf8.len(var_151_15)
				local var_151_18 = var_151_16 <= 0 and var_151_12 or var_151_12 * (var_151_17 / var_151_16)

				if var_151_18 > 0 and var_151_12 < var_151_18 then
					arg_148_1.talkMaxDuration = var_151_18

					if var_151_18 + var_151_11 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_18 + var_151_11
					end
				end

				arg_148_1.text_.text = var_151_15
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704037", "story_v_side_new_1104704.awb") ~= 0 then
					local var_151_19 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704037", "story_v_side_new_1104704.awb") / 1000

					if var_151_19 + var_151_11 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_19 + var_151_11
					end

					if var_151_14.prefab_name ~= "" and arg_148_1.actors_[var_151_14.prefab_name] ~= nil then
						local var_151_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_14.prefab_name].transform, "story_v_side_new_1104704", "1104704037", "story_v_side_new_1104704.awb")

						arg_148_1:RecordAudio("1104704037", var_151_20)
						arg_148_1:RecordAudio("1104704037", var_151_20)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704037", "story_v_side_new_1104704.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704037", "story_v_side_new_1104704.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_21 = math.max(var_151_12, arg_148_1.talkMaxDuration)

			if var_151_11 <= arg_148_1.time_ and arg_148_1.time_ < var_151_11 + var_151_21 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_11) / var_151_21

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_11 + var_151_21 and arg_148_1.time_ < var_151_11 + var_151_21 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play1104704038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1104704038
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1104704039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1047ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1047ui_story == nil then
				arg_152_1.var_.characterEffect1047ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect1047ui_story and not isNil(var_155_0) then
					local var_155_4 = Mathf.Lerp(0, 0.5, var_155_3)

					arg_152_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1047ui_story.fillRatio = var_155_4
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1047ui_story then
				local var_155_5 = 0.5

				arg_152_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1047ui_story.fillRatio = var_155_5
			end

			local var_155_6 = 0
			local var_155_7 = 0.3

			if var_155_6 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_8 = arg_152_1:FormatText(StoryNameCfg[7].name)

				arg_152_1.leftNameTxt_.text = var_155_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_9 = arg_152_1:GetWordFromCfg(1104704038)
				local var_155_10 = arg_152_1:FormatText(var_155_9.content)

				arg_152_1.text_.text = var_155_10

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_11 = 12
				local var_155_12 = utf8.len(var_155_10)
				local var_155_13 = var_155_11 <= 0 and var_155_7 or var_155_7 * (var_155_12 / var_155_11)

				if var_155_13 > 0 and var_155_7 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_10
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_14 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_14 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_14

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_14 and arg_152_1.time_ < var_155_6 + var_155_14 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play1104704039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1104704039
		arg_156_1.duration_ = 4.77

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1104704040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1047ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos1047ui_story = var_159_0.localPosition
			end

			local var_159_2 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2
				local var_159_4 = Vector3.New(0, -1.13, -6.2)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1047ui_story, var_159_4, var_159_3)

				local var_159_5 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_5.x, var_159_5.y, var_159_5.z)

				local var_159_6 = var_159_0.localEulerAngles

				var_159_6.z = 0
				var_159_6.x = 0
				var_159_0.localEulerAngles = var_159_6
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_159_7 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_7.x, var_159_7.y, var_159_7.z)

				local var_159_8 = var_159_0.localEulerAngles

				var_159_8.z = 0
				var_159_8.x = 0
				var_159_0.localEulerAngles = var_159_8
			end

			local var_159_9 = arg_156_1.actors_["1047ui_story"]
			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1047ui_story == nil then
				arg_156_1.var_.characterEffect1047ui_story = var_159_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_11 = 0.200000002980232

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 and not isNil(var_159_9) then
				local var_159_12 = (arg_156_1.time_ - var_159_10) / var_159_11

				if arg_156_1.var_.characterEffect1047ui_story and not isNil(var_159_9) then
					arg_156_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1047ui_story then
				arg_156_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_159_13 = 0

			if var_159_13 < arg_156_1.time_ and arg_156_1.time_ <= var_159_13 + arg_159_0 then
				arg_156_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action464")
			end

			local var_159_14 = 0

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_159_15 = 0
			local var_159_16 = 0.4

			if var_159_15 < arg_156_1.time_ and arg_156_1.time_ <= var_159_15 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_17 = arg_156_1:FormatText(StoryNameCfg[1296].name)

				arg_156_1.leftNameTxt_.text = var_159_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_18 = arg_156_1:GetWordFromCfg(1104704039)
				local var_159_19 = arg_156_1:FormatText(var_159_18.content)

				arg_156_1.text_.text = var_159_19

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_20 = 16
				local var_159_21 = utf8.len(var_159_19)
				local var_159_22 = var_159_20 <= 0 and var_159_16 or var_159_16 * (var_159_21 / var_159_20)

				if var_159_22 > 0 and var_159_16 < var_159_22 then
					arg_156_1.talkMaxDuration = var_159_22

					if var_159_22 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_22 + var_159_15
					end
				end

				arg_156_1.text_.text = var_159_19
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704039", "story_v_side_new_1104704.awb") ~= 0 then
					local var_159_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704039", "story_v_side_new_1104704.awb") / 1000

					if var_159_23 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_23 + var_159_15
					end

					if var_159_18.prefab_name ~= "" and arg_156_1.actors_[var_159_18.prefab_name] ~= nil then
						local var_159_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_18.prefab_name].transform, "story_v_side_new_1104704", "1104704039", "story_v_side_new_1104704.awb")

						arg_156_1:RecordAudio("1104704039", var_159_24)
						arg_156_1:RecordAudio("1104704039", var_159_24)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704039", "story_v_side_new_1104704.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704039", "story_v_side_new_1104704.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_25 = math.max(var_159_16, arg_156_1.talkMaxDuration)

			if var_159_15 <= arg_156_1.time_ and arg_156_1.time_ < var_159_15 + var_159_25 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_15) / var_159_25

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_15 + var_159_25 and arg_156_1.time_ < var_159_15 + var_159_25 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play1104704040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1104704040
		arg_160_1.duration_ = 5.13

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1104704041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1047ui_story"].transform
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.var_.moveOldPos1047ui_story = var_163_0.localPosition
			end

			local var_163_2 = 0.001

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2
				local var_163_4 = Vector3.New(0, -1.13, -6.2)

				var_163_0.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1047ui_story, var_163_4, var_163_3)

				local var_163_5 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_5.x, var_163_5.y, var_163_5.z)

				local var_163_6 = var_163_0.localEulerAngles

				var_163_6.z = 0
				var_163_6.x = 0
				var_163_0.localEulerAngles = var_163_6
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 then
				var_163_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_163_7 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_7.x, var_163_7.y, var_163_7.z)

				local var_163_8 = var_163_0.localEulerAngles

				var_163_8.z = 0
				var_163_8.x = 0
				var_163_0.localEulerAngles = var_163_8
			end

			local var_163_9 = 0

			if var_163_9 < arg_160_1.time_ and arg_160_1.time_ <= var_163_9 + arg_163_0 then
				arg_160_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			local var_163_10 = 0

			if var_163_10 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				arg_160_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_163_11 = 0
			local var_163_12 = 0.475

			if var_163_11 < arg_160_1.time_ and arg_160_1.time_ <= var_163_11 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_13 = arg_160_1:FormatText(StoryNameCfg[1296].name)

				arg_160_1.leftNameTxt_.text = var_163_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_14 = arg_160_1:GetWordFromCfg(1104704040)
				local var_163_15 = arg_160_1:FormatText(var_163_14.content)

				arg_160_1.text_.text = var_163_15

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_16 = 19
				local var_163_17 = utf8.len(var_163_15)
				local var_163_18 = var_163_16 <= 0 and var_163_12 or var_163_12 * (var_163_17 / var_163_16)

				if var_163_18 > 0 and var_163_12 < var_163_18 then
					arg_160_1.talkMaxDuration = var_163_18

					if var_163_18 + var_163_11 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_18 + var_163_11
					end
				end

				arg_160_1.text_.text = var_163_15
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704040", "story_v_side_new_1104704.awb") ~= 0 then
					local var_163_19 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704040", "story_v_side_new_1104704.awb") / 1000

					if var_163_19 + var_163_11 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_19 + var_163_11
					end

					if var_163_14.prefab_name ~= "" and arg_160_1.actors_[var_163_14.prefab_name] ~= nil then
						local var_163_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_14.prefab_name].transform, "story_v_side_new_1104704", "1104704040", "story_v_side_new_1104704.awb")

						arg_160_1:RecordAudio("1104704040", var_163_20)
						arg_160_1:RecordAudio("1104704040", var_163_20)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704040", "story_v_side_new_1104704.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704040", "story_v_side_new_1104704.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_21 = math.max(var_163_12, arg_160_1.talkMaxDuration)

			if var_163_11 <= arg_160_1.time_ and arg_160_1.time_ < var_163_11 + var_163_21 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_11) / var_163_21

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_11 + var_163_21 and arg_160_1.time_ < var_163_11 + var_163_21 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play1104704041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1104704041
		arg_164_1.duration_ = 4.67

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1104704042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.525

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[1296].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_3 = arg_164_1:GetWordFromCfg(1104704041)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 21
				local var_167_6 = utf8.len(var_167_4)
				local var_167_7 = var_167_5 <= 0 and var_167_1 or var_167_1 * (var_167_6 / var_167_5)

				if var_167_7 > 0 and var_167_1 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704041", "story_v_side_new_1104704.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704041", "story_v_side_new_1104704.awb") / 1000

					if var_167_8 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_0
					end

					if var_167_3.prefab_name ~= "" and arg_164_1.actors_[var_167_3.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_3.prefab_name].transform, "story_v_side_new_1104704", "1104704041", "story_v_side_new_1104704.awb")

						arg_164_1:RecordAudio("1104704041", var_167_9)
						arg_164_1:RecordAudio("1104704041", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704041", "story_v_side_new_1104704.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704041", "story_v_side_new_1104704.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_10 and arg_164_1.time_ < var_167_0 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play1104704042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1104704042
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1104704043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1047ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1047ui_story == nil then
				arg_168_1.var_.characterEffect1047ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1047ui_story and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1047ui_story.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1047ui_story then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1047ui_story.fillRatio = var_171_5
			end

			local var_171_6 = 0
			local var_171_7 = 0.25

			if var_171_6 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_8 = arg_168_1:FormatText(StoryNameCfg[7].name)

				arg_168_1.leftNameTxt_.text = var_171_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_9 = arg_168_1:GetWordFromCfg(1104704042)
				local var_171_10 = arg_168_1:FormatText(var_171_9.content)

				arg_168_1.text_.text = var_171_10

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 10
				local var_171_12 = utf8.len(var_171_10)
				local var_171_13 = var_171_11 <= 0 and var_171_7 or var_171_7 * (var_171_12 / var_171_11)

				if var_171_13 > 0 and var_171_7 < var_171_13 then
					arg_168_1.talkMaxDuration = var_171_13

					if var_171_13 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_10
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_14 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_14 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_14

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_14 and arg_168_1.time_ < var_171_6 + var_171_14 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1104704043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1104704043
		arg_172_1.duration_ = 2

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1104704044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1047ui_story"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos1047ui_story = var_175_0.localPosition
			end

			local var_175_2 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2
				local var_175_4 = Vector3.New(0, -1.13, -6.2)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1047ui_story, var_175_4, var_175_3)

				local var_175_5 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_5.x, var_175_5.y, var_175_5.z)

				local var_175_6 = var_175_0.localEulerAngles

				var_175_6.z = 0
				var_175_6.x = 0
				var_175_0.localEulerAngles = var_175_6
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_175_7 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_7.x, var_175_7.y, var_175_7.z)

				local var_175_8 = var_175_0.localEulerAngles

				var_175_8.z = 0
				var_175_8.x = 0
				var_175_0.localEulerAngles = var_175_8
			end

			local var_175_9 = arg_172_1.actors_["1047ui_story"]
			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 and not isNil(var_175_9) and arg_172_1.var_.characterEffect1047ui_story == nil then
				arg_172_1.var_.characterEffect1047ui_story = var_175_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_11 = 0.200000002980232

			if var_175_10 <= arg_172_1.time_ and arg_172_1.time_ < var_175_10 + var_175_11 and not isNil(var_175_9) then
				local var_175_12 = (arg_172_1.time_ - var_175_10) / var_175_11

				if arg_172_1.var_.characterEffect1047ui_story and not isNil(var_175_9) then
					arg_172_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_10 + var_175_11 and arg_172_1.time_ < var_175_10 + var_175_11 + arg_175_0 and not isNil(var_175_9) and arg_172_1.var_.characterEffect1047ui_story then
				arg_172_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_175_13 = 0

			if var_175_13 < arg_172_1.time_ and arg_172_1.time_ <= var_175_13 + arg_175_0 then
				arg_172_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			local var_175_14 = 0

			if var_175_14 < arg_172_1.time_ and arg_172_1.time_ <= var_175_14 + arg_175_0 then
				arg_172_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_175_15 = 0
			local var_175_16 = 0.05

			if var_175_15 < arg_172_1.time_ and arg_172_1.time_ <= var_175_15 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_17 = arg_172_1:FormatText(StoryNameCfg[1296].name)

				arg_172_1.leftNameTxt_.text = var_175_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_18 = arg_172_1:GetWordFromCfg(1104704043)
				local var_175_19 = arg_172_1:FormatText(var_175_18.content)

				arg_172_1.text_.text = var_175_19

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_20 = 2
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704043", "story_v_side_new_1104704.awb") ~= 0 then
					local var_175_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704043", "story_v_side_new_1104704.awb") / 1000

					if var_175_23 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_23 + var_175_15
					end

					if var_175_18.prefab_name ~= "" and arg_172_1.actors_[var_175_18.prefab_name] ~= nil then
						local var_175_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_18.prefab_name].transform, "story_v_side_new_1104704", "1104704043", "story_v_side_new_1104704.awb")

						arg_172_1:RecordAudio("1104704043", var_175_24)
						arg_172_1:RecordAudio("1104704043", var_175_24)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704043", "story_v_side_new_1104704.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704043", "story_v_side_new_1104704.awb")
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play1104704044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1104704044
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1104704045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1047ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1047ui_story == nil then
				arg_176_1.var_.characterEffect1047ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1047ui_story and not isNil(var_179_0) then
					local var_179_4 = Mathf.Lerp(0, 0.5, var_179_3)

					arg_176_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1047ui_story.fillRatio = var_179_4
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1047ui_story then
				local var_179_5 = 0.5

				arg_176_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1047ui_story.fillRatio = var_179_5
			end

			local var_179_6 = arg_176_1.actors_["1047ui_story"].transform
			local var_179_7 = 0

			if var_179_7 < arg_176_1.time_ and arg_176_1.time_ <= var_179_7 + arg_179_0 then
				arg_176_1.var_.moveOldPos1047ui_story = var_179_6.localPosition
			end

			local var_179_8 = 0.001

			if var_179_7 <= arg_176_1.time_ and arg_176_1.time_ < var_179_7 + var_179_8 then
				local var_179_9 = (arg_176_1.time_ - var_179_7) / var_179_8
				local var_179_10 = Vector3.New(0, 100, 0)

				var_179_6.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1047ui_story, var_179_10, var_179_9)

				local var_179_11 = manager.ui.mainCamera.transform.position - var_179_6.position

				var_179_6.forward = Vector3.New(var_179_11.x, var_179_11.y, var_179_11.z)

				local var_179_12 = var_179_6.localEulerAngles

				var_179_12.z = 0
				var_179_12.x = 0
				var_179_6.localEulerAngles = var_179_12
			end

			if arg_176_1.time_ >= var_179_7 + var_179_8 and arg_176_1.time_ < var_179_7 + var_179_8 + arg_179_0 then
				var_179_6.localPosition = Vector3.New(0, 100, 0)

				local var_179_13 = manager.ui.mainCamera.transform.position - var_179_6.position

				var_179_6.forward = Vector3.New(var_179_13.x, var_179_13.y, var_179_13.z)

				local var_179_14 = var_179_6.localEulerAngles

				var_179_14.z = 0
				var_179_14.x = 0
				var_179_6.localEulerAngles = var_179_14
			end

			local var_179_15 = 0
			local var_179_16 = 0.55

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_17 = arg_176_1:GetWordFromCfg(1104704044)
				local var_179_18 = arg_176_1:FormatText(var_179_17.content)

				arg_176_1.text_.text = var_179_18

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_19 = 22
				local var_179_20 = utf8.len(var_179_18)
				local var_179_21 = var_179_19 <= 0 and var_179_16 or var_179_16 * (var_179_20 / var_179_19)

				if var_179_21 > 0 and var_179_16 < var_179_21 then
					arg_176_1.talkMaxDuration = var_179_21

					if var_179_21 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_21 + var_179_15
					end
				end

				arg_176_1.text_.text = var_179_18
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_22 = math.max(var_179_16, arg_176_1.talkMaxDuration)

			if var_179_15 <= arg_176_1.time_ and arg_176_1.time_ < var_179_15 + var_179_22 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_15) / var_179_22

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_15 + var_179_22 and arg_176_1.time_ < var_179_15 + var_179_22 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play1104704045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1104704045
		arg_180_1.duration_ = 6.63

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1104704046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1047ui_story"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos1047ui_story = var_183_0.localPosition
			end

			local var_183_2 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2
				local var_183_4 = Vector3.New(0, -1.13, -6.2)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1047ui_story, var_183_4, var_183_3)

				local var_183_5 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_5.x, var_183_5.y, var_183_5.z)

				local var_183_6 = var_183_0.localEulerAngles

				var_183_6.z = 0
				var_183_6.x = 0
				var_183_0.localEulerAngles = var_183_6
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_183_7 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_7.x, var_183_7.y, var_183_7.z)

				local var_183_8 = var_183_0.localEulerAngles

				var_183_8.z = 0
				var_183_8.x = 0
				var_183_0.localEulerAngles = var_183_8
			end

			local var_183_9 = arg_180_1.actors_["1047ui_story"]
			local var_183_10 = 0

			if var_183_10 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 and not isNil(var_183_9) and arg_180_1.var_.characterEffect1047ui_story == nil then
				arg_180_1.var_.characterEffect1047ui_story = var_183_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_11 = 0.200000002980232

			if var_183_10 <= arg_180_1.time_ and arg_180_1.time_ < var_183_10 + var_183_11 and not isNil(var_183_9) then
				local var_183_12 = (arg_180_1.time_ - var_183_10) / var_183_11

				if arg_180_1.var_.characterEffect1047ui_story and not isNil(var_183_9) then
					arg_180_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_10 + var_183_11 and arg_180_1.time_ < var_183_10 + var_183_11 + arg_183_0 and not isNil(var_183_9) and arg_180_1.var_.characterEffect1047ui_story then
				arg_180_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_183_13 = 0

			if var_183_13 < arg_180_1.time_ and arg_180_1.time_ <= var_183_13 + arg_183_0 then
				arg_180_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			local var_183_14 = 0

			if var_183_14 < arg_180_1.time_ and arg_180_1.time_ <= var_183_14 + arg_183_0 then
				arg_180_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_183_15 = 0
			local var_183_16 = 0.575

			if var_183_15 < arg_180_1.time_ and arg_180_1.time_ <= var_183_15 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_17 = arg_180_1:FormatText(StoryNameCfg[1296].name)

				arg_180_1.leftNameTxt_.text = var_183_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_18 = arg_180_1:GetWordFromCfg(1104704045)
				local var_183_19 = arg_180_1:FormatText(var_183_18.content)

				arg_180_1.text_.text = var_183_19

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_20 = 23
				local var_183_21 = utf8.len(var_183_19)
				local var_183_22 = var_183_20 <= 0 and var_183_16 or var_183_16 * (var_183_21 / var_183_20)

				if var_183_22 > 0 and var_183_16 < var_183_22 then
					arg_180_1.talkMaxDuration = var_183_22

					if var_183_22 + var_183_15 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_22 + var_183_15
					end
				end

				arg_180_1.text_.text = var_183_19
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704045", "story_v_side_new_1104704.awb") ~= 0 then
					local var_183_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704045", "story_v_side_new_1104704.awb") / 1000

					if var_183_23 + var_183_15 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_23 + var_183_15
					end

					if var_183_18.prefab_name ~= "" and arg_180_1.actors_[var_183_18.prefab_name] ~= nil then
						local var_183_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_18.prefab_name].transform, "story_v_side_new_1104704", "1104704045", "story_v_side_new_1104704.awb")

						arg_180_1:RecordAudio("1104704045", var_183_24)
						arg_180_1:RecordAudio("1104704045", var_183_24)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704045", "story_v_side_new_1104704.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704045", "story_v_side_new_1104704.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_25 = math.max(var_183_16, arg_180_1.talkMaxDuration)

			if var_183_15 <= arg_180_1.time_ and arg_180_1.time_ < var_183_15 + var_183_25 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_15) / var_183_25

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_15 + var_183_25 and arg_180_1.time_ < var_183_15 + var_183_25 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play1104704046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1104704046
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1104704047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1047ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1047ui_story == nil then
				arg_184_1.var_.characterEffect1047ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1047ui_story and not isNil(var_187_0) then
					local var_187_4 = Mathf.Lerp(0, 0.5, var_187_3)

					arg_184_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1047ui_story.fillRatio = var_187_4
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1047ui_story then
				local var_187_5 = 0.5

				arg_184_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1047ui_story.fillRatio = var_187_5
			end

			local var_187_6 = arg_184_1.actors_["1047ui_story"].transform
			local var_187_7 = 0

			if var_187_7 < arg_184_1.time_ and arg_184_1.time_ <= var_187_7 + arg_187_0 then
				arg_184_1.var_.moveOldPos1047ui_story = var_187_6.localPosition
			end

			local var_187_8 = 0.001

			if var_187_7 <= arg_184_1.time_ and arg_184_1.time_ < var_187_7 + var_187_8 then
				local var_187_9 = (arg_184_1.time_ - var_187_7) / var_187_8
				local var_187_10 = Vector3.New(0, 100, 0)

				var_187_6.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1047ui_story, var_187_10, var_187_9)

				local var_187_11 = manager.ui.mainCamera.transform.position - var_187_6.position

				var_187_6.forward = Vector3.New(var_187_11.x, var_187_11.y, var_187_11.z)

				local var_187_12 = var_187_6.localEulerAngles

				var_187_12.z = 0
				var_187_12.x = 0
				var_187_6.localEulerAngles = var_187_12
			end

			if arg_184_1.time_ >= var_187_7 + var_187_8 and arg_184_1.time_ < var_187_7 + var_187_8 + arg_187_0 then
				var_187_6.localPosition = Vector3.New(0, 100, 0)

				local var_187_13 = manager.ui.mainCamera.transform.position - var_187_6.position

				var_187_6.forward = Vector3.New(var_187_13.x, var_187_13.y, var_187_13.z)

				local var_187_14 = var_187_6.localEulerAngles

				var_187_14.z = 0
				var_187_14.x = 0
				var_187_6.localEulerAngles = var_187_14
			end

			local var_187_15 = 0
			local var_187_16 = 0.075

			if var_187_15 < arg_184_1.time_ and arg_184_1.time_ <= var_187_15 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_17 = arg_184_1:FormatText(StoryNameCfg[7].name)

				arg_184_1.leftNameTxt_.text = var_187_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_18 = arg_184_1:GetWordFromCfg(1104704046)
				local var_187_19 = arg_184_1:FormatText(var_187_18.content)

				arg_184_1.text_.text = var_187_19

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_20 = 3
				local var_187_21 = utf8.len(var_187_19)
				local var_187_22 = var_187_20 <= 0 and var_187_16 or var_187_16 * (var_187_21 / var_187_20)

				if var_187_22 > 0 and var_187_16 < var_187_22 then
					arg_184_1.talkMaxDuration = var_187_22

					if var_187_22 + var_187_15 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_22 + var_187_15
					end
				end

				arg_184_1.text_.text = var_187_19
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_23 = math.max(var_187_16, arg_184_1.talkMaxDuration)

			if var_187_15 <= arg_184_1.time_ and arg_184_1.time_ < var_187_15 + var_187_23 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_15) / var_187_23

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_15 + var_187_23 and arg_184_1.time_ < var_187_15 + var_187_23 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play1104704047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1104704047
		arg_188_1.duration_ = 1

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"

			SetActive(arg_188_1.choicesGo_, true)

			for iter_189_0, iter_189_1 in ipairs(arg_188_1.choices_) do
				local var_189_0 = iter_189_0 <= 2

				SetActive(iter_189_1.go, var_189_0)
			end

			arg_188_1.choices_[1].txt.text = arg_188_1:FormatText(StoryChoiceCfg[1659].name)
			arg_188_1.choices_[2].txt.text = arg_188_1:FormatText(StoryChoiceCfg[1660].name)
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1104704048(arg_188_1)
			end

			if arg_190_0 == 2 then
				arg_188_0:Play1104704048(arg_188_1)
			end

			arg_188_1:RecordChoiceLog(1104704047, 1659, 1660)
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.allBtn_.enabled = false
			end

			local var_191_1 = 1

			if arg_188_1.time_ >= var_191_0 + var_191_1 and arg_188_1.time_ < var_191_0 + var_191_1 + arg_191_0 then
				arg_188_1.allBtn_.enabled = true
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play1104704048 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1104704048
		arg_192_1.duration_ = 3.7

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1104704049(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1047ui_story"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos1047ui_story = var_195_0.localPosition
			end

			local var_195_2 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2
				local var_195_4 = Vector3.New(0, -1.13, -6.2)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1047ui_story, var_195_4, var_195_3)

				local var_195_5 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_5.x, var_195_5.y, var_195_5.z)

				local var_195_6 = var_195_0.localEulerAngles

				var_195_6.z = 0
				var_195_6.x = 0
				var_195_0.localEulerAngles = var_195_6
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_195_7 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_7.x, var_195_7.y, var_195_7.z)

				local var_195_8 = var_195_0.localEulerAngles

				var_195_8.z = 0
				var_195_8.x = 0
				var_195_0.localEulerAngles = var_195_8
			end

			local var_195_9 = arg_192_1.actors_["1047ui_story"]
			local var_195_10 = 0

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 and not isNil(var_195_9) and arg_192_1.var_.characterEffect1047ui_story == nil then
				arg_192_1.var_.characterEffect1047ui_story = var_195_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_11 = 0.200000002980232

			if var_195_10 <= arg_192_1.time_ and arg_192_1.time_ < var_195_10 + var_195_11 and not isNil(var_195_9) then
				local var_195_12 = (arg_192_1.time_ - var_195_10) / var_195_11

				if arg_192_1.var_.characterEffect1047ui_story and not isNil(var_195_9) then
					arg_192_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_10 + var_195_11 and arg_192_1.time_ < var_195_10 + var_195_11 + arg_195_0 and not isNil(var_195_9) and arg_192_1.var_.characterEffect1047ui_story then
				arg_192_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_195_13 = "1047ui_story"

			if arg_192_1.actors_[var_195_13] == nil then
				local var_195_14 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_195_14) then
					local var_195_15 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_192_1.stage_.transform)

					var_195_15.name = var_195_13
					var_195_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_192_1.actors_[var_195_13] = var_195_15

					local var_195_16 = var_195_15:GetComponentInChildren(typeof(CharacterEffect))

					var_195_16.enabled = true

					local var_195_17 = GameObjectTools.GetOrAddComponent(var_195_15, typeof(DynamicBoneHelper))

					if var_195_17 then
						var_195_17:EnableDynamicBone(false)
					end

					arg_192_1:ShowWeapon(var_195_16.transform, false)

					arg_192_1.var_[var_195_13 .. "Animator"] = var_195_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_192_1.var_[var_195_13 .. "Animator"].applyRootMotion = true
					arg_192_1.var_[var_195_13 .. "LipSync"] = var_195_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_195_18 = 0

			if var_195_18 < arg_192_1.time_ and arg_192_1.time_ <= var_195_18 + arg_195_0 then
				arg_192_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_195_19 = "1047ui_story"

			if arg_192_1.actors_[var_195_19] == nil then
				local var_195_20 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_195_20) then
					local var_195_21 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_192_1.stage_.transform)

					var_195_21.name = var_195_19
					var_195_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_192_1.actors_[var_195_19] = var_195_21

					local var_195_22 = var_195_21:GetComponentInChildren(typeof(CharacterEffect))

					var_195_22.enabled = true

					local var_195_23 = GameObjectTools.GetOrAddComponent(var_195_21, typeof(DynamicBoneHelper))

					if var_195_23 then
						var_195_23:EnableDynamicBone(false)
					end

					arg_192_1:ShowWeapon(var_195_22.transform, false)

					arg_192_1.var_[var_195_19 .. "Animator"] = var_195_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_192_1.var_[var_195_19 .. "Animator"].applyRootMotion = true
					arg_192_1.var_[var_195_19 .. "LipSync"] = var_195_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_195_24 = 0

			if var_195_24 < arg_192_1.time_ and arg_192_1.time_ <= var_195_24 + arg_195_0 then
				arg_192_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_195_25 = 0
			local var_195_26 = 0.275

			if var_195_25 < arg_192_1.time_ and arg_192_1.time_ <= var_195_25 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_27 = arg_192_1:FormatText(StoryNameCfg[1296].name)

				arg_192_1.leftNameTxt_.text = var_195_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_28 = arg_192_1:GetWordFromCfg(1104704048)
				local var_195_29 = arg_192_1:FormatText(var_195_28.content)

				arg_192_1.text_.text = var_195_29

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_30 = 11
				local var_195_31 = utf8.len(var_195_29)
				local var_195_32 = var_195_30 <= 0 and var_195_26 or var_195_26 * (var_195_31 / var_195_30)

				if var_195_32 > 0 and var_195_26 < var_195_32 then
					arg_192_1.talkMaxDuration = var_195_32

					if var_195_32 + var_195_25 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_32 + var_195_25
					end
				end

				arg_192_1.text_.text = var_195_29
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704048", "story_v_side_new_1104704.awb") ~= 0 then
					local var_195_33 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704048", "story_v_side_new_1104704.awb") / 1000

					if var_195_33 + var_195_25 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_33 + var_195_25
					end

					if var_195_28.prefab_name ~= "" and arg_192_1.actors_[var_195_28.prefab_name] ~= nil then
						local var_195_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_28.prefab_name].transform, "story_v_side_new_1104704", "1104704048", "story_v_side_new_1104704.awb")

						arg_192_1:RecordAudio("1104704048", var_195_34)
						arg_192_1:RecordAudio("1104704048", var_195_34)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704048", "story_v_side_new_1104704.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704048", "story_v_side_new_1104704.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_35 = math.max(var_195_26, arg_192_1.talkMaxDuration)

			if var_195_25 <= arg_192_1.time_ and arg_192_1.time_ < var_195_25 + var_195_35 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_25) / var_195_35

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_25 + var_195_35 and arg_192_1.time_ < var_195_25 + var_195_35 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play1104704049 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1104704049
		arg_196_1.duration_ = 4.7

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1104704050(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_199_1 = 0
			local var_199_2 = 0.5

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_3 = arg_196_1:FormatText(StoryNameCfg[1296].name)

				arg_196_1.leftNameTxt_.text = var_199_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_4 = arg_196_1:GetWordFromCfg(1104704049)
				local var_199_5 = arg_196_1:FormatText(var_199_4.content)

				arg_196_1.text_.text = var_199_5

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_6 = 20
				local var_199_7 = utf8.len(var_199_5)
				local var_199_8 = var_199_6 <= 0 and var_199_2 or var_199_2 * (var_199_7 / var_199_6)

				if var_199_8 > 0 and var_199_2 < var_199_8 then
					arg_196_1.talkMaxDuration = var_199_8

					if var_199_8 + var_199_1 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_1
					end
				end

				arg_196_1.text_.text = var_199_5
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704049", "story_v_side_new_1104704.awb") ~= 0 then
					local var_199_9 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704049", "story_v_side_new_1104704.awb") / 1000

					if var_199_9 + var_199_1 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_1
					end

					if var_199_4.prefab_name ~= "" and arg_196_1.actors_[var_199_4.prefab_name] ~= nil then
						local var_199_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_4.prefab_name].transform, "story_v_side_new_1104704", "1104704049", "story_v_side_new_1104704.awb")

						arg_196_1:RecordAudio("1104704049", var_199_10)
						arg_196_1:RecordAudio("1104704049", var_199_10)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704049", "story_v_side_new_1104704.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704049", "story_v_side_new_1104704.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_11 = math.max(var_199_2, arg_196_1.talkMaxDuration)

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_11 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_1) / var_199_11

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_1 + var_199_11 and arg_196_1.time_ < var_199_1 + var_199_11 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play1104704050 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1104704050
		arg_200_1.duration_ = 6.53

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1104704051(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = "ST27a"

			if arg_200_1.bgs_[var_203_0] == nil then
				local var_203_1 = Object.Instantiate(arg_200_1.paintGo_)

				var_203_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_203_0)
				var_203_1.name = var_203_0
				var_203_1.transform.parent = arg_200_1.stage_.transform
				var_203_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_200_1.bgs_[var_203_0] = var_203_1
			end

			local var_203_2 = 0.566666666666667

			if var_203_2 < arg_200_1.time_ and arg_200_1.time_ <= var_203_2 + arg_203_0 then
				local var_203_3 = manager.ui.mainCamera.transform.localPosition
				local var_203_4 = Vector3.New(0, 0, 10) + Vector3.New(var_203_3.x, var_203_3.y, 0)
				local var_203_5 = arg_200_1.bgs_.ST27a

				var_203_5.transform.localPosition = var_203_4
				var_203_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_203_6 = var_203_5:GetComponent("SpriteRenderer")

				if var_203_6 and var_203_6.sprite then
					local var_203_7 = (var_203_5.transform.localPosition - var_203_3).z
					local var_203_8 = manager.ui.mainCameraCom_
					local var_203_9 = 2 * var_203_7 * Mathf.Tan(var_203_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_203_10 = var_203_9 * var_203_8.aspect
					local var_203_11 = var_203_6.sprite.bounds.size.x
					local var_203_12 = var_203_6.sprite.bounds.size.y
					local var_203_13 = var_203_10 / var_203_11
					local var_203_14 = var_203_9 / var_203_12
					local var_203_15 = var_203_14 < var_203_13 and var_203_13 or var_203_14

					var_203_5.transform.localScale = Vector3.New(var_203_15, var_203_15, 0)
				end

				for iter_203_0, iter_203_1 in pairs(arg_200_1.bgs_) do
					if iter_203_0 ~= "ST27a" then
						iter_203_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_203_16 = 0.866666666666667

			if var_203_16 < arg_200_1.time_ and arg_200_1.time_ <= var_203_16 + arg_203_0 then
				arg_200_1.allBtn_.enabled = false
			end

			local var_203_17 = 0.3

			if arg_200_1.time_ >= var_203_16 + var_203_17 and arg_200_1.time_ < var_203_16 + var_203_17 + arg_203_0 then
				arg_200_1.allBtn_.enabled = true
			end

			local var_203_18 = arg_200_1.actors_["1047ui_story"]
			local var_203_19 = 0

			if var_203_19 < arg_200_1.time_ and arg_200_1.time_ <= var_203_19 + arg_203_0 and not isNil(var_203_18) and arg_200_1.var_.characterEffect1047ui_story == nil then
				arg_200_1.var_.characterEffect1047ui_story = var_203_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_20 = 0.034000001847744

			if var_203_19 <= arg_200_1.time_ and arg_200_1.time_ < var_203_19 + var_203_20 and not isNil(var_203_18) then
				local var_203_21 = (arg_200_1.time_ - var_203_19) / var_203_20

				if arg_200_1.var_.characterEffect1047ui_story and not isNil(var_203_18) then
					local var_203_22 = Mathf.Lerp(0, 0.5, var_203_21)

					arg_200_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1047ui_story.fillRatio = var_203_22
				end
			end

			if arg_200_1.time_ >= var_203_19 + var_203_20 and arg_200_1.time_ < var_203_19 + var_203_20 + arg_203_0 and not isNil(var_203_18) and arg_200_1.var_.characterEffect1047ui_story then
				local var_203_23 = 0.5

				arg_200_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1047ui_story.fillRatio = var_203_23
			end

			local var_203_24 = arg_200_1.actors_["1047ui_story"].transform
			local var_203_25 = 0

			if var_203_25 < arg_200_1.time_ and arg_200_1.time_ <= var_203_25 + arg_203_0 then
				arg_200_1.var_.moveOldPos1047ui_story = var_203_24.localPosition
			end

			local var_203_26 = 0.001

			if var_203_25 <= arg_200_1.time_ and arg_200_1.time_ < var_203_25 + var_203_26 then
				local var_203_27 = (arg_200_1.time_ - var_203_25) / var_203_26
				local var_203_28 = Vector3.New(0, 100, 0)

				var_203_24.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1047ui_story, var_203_28, var_203_27)

				local var_203_29 = manager.ui.mainCamera.transform.position - var_203_24.position

				var_203_24.forward = Vector3.New(var_203_29.x, var_203_29.y, var_203_29.z)

				local var_203_30 = var_203_24.localEulerAngles

				var_203_30.z = 0
				var_203_30.x = 0
				var_203_24.localEulerAngles = var_203_30
			end

			if arg_200_1.time_ >= var_203_25 + var_203_26 and arg_200_1.time_ < var_203_25 + var_203_26 + arg_203_0 then
				var_203_24.localPosition = Vector3.New(0, 100, 0)

				local var_203_31 = manager.ui.mainCamera.transform.position - var_203_24.position

				var_203_24.forward = Vector3.New(var_203_31.x, var_203_31.y, var_203_31.z)

				local var_203_32 = var_203_24.localEulerAngles

				var_203_32.z = 0
				var_203_32.x = 0
				var_203_24.localEulerAngles = var_203_32
			end

			local var_203_33 = manager.ui.mainCamera.transform
			local var_203_34 = 0

			if var_203_34 < arg_200_1.time_ and arg_200_1.time_ <= var_203_34 + arg_203_0 then
				local var_203_35 = arg_200_1.var_.effectzhuanchangyixia1
				local var_203_36
				local var_203_37 = var_203_33

				if not var_203_35 then
					var_203_35 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_203_37)
					var_203_35.name = "zhuanchangyixia1"
					arg_200_1.var_.effectzhuanchangyixia1 = var_203_35
				else
					var_203_35.transform:SetParent(var_203_37)
				end

				var_203_35.transform.localPosition = Vector3.New(0, 0, 0)
				var_203_35.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_203_38 = 1.7777777777777777
				local var_203_39 = Screen.width / Screen.height
				local var_203_40 = var_203_39 / var_203_38
				local var_203_41 = Mathf.Max(var_203_38 / var_203_39, 1)
				local var_203_42 = Mathf.Max(var_203_40, var_203_41)

				var_203_35.transform.localScale = Vector3.New(var_203_35.transform.localScale.x * var_203_42, var_203_35.transform.localScale.y * var_203_42, var_203_35.transform.localScale.z * var_203_42)
			end

			local var_203_43 = 0

			if var_203_43 < arg_200_1.time_ and arg_200_1.time_ <= var_203_43 + arg_203_0 then
				arg_200_1.allBtn_.enabled = false
			end

			local var_203_44 = 1.674999999999

			if arg_200_1.time_ >= var_203_43 + var_203_44 and arg_200_1.time_ < var_203_43 + var_203_44 + arg_203_0 then
				arg_200_1.allBtn_.enabled = true
			end

			local var_203_45 = 1.2
			local var_203_46 = 1

			if var_203_45 < arg_200_1.time_ and arg_200_1.time_ <= var_203_45 + arg_203_0 then
				local var_203_47 = "play"
				local var_203_48 = "effect"

				arg_200_1:AudioAction(var_203_47, var_203_48, "se_story_143", "se_story_143_amb_club", "")
			end

			local var_203_49 = 0.1
			local var_203_50 = 1

			if var_203_49 < arg_200_1.time_ and arg_200_1.time_ <= var_203_49 + arg_203_0 then
				local var_203_51 = "stop"
				local var_203_52 = "effect"

				arg_200_1:AudioAction(var_203_51, var_203_52, "se_story_1310", "se_story_1310_nightloop", "")
			end

			if arg_200_1.frameCnt_ <= 1 then
				arg_200_1.dialog_:SetActive(false)
			end

			local var_203_53 = 1.53333333333333
			local var_203_54 = 0.95

			if var_203_53 < arg_200_1.time_ and arg_200_1.time_ <= var_203_53 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0

				arg_200_1.dialog_:SetActive(true)

				arg_200_1.dialogCg_.alpha = 0

				local var_203_55 = LeanTween.value(arg_200_1.dialog_, 0, 1, 0.3)

				var_203_55:setOnUpdate(LuaHelper.FloatAction(function(arg_204_0)
					arg_200_1.dialogCg_.alpha = arg_204_0
				end))
				var_203_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_200_1.dialog_)
					var_203_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_200_1.duration_ = arg_200_1.duration_ + 0.3

				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_56 = arg_200_1:GetWordFromCfg(1104704050)
				local var_203_57 = arg_200_1:FormatText(var_203_56.content)

				arg_200_1.text_.text = var_203_57

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_58 = 38
				local var_203_59 = utf8.len(var_203_57)
				local var_203_60 = var_203_58 <= 0 and var_203_54 or var_203_54 * (var_203_59 / var_203_58)

				if var_203_60 > 0 and var_203_54 < var_203_60 then
					arg_200_1.talkMaxDuration = var_203_60
					var_203_53 = var_203_53 + 0.3

					if var_203_60 + var_203_53 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_60 + var_203_53
					end
				end

				arg_200_1.text_.text = var_203_57
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_61 = var_203_53 + 0.3
			local var_203_62 = math.max(var_203_54, arg_200_1.talkMaxDuration)

			if var_203_61 <= arg_200_1.time_ and arg_200_1.time_ < var_203_61 + var_203_62 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_61) / var_203_62

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_61 + var_203_62 and arg_200_1.time_ < var_203_61 + var_203_62 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play1104704051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1104704051
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1104704052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0
			local var_209_1 = 0.75

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_2 = arg_206_1:GetWordFromCfg(1104704051)
				local var_209_3 = arg_206_1:FormatText(var_209_2.content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 30
				local var_209_5 = utf8.len(var_209_3)
				local var_209_6 = var_209_4 <= 0 and var_209_1 or var_209_1 * (var_209_5 / var_209_4)

				if var_209_6 > 0 and var_209_1 < var_209_6 then
					arg_206_1.talkMaxDuration = var_209_6

					if var_209_6 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_6 + var_209_0
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_1, arg_206_1.talkMaxDuration)

			if var_209_0 <= arg_206_1.time_ and arg_206_1.time_ < var_209_0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_0 + var_209_7 and arg_206_1.time_ < var_209_0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play1104704052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1104704052
		arg_210_1.duration_ = 3.33

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1104704053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1047ui_story"].transform
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.var_.moveOldPos1047ui_story = var_213_0.localPosition
			end

			local var_213_2 = 0.001

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2
				local var_213_4 = Vector3.New(0, -1.13, -6.2)

				var_213_0.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1047ui_story, var_213_4, var_213_3)

				local var_213_5 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_5.x, var_213_5.y, var_213_5.z)

				local var_213_6 = var_213_0.localEulerAngles

				var_213_6.z = 0
				var_213_6.x = 0
				var_213_0.localEulerAngles = var_213_6
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 then
				var_213_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_213_7 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_7.x, var_213_7.y, var_213_7.z)

				local var_213_8 = var_213_0.localEulerAngles

				var_213_8.z = 0
				var_213_8.x = 0
				var_213_0.localEulerAngles = var_213_8
			end

			local var_213_9 = arg_210_1.actors_["1047ui_story"]
			local var_213_10 = 0

			if var_213_10 < arg_210_1.time_ and arg_210_1.time_ <= var_213_10 + arg_213_0 and not isNil(var_213_9) and arg_210_1.var_.characterEffect1047ui_story == nil then
				arg_210_1.var_.characterEffect1047ui_story = var_213_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_11 = 0.200000002980232

			if var_213_10 <= arg_210_1.time_ and arg_210_1.time_ < var_213_10 + var_213_11 and not isNil(var_213_9) then
				local var_213_12 = (arg_210_1.time_ - var_213_10) / var_213_11

				if arg_210_1.var_.characterEffect1047ui_story and not isNil(var_213_9) then
					arg_210_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_10 + var_213_11 and arg_210_1.time_ < var_213_10 + var_213_11 + arg_213_0 and not isNil(var_213_9) and arg_210_1.var_.characterEffect1047ui_story then
				arg_210_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_213_13 = 0

			if var_213_13 < arg_210_1.time_ and arg_210_1.time_ <= var_213_13 + arg_213_0 then
				arg_210_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_213_14 = 0

			if var_213_14 < arg_210_1.time_ and arg_210_1.time_ <= var_213_14 + arg_213_0 then
				arg_210_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_213_15 = 0
			local var_213_16 = 0.3

			if var_213_15 < arg_210_1.time_ and arg_210_1.time_ <= var_213_15 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_17 = arg_210_1:FormatText(StoryNameCfg[1296].name)

				arg_210_1.leftNameTxt_.text = var_213_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_18 = arg_210_1:GetWordFromCfg(1104704052)
				local var_213_19 = arg_210_1:FormatText(var_213_18.content)

				arg_210_1.text_.text = var_213_19

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_20 = 12
				local var_213_21 = utf8.len(var_213_19)
				local var_213_22 = var_213_20 <= 0 and var_213_16 or var_213_16 * (var_213_21 / var_213_20)

				if var_213_22 > 0 and var_213_16 < var_213_22 then
					arg_210_1.talkMaxDuration = var_213_22

					if var_213_22 + var_213_15 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_22 + var_213_15
					end
				end

				arg_210_1.text_.text = var_213_19
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704052", "story_v_side_new_1104704.awb") ~= 0 then
					local var_213_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704052", "story_v_side_new_1104704.awb") / 1000

					if var_213_23 + var_213_15 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_23 + var_213_15
					end

					if var_213_18.prefab_name ~= "" and arg_210_1.actors_[var_213_18.prefab_name] ~= nil then
						local var_213_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_18.prefab_name].transform, "story_v_side_new_1104704", "1104704052", "story_v_side_new_1104704.awb")

						arg_210_1:RecordAudio("1104704052", var_213_24)
						arg_210_1:RecordAudio("1104704052", var_213_24)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704052", "story_v_side_new_1104704.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704052", "story_v_side_new_1104704.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_25 = math.max(var_213_16, arg_210_1.talkMaxDuration)

			if var_213_15 <= arg_210_1.time_ and arg_210_1.time_ < var_213_15 + var_213_25 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_15) / var_213_25

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_15 + var_213_25 and arg_210_1.time_ < var_213_15 + var_213_25 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play1104704053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1104704053
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1104704054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1047ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1047ui_story == nil then
				arg_214_1.var_.characterEffect1047ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect1047ui_story and not isNil(var_217_0) then
					local var_217_4 = Mathf.Lerp(0, 0.5, var_217_3)

					arg_214_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1047ui_story.fillRatio = var_217_4
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1047ui_story then
				local var_217_5 = 0.5

				arg_214_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1047ui_story.fillRatio = var_217_5
			end

			local var_217_6 = 0
			local var_217_7 = 0.725

			if var_217_6 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_8 = arg_214_1:FormatText(StoryNameCfg[7].name)

				arg_214_1.leftNameTxt_.text = var_217_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_9 = arg_214_1:GetWordFromCfg(1104704053)
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
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_14 = math.max(var_217_7, arg_214_1.talkMaxDuration)

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_14 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_6) / var_217_14

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_6 + var_217_14 and arg_214_1.time_ < var_217_6 + var_217_14 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1104704054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1104704054
		arg_218_1.duration_ = 3.4

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1104704055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1047ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos1047ui_story = var_221_0.localPosition
			end

			local var_221_2 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2
				local var_221_4 = Vector3.New(0, -1.13, -6.2)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1047ui_story, var_221_4, var_221_3)

				local var_221_5 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_5.x, var_221_5.y, var_221_5.z)

				local var_221_6 = var_221_0.localEulerAngles

				var_221_6.z = 0
				var_221_6.x = 0
				var_221_0.localEulerAngles = var_221_6
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_221_7 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_7.x, var_221_7.y, var_221_7.z)

				local var_221_8 = var_221_0.localEulerAngles

				var_221_8.z = 0
				var_221_8.x = 0
				var_221_0.localEulerAngles = var_221_8
			end

			local var_221_9 = arg_218_1.actors_["1047ui_story"]
			local var_221_10 = 0

			if var_221_10 < arg_218_1.time_ and arg_218_1.time_ <= var_221_10 + arg_221_0 and not isNil(var_221_9) and arg_218_1.var_.characterEffect1047ui_story == nil then
				arg_218_1.var_.characterEffect1047ui_story = var_221_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_11 = 0.200000002980232

			if var_221_10 <= arg_218_1.time_ and arg_218_1.time_ < var_221_10 + var_221_11 and not isNil(var_221_9) then
				local var_221_12 = (arg_218_1.time_ - var_221_10) / var_221_11

				if arg_218_1.var_.characterEffect1047ui_story and not isNil(var_221_9) then
					arg_218_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_10 + var_221_11 and arg_218_1.time_ < var_221_10 + var_221_11 + arg_221_0 and not isNil(var_221_9) and arg_218_1.var_.characterEffect1047ui_story then
				arg_218_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_221_13 = 0

			if var_221_13 < arg_218_1.time_ and arg_218_1.time_ <= var_221_13 + arg_221_0 then
				arg_218_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			local var_221_14 = 0

			if var_221_14 < arg_218_1.time_ and arg_218_1.time_ <= var_221_14 + arg_221_0 then
				arg_218_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_221_15 = 0
			local var_221_16 = 0.4

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_17 = arg_218_1:FormatText(StoryNameCfg[1296].name)

				arg_218_1.leftNameTxt_.text = var_221_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_18 = arg_218_1:GetWordFromCfg(1104704054)
				local var_221_19 = arg_218_1:FormatText(var_221_18.content)

				arg_218_1.text_.text = var_221_19

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_20 = 16
				local var_221_21 = utf8.len(var_221_19)
				local var_221_22 = var_221_20 <= 0 and var_221_16 or var_221_16 * (var_221_21 / var_221_20)

				if var_221_22 > 0 and var_221_16 < var_221_22 then
					arg_218_1.talkMaxDuration = var_221_22

					if var_221_22 + var_221_15 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_22 + var_221_15
					end
				end

				arg_218_1.text_.text = var_221_19
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704054", "story_v_side_new_1104704.awb") ~= 0 then
					local var_221_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704054", "story_v_side_new_1104704.awb") / 1000

					if var_221_23 + var_221_15 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_23 + var_221_15
					end

					if var_221_18.prefab_name ~= "" and arg_218_1.actors_[var_221_18.prefab_name] ~= nil then
						local var_221_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_18.prefab_name].transform, "story_v_side_new_1104704", "1104704054", "story_v_side_new_1104704.awb")

						arg_218_1:RecordAudio("1104704054", var_221_24)
						arg_218_1:RecordAudio("1104704054", var_221_24)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704054", "story_v_side_new_1104704.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704054", "story_v_side_new_1104704.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_25 = math.max(var_221_16, arg_218_1.talkMaxDuration)

			if var_221_15 <= arg_218_1.time_ and arg_218_1.time_ < var_221_15 + var_221_25 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_15) / var_221_25

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_15 + var_221_25 and arg_218_1.time_ < var_221_15 + var_221_25 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104704055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1104704055
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1104704056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1047ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1047ui_story == nil then
				arg_222_1.var_.characterEffect1047ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect1047ui_story and not isNil(var_225_0) then
					local var_225_4 = Mathf.Lerp(0, 0.5, var_225_3)

					arg_222_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1047ui_story.fillRatio = var_225_4
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1047ui_story then
				local var_225_5 = 0.5

				arg_222_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1047ui_story.fillRatio = var_225_5
			end

			local var_225_6 = 0
			local var_225_7 = 0.225

			if var_225_6 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_8 = arg_222_1:FormatText(StoryNameCfg[7].name)

				arg_222_1.leftNameTxt_.text = var_225_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_9 = arg_222_1:GetWordFromCfg(1104704055)
				local var_225_10 = arg_222_1:FormatText(var_225_9.content)

				arg_222_1.text_.text = var_225_10

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_11 = 9
				local var_225_12 = utf8.len(var_225_10)
				local var_225_13 = var_225_11 <= 0 and var_225_7 or var_225_7 * (var_225_12 / var_225_11)

				if var_225_13 > 0 and var_225_7 < var_225_13 then
					arg_222_1.talkMaxDuration = var_225_13

					if var_225_13 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_13 + var_225_6
					end
				end

				arg_222_1.text_.text = var_225_10
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_14 = math.max(var_225_7, arg_222_1.talkMaxDuration)

			if var_225_6 <= arg_222_1.time_ and arg_222_1.time_ < var_225_6 + var_225_14 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_6) / var_225_14

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_6 + var_225_14 and arg_222_1.time_ < var_225_6 + var_225_14 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1104704056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1104704056
		arg_226_1.duration_ = 6.27

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1104704057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1047ui_story"].transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPos1047ui_story = var_229_0.localPosition
			end

			local var_229_2 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2
				local var_229_4 = Vector3.New(0, -1.13, -6.2)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1047ui_story, var_229_4, var_229_3)

				local var_229_5 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_5.x, var_229_5.y, var_229_5.z)

				local var_229_6 = var_229_0.localEulerAngles

				var_229_6.z = 0
				var_229_6.x = 0
				var_229_0.localEulerAngles = var_229_6
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_229_7 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_7.x, var_229_7.y, var_229_7.z)

				local var_229_8 = var_229_0.localEulerAngles

				var_229_8.z = 0
				var_229_8.x = 0
				var_229_0.localEulerAngles = var_229_8
			end

			local var_229_9 = arg_226_1.actors_["1047ui_story"]
			local var_229_10 = 0

			if var_229_10 < arg_226_1.time_ and arg_226_1.time_ <= var_229_10 + arg_229_0 and not isNil(var_229_9) and arg_226_1.var_.characterEffect1047ui_story == nil then
				arg_226_1.var_.characterEffect1047ui_story = var_229_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_11 = 0.200000002980232

			if var_229_10 <= arg_226_1.time_ and arg_226_1.time_ < var_229_10 + var_229_11 and not isNil(var_229_9) then
				local var_229_12 = (arg_226_1.time_ - var_229_10) / var_229_11

				if arg_226_1.var_.characterEffect1047ui_story and not isNil(var_229_9) then
					arg_226_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_10 + var_229_11 and arg_226_1.time_ < var_229_10 + var_229_11 + arg_229_0 and not isNil(var_229_9) and arg_226_1.var_.characterEffect1047ui_story then
				arg_226_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_229_13 = 0

			if var_229_13 < arg_226_1.time_ and arg_226_1.time_ <= var_229_13 + arg_229_0 then
				arg_226_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_229_14 = 0

			if var_229_14 < arg_226_1.time_ and arg_226_1.time_ <= var_229_14 + arg_229_0 then
				arg_226_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_229_15 = 0
			local var_229_16 = 0.75

			if var_229_15 < arg_226_1.time_ and arg_226_1.time_ <= var_229_15 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_17 = arg_226_1:FormatText(StoryNameCfg[1296].name)

				arg_226_1.leftNameTxt_.text = var_229_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_18 = arg_226_1:GetWordFromCfg(1104704056)
				local var_229_19 = arg_226_1:FormatText(var_229_18.content)

				arg_226_1.text_.text = var_229_19

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_20 = 30
				local var_229_21 = utf8.len(var_229_19)
				local var_229_22 = var_229_20 <= 0 and var_229_16 or var_229_16 * (var_229_21 / var_229_20)

				if var_229_22 > 0 and var_229_16 < var_229_22 then
					arg_226_1.talkMaxDuration = var_229_22

					if var_229_22 + var_229_15 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_22 + var_229_15
					end
				end

				arg_226_1.text_.text = var_229_19
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704056", "story_v_side_new_1104704.awb") ~= 0 then
					local var_229_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704056", "story_v_side_new_1104704.awb") / 1000

					if var_229_23 + var_229_15 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_23 + var_229_15
					end

					if var_229_18.prefab_name ~= "" and arg_226_1.actors_[var_229_18.prefab_name] ~= nil then
						local var_229_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_18.prefab_name].transform, "story_v_side_new_1104704", "1104704056", "story_v_side_new_1104704.awb")

						arg_226_1:RecordAudio("1104704056", var_229_24)
						arg_226_1:RecordAudio("1104704056", var_229_24)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704056", "story_v_side_new_1104704.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704056", "story_v_side_new_1104704.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_25 = math.max(var_229_16, arg_226_1.talkMaxDuration)

			if var_229_15 <= arg_226_1.time_ and arg_226_1.time_ < var_229_15 + var_229_25 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_15) / var_229_25

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_15 + var_229_25 and arg_226_1.time_ < var_229_15 + var_229_25 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play1104704057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1104704057
		arg_230_1.duration_ = 4.63

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1104704058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1047ui_story"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos1047ui_story = var_233_0.localPosition
			end

			local var_233_2 = 0.001

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2
				local var_233_4 = Vector3.New(0, -1.13, -6.2)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1047ui_story, var_233_4, var_233_3)

				local var_233_5 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_5.x, var_233_5.y, var_233_5.z)

				local var_233_6 = var_233_0.localEulerAngles

				var_233_6.z = 0
				var_233_6.x = 0
				var_233_0.localEulerAngles = var_233_6
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 then
				var_233_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_233_7 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_7.x, var_233_7.y, var_233_7.z)

				local var_233_8 = var_233_0.localEulerAngles

				var_233_8.z = 0
				var_233_8.x = 0
				var_233_0.localEulerAngles = var_233_8
			end

			local var_233_9 = 0

			if var_233_9 < arg_230_1.time_ and arg_230_1.time_ <= var_233_9 + arg_233_0 then
				arg_230_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_1")
			end

			local var_233_10 = 0

			if var_233_10 < arg_230_1.time_ and arg_230_1.time_ <= var_233_10 + arg_233_0 then
				arg_230_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_233_11 = 0
			local var_233_12 = 0.525

			if var_233_11 < arg_230_1.time_ and arg_230_1.time_ <= var_233_11 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_13 = arg_230_1:FormatText(StoryNameCfg[1296].name)

				arg_230_1.leftNameTxt_.text = var_233_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_14 = arg_230_1:GetWordFromCfg(1104704057)
				local var_233_15 = arg_230_1:FormatText(var_233_14.content)

				arg_230_1.text_.text = var_233_15

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_16 = 21
				local var_233_17 = utf8.len(var_233_15)
				local var_233_18 = var_233_16 <= 0 and var_233_12 or var_233_12 * (var_233_17 / var_233_16)

				if var_233_18 > 0 and var_233_12 < var_233_18 then
					arg_230_1.talkMaxDuration = var_233_18

					if var_233_18 + var_233_11 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_18 + var_233_11
					end
				end

				arg_230_1.text_.text = var_233_15
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704057", "story_v_side_new_1104704.awb") ~= 0 then
					local var_233_19 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704057", "story_v_side_new_1104704.awb") / 1000

					if var_233_19 + var_233_11 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_19 + var_233_11
					end

					if var_233_14.prefab_name ~= "" and arg_230_1.actors_[var_233_14.prefab_name] ~= nil then
						local var_233_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_14.prefab_name].transform, "story_v_side_new_1104704", "1104704057", "story_v_side_new_1104704.awb")

						arg_230_1:RecordAudio("1104704057", var_233_20)
						arg_230_1:RecordAudio("1104704057", var_233_20)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704057", "story_v_side_new_1104704.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704057", "story_v_side_new_1104704.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_21 = math.max(var_233_12, arg_230_1.talkMaxDuration)

			if var_233_11 <= arg_230_1.time_ and arg_230_1.time_ < var_233_11 + var_233_21 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_11) / var_233_21

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_11 + var_233_21 and arg_230_1.time_ < var_233_11 + var_233_21 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play1104704058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1104704058
		arg_234_1.duration_ = 8.4

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1104704059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_2")
			end

			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_237_2 = 0
			local var_237_3 = 1.025

			if var_237_2 < arg_234_1.time_ and arg_234_1.time_ <= var_237_2 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_4 = arg_234_1:FormatText(StoryNameCfg[1296].name)

				arg_234_1.leftNameTxt_.text = var_237_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_5 = arg_234_1:GetWordFromCfg(1104704058)
				local var_237_6 = arg_234_1:FormatText(var_237_5.content)

				arg_234_1.text_.text = var_237_6

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_7 = 41
				local var_237_8 = utf8.len(var_237_6)
				local var_237_9 = var_237_7 <= 0 and var_237_3 or var_237_3 * (var_237_8 / var_237_7)

				if var_237_9 > 0 and var_237_3 < var_237_9 then
					arg_234_1.talkMaxDuration = var_237_9

					if var_237_9 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_9 + var_237_2
					end
				end

				arg_234_1.text_.text = var_237_6
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704058", "story_v_side_new_1104704.awb") ~= 0 then
					local var_237_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704058", "story_v_side_new_1104704.awb") / 1000

					if var_237_10 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_10 + var_237_2
					end

					if var_237_5.prefab_name ~= "" and arg_234_1.actors_[var_237_5.prefab_name] ~= nil then
						local var_237_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_5.prefab_name].transform, "story_v_side_new_1104704", "1104704058", "story_v_side_new_1104704.awb")

						arg_234_1:RecordAudio("1104704058", var_237_11)
						arg_234_1:RecordAudio("1104704058", var_237_11)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704058", "story_v_side_new_1104704.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704058", "story_v_side_new_1104704.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_12 = math.max(var_237_3, arg_234_1.talkMaxDuration)

			if var_237_2 <= arg_234_1.time_ and arg_234_1.time_ < var_237_2 + var_237_12 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_2) / var_237_12

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_2 + var_237_12 and arg_234_1.time_ < var_237_2 + var_237_12 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1104704059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1104704059
		arg_238_1.duration_ = 3.5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1104704060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 0.3

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_2 = arg_238_1:FormatText(StoryNameCfg[1296].name)

				arg_238_1.leftNameTxt_.text = var_241_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_3 = arg_238_1:GetWordFromCfg(1104704059)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 12
				local var_241_6 = utf8.len(var_241_4)
				local var_241_7 = var_241_5 <= 0 and var_241_1 or var_241_1 * (var_241_6 / var_241_5)

				if var_241_7 > 0 and var_241_1 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704059", "story_v_side_new_1104704.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704059", "story_v_side_new_1104704.awb") / 1000

					if var_241_8 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_0
					end

					if var_241_3.prefab_name ~= "" and arg_238_1.actors_[var_241_3.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_3.prefab_name].transform, "story_v_side_new_1104704", "1104704059", "story_v_side_new_1104704.awb")

						arg_238_1:RecordAudio("1104704059", var_241_9)
						arg_238_1:RecordAudio("1104704059", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704059", "story_v_side_new_1104704.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704059", "story_v_side_new_1104704.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_10 and arg_238_1.time_ < var_241_0 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play1104704060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1104704060
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1104704061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1047ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1047ui_story == nil then
				arg_242_1.var_.characterEffect1047ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect1047ui_story and not isNil(var_245_0) then
					local var_245_4 = Mathf.Lerp(0, 0.5, var_245_3)

					arg_242_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1047ui_story.fillRatio = var_245_4
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1047ui_story then
				local var_245_5 = 0.5

				arg_242_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1047ui_story.fillRatio = var_245_5
			end

			local var_245_6 = arg_242_1.actors_["1047ui_story"].transform
			local var_245_7 = 0

			if var_245_7 < arg_242_1.time_ and arg_242_1.time_ <= var_245_7 + arg_245_0 then
				arg_242_1.var_.moveOldPos1047ui_story = var_245_6.localPosition
			end

			local var_245_8 = 0.001

			if var_245_7 <= arg_242_1.time_ and arg_242_1.time_ < var_245_7 + var_245_8 then
				local var_245_9 = (arg_242_1.time_ - var_245_7) / var_245_8
				local var_245_10 = Vector3.New(0, 100, 0)

				var_245_6.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1047ui_story, var_245_10, var_245_9)

				local var_245_11 = manager.ui.mainCamera.transform.position - var_245_6.position

				var_245_6.forward = Vector3.New(var_245_11.x, var_245_11.y, var_245_11.z)

				local var_245_12 = var_245_6.localEulerAngles

				var_245_12.z = 0
				var_245_12.x = 0
				var_245_6.localEulerAngles = var_245_12
			end

			if arg_242_1.time_ >= var_245_7 + var_245_8 and arg_242_1.time_ < var_245_7 + var_245_8 + arg_245_0 then
				var_245_6.localPosition = Vector3.New(0, 100, 0)

				local var_245_13 = manager.ui.mainCamera.transform.position - var_245_6.position

				var_245_6.forward = Vector3.New(var_245_13.x, var_245_13.y, var_245_13.z)

				local var_245_14 = var_245_6.localEulerAngles

				var_245_14.z = 0
				var_245_14.x = 0
				var_245_6.localEulerAngles = var_245_14
			end

			local var_245_15 = 0
			local var_245_16 = 0.75

			if var_245_15 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_17 = arg_242_1:GetWordFromCfg(1104704060)
				local var_245_18 = arg_242_1:FormatText(var_245_17.content)

				arg_242_1.text_.text = var_245_18

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_19 = 30
				local var_245_20 = utf8.len(var_245_18)
				local var_245_21 = var_245_19 <= 0 and var_245_16 or var_245_16 * (var_245_20 / var_245_19)

				if var_245_21 > 0 and var_245_16 < var_245_21 then
					arg_242_1.talkMaxDuration = var_245_21

					if var_245_21 + var_245_15 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_21 + var_245_15
					end
				end

				arg_242_1.text_.text = var_245_18
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_22 = math.max(var_245_16, arg_242_1.talkMaxDuration)

			if var_245_15 <= arg_242_1.time_ and arg_242_1.time_ < var_245_15 + var_245_22 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_15) / var_245_22

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_15 + var_245_22 and arg_242_1.time_ < var_245_15 + var_245_22 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play1104704061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1104704061
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1104704062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 0.35

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

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_3 = arg_246_1:GetWordFromCfg(1104704061)
				local var_249_4 = arg_246_1:FormatText(var_249_3.content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 14
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
	Play1104704062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1104704062
		arg_250_1.duration_ = 7.63

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1104704063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1047ui_story"].transform
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.var_.moveOldPos1047ui_story = var_253_0.localPosition
			end

			local var_253_2 = 0.001

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2
				local var_253_4 = Vector3.New(0, -1.13, -6.2)

				var_253_0.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1047ui_story, var_253_4, var_253_3)

				local var_253_5 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_5.x, var_253_5.y, var_253_5.z)

				local var_253_6 = var_253_0.localEulerAngles

				var_253_6.z = 0
				var_253_6.x = 0
				var_253_0.localEulerAngles = var_253_6
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 then
				var_253_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_253_7 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_7.x, var_253_7.y, var_253_7.z)

				local var_253_8 = var_253_0.localEulerAngles

				var_253_8.z = 0
				var_253_8.x = 0
				var_253_0.localEulerAngles = var_253_8
			end

			local var_253_9 = arg_250_1.actors_["1047ui_story"]
			local var_253_10 = 0

			if var_253_10 < arg_250_1.time_ and arg_250_1.time_ <= var_253_10 + arg_253_0 and not isNil(var_253_9) and arg_250_1.var_.characterEffect1047ui_story == nil then
				arg_250_1.var_.characterEffect1047ui_story = var_253_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_11 = 0.200000002980232

			if var_253_10 <= arg_250_1.time_ and arg_250_1.time_ < var_253_10 + var_253_11 and not isNil(var_253_9) then
				local var_253_12 = (arg_250_1.time_ - var_253_10) / var_253_11

				if arg_250_1.var_.characterEffect1047ui_story and not isNil(var_253_9) then
					arg_250_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_10 + var_253_11 and arg_250_1.time_ < var_253_10 + var_253_11 + arg_253_0 and not isNil(var_253_9) and arg_250_1.var_.characterEffect1047ui_story then
				arg_250_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_253_13 = 0

			if var_253_13 < arg_250_1.time_ and arg_250_1.time_ <= var_253_13 + arg_253_0 then
				arg_250_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_253_14 = 0

			if var_253_14 < arg_250_1.time_ and arg_250_1.time_ <= var_253_14 + arg_253_0 then
				arg_250_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_253_15 = 0
			local var_253_16 = 0.7

			if var_253_15 < arg_250_1.time_ and arg_250_1.time_ <= var_253_15 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_17 = arg_250_1:FormatText(StoryNameCfg[1296].name)

				arg_250_1.leftNameTxt_.text = var_253_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_18 = arg_250_1:GetWordFromCfg(1104704062)
				local var_253_19 = arg_250_1:FormatText(var_253_18.content)

				arg_250_1.text_.text = var_253_19

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_20 = 28
				local var_253_21 = utf8.len(var_253_19)
				local var_253_22 = var_253_20 <= 0 and var_253_16 or var_253_16 * (var_253_21 / var_253_20)

				if var_253_22 > 0 and var_253_16 < var_253_22 then
					arg_250_1.talkMaxDuration = var_253_22

					if var_253_22 + var_253_15 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_22 + var_253_15
					end
				end

				arg_250_1.text_.text = var_253_19
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704062", "story_v_side_new_1104704.awb") ~= 0 then
					local var_253_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704062", "story_v_side_new_1104704.awb") / 1000

					if var_253_23 + var_253_15 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_23 + var_253_15
					end

					if var_253_18.prefab_name ~= "" and arg_250_1.actors_[var_253_18.prefab_name] ~= nil then
						local var_253_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_18.prefab_name].transform, "story_v_side_new_1104704", "1104704062", "story_v_side_new_1104704.awb")

						arg_250_1:RecordAudio("1104704062", var_253_24)
						arg_250_1:RecordAudio("1104704062", var_253_24)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704062", "story_v_side_new_1104704.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704062", "story_v_side_new_1104704.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_25 = math.max(var_253_16, arg_250_1.talkMaxDuration)

			if var_253_15 <= arg_250_1.time_ and arg_250_1.time_ < var_253_15 + var_253_25 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_15) / var_253_25

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_15 + var_253_25 and arg_250_1.time_ < var_253_15 + var_253_25 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play1104704063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1104704063
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1104704064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1047ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1047ui_story == nil then
				arg_254_1.var_.characterEffect1047ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect1047ui_story and not isNil(var_257_0) then
					local var_257_4 = Mathf.Lerp(0, 0.5, var_257_3)

					arg_254_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1047ui_story.fillRatio = var_257_4
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1047ui_story then
				local var_257_5 = 0.5

				arg_254_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1047ui_story.fillRatio = var_257_5
			end

			local var_257_6 = arg_254_1.actors_["1047ui_story"].transform
			local var_257_7 = 0

			if var_257_7 < arg_254_1.time_ and arg_254_1.time_ <= var_257_7 + arg_257_0 then
				arg_254_1.var_.moveOldPos1047ui_story = var_257_6.localPosition
			end

			local var_257_8 = 0.001

			if var_257_7 <= arg_254_1.time_ and arg_254_1.time_ < var_257_7 + var_257_8 then
				local var_257_9 = (arg_254_1.time_ - var_257_7) / var_257_8
				local var_257_10 = Vector3.New(0, 100, 0)

				var_257_6.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1047ui_story, var_257_10, var_257_9)

				local var_257_11 = manager.ui.mainCamera.transform.position - var_257_6.position

				var_257_6.forward = Vector3.New(var_257_11.x, var_257_11.y, var_257_11.z)

				local var_257_12 = var_257_6.localEulerAngles

				var_257_12.z = 0
				var_257_12.x = 0
				var_257_6.localEulerAngles = var_257_12
			end

			if arg_254_1.time_ >= var_257_7 + var_257_8 and arg_254_1.time_ < var_257_7 + var_257_8 + arg_257_0 then
				var_257_6.localPosition = Vector3.New(0, 100, 0)

				local var_257_13 = manager.ui.mainCamera.transform.position - var_257_6.position

				var_257_6.forward = Vector3.New(var_257_13.x, var_257_13.y, var_257_13.z)

				local var_257_14 = var_257_6.localEulerAngles

				var_257_14.z = 0
				var_257_14.x = 0
				var_257_6.localEulerAngles = var_257_14
			end

			local var_257_15 = 0
			local var_257_16 = 1.425

			if var_257_15 < arg_254_1.time_ and arg_254_1.time_ <= var_257_15 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_17 = arg_254_1:GetWordFromCfg(1104704063)
				local var_257_18 = arg_254_1:FormatText(var_257_17.content)

				arg_254_1.text_.text = var_257_18

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_19 = 57
				local var_257_20 = utf8.len(var_257_18)
				local var_257_21 = var_257_19 <= 0 and var_257_16 or var_257_16 * (var_257_20 / var_257_19)

				if var_257_21 > 0 and var_257_16 < var_257_21 then
					arg_254_1.talkMaxDuration = var_257_21

					if var_257_21 + var_257_15 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_21 + var_257_15
					end
				end

				arg_254_1.text_.text = var_257_18
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_22 = math.max(var_257_16, arg_254_1.talkMaxDuration)

			if var_257_15 <= arg_254_1.time_ and arg_254_1.time_ < var_257_15 + var_257_22 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_15) / var_257_22

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_15 + var_257_22 and arg_254_1.time_ < var_257_15 + var_257_22 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play1104704064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1104704064
		arg_258_1.duration_ = 6.77

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1104704065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1047ui_story"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos1047ui_story = var_261_0.localPosition
			end

			local var_261_2 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2
				local var_261_4 = Vector3.New(0, -1.13, -6.2)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1047ui_story, var_261_4, var_261_3)

				local var_261_5 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_5.x, var_261_5.y, var_261_5.z)

				local var_261_6 = var_261_0.localEulerAngles

				var_261_6.z = 0
				var_261_6.x = 0
				var_261_0.localEulerAngles = var_261_6
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_261_7 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_7.x, var_261_7.y, var_261_7.z)

				local var_261_8 = var_261_0.localEulerAngles

				var_261_8.z = 0
				var_261_8.x = 0
				var_261_0.localEulerAngles = var_261_8
			end

			local var_261_9 = arg_258_1.actors_["1047ui_story"]
			local var_261_10 = 0

			if var_261_10 < arg_258_1.time_ and arg_258_1.time_ <= var_261_10 + arg_261_0 and not isNil(var_261_9) and arg_258_1.var_.characterEffect1047ui_story == nil then
				arg_258_1.var_.characterEffect1047ui_story = var_261_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_11 = 0.200000002980232

			if var_261_10 <= arg_258_1.time_ and arg_258_1.time_ < var_261_10 + var_261_11 and not isNil(var_261_9) then
				local var_261_12 = (arg_258_1.time_ - var_261_10) / var_261_11

				if arg_258_1.var_.characterEffect1047ui_story and not isNil(var_261_9) then
					arg_258_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_10 + var_261_11 and arg_258_1.time_ < var_261_10 + var_261_11 + arg_261_0 and not isNil(var_261_9) and arg_258_1.var_.characterEffect1047ui_story then
				arg_258_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_261_13 = 0

			if var_261_13 < arg_258_1.time_ and arg_258_1.time_ <= var_261_13 + arg_261_0 then
				arg_258_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			local var_261_14 = 0

			if var_261_14 < arg_258_1.time_ and arg_258_1.time_ <= var_261_14 + arg_261_0 then
				arg_258_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_261_15 = 0
			local var_261_16 = 0.55

			if var_261_15 < arg_258_1.time_ and arg_258_1.time_ <= var_261_15 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_17 = arg_258_1:FormatText(StoryNameCfg[1296].name)

				arg_258_1.leftNameTxt_.text = var_261_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_18 = arg_258_1:GetWordFromCfg(1104704064)
				local var_261_19 = arg_258_1:FormatText(var_261_18.content)

				arg_258_1.text_.text = var_261_19

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_20 = 22
				local var_261_21 = utf8.len(var_261_19)
				local var_261_22 = var_261_20 <= 0 and var_261_16 or var_261_16 * (var_261_21 / var_261_20)

				if var_261_22 > 0 and var_261_16 < var_261_22 then
					arg_258_1.talkMaxDuration = var_261_22

					if var_261_22 + var_261_15 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_22 + var_261_15
					end
				end

				arg_258_1.text_.text = var_261_19
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704064", "story_v_side_new_1104704.awb") ~= 0 then
					local var_261_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704064", "story_v_side_new_1104704.awb") / 1000

					if var_261_23 + var_261_15 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_23 + var_261_15
					end

					if var_261_18.prefab_name ~= "" and arg_258_1.actors_[var_261_18.prefab_name] ~= nil then
						local var_261_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_18.prefab_name].transform, "story_v_side_new_1104704", "1104704064", "story_v_side_new_1104704.awb")

						arg_258_1:RecordAudio("1104704064", var_261_24)
						arg_258_1:RecordAudio("1104704064", var_261_24)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704064", "story_v_side_new_1104704.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704064", "story_v_side_new_1104704.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_25 = math.max(var_261_16, arg_258_1.talkMaxDuration)

			if var_261_15 <= arg_258_1.time_ and arg_258_1.time_ < var_261_15 + var_261_25 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_15) / var_261_25

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_15 + var_261_25 and arg_258_1.time_ < var_261_15 + var_261_25 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play1104704065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1104704065
		arg_262_1.duration_ = 6.2

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1104704066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1047ui_story"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos1047ui_story = var_265_0.localPosition
			end

			local var_265_2 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2
				local var_265_4 = Vector3.New(0, -1.13, -6.2)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1047ui_story, var_265_4, var_265_3)

				local var_265_5 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_5.x, var_265_5.y, var_265_5.z)

				local var_265_6 = var_265_0.localEulerAngles

				var_265_6.z = 0
				var_265_6.x = 0
				var_265_0.localEulerAngles = var_265_6
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_265_7 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_7.x, var_265_7.y, var_265_7.z)

				local var_265_8 = var_265_0.localEulerAngles

				var_265_8.z = 0
				var_265_8.x = 0
				var_265_0.localEulerAngles = var_265_8
			end

			local var_265_9 = 0

			if var_265_9 < arg_262_1.time_ and arg_262_1.time_ <= var_265_9 + arg_265_0 then
				arg_262_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action472")
			end

			local var_265_10 = 0

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 then
				arg_262_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_265_11 = 0
			local var_265_12 = 0.675

			if var_265_11 < arg_262_1.time_ and arg_262_1.time_ <= var_265_11 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_13 = arg_262_1:FormatText(StoryNameCfg[1296].name)

				arg_262_1.leftNameTxt_.text = var_265_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_14 = arg_262_1:GetWordFromCfg(1104704065)
				local var_265_15 = arg_262_1:FormatText(var_265_14.content)

				arg_262_1.text_.text = var_265_15

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_16 = 27
				local var_265_17 = utf8.len(var_265_15)
				local var_265_18 = var_265_16 <= 0 and var_265_12 or var_265_12 * (var_265_17 / var_265_16)

				if var_265_18 > 0 and var_265_12 < var_265_18 then
					arg_262_1.talkMaxDuration = var_265_18

					if var_265_18 + var_265_11 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_18 + var_265_11
					end
				end

				arg_262_1.text_.text = var_265_15
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704065", "story_v_side_new_1104704.awb") ~= 0 then
					local var_265_19 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704065", "story_v_side_new_1104704.awb") / 1000

					if var_265_19 + var_265_11 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_19 + var_265_11
					end

					if var_265_14.prefab_name ~= "" and arg_262_1.actors_[var_265_14.prefab_name] ~= nil then
						local var_265_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_14.prefab_name].transform, "story_v_side_new_1104704", "1104704065", "story_v_side_new_1104704.awb")

						arg_262_1:RecordAudio("1104704065", var_265_20)
						arg_262_1:RecordAudio("1104704065", var_265_20)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704065", "story_v_side_new_1104704.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704065", "story_v_side_new_1104704.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_21 = math.max(var_265_12, arg_262_1.talkMaxDuration)

			if var_265_11 <= arg_262_1.time_ and arg_262_1.time_ < var_265_11 + var_265_21 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_11) / var_265_21

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_11 + var_265_21 and arg_262_1.time_ < var_265_11 + var_265_21 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play1104704066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1104704066
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1104704067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1047ui_story"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect1047ui_story == nil then
				arg_266_1.var_.characterEffect1047ui_story = var_269_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.characterEffect1047ui_story and not isNil(var_269_0) then
					local var_269_4 = Mathf.Lerp(0, 0.5, var_269_3)

					arg_266_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1047ui_story.fillRatio = var_269_4
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect1047ui_story then
				local var_269_5 = 0.5

				arg_266_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1047ui_story.fillRatio = var_269_5
			end

			local var_269_6 = arg_266_1.actors_["1047ui_story"].transform
			local var_269_7 = 0

			if var_269_7 < arg_266_1.time_ and arg_266_1.time_ <= var_269_7 + arg_269_0 then
				arg_266_1.var_.moveOldPos1047ui_story = var_269_6.localPosition
			end

			local var_269_8 = 0.001

			if var_269_7 <= arg_266_1.time_ and arg_266_1.time_ < var_269_7 + var_269_8 then
				local var_269_9 = (arg_266_1.time_ - var_269_7) / var_269_8
				local var_269_10 = Vector3.New(0, 100, 0)

				var_269_6.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1047ui_story, var_269_10, var_269_9)

				local var_269_11 = manager.ui.mainCamera.transform.position - var_269_6.position

				var_269_6.forward = Vector3.New(var_269_11.x, var_269_11.y, var_269_11.z)

				local var_269_12 = var_269_6.localEulerAngles

				var_269_12.z = 0
				var_269_12.x = 0
				var_269_6.localEulerAngles = var_269_12
			end

			if arg_266_1.time_ >= var_269_7 + var_269_8 and arg_266_1.time_ < var_269_7 + var_269_8 + arg_269_0 then
				var_269_6.localPosition = Vector3.New(0, 100, 0)

				local var_269_13 = manager.ui.mainCamera.transform.position - var_269_6.position

				var_269_6.forward = Vector3.New(var_269_13.x, var_269_13.y, var_269_13.z)

				local var_269_14 = var_269_6.localEulerAngles

				var_269_14.z = 0
				var_269_14.x = 0
				var_269_6.localEulerAngles = var_269_14
			end

			local var_269_15 = 0
			local var_269_16 = 1.125

			if var_269_15 < arg_266_1.time_ and arg_266_1.time_ <= var_269_15 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_17 = arg_266_1:GetWordFromCfg(1104704066)
				local var_269_18 = arg_266_1:FormatText(var_269_17.content)

				arg_266_1.text_.text = var_269_18

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_19 = 45
				local var_269_20 = utf8.len(var_269_18)
				local var_269_21 = var_269_19 <= 0 and var_269_16 or var_269_16 * (var_269_20 / var_269_19)

				if var_269_21 > 0 and var_269_16 < var_269_21 then
					arg_266_1.talkMaxDuration = var_269_21

					if var_269_21 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_21 + var_269_15
					end
				end

				arg_266_1.text_.text = var_269_18
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_22 = math.max(var_269_16, arg_266_1.talkMaxDuration)

			if var_269_15 <= arg_266_1.time_ and arg_266_1.time_ < var_269_15 + var_269_22 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_15) / var_269_22

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_15 + var_269_22 and arg_266_1.time_ < var_269_15 + var_269_22 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play1104704067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1104704067
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1104704068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.275

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[7].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(1104704067)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 11
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
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_8 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_8 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_8

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_8 and arg_270_1.time_ < var_273_0 + var_273_8 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1104704068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1104704068
		arg_274_1.duration_ = 2

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1104704069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1047ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos1047ui_story = var_277_0.localPosition
			end

			local var_277_2 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2
				local var_277_4 = Vector3.New(0, -1.13, -6.2)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1047ui_story, var_277_4, var_277_3)

				local var_277_5 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_5.x, var_277_5.y, var_277_5.z)

				local var_277_6 = var_277_0.localEulerAngles

				var_277_6.z = 0
				var_277_6.x = 0
				var_277_0.localEulerAngles = var_277_6
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_277_7 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_7.x, var_277_7.y, var_277_7.z)

				local var_277_8 = var_277_0.localEulerAngles

				var_277_8.z = 0
				var_277_8.x = 0
				var_277_0.localEulerAngles = var_277_8
			end

			local var_277_9 = arg_274_1.actors_["1047ui_story"]
			local var_277_10 = 0

			if var_277_10 < arg_274_1.time_ and arg_274_1.time_ <= var_277_10 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect1047ui_story == nil then
				arg_274_1.var_.characterEffect1047ui_story = var_277_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_11 = 0.200000002980232

			if var_277_10 <= arg_274_1.time_ and arg_274_1.time_ < var_277_10 + var_277_11 and not isNil(var_277_9) then
				local var_277_12 = (arg_274_1.time_ - var_277_10) / var_277_11

				if arg_274_1.var_.characterEffect1047ui_story and not isNil(var_277_9) then
					arg_274_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_10 + var_277_11 and arg_274_1.time_ < var_277_10 + var_277_11 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect1047ui_story then
				arg_274_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_277_13 = 0

			if var_277_13 < arg_274_1.time_ and arg_274_1.time_ <= var_277_13 + arg_277_0 then
				arg_274_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action426")
			end

			local var_277_14 = 0

			if var_277_14 < arg_274_1.time_ and arg_274_1.time_ <= var_277_14 + arg_277_0 then
				arg_274_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_277_15 = 0
			local var_277_16 = 0.05

			if var_277_15 < arg_274_1.time_ and arg_274_1.time_ <= var_277_15 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_17 = arg_274_1:FormatText(StoryNameCfg[1296].name)

				arg_274_1.leftNameTxt_.text = var_277_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_18 = arg_274_1:GetWordFromCfg(1104704068)
				local var_277_19 = arg_274_1:FormatText(var_277_18.content)

				arg_274_1.text_.text = var_277_19

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_20 = 2
				local var_277_21 = utf8.len(var_277_19)
				local var_277_22 = var_277_20 <= 0 and var_277_16 or var_277_16 * (var_277_21 / var_277_20)

				if var_277_22 > 0 and var_277_16 < var_277_22 then
					arg_274_1.talkMaxDuration = var_277_22

					if var_277_22 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_22 + var_277_15
					end
				end

				arg_274_1.text_.text = var_277_19
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704068", "story_v_side_new_1104704.awb") ~= 0 then
					local var_277_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704068", "story_v_side_new_1104704.awb") / 1000

					if var_277_23 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_23 + var_277_15
					end

					if var_277_18.prefab_name ~= "" and arg_274_1.actors_[var_277_18.prefab_name] ~= nil then
						local var_277_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_18.prefab_name].transform, "story_v_side_new_1104704", "1104704068", "story_v_side_new_1104704.awb")

						arg_274_1:RecordAudio("1104704068", var_277_24)
						arg_274_1:RecordAudio("1104704068", var_277_24)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704068", "story_v_side_new_1104704.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704068", "story_v_side_new_1104704.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_25 = math.max(var_277_16, arg_274_1.talkMaxDuration)

			if var_277_15 <= arg_274_1.time_ and arg_274_1.time_ < var_277_15 + var_277_25 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_15) / var_277_25

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_15 + var_277_25 and arg_274_1.time_ < var_277_15 + var_277_25 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play1104704069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1104704069
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1104704070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1047ui_story"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1047ui_story == nil then
				arg_278_1.var_.characterEffect1047ui_story = var_281_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.200000002980232

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.characterEffect1047ui_story and not isNil(var_281_0) then
					local var_281_4 = Mathf.Lerp(0, 0.5, var_281_3)

					arg_278_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1047ui_story.fillRatio = var_281_4
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1047ui_story then
				local var_281_5 = 0.5

				arg_278_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1047ui_story.fillRatio = var_281_5
			end

			local var_281_6 = 0
			local var_281_7 = 0.9

			if var_281_6 < arg_278_1.time_ and arg_278_1.time_ <= var_281_6 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_8 = arg_278_1:FormatText(StoryNameCfg[7].name)

				arg_278_1.leftNameTxt_.text = var_281_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_9 = arg_278_1:GetWordFromCfg(1104704069)
				local var_281_10 = arg_278_1:FormatText(var_281_9.content)

				arg_278_1.text_.text = var_281_10

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_11 = 36
				local var_281_12 = utf8.len(var_281_10)
				local var_281_13 = var_281_11 <= 0 and var_281_7 or var_281_7 * (var_281_12 / var_281_11)

				if var_281_13 > 0 and var_281_7 < var_281_13 then
					arg_278_1.talkMaxDuration = var_281_13

					if var_281_13 + var_281_6 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_13 + var_281_6
					end
				end

				arg_278_1.text_.text = var_281_10
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_14 = math.max(var_281_7, arg_278_1.talkMaxDuration)

			if var_281_6 <= arg_278_1.time_ and arg_278_1.time_ < var_281_6 + var_281_14 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_6) / var_281_14

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_6 + var_281_14 and arg_278_1.time_ < var_281_6 + var_281_14 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play1104704070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1104704070
		arg_282_1.duration_ = 2

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1104704071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1047ui_story"].transform
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.var_.moveOldPos1047ui_story = var_285_0.localPosition
			end

			local var_285_2 = 0.001

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2
				local var_285_4 = Vector3.New(0, -1.13, -6.2)

				var_285_0.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1047ui_story, var_285_4, var_285_3)

				local var_285_5 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_5.x, var_285_5.y, var_285_5.z)

				local var_285_6 = var_285_0.localEulerAngles

				var_285_6.z = 0
				var_285_6.x = 0
				var_285_0.localEulerAngles = var_285_6
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 then
				var_285_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_285_7 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_7.x, var_285_7.y, var_285_7.z)

				local var_285_8 = var_285_0.localEulerAngles

				var_285_8.z = 0
				var_285_8.x = 0
				var_285_0.localEulerAngles = var_285_8
			end

			local var_285_9 = arg_282_1.actors_["1047ui_story"]
			local var_285_10 = 0

			if var_285_10 < arg_282_1.time_ and arg_282_1.time_ <= var_285_10 + arg_285_0 and not isNil(var_285_9) and arg_282_1.var_.characterEffect1047ui_story == nil then
				arg_282_1.var_.characterEffect1047ui_story = var_285_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_11 = 0.200000002980232

			if var_285_10 <= arg_282_1.time_ and arg_282_1.time_ < var_285_10 + var_285_11 and not isNil(var_285_9) then
				local var_285_12 = (arg_282_1.time_ - var_285_10) / var_285_11

				if arg_282_1.var_.characterEffect1047ui_story and not isNil(var_285_9) then
					arg_282_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= var_285_10 + var_285_11 and arg_282_1.time_ < var_285_10 + var_285_11 + arg_285_0 and not isNil(var_285_9) and arg_282_1.var_.characterEffect1047ui_story then
				arg_282_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_285_13 = 0

			if var_285_13 < arg_282_1.time_ and arg_282_1.time_ <= var_285_13 + arg_285_0 then
				arg_282_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			local var_285_14 = 0

			if var_285_14 < arg_282_1.time_ and arg_282_1.time_ <= var_285_14 + arg_285_0 then
				arg_282_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_285_15 = 0
			local var_285_16 = 0.05

			if var_285_15 < arg_282_1.time_ and arg_282_1.time_ <= var_285_15 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_17 = arg_282_1:FormatText(StoryNameCfg[1296].name)

				arg_282_1.leftNameTxt_.text = var_285_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_18 = arg_282_1:GetWordFromCfg(1104704070)
				local var_285_19 = arg_282_1:FormatText(var_285_18.content)

				arg_282_1.text_.text = var_285_19

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_20 = 2
				local var_285_21 = utf8.len(var_285_19)
				local var_285_22 = var_285_20 <= 0 and var_285_16 or var_285_16 * (var_285_21 / var_285_20)

				if var_285_22 > 0 and var_285_16 < var_285_22 then
					arg_282_1.talkMaxDuration = var_285_22

					if var_285_22 + var_285_15 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_22 + var_285_15
					end
				end

				arg_282_1.text_.text = var_285_19
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704070", "story_v_side_new_1104704.awb") ~= 0 then
					local var_285_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704070", "story_v_side_new_1104704.awb") / 1000

					if var_285_23 + var_285_15 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_23 + var_285_15
					end

					if var_285_18.prefab_name ~= "" and arg_282_1.actors_[var_285_18.prefab_name] ~= nil then
						local var_285_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_18.prefab_name].transform, "story_v_side_new_1104704", "1104704070", "story_v_side_new_1104704.awb")

						arg_282_1:RecordAudio("1104704070", var_285_24)
						arg_282_1:RecordAudio("1104704070", var_285_24)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704070", "story_v_side_new_1104704.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704070", "story_v_side_new_1104704.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_25 = math.max(var_285_16, arg_282_1.talkMaxDuration)

			if var_285_15 <= arg_282_1.time_ and arg_282_1.time_ < var_285_15 + var_285_25 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_15) / var_285_25

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_15 + var_285_25 and arg_282_1.time_ < var_285_15 + var_285_25 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play1104704071 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1104704071
		arg_286_1.duration_ = 8.53

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1104704072(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.8

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[1296].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_3 = arg_286_1:GetWordFromCfg(1104704071)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 32
				local var_289_6 = utf8.len(var_289_4)
				local var_289_7 = var_289_5 <= 0 and var_289_1 or var_289_1 * (var_289_6 / var_289_5)

				if var_289_7 > 0 and var_289_1 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704071", "story_v_side_new_1104704.awb") ~= 0 then
					local var_289_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704071", "story_v_side_new_1104704.awb") / 1000

					if var_289_8 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_0
					end

					if var_289_3.prefab_name ~= "" and arg_286_1.actors_[var_289_3.prefab_name] ~= nil then
						local var_289_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_3.prefab_name].transform, "story_v_side_new_1104704", "1104704071", "story_v_side_new_1104704.awb")

						arg_286_1:RecordAudio("1104704071", var_289_9)
						arg_286_1:RecordAudio("1104704071", var_289_9)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704071", "story_v_side_new_1104704.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704071", "story_v_side_new_1104704.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_10 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_10

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_10 and arg_286_1.time_ < var_289_0 + var_289_10 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play1104704072 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1104704072
		arg_290_1.duration_ = 5.2

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1104704073(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_293_2 = 0
			local var_293_3 = 0.425

			if var_293_2 < arg_290_1.time_ and arg_290_1.time_ <= var_293_2 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_4 = arg_290_1:FormatText(StoryNameCfg[1296].name)

				arg_290_1.leftNameTxt_.text = var_293_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_5 = arg_290_1:GetWordFromCfg(1104704072)
				local var_293_6 = arg_290_1:FormatText(var_293_5.content)

				arg_290_1.text_.text = var_293_6

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_7 = 17
				local var_293_8 = utf8.len(var_293_6)
				local var_293_9 = var_293_7 <= 0 and var_293_3 or var_293_3 * (var_293_8 / var_293_7)

				if var_293_9 > 0 and var_293_3 < var_293_9 then
					arg_290_1.talkMaxDuration = var_293_9

					if var_293_9 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_9 + var_293_2
					end
				end

				arg_290_1.text_.text = var_293_6
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704072", "story_v_side_new_1104704.awb") ~= 0 then
					local var_293_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704072", "story_v_side_new_1104704.awb") / 1000

					if var_293_10 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_2
					end

					if var_293_5.prefab_name ~= "" and arg_290_1.actors_[var_293_5.prefab_name] ~= nil then
						local var_293_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_5.prefab_name].transform, "story_v_side_new_1104704", "1104704072", "story_v_side_new_1104704.awb")

						arg_290_1:RecordAudio("1104704072", var_293_11)
						arg_290_1:RecordAudio("1104704072", var_293_11)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704072", "story_v_side_new_1104704.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704072", "story_v_side_new_1104704.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_12 = math.max(var_293_3, arg_290_1.talkMaxDuration)

			if var_293_2 <= arg_290_1.time_ and arg_290_1.time_ < var_293_2 + var_293_12 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_2) / var_293_12

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_2 + var_293_12 and arg_290_1.time_ < var_293_2 + var_293_12 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play1104704073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1104704073
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1104704074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1047ui_story"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect1047ui_story == nil then
				arg_294_1.var_.characterEffect1047ui_story = var_297_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.200000002980232

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.characterEffect1047ui_story and not isNil(var_297_0) then
					local var_297_4 = Mathf.Lerp(0, 0.5, var_297_3)

					arg_294_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1047ui_story.fillRatio = var_297_4
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect1047ui_story then
				local var_297_5 = 0.5

				arg_294_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1047ui_story.fillRatio = var_297_5
			end

			local var_297_6 = arg_294_1.actors_["1047ui_story"].transform
			local var_297_7 = 0

			if var_297_7 < arg_294_1.time_ and arg_294_1.time_ <= var_297_7 + arg_297_0 then
				arg_294_1.var_.moveOldPos1047ui_story = var_297_6.localPosition
			end

			local var_297_8 = 0.001

			if var_297_7 <= arg_294_1.time_ and arg_294_1.time_ < var_297_7 + var_297_8 then
				local var_297_9 = (arg_294_1.time_ - var_297_7) / var_297_8
				local var_297_10 = Vector3.New(0, 100, 0)

				var_297_6.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1047ui_story, var_297_10, var_297_9)

				local var_297_11 = manager.ui.mainCamera.transform.position - var_297_6.position

				var_297_6.forward = Vector3.New(var_297_11.x, var_297_11.y, var_297_11.z)

				local var_297_12 = var_297_6.localEulerAngles

				var_297_12.z = 0
				var_297_12.x = 0
				var_297_6.localEulerAngles = var_297_12
			end

			if arg_294_1.time_ >= var_297_7 + var_297_8 and arg_294_1.time_ < var_297_7 + var_297_8 + arg_297_0 then
				var_297_6.localPosition = Vector3.New(0, 100, 0)

				local var_297_13 = manager.ui.mainCamera.transform.position - var_297_6.position

				var_297_6.forward = Vector3.New(var_297_13.x, var_297_13.y, var_297_13.z)

				local var_297_14 = var_297_6.localEulerAngles

				var_297_14.z = 0
				var_297_14.x = 0
				var_297_6.localEulerAngles = var_297_14
			end

			local var_297_15 = 0.1
			local var_297_16 = 1

			if var_297_15 < arg_294_1.time_ and arg_294_1.time_ <= var_297_15 + arg_297_0 then
				local var_297_17 = "play"
				local var_297_18 = "effect"

				arg_294_1:AudioAction(var_297_17, var_297_18, "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_297_19 = 0
			local var_297_20 = 0.825

			if var_297_19 < arg_294_1.time_ and arg_294_1.time_ <= var_297_19 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_21 = arg_294_1:GetWordFromCfg(1104704073)
				local var_297_22 = arg_294_1:FormatText(var_297_21.content)

				arg_294_1.text_.text = var_297_22

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_23 = 33
				local var_297_24 = utf8.len(var_297_22)
				local var_297_25 = var_297_23 <= 0 and var_297_20 or var_297_20 * (var_297_24 / var_297_23)

				if var_297_25 > 0 and var_297_20 < var_297_25 then
					arg_294_1.talkMaxDuration = var_297_25

					if var_297_25 + var_297_19 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_25 + var_297_19
					end
				end

				arg_294_1.text_.text = var_297_22
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_26 = math.max(var_297_20, arg_294_1.talkMaxDuration)

			if var_297_19 <= arg_294_1.time_ and arg_294_1.time_ < var_297_19 + var_297_26 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_19) / var_297_26

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_19 + var_297_26 and arg_294_1.time_ < var_297_19 + var_297_26 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play1104704074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1104704074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1104704075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 0.2

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_2 = arg_298_1:FormatText(StoryNameCfg[7].name)

				arg_298_1.leftNameTxt_.text = var_301_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_3 = arg_298_1:GetWordFromCfg(1104704074)
				local var_301_4 = arg_298_1:FormatText(var_301_3.content)

				arg_298_1.text_.text = var_301_4

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 8
				local var_301_6 = utf8.len(var_301_4)
				local var_301_7 = var_301_5 <= 0 and var_301_1 or var_301_1 * (var_301_6 / var_301_5)

				if var_301_7 > 0 and var_301_1 < var_301_7 then
					arg_298_1.talkMaxDuration = var_301_7

					if var_301_7 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_7 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_4
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_8 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_8 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_8

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_8 and arg_298_1.time_ < var_301_0 + var_301_8 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play1104704075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 1104704075
		arg_302_1.duration_ = 2

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play1104704076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1047ui_story"].transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPos1047ui_story = var_305_0.localPosition
			end

			local var_305_2 = 0.001

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2
				local var_305_4 = Vector3.New(0, -1.13, -6.2)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1047ui_story, var_305_4, var_305_3)

				local var_305_5 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_5.x, var_305_5.y, var_305_5.z)

				local var_305_6 = var_305_0.localEulerAngles

				var_305_6.z = 0
				var_305_6.x = 0
				var_305_0.localEulerAngles = var_305_6
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_305_7 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_7.x, var_305_7.y, var_305_7.z)

				local var_305_8 = var_305_0.localEulerAngles

				var_305_8.z = 0
				var_305_8.x = 0
				var_305_0.localEulerAngles = var_305_8
			end

			local var_305_9 = arg_302_1.actors_["1047ui_story"]
			local var_305_10 = 0

			if var_305_10 < arg_302_1.time_ and arg_302_1.time_ <= var_305_10 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect1047ui_story == nil then
				arg_302_1.var_.characterEffect1047ui_story = var_305_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_11 = 0.200000002980232

			if var_305_10 <= arg_302_1.time_ and arg_302_1.time_ < var_305_10 + var_305_11 and not isNil(var_305_9) then
				local var_305_12 = (arg_302_1.time_ - var_305_10) / var_305_11

				if arg_302_1.var_.characterEffect1047ui_story and not isNil(var_305_9) then
					arg_302_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_10 + var_305_11 and arg_302_1.time_ < var_305_10 + var_305_11 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect1047ui_story then
				arg_302_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_305_13 = 0

			if var_305_13 < arg_302_1.time_ and arg_302_1.time_ <= var_305_13 + arg_305_0 then
				arg_302_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			local var_305_14 = 0

			if var_305_14 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaB", "EmotionTimelineAnimator")
			end

			local var_305_15 = 0
			local var_305_16 = 0.05

			if var_305_15 < arg_302_1.time_ and arg_302_1.time_ <= var_305_15 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_17 = arg_302_1:FormatText(StoryNameCfg[1296].name)

				arg_302_1.leftNameTxt_.text = var_305_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_18 = arg_302_1:GetWordFromCfg(1104704075)
				local var_305_19 = arg_302_1:FormatText(var_305_18.content)

				arg_302_1.text_.text = var_305_19

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_20 = 2
				local var_305_21 = utf8.len(var_305_19)
				local var_305_22 = var_305_20 <= 0 and var_305_16 or var_305_16 * (var_305_21 / var_305_20)

				if var_305_22 > 0 and var_305_16 < var_305_22 then
					arg_302_1.talkMaxDuration = var_305_22

					if var_305_22 + var_305_15 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_22 + var_305_15
					end
				end

				arg_302_1.text_.text = var_305_19
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704075", "story_v_side_new_1104704.awb") ~= 0 then
					local var_305_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704075", "story_v_side_new_1104704.awb") / 1000

					if var_305_23 + var_305_15 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_23 + var_305_15
					end

					if var_305_18.prefab_name ~= "" and arg_302_1.actors_[var_305_18.prefab_name] ~= nil then
						local var_305_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_18.prefab_name].transform, "story_v_side_new_1104704", "1104704075", "story_v_side_new_1104704.awb")

						arg_302_1:RecordAudio("1104704075", var_305_24)
						arg_302_1:RecordAudio("1104704075", var_305_24)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704075", "story_v_side_new_1104704.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704075", "story_v_side_new_1104704.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_25 = math.max(var_305_16, arg_302_1.talkMaxDuration)

			if var_305_15 <= arg_302_1.time_ and arg_302_1.time_ < var_305_15 + var_305_25 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_15) / var_305_25

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_15 + var_305_25 and arg_302_1.time_ < var_305_15 + var_305_25 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play1104704076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 1104704076
		arg_306_1.duration_ = 7

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play1104704077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = "ST84a"

			if arg_306_1.bgs_[var_309_0] == nil then
				local var_309_1 = Object.Instantiate(arg_306_1.paintGo_)

				var_309_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_309_0)
				var_309_1.name = var_309_0
				var_309_1.transform.parent = arg_306_1.stage_.transform
				var_309_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_306_1.bgs_[var_309_0] = var_309_1
			end

			local var_309_2 = 0.466666666666667

			if var_309_2 < arg_306_1.time_ and arg_306_1.time_ <= var_309_2 + arg_309_0 then
				local var_309_3 = manager.ui.mainCamera.transform.localPosition
				local var_309_4 = Vector3.New(0, 0, 10) + Vector3.New(var_309_3.x, var_309_3.y, 0)
				local var_309_5 = arg_306_1.bgs_.ST84a

				var_309_5.transform.localPosition = var_309_4
				var_309_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_309_6 = var_309_5:GetComponent("SpriteRenderer")

				if var_309_6 and var_309_6.sprite then
					local var_309_7 = (var_309_5.transform.localPosition - var_309_3).z
					local var_309_8 = manager.ui.mainCameraCom_
					local var_309_9 = 2 * var_309_7 * Mathf.Tan(var_309_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_309_10 = var_309_9 * var_309_8.aspect
					local var_309_11 = var_309_6.sprite.bounds.size.x
					local var_309_12 = var_309_6.sprite.bounds.size.y
					local var_309_13 = var_309_10 / var_309_11
					local var_309_14 = var_309_9 / var_309_12
					local var_309_15 = var_309_14 < var_309_13 and var_309_13 or var_309_14

					var_309_5.transform.localScale = Vector3.New(var_309_15, var_309_15, 0)
				end

				for iter_309_0, iter_309_1 in pairs(arg_306_1.bgs_) do
					if iter_309_0 ~= "ST84a" then
						iter_309_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_309_16 = 2

			if var_309_16 < arg_306_1.time_ and arg_306_1.time_ <= var_309_16 + arg_309_0 then
				arg_306_1.allBtn_.enabled = false
			end

			local var_309_17 = 0.3

			if arg_306_1.time_ >= var_309_16 + var_309_17 and arg_306_1.time_ < var_309_16 + var_309_17 + arg_309_0 then
				arg_306_1.allBtn_.enabled = true
			end

			local var_309_18 = 0.466666666666667

			if var_309_18 < arg_306_1.time_ and arg_306_1.time_ <= var_309_18 + arg_309_0 then
				arg_306_1.mask_.enabled = true
				arg_306_1.mask_.raycastTarget = true

				arg_306_1:SetGaussion(false)
			end

			local var_309_19 = 2

			if var_309_18 <= arg_306_1.time_ and arg_306_1.time_ < var_309_18 + var_309_19 then
				local var_309_20 = (arg_306_1.time_ - var_309_18) / var_309_19
				local var_309_21 = Color.New(1, 1, 1)

				var_309_21.a = Mathf.Lerp(1, 0, var_309_20)
				arg_306_1.mask_.color = var_309_21
			end

			if arg_306_1.time_ >= var_309_18 + var_309_19 and arg_306_1.time_ < var_309_18 + var_309_19 + arg_309_0 then
				local var_309_22 = Color.New(1, 1, 1)
				local var_309_23 = 0

				arg_306_1.mask_.enabled = false
				var_309_22.a = var_309_23
				arg_306_1.mask_.color = var_309_22
			end

			local var_309_24 = arg_306_1.actors_["1047ui_story"]
			local var_309_25 = 0.466666666666667

			if var_309_25 < arg_306_1.time_ and arg_306_1.time_ <= var_309_25 + arg_309_0 and not isNil(var_309_24) and arg_306_1.var_.characterEffect1047ui_story == nil then
				arg_306_1.var_.characterEffect1047ui_story = var_309_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_26 = 0.034000001847744

			if var_309_25 <= arg_306_1.time_ and arg_306_1.time_ < var_309_25 + var_309_26 and not isNil(var_309_24) then
				local var_309_27 = (arg_306_1.time_ - var_309_25) / var_309_26

				if arg_306_1.var_.characterEffect1047ui_story and not isNil(var_309_24) then
					local var_309_28 = Mathf.Lerp(0, 0.5, var_309_27)

					arg_306_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1047ui_story.fillRatio = var_309_28
				end
			end

			if arg_306_1.time_ >= var_309_25 + var_309_26 and arg_306_1.time_ < var_309_25 + var_309_26 + arg_309_0 and not isNil(var_309_24) and arg_306_1.var_.characterEffect1047ui_story then
				local var_309_29 = 0.5

				arg_306_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1047ui_story.fillRatio = var_309_29
			end

			local var_309_30 = arg_306_1.actors_["1047ui_story"].transform
			local var_309_31 = 0.466666666666667

			if var_309_31 < arg_306_1.time_ and arg_306_1.time_ <= var_309_31 + arg_309_0 then
				arg_306_1.var_.moveOldPos1047ui_story = var_309_30.localPosition
			end

			local var_309_32 = 0.001

			if var_309_31 <= arg_306_1.time_ and arg_306_1.time_ < var_309_31 + var_309_32 then
				local var_309_33 = (arg_306_1.time_ - var_309_31) / var_309_32
				local var_309_34 = Vector3.New(0, 100, 0)

				var_309_30.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1047ui_story, var_309_34, var_309_33)

				local var_309_35 = manager.ui.mainCamera.transform.position - var_309_30.position

				var_309_30.forward = Vector3.New(var_309_35.x, var_309_35.y, var_309_35.z)

				local var_309_36 = var_309_30.localEulerAngles

				var_309_36.z = 0
				var_309_36.x = 0
				var_309_30.localEulerAngles = var_309_36
			end

			if arg_306_1.time_ >= var_309_31 + var_309_32 and arg_306_1.time_ < var_309_31 + var_309_32 + arg_309_0 then
				var_309_30.localPosition = Vector3.New(0, 100, 0)

				local var_309_37 = manager.ui.mainCamera.transform.position - var_309_30.position

				var_309_30.forward = Vector3.New(var_309_37.x, var_309_37.y, var_309_37.z)

				local var_309_38 = var_309_30.localEulerAngles

				var_309_38.z = 0
				var_309_38.x = 0
				var_309_30.localEulerAngles = var_309_38
			end

			local var_309_39 = 0

			if var_309_39 < arg_306_1.time_ and arg_306_1.time_ <= var_309_39 + arg_309_0 then
				arg_306_1.allBtn_.enabled = false
			end

			local var_309_40 = 0.6

			if arg_306_1.time_ >= var_309_39 + var_309_40 and arg_306_1.time_ < var_309_39 + var_309_40 + arg_309_0 then
				arg_306_1.allBtn_.enabled = true
			end

			local var_309_41 = 1.2
			local var_309_42 = 1

			if var_309_41 < arg_306_1.time_ and arg_306_1.time_ <= var_309_41 + arg_309_0 then
				local var_309_43 = "play"
				local var_309_44 = "effect"

				arg_306_1:AudioAction(var_309_43, var_309_44, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			local var_309_45 = 0.1
			local var_309_46 = 1

			if var_309_45 < arg_306_1.time_ and arg_306_1.time_ <= var_309_45 + arg_309_0 then
				local var_309_47 = "stop"
				local var_309_48 = "effect"

				arg_306_1:AudioAction(var_309_47, var_309_48, "se_story_143", "se_story_143_amb_club", "")
			end

			if arg_306_1.frameCnt_ <= 1 then
				arg_306_1.dialog_:SetActive(false)
			end

			local var_309_49 = 2
			local var_309_50 = 0.55

			if var_309_49 < arg_306_1.time_ and arg_306_1.time_ <= var_309_49 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0

				arg_306_1.dialog_:SetActive(true)

				arg_306_1.dialogCg_.alpha = 0

				local var_309_51 = LeanTween.value(arg_306_1.dialog_, 0, 1, 0.3)

				var_309_51:setOnUpdate(LuaHelper.FloatAction(function(arg_310_0)
					arg_306_1.dialogCg_.alpha = arg_310_0
				end))
				var_309_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_306_1.dialog_)
					var_309_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_306_1.duration_ = arg_306_1.duration_ + 0.3

				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_52 = arg_306_1:GetWordFromCfg(1104704076)
				local var_309_53 = arg_306_1:FormatText(var_309_52.content)

				arg_306_1.text_.text = var_309_53

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_54 = 22
				local var_309_55 = utf8.len(var_309_53)
				local var_309_56 = var_309_54 <= 0 and var_309_50 or var_309_50 * (var_309_55 / var_309_54)

				if var_309_56 > 0 and var_309_50 < var_309_56 then
					arg_306_1.talkMaxDuration = var_309_56
					var_309_49 = var_309_49 + 0.3

					if var_309_56 + var_309_49 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_56 + var_309_49
					end
				end

				arg_306_1.text_.text = var_309_53
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_57 = var_309_49 + 0.3
			local var_309_58 = math.max(var_309_50, arg_306_1.talkMaxDuration)

			if var_309_57 <= arg_306_1.time_ and arg_306_1.time_ < var_309_57 + var_309_58 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_57) / var_309_58

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_57 + var_309_58 and arg_306_1.time_ < var_309_57 + var_309_58 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.466666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play1104704077 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1104704077
		arg_312_1.duration_ = 1.9

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1104704078(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0
			local var_315_1 = 0.125

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_2 = arg_312_1:FormatText(StoryNameCfg[1516].name)

				arg_312_1.leftNameTxt_.text = var_315_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_3 = arg_312_1:GetWordFromCfg(1104704077)
				local var_315_4 = arg_312_1:FormatText(var_315_3.content)

				arg_312_1.text_.text = var_315_4

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_5 = 5
				local var_315_6 = utf8.len(var_315_4)
				local var_315_7 = var_315_5 <= 0 and var_315_1 or var_315_1 * (var_315_6 / var_315_5)

				if var_315_7 > 0 and var_315_1 < var_315_7 then
					arg_312_1.talkMaxDuration = var_315_7

					if var_315_7 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_7 + var_315_0
					end
				end

				arg_312_1.text_.text = var_315_4
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704077", "story_v_side_new_1104704.awb") ~= 0 then
					local var_315_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704077", "story_v_side_new_1104704.awb") / 1000

					if var_315_8 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_8 + var_315_0
					end

					if var_315_3.prefab_name ~= "" and arg_312_1.actors_[var_315_3.prefab_name] ~= nil then
						local var_315_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_3.prefab_name].transform, "story_v_side_new_1104704", "1104704077", "story_v_side_new_1104704.awb")

						arg_312_1:RecordAudio("1104704077", var_315_9)
						arg_312_1:RecordAudio("1104704077", var_315_9)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704077", "story_v_side_new_1104704.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704077", "story_v_side_new_1104704.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_10 = math.max(var_315_1, arg_312_1.talkMaxDuration)

			if var_315_0 <= arg_312_1.time_ and arg_312_1.time_ < var_315_0 + var_315_10 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_0) / var_315_10

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_0 + var_315_10 and arg_312_1.time_ < var_315_0 + var_315_10 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play1104704078 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1104704078
		arg_316_1.duration_ = 1.03

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1104704079(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.05

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_2 = arg_316_1:FormatText(StoryNameCfg[1517].name)

				arg_316_1.leftNameTxt_.text = var_319_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_3 = arg_316_1:GetWordFromCfg(1104704078)
				local var_319_4 = arg_316_1:FormatText(var_319_3.content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 2
				local var_319_6 = utf8.len(var_319_4)
				local var_319_7 = var_319_5 <= 0 and var_319_1 or var_319_1 * (var_319_6 / var_319_5)

				if var_319_7 > 0 and var_319_1 < var_319_7 then
					arg_316_1.talkMaxDuration = var_319_7

					if var_319_7 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704078", "story_v_side_new_1104704.awb") ~= 0 then
					local var_319_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704078", "story_v_side_new_1104704.awb") / 1000

					if var_319_8 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_8 + var_319_0
					end

					if var_319_3.prefab_name ~= "" and arg_316_1.actors_[var_319_3.prefab_name] ~= nil then
						local var_319_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_3.prefab_name].transform, "story_v_side_new_1104704", "1104704078", "story_v_side_new_1104704.awb")

						arg_316_1:RecordAudio("1104704078", var_319_9)
						arg_316_1:RecordAudio("1104704078", var_319_9)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704078", "story_v_side_new_1104704.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704078", "story_v_side_new_1104704.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_10 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_10 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_10

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_10 and arg_316_1.time_ < var_319_0 + var_319_10 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play1104704079 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1104704079
		arg_320_1.duration_ = 5.4

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1104704080(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = manager.ui.mainCamera.transform
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.var_.shakeOldPos = var_323_0.localPosition
			end

			local var_323_2 = 0.4

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / 0.066
				local var_323_4, var_323_5 = math.modf(var_323_3)

				var_323_0.localPosition = Vector3.New(var_323_5 * 0.13, var_323_5 * 0.13, var_323_5 * 0.13) + arg_320_1.var_.shakeOldPos
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 then
				var_323_0.localPosition = arg_320_1.var_.shakeOldPos
			end

			local var_323_6 = manager.ui.mainCamera.transform
			local var_323_7 = 0.4

			if var_323_7 < arg_320_1.time_ and arg_320_1.time_ <= var_323_7 + arg_323_0 then
				local var_323_8 = arg_320_1.var_.effectboguang1caidai2
				local var_323_9
				local var_323_10 = var_323_6

				if not var_323_8 then
					var_323_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), var_323_10)
					var_323_8.name = "caidai2"
					arg_320_1.var_.effectboguang1caidai2 = var_323_8
				else
					var_323_8.transform:SetParent(var_323_10)
				end

				var_323_8.transform.localPosition = Vector3.New(0, 0, -5.19)
				var_323_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_323_11 = 0

			if var_323_11 < arg_320_1.time_ and arg_320_1.time_ <= var_323_11 + arg_323_0 then
				arg_320_1.allBtn_.enabled = false
			end

			local var_323_12 = 1.674999999999

			if arg_320_1.time_ >= var_323_11 + var_323_12 and arg_320_1.time_ < var_323_11 + var_323_12 + arg_323_0 then
				arg_320_1.allBtn_.enabled = true
			end

			local var_323_13 = 0.1
			local var_323_14 = 1

			if var_323_13 < arg_320_1.time_ and arg_320_1.time_ <= var_323_13 + arg_323_0 then
				local var_323_15 = "play"
				local var_323_16 = "effect"

				arg_320_1:AudioAction(var_323_15, var_323_16, "se_story_1311", "se_story_1311_partypopper", "")
			end

			if arg_320_1.frameCnt_ <= 1 then
				arg_320_1.dialog_:SetActive(false)
			end

			local var_323_17 = 0.4
			local var_323_18 = 1.2

			if var_323_17 < arg_320_1.time_ and arg_320_1.time_ <= var_323_17 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0

				arg_320_1.dialog_:SetActive(true)

				arg_320_1.dialogCg_.alpha = 0

				local var_323_19 = LeanTween.value(arg_320_1.dialog_, 0, 1, 0.3)

				var_323_19:setOnUpdate(LuaHelper.FloatAction(function(arg_324_0)
					arg_320_1.dialogCg_.alpha = arg_324_0
				end))
				var_323_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_320_1.dialog_)
					var_323_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_320_1.duration_ = arg_320_1.duration_ + 0.3

				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_20 = arg_320_1:GetWordFromCfg(1104704079)
				local var_323_21 = arg_320_1:FormatText(var_323_20.content)

				arg_320_1.text_.text = var_323_21

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_22 = 48
				local var_323_23 = utf8.len(var_323_21)
				local var_323_24 = var_323_22 <= 0 and var_323_18 or var_323_18 * (var_323_23 / var_323_22)

				if var_323_24 > 0 and var_323_18 < var_323_24 then
					arg_320_1.talkMaxDuration = var_323_24
					var_323_17 = var_323_17 + 0.3

					if var_323_24 + var_323_17 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_24 + var_323_17
					end
				end

				arg_320_1.text_.text = var_323_21
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_25 = var_323_17 + 0.3
			local var_323_26 = math.max(var_323_18, arg_320_1.talkMaxDuration)

			if var_323_25 <= arg_320_1.time_ and arg_320_1.time_ < var_323_25 + var_323_26 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_25) / var_323_26

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_25 + var_323_26 and arg_320_1.time_ < var_323_25 + var_323_26 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1104704080 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1104704080
		arg_326_1.duration_ = 1

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"

			SetActive(arg_326_1.choicesGo_, true)

			for iter_327_0, iter_327_1 in ipairs(arg_326_1.choices_) do
				local var_327_0 = iter_327_0 <= 1

				SetActive(iter_327_1.go, var_327_0)
			end

			arg_326_1.choices_[1].txt.text = arg_326_1:FormatText(StoryChoiceCfg[1661].name)
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1104704081(arg_326_1)
			end

			arg_326_1:RecordChoiceLog(1104704080, 1661)
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.allBtn_.enabled = false
			end

			local var_329_1 = 0.433333333333333

			if arg_326_1.time_ >= var_329_0 + var_329_1 and arg_326_1.time_ < var_329_0 + var_329_1 + arg_329_0 then
				arg_326_1.allBtn_.enabled = true
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1104704081 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1104704081
		arg_330_1.duration_ = 1.8

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1104704082(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.15

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_2 = arg_330_1:FormatText(StoryNameCfg[1518].name)

				arg_330_1.leftNameTxt_.text = var_333_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_3 = arg_330_1:GetWordFromCfg(1104704081)
				local var_333_4 = arg_330_1:FormatText(var_333_3.content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 6
				local var_333_6 = utf8.len(var_333_4)
				local var_333_7 = var_333_5 <= 0 and var_333_1 or var_333_1 * (var_333_6 / var_333_5)

				if var_333_7 > 0 and var_333_1 < var_333_7 then
					arg_330_1.talkMaxDuration = var_333_7

					if var_333_7 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_4
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704081", "story_v_side_new_1104704.awb") ~= 0 then
					local var_333_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704081", "story_v_side_new_1104704.awb") / 1000

					if var_333_8 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_8 + var_333_0
					end

					if var_333_3.prefab_name ~= "" and arg_330_1.actors_[var_333_3.prefab_name] ~= nil then
						local var_333_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_3.prefab_name].transform, "story_v_side_new_1104704", "1104704081", "story_v_side_new_1104704.awb")

						arg_330_1:RecordAudio("1104704081", var_333_9)
						arg_330_1:RecordAudio("1104704081", var_333_9)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704081", "story_v_side_new_1104704.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704081", "story_v_side_new_1104704.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_10 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_10

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_10 and arg_330_1.time_ < var_333_0 + var_333_10 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1104704082 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1104704082
		arg_334_1.duration_ = 2

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1104704083(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["1047ui_story"].transform
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.var_.moveOldPos1047ui_story = var_337_0.localPosition
			end

			local var_337_2 = 0.001

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2
				local var_337_4 = Vector3.New(0, -1.13, -6.2)

				var_337_0.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1047ui_story, var_337_4, var_337_3)

				local var_337_5 = manager.ui.mainCamera.transform.position - var_337_0.position

				var_337_0.forward = Vector3.New(var_337_5.x, var_337_5.y, var_337_5.z)

				local var_337_6 = var_337_0.localEulerAngles

				var_337_6.z = 0
				var_337_6.x = 0
				var_337_0.localEulerAngles = var_337_6
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 then
				var_337_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_337_7 = manager.ui.mainCamera.transform.position - var_337_0.position

				var_337_0.forward = Vector3.New(var_337_7.x, var_337_7.y, var_337_7.z)

				local var_337_8 = var_337_0.localEulerAngles

				var_337_8.z = 0
				var_337_8.x = 0
				var_337_0.localEulerAngles = var_337_8
			end

			local var_337_9 = arg_334_1.actors_["1047ui_story"]
			local var_337_10 = 0

			if var_337_10 < arg_334_1.time_ and arg_334_1.time_ <= var_337_10 + arg_337_0 and not isNil(var_337_9) and arg_334_1.var_.characterEffect1047ui_story == nil then
				arg_334_1.var_.characterEffect1047ui_story = var_337_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_11 = 0.200000002980232

			if var_337_10 <= arg_334_1.time_ and arg_334_1.time_ < var_337_10 + var_337_11 and not isNil(var_337_9) then
				local var_337_12 = (arg_334_1.time_ - var_337_10) / var_337_11

				if arg_334_1.var_.characterEffect1047ui_story and not isNil(var_337_9) then
					arg_334_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= var_337_10 + var_337_11 and arg_334_1.time_ < var_337_10 + var_337_11 + arg_337_0 and not isNil(var_337_9) and arg_334_1.var_.characterEffect1047ui_story then
				arg_334_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_337_13 = 0

			if var_337_13 < arg_334_1.time_ and arg_334_1.time_ <= var_337_13 + arg_337_0 then
				arg_334_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_337_14 = 0

			if var_337_14 < arg_334_1.time_ and arg_334_1.time_ <= var_337_14 + arg_337_0 then
				arg_334_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_337_15 = manager.ui.mainCamera.transform
			local var_337_16 = 0

			if var_337_16 < arg_334_1.time_ and arg_334_1.time_ <= var_337_16 + arg_337_0 then
				local var_337_17 = arg_334_1.var_.effectboguang1caidai2

				if var_337_17 then
					Object.Destroy(var_337_17)

					arg_334_1.var_.effectboguang1caidai2 = nil
				end
			end

			local var_337_18 = 0
			local var_337_19 = 0.15

			if var_337_18 < arg_334_1.time_ and arg_334_1.time_ <= var_337_18 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_20 = arg_334_1:FormatText(StoryNameCfg[1296].name)

				arg_334_1.leftNameTxt_.text = var_337_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_21 = arg_334_1:GetWordFromCfg(1104704082)
				local var_337_22 = arg_334_1:FormatText(var_337_21.content)

				arg_334_1.text_.text = var_337_22

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_23 = 6
				local var_337_24 = utf8.len(var_337_22)
				local var_337_25 = var_337_23 <= 0 and var_337_19 or var_337_19 * (var_337_24 / var_337_23)

				if var_337_25 > 0 and var_337_19 < var_337_25 then
					arg_334_1.talkMaxDuration = var_337_25

					if var_337_25 + var_337_18 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_25 + var_337_18
					end
				end

				arg_334_1.text_.text = var_337_22
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704082", "story_v_side_new_1104704.awb") ~= 0 then
					local var_337_26 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704082", "story_v_side_new_1104704.awb") / 1000

					if var_337_26 + var_337_18 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_26 + var_337_18
					end

					if var_337_21.prefab_name ~= "" and arg_334_1.actors_[var_337_21.prefab_name] ~= nil then
						local var_337_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_21.prefab_name].transform, "story_v_side_new_1104704", "1104704082", "story_v_side_new_1104704.awb")

						arg_334_1:RecordAudio("1104704082", var_337_27)
						arg_334_1:RecordAudio("1104704082", var_337_27)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704082", "story_v_side_new_1104704.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704082", "story_v_side_new_1104704.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_28 = math.max(var_337_19, arg_334_1.talkMaxDuration)

			if var_337_18 <= arg_334_1.time_ and arg_334_1.time_ < var_337_18 + var_337_28 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_18) / var_337_28

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_18 + var_337_28 and arg_334_1.time_ < var_337_18 + var_337_28 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play1104704083 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1104704083
		arg_338_1.duration_ = 11.67

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1104704084(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1047ui_story"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1047ui_story == nil then
				arg_338_1.var_.characterEffect1047ui_story = var_341_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.characterEffect1047ui_story and not isNil(var_341_0) then
					local var_341_4 = Mathf.Lerp(0, 0.5, var_341_3)

					arg_338_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_338_1.var_.characterEffect1047ui_story.fillRatio = var_341_4
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1047ui_story then
				local var_341_5 = 0.5

				arg_338_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_338_1.var_.characterEffect1047ui_story.fillRatio = var_341_5
			end

			local var_341_6 = arg_338_1.actors_["1047ui_story"].transform
			local var_341_7 = 0

			if var_341_7 < arg_338_1.time_ and arg_338_1.time_ <= var_341_7 + arg_341_0 then
				arg_338_1.var_.moveOldPos1047ui_story = var_341_6.localPosition
			end

			local var_341_8 = 0.001

			if var_341_7 <= arg_338_1.time_ and arg_338_1.time_ < var_341_7 + var_341_8 then
				local var_341_9 = (arg_338_1.time_ - var_341_7) / var_341_8
				local var_341_10 = Vector3.New(0, 100, 0)

				var_341_6.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1047ui_story, var_341_10, var_341_9)

				local var_341_11 = manager.ui.mainCamera.transform.position - var_341_6.position

				var_341_6.forward = Vector3.New(var_341_11.x, var_341_11.y, var_341_11.z)

				local var_341_12 = var_341_6.localEulerAngles

				var_341_12.z = 0
				var_341_12.x = 0
				var_341_6.localEulerAngles = var_341_12
			end

			if arg_338_1.time_ >= var_341_7 + var_341_8 and arg_338_1.time_ < var_341_7 + var_341_8 + arg_341_0 then
				var_341_6.localPosition = Vector3.New(0, 100, 0)

				local var_341_13 = manager.ui.mainCamera.transform.position - var_341_6.position

				var_341_6.forward = Vector3.New(var_341_13.x, var_341_13.y, var_341_13.z)

				local var_341_14 = var_341_6.localEulerAngles

				var_341_14.z = 0
				var_341_14.x = 0
				var_341_6.localEulerAngles = var_341_14
			end

			local var_341_15 = 0
			local var_341_16 = 1.075

			if var_341_15 < arg_338_1.time_ and arg_338_1.time_ <= var_341_15 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_17 = arg_338_1:FormatText(StoryNameCfg[1518].name)

				arg_338_1.leftNameTxt_.text = var_341_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_18 = arg_338_1:GetWordFromCfg(1104704083)
				local var_341_19 = arg_338_1:FormatText(var_341_18.content)

				arg_338_1.text_.text = var_341_19

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_20 = 43
				local var_341_21 = utf8.len(var_341_19)
				local var_341_22 = var_341_20 <= 0 and var_341_16 or var_341_16 * (var_341_21 / var_341_20)

				if var_341_22 > 0 and var_341_16 < var_341_22 then
					arg_338_1.talkMaxDuration = var_341_22

					if var_341_22 + var_341_15 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_22 + var_341_15
					end
				end

				arg_338_1.text_.text = var_341_19
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704083", "story_v_side_new_1104704.awb") ~= 0 then
					local var_341_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704083", "story_v_side_new_1104704.awb") / 1000

					if var_341_23 + var_341_15 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_23 + var_341_15
					end

					if var_341_18.prefab_name ~= "" and arg_338_1.actors_[var_341_18.prefab_name] ~= nil then
						local var_341_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_18.prefab_name].transform, "story_v_side_new_1104704", "1104704083", "story_v_side_new_1104704.awb")

						arg_338_1:RecordAudio("1104704083", var_341_24)
						arg_338_1:RecordAudio("1104704083", var_341_24)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704083", "story_v_side_new_1104704.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704083", "story_v_side_new_1104704.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_25 = math.max(var_341_16, arg_338_1.talkMaxDuration)

			if var_341_15 <= arg_338_1.time_ and arg_338_1.time_ < var_341_15 + var_341_25 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_15) / var_341_25

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_15 + var_341_25 and arg_338_1.time_ < var_341_15 + var_341_25 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play1104704084 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1104704084
		arg_342_1.duration_ = 15.1

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1104704085(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0
			local var_345_1 = 1.35

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_2 = arg_342_1:FormatText(StoryNameCfg[1518].name)

				arg_342_1.leftNameTxt_.text = var_345_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_3 = arg_342_1:GetWordFromCfg(1104704084)
				local var_345_4 = arg_342_1:FormatText(var_345_3.content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 54
				local var_345_6 = utf8.len(var_345_4)
				local var_345_7 = var_345_5 <= 0 and var_345_1 or var_345_1 * (var_345_6 / var_345_5)

				if var_345_7 > 0 and var_345_1 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_4
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704084", "story_v_side_new_1104704.awb") ~= 0 then
					local var_345_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704084", "story_v_side_new_1104704.awb") / 1000

					if var_345_8 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_8 + var_345_0
					end

					if var_345_3.prefab_name ~= "" and arg_342_1.actors_[var_345_3.prefab_name] ~= nil then
						local var_345_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_3.prefab_name].transform, "story_v_side_new_1104704", "1104704084", "story_v_side_new_1104704.awb")

						arg_342_1:RecordAudio("1104704084", var_345_9)
						arg_342_1:RecordAudio("1104704084", var_345_9)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704084", "story_v_side_new_1104704.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704084", "story_v_side_new_1104704.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_10 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_10 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_10

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_10 and arg_342_1.time_ < var_345_0 + var_345_10 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play1104704085 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1104704085
		arg_346_1.duration_ = 4.03

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1104704086(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1047ui_story"].transform
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.var_.moveOldPos1047ui_story = var_349_0.localPosition
			end

			local var_349_2 = 0.001

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2
				local var_349_4 = Vector3.New(0, -1.13, -6.2)

				var_349_0.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1047ui_story, var_349_4, var_349_3)

				local var_349_5 = manager.ui.mainCamera.transform.position - var_349_0.position

				var_349_0.forward = Vector3.New(var_349_5.x, var_349_5.y, var_349_5.z)

				local var_349_6 = var_349_0.localEulerAngles

				var_349_6.z = 0
				var_349_6.x = 0
				var_349_0.localEulerAngles = var_349_6
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 then
				var_349_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_349_7 = manager.ui.mainCamera.transform.position - var_349_0.position

				var_349_0.forward = Vector3.New(var_349_7.x, var_349_7.y, var_349_7.z)

				local var_349_8 = var_349_0.localEulerAngles

				var_349_8.z = 0
				var_349_8.x = 0
				var_349_0.localEulerAngles = var_349_8
			end

			local var_349_9 = arg_346_1.actors_["1047ui_story"]
			local var_349_10 = 0

			if var_349_10 < arg_346_1.time_ and arg_346_1.time_ <= var_349_10 + arg_349_0 and not isNil(var_349_9) and arg_346_1.var_.characterEffect1047ui_story == nil then
				arg_346_1.var_.characterEffect1047ui_story = var_349_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_11 = 0.200000002980232

			if var_349_10 <= arg_346_1.time_ and arg_346_1.time_ < var_349_10 + var_349_11 and not isNil(var_349_9) then
				local var_349_12 = (arg_346_1.time_ - var_349_10) / var_349_11

				if arg_346_1.var_.characterEffect1047ui_story and not isNil(var_349_9) then
					arg_346_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= var_349_10 + var_349_11 and arg_346_1.time_ < var_349_10 + var_349_11 + arg_349_0 and not isNil(var_349_9) and arg_346_1.var_.characterEffect1047ui_story then
				arg_346_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_349_13 = 0

			if var_349_13 < arg_346_1.time_ and arg_346_1.time_ <= var_349_13 + arg_349_0 then
				arg_346_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			local var_349_14 = 0

			if var_349_14 < arg_346_1.time_ and arg_346_1.time_ <= var_349_14 + arg_349_0 then
				arg_346_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_349_15 = 0
			local var_349_16 = 0.45

			if var_349_15 < arg_346_1.time_ and arg_346_1.time_ <= var_349_15 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_17 = arg_346_1:FormatText(StoryNameCfg[1296].name)

				arg_346_1.leftNameTxt_.text = var_349_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_18 = arg_346_1:GetWordFromCfg(1104704085)
				local var_349_19 = arg_346_1:FormatText(var_349_18.content)

				arg_346_1.text_.text = var_349_19

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_20 = 18
				local var_349_21 = utf8.len(var_349_19)
				local var_349_22 = var_349_20 <= 0 and var_349_16 or var_349_16 * (var_349_21 / var_349_20)

				if var_349_22 > 0 and var_349_16 < var_349_22 then
					arg_346_1.talkMaxDuration = var_349_22

					if var_349_22 + var_349_15 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_22 + var_349_15
					end
				end

				arg_346_1.text_.text = var_349_19
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704085", "story_v_side_new_1104704.awb") ~= 0 then
					local var_349_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704085", "story_v_side_new_1104704.awb") / 1000

					if var_349_23 + var_349_15 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_23 + var_349_15
					end

					if var_349_18.prefab_name ~= "" and arg_346_1.actors_[var_349_18.prefab_name] ~= nil then
						local var_349_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_18.prefab_name].transform, "story_v_side_new_1104704", "1104704085", "story_v_side_new_1104704.awb")

						arg_346_1:RecordAudio("1104704085", var_349_24)
						arg_346_1:RecordAudio("1104704085", var_349_24)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704085", "story_v_side_new_1104704.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704085", "story_v_side_new_1104704.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_25 = math.max(var_349_16, arg_346_1.talkMaxDuration)

			if var_349_15 <= arg_346_1.time_ and arg_346_1.time_ < var_349_15 + var_349_25 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_15) / var_349_25

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_15 + var_349_25 and arg_346_1.time_ < var_349_15 + var_349_25 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play1104704086 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1104704086
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1104704087(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1047ui_story"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1047ui_story == nil then
				arg_350_1.var_.characterEffect1047ui_story = var_353_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.characterEffect1047ui_story and not isNil(var_353_0) then
					local var_353_4 = Mathf.Lerp(0, 0.5, var_353_3)

					arg_350_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_350_1.var_.characterEffect1047ui_story.fillRatio = var_353_4
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1047ui_story then
				local var_353_5 = 0.5

				arg_350_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_350_1.var_.characterEffect1047ui_story.fillRatio = var_353_5
			end

			local var_353_6 = arg_350_1.actors_["1047ui_story"].transform
			local var_353_7 = 0

			if var_353_7 < arg_350_1.time_ and arg_350_1.time_ <= var_353_7 + arg_353_0 then
				arg_350_1.var_.moveOldPos1047ui_story = var_353_6.localPosition
			end

			local var_353_8 = 0.001

			if var_353_7 <= arg_350_1.time_ and arg_350_1.time_ < var_353_7 + var_353_8 then
				local var_353_9 = (arg_350_1.time_ - var_353_7) / var_353_8
				local var_353_10 = Vector3.New(0, 100, 0)

				var_353_6.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1047ui_story, var_353_10, var_353_9)

				local var_353_11 = manager.ui.mainCamera.transform.position - var_353_6.position

				var_353_6.forward = Vector3.New(var_353_11.x, var_353_11.y, var_353_11.z)

				local var_353_12 = var_353_6.localEulerAngles

				var_353_12.z = 0
				var_353_12.x = 0
				var_353_6.localEulerAngles = var_353_12
			end

			if arg_350_1.time_ >= var_353_7 + var_353_8 and arg_350_1.time_ < var_353_7 + var_353_8 + arg_353_0 then
				var_353_6.localPosition = Vector3.New(0, 100, 0)

				local var_353_13 = manager.ui.mainCamera.transform.position - var_353_6.position

				var_353_6.forward = Vector3.New(var_353_13.x, var_353_13.y, var_353_13.z)

				local var_353_14 = var_353_6.localEulerAngles

				var_353_14.z = 0
				var_353_14.x = 0
				var_353_6.localEulerAngles = var_353_14
			end

			local var_353_15 = 0
			local var_353_16 = 0.625

			if var_353_15 < arg_350_1.time_ and arg_350_1.time_ <= var_353_15 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_17 = arg_350_1:GetWordFromCfg(1104704086)
				local var_353_18 = arg_350_1:FormatText(var_353_17.content)

				arg_350_1.text_.text = var_353_18

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_19 = 25
				local var_353_20 = utf8.len(var_353_18)
				local var_353_21 = var_353_19 <= 0 and var_353_16 or var_353_16 * (var_353_20 / var_353_19)

				if var_353_21 > 0 and var_353_16 < var_353_21 then
					arg_350_1.talkMaxDuration = var_353_21

					if var_353_21 + var_353_15 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_21 + var_353_15
					end
				end

				arg_350_1.text_.text = var_353_18
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_22 = math.max(var_353_16, arg_350_1.talkMaxDuration)

			if var_353_15 <= arg_350_1.time_ and arg_350_1.time_ < var_353_15 + var_353_22 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_15) / var_353_22

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_15 + var_353_22 and arg_350_1.time_ < var_353_15 + var_353_22 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play1104704087 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1104704087
		arg_354_1.duration_ = 5.6

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1104704088(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0
			local var_357_1 = 0.725

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_2 = arg_354_1:FormatText(StoryNameCfg[1517].name)

				arg_354_1.leftNameTxt_.text = var_357_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_3 = arg_354_1:GetWordFromCfg(1104704087)
				local var_357_4 = arg_354_1:FormatText(var_357_3.content)

				arg_354_1.text_.text = var_357_4

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 29
				local var_357_6 = utf8.len(var_357_4)
				local var_357_7 = var_357_5 <= 0 and var_357_1 or var_357_1 * (var_357_6 / var_357_5)

				if var_357_7 > 0 and var_357_1 < var_357_7 then
					arg_354_1.talkMaxDuration = var_357_7

					if var_357_7 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_7 + var_357_0
					end
				end

				arg_354_1.text_.text = var_357_4
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704087", "story_v_side_new_1104704.awb") ~= 0 then
					local var_357_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704087", "story_v_side_new_1104704.awb") / 1000

					if var_357_8 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_8 + var_357_0
					end

					if var_357_3.prefab_name ~= "" and arg_354_1.actors_[var_357_3.prefab_name] ~= nil then
						local var_357_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_3.prefab_name].transform, "story_v_side_new_1104704", "1104704087", "story_v_side_new_1104704.awb")

						arg_354_1:RecordAudio("1104704087", var_357_9)
						arg_354_1:RecordAudio("1104704087", var_357_9)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704087", "story_v_side_new_1104704.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704087", "story_v_side_new_1104704.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_10 = math.max(var_357_1, arg_354_1.talkMaxDuration)

			if var_357_0 <= arg_354_1.time_ and arg_354_1.time_ < var_357_0 + var_357_10 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_0) / var_357_10

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_0 + var_357_10 and arg_354_1.time_ < var_357_0 + var_357_10 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play1104704088 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1104704088
		arg_358_1.duration_ = 8.67

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1104704089(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 0.95

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_2 = arg_358_1:FormatText(StoryNameCfg[1517].name)

				arg_358_1.leftNameTxt_.text = var_361_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:GetWordFromCfg(1104704088)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 38
				local var_361_6 = utf8.len(var_361_4)
				local var_361_7 = var_361_5 <= 0 and var_361_1 or var_361_1 * (var_361_6 / var_361_5)

				if var_361_7 > 0 and var_361_1 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_0
					end
				end

				arg_358_1.text_.text = var_361_4
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704088", "story_v_side_new_1104704.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704088", "story_v_side_new_1104704.awb") / 1000

					if var_361_8 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_0
					end

					if var_361_3.prefab_name ~= "" and arg_358_1.actors_[var_361_3.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_3.prefab_name].transform, "story_v_side_new_1104704", "1104704088", "story_v_side_new_1104704.awb")

						arg_358_1:RecordAudio("1104704088", var_361_9)
						arg_358_1:RecordAudio("1104704088", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704088", "story_v_side_new_1104704.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704088", "story_v_side_new_1104704.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_10 and arg_358_1.time_ < var_361_0 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1104704089 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1104704089
		arg_362_1.duration_ = 9.1

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1104704090(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0
			local var_365_1 = 1.1

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_2 = arg_362_1:FormatText(StoryNameCfg[1517].name)

				arg_362_1.leftNameTxt_.text = var_365_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_3 = arg_362_1:GetWordFromCfg(1104704089)
				local var_365_4 = arg_362_1:FormatText(var_365_3.content)

				arg_362_1.text_.text = var_365_4

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 44
				local var_365_6 = utf8.len(var_365_4)
				local var_365_7 = var_365_5 <= 0 and var_365_1 or var_365_1 * (var_365_6 / var_365_5)

				if var_365_7 > 0 and var_365_1 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_4
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704089", "story_v_side_new_1104704.awb") ~= 0 then
					local var_365_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704089", "story_v_side_new_1104704.awb") / 1000

					if var_365_8 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_8 + var_365_0
					end

					if var_365_3.prefab_name ~= "" and arg_362_1.actors_[var_365_3.prefab_name] ~= nil then
						local var_365_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_3.prefab_name].transform, "story_v_side_new_1104704", "1104704089", "story_v_side_new_1104704.awb")

						arg_362_1:RecordAudio("1104704089", var_365_9)
						arg_362_1:RecordAudio("1104704089", var_365_9)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704089", "story_v_side_new_1104704.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704089", "story_v_side_new_1104704.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_10 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_10 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_10

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_10 and arg_362_1.time_ < var_365_0 + var_365_10 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1104704090 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1104704090
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1104704091(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0
			local var_369_1 = 0.775

			if var_369_0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_2 = arg_366_1:GetWordFromCfg(1104704090)
				local var_369_3 = arg_366_1:FormatText(var_369_2.content)

				arg_366_1.text_.text = var_369_3

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_4 = 31
				local var_369_5 = utf8.len(var_369_3)
				local var_369_6 = var_369_4 <= 0 and var_369_1 or var_369_1 * (var_369_5 / var_369_4)

				if var_369_6 > 0 and var_369_1 < var_369_6 then
					arg_366_1.talkMaxDuration = var_369_6

					if var_369_6 + var_369_0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_6 + var_369_0
					end
				end

				arg_366_1.text_.text = var_369_3
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_7 = math.max(var_369_1, arg_366_1.talkMaxDuration)

			if var_369_0 <= arg_366_1.time_ and arg_366_1.time_ < var_369_0 + var_369_7 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_0) / var_369_7

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_0 + var_369_7 and arg_366_1.time_ < var_369_0 + var_369_7 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1104704091 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1104704091
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1104704092(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0
			local var_373_1 = 1.5

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, false)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_2 = arg_370_1:GetWordFromCfg(1104704091)
				local var_373_3 = arg_370_1:FormatText(var_373_2.content)

				arg_370_1.text_.text = var_373_3

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_4 = 60
				local var_373_5 = utf8.len(var_373_3)
				local var_373_6 = var_373_4 <= 0 and var_373_1 or var_373_1 * (var_373_5 / var_373_4)

				if var_373_6 > 0 and var_373_1 < var_373_6 then
					arg_370_1.talkMaxDuration = var_373_6

					if var_373_6 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_6 + var_373_0
					end
				end

				arg_370_1.text_.text = var_373_3
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_7 = math.max(var_373_1, arg_370_1.talkMaxDuration)

			if var_373_0 <= arg_370_1.time_ and arg_370_1.time_ < var_373_0 + var_373_7 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_0) / var_373_7

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_0 + var_373_7 and arg_370_1.time_ < var_373_0 + var_373_7 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play1104704092 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1104704092
		arg_374_1.duration_ = 4.73

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1104704093(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["1047ui_story"].transform
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 then
				arg_374_1.var_.moveOldPos1047ui_story = var_377_0.localPosition
			end

			local var_377_2 = 0.001

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2
				local var_377_4 = Vector3.New(0, -1.13, -6.2)

				var_377_0.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1047ui_story, var_377_4, var_377_3)

				local var_377_5 = manager.ui.mainCamera.transform.position - var_377_0.position

				var_377_0.forward = Vector3.New(var_377_5.x, var_377_5.y, var_377_5.z)

				local var_377_6 = var_377_0.localEulerAngles

				var_377_6.z = 0
				var_377_6.x = 0
				var_377_0.localEulerAngles = var_377_6
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 then
				var_377_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_377_7 = manager.ui.mainCamera.transform.position - var_377_0.position

				var_377_0.forward = Vector3.New(var_377_7.x, var_377_7.y, var_377_7.z)

				local var_377_8 = var_377_0.localEulerAngles

				var_377_8.z = 0
				var_377_8.x = 0
				var_377_0.localEulerAngles = var_377_8
			end

			local var_377_9 = arg_374_1.actors_["1047ui_story"]
			local var_377_10 = 0

			if var_377_10 < arg_374_1.time_ and arg_374_1.time_ <= var_377_10 + arg_377_0 and not isNil(var_377_9) and arg_374_1.var_.characterEffect1047ui_story == nil then
				arg_374_1.var_.characterEffect1047ui_story = var_377_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_11 = 0.200000002980232

			if var_377_10 <= arg_374_1.time_ and arg_374_1.time_ < var_377_10 + var_377_11 and not isNil(var_377_9) then
				local var_377_12 = (arg_374_1.time_ - var_377_10) / var_377_11

				if arg_374_1.var_.characterEffect1047ui_story and not isNil(var_377_9) then
					arg_374_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= var_377_10 + var_377_11 and arg_374_1.time_ < var_377_10 + var_377_11 + arg_377_0 and not isNil(var_377_9) and arg_374_1.var_.characterEffect1047ui_story then
				arg_374_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_377_13 = 0

			if var_377_13 < arg_374_1.time_ and arg_374_1.time_ <= var_377_13 + arg_377_0 then
				arg_374_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_377_14 = 0

			if var_377_14 < arg_374_1.time_ and arg_374_1.time_ <= var_377_14 + arg_377_0 then
				arg_374_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_377_15 = 0
			local var_377_16 = 0.55

			if var_377_15 < arg_374_1.time_ and arg_374_1.time_ <= var_377_15 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_17 = arg_374_1:FormatText(StoryNameCfg[1296].name)

				arg_374_1.leftNameTxt_.text = var_377_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_18 = arg_374_1:GetWordFromCfg(1104704092)
				local var_377_19 = arg_374_1:FormatText(var_377_18.content)

				arg_374_1.text_.text = var_377_19

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_20 = 22
				local var_377_21 = utf8.len(var_377_19)
				local var_377_22 = var_377_20 <= 0 and var_377_16 or var_377_16 * (var_377_21 / var_377_20)

				if var_377_22 > 0 and var_377_16 < var_377_22 then
					arg_374_1.talkMaxDuration = var_377_22

					if var_377_22 + var_377_15 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_22 + var_377_15
					end
				end

				arg_374_1.text_.text = var_377_19
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704092", "story_v_side_new_1104704.awb") ~= 0 then
					local var_377_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704092", "story_v_side_new_1104704.awb") / 1000

					if var_377_23 + var_377_15 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_23 + var_377_15
					end

					if var_377_18.prefab_name ~= "" and arg_374_1.actors_[var_377_18.prefab_name] ~= nil then
						local var_377_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_18.prefab_name].transform, "story_v_side_new_1104704", "1104704092", "story_v_side_new_1104704.awb")

						arg_374_1:RecordAudio("1104704092", var_377_24)
						arg_374_1:RecordAudio("1104704092", var_377_24)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704092", "story_v_side_new_1104704.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704092", "story_v_side_new_1104704.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_25 = math.max(var_377_16, arg_374_1.talkMaxDuration)

			if var_377_15 <= arg_374_1.time_ and arg_374_1.time_ < var_377_15 + var_377_25 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_15) / var_377_25

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_15 + var_377_25 and arg_374_1.time_ < var_377_15 + var_377_25 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play1104704093 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1104704093
		arg_378_1.duration_ = 6.47

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1104704094(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1047ui_story"]
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1047ui_story == nil then
				arg_378_1.var_.characterEffect1047ui_story = var_381_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 and not isNil(var_381_0) then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2

				if arg_378_1.var_.characterEffect1047ui_story and not isNil(var_381_0) then
					local var_381_4 = Mathf.Lerp(0, 0.5, var_381_3)

					arg_378_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1047ui_story.fillRatio = var_381_4
				end
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1047ui_story then
				local var_381_5 = 0.5

				arg_378_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1047ui_story.fillRatio = var_381_5
			end

			local var_381_6 = 0
			local var_381_7 = 0.725

			if var_381_6 < arg_378_1.time_ and arg_378_1.time_ <= var_381_6 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_8 = arg_378_1:FormatText(StoryNameCfg[1516].name)

				arg_378_1.leftNameTxt_.text = var_381_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_9 = arg_378_1:GetWordFromCfg(1104704093)
				local var_381_10 = arg_378_1:FormatText(var_381_9.content)

				arg_378_1.text_.text = var_381_10

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_11 = 29
				local var_381_12 = utf8.len(var_381_10)
				local var_381_13 = var_381_11 <= 0 and var_381_7 or var_381_7 * (var_381_12 / var_381_11)

				if var_381_13 > 0 and var_381_7 < var_381_13 then
					arg_378_1.talkMaxDuration = var_381_13

					if var_381_13 + var_381_6 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_13 + var_381_6
					end
				end

				arg_378_1.text_.text = var_381_10
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704093", "story_v_side_new_1104704.awb") ~= 0 then
					local var_381_14 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704093", "story_v_side_new_1104704.awb") / 1000

					if var_381_14 + var_381_6 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_14 + var_381_6
					end

					if var_381_9.prefab_name ~= "" and arg_378_1.actors_[var_381_9.prefab_name] ~= nil then
						local var_381_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_9.prefab_name].transform, "story_v_side_new_1104704", "1104704093", "story_v_side_new_1104704.awb")

						arg_378_1:RecordAudio("1104704093", var_381_15)
						arg_378_1:RecordAudio("1104704093", var_381_15)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704093", "story_v_side_new_1104704.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704093", "story_v_side_new_1104704.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_16 = math.max(var_381_7, arg_378_1.talkMaxDuration)

			if var_381_6 <= arg_378_1.time_ and arg_378_1.time_ < var_381_6 + var_381_16 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_6) / var_381_16

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_6 + var_381_16 and arg_378_1.time_ < var_381_6 + var_381_16 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1104704094 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1104704094
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1104704095(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["1047ui_story"].transform
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.var_.moveOldPos1047ui_story = var_385_0.localPosition
			end

			local var_385_2 = 0.001

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2
				local var_385_4 = Vector3.New(0, 100, 0)

				var_385_0.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1047ui_story, var_385_4, var_385_3)

				local var_385_5 = manager.ui.mainCamera.transform.position - var_385_0.position

				var_385_0.forward = Vector3.New(var_385_5.x, var_385_5.y, var_385_5.z)

				local var_385_6 = var_385_0.localEulerAngles

				var_385_6.z = 0
				var_385_6.x = 0
				var_385_0.localEulerAngles = var_385_6
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 then
				var_385_0.localPosition = Vector3.New(0, 100, 0)

				local var_385_7 = manager.ui.mainCamera.transform.position - var_385_0.position

				var_385_0.forward = Vector3.New(var_385_7.x, var_385_7.y, var_385_7.z)

				local var_385_8 = var_385_0.localEulerAngles

				var_385_8.z = 0
				var_385_8.x = 0
				var_385_0.localEulerAngles = var_385_8
			end

			local var_385_9 = 0
			local var_385_10 = 1.325

			if var_385_9 < arg_382_1.time_ and arg_382_1.time_ <= var_385_9 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_11 = arg_382_1:GetWordFromCfg(1104704094)
				local var_385_12 = arg_382_1:FormatText(var_385_11.content)

				arg_382_1.text_.text = var_385_12

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_13 = 53
				local var_385_14 = utf8.len(var_385_12)
				local var_385_15 = var_385_13 <= 0 and var_385_10 or var_385_10 * (var_385_14 / var_385_13)

				if var_385_15 > 0 and var_385_10 < var_385_15 then
					arg_382_1.talkMaxDuration = var_385_15

					if var_385_15 + var_385_9 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_15 + var_385_9
					end
				end

				arg_382_1.text_.text = var_385_12
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_16 = math.max(var_385_10, arg_382_1.talkMaxDuration)

			if var_385_9 <= arg_382_1.time_ and arg_382_1.time_ < var_385_9 + var_385_16 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_9) / var_385_16

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_9 + var_385_16 and arg_382_1.time_ < var_385_9 + var_385_16 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play1104704095 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1104704095
		arg_386_1.duration_ = 3.9

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1104704096(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["1047ui_story"].transform
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.var_.moveOldPos1047ui_story = var_389_0.localPosition
			end

			local var_389_2 = 0.001

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2
				local var_389_4 = Vector3.New(0, -1.13, -6.2)

				var_389_0.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1047ui_story, var_389_4, var_389_3)

				local var_389_5 = manager.ui.mainCamera.transform.position - var_389_0.position

				var_389_0.forward = Vector3.New(var_389_5.x, var_389_5.y, var_389_5.z)

				local var_389_6 = var_389_0.localEulerAngles

				var_389_6.z = 0
				var_389_6.x = 0
				var_389_0.localEulerAngles = var_389_6
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 then
				var_389_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_389_7 = manager.ui.mainCamera.transform.position - var_389_0.position

				var_389_0.forward = Vector3.New(var_389_7.x, var_389_7.y, var_389_7.z)

				local var_389_8 = var_389_0.localEulerAngles

				var_389_8.z = 0
				var_389_8.x = 0
				var_389_0.localEulerAngles = var_389_8
			end

			local var_389_9 = arg_386_1.actors_["1047ui_story"]
			local var_389_10 = 0

			if var_389_10 < arg_386_1.time_ and arg_386_1.time_ <= var_389_10 + arg_389_0 and not isNil(var_389_9) and arg_386_1.var_.characterEffect1047ui_story == nil then
				arg_386_1.var_.characterEffect1047ui_story = var_389_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_11 = 0.200000002980232

			if var_389_10 <= arg_386_1.time_ and arg_386_1.time_ < var_389_10 + var_389_11 and not isNil(var_389_9) then
				local var_389_12 = (arg_386_1.time_ - var_389_10) / var_389_11

				if arg_386_1.var_.characterEffect1047ui_story and not isNil(var_389_9) then
					arg_386_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= var_389_10 + var_389_11 and arg_386_1.time_ < var_389_10 + var_389_11 + arg_389_0 and not isNil(var_389_9) and arg_386_1.var_.characterEffect1047ui_story then
				arg_386_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_389_13 = 0

			if var_389_13 < arg_386_1.time_ and arg_386_1.time_ <= var_389_13 + arg_389_0 then
				arg_386_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_389_14 = 0

			if var_389_14 < arg_386_1.time_ and arg_386_1.time_ <= var_389_14 + arg_389_0 then
				arg_386_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_389_15 = 0
			local var_389_16 = 0.425

			if var_389_15 < arg_386_1.time_ and arg_386_1.time_ <= var_389_15 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_17 = arg_386_1:FormatText(StoryNameCfg[1296].name)

				arg_386_1.leftNameTxt_.text = var_389_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_18 = arg_386_1:GetWordFromCfg(1104704095)
				local var_389_19 = arg_386_1:FormatText(var_389_18.content)

				arg_386_1.text_.text = var_389_19

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_20 = 17
				local var_389_21 = utf8.len(var_389_19)
				local var_389_22 = var_389_20 <= 0 and var_389_16 or var_389_16 * (var_389_21 / var_389_20)

				if var_389_22 > 0 and var_389_16 < var_389_22 then
					arg_386_1.talkMaxDuration = var_389_22

					if var_389_22 + var_389_15 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_22 + var_389_15
					end
				end

				arg_386_1.text_.text = var_389_19
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704095", "story_v_side_new_1104704.awb") ~= 0 then
					local var_389_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704095", "story_v_side_new_1104704.awb") / 1000

					if var_389_23 + var_389_15 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_23 + var_389_15
					end

					if var_389_18.prefab_name ~= "" and arg_386_1.actors_[var_389_18.prefab_name] ~= nil then
						local var_389_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_18.prefab_name].transform, "story_v_side_new_1104704", "1104704095", "story_v_side_new_1104704.awb")

						arg_386_1:RecordAudio("1104704095", var_389_24)
						arg_386_1:RecordAudio("1104704095", var_389_24)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704095", "story_v_side_new_1104704.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704095", "story_v_side_new_1104704.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_25 = math.max(var_389_16, arg_386_1.talkMaxDuration)

			if var_389_15 <= arg_386_1.time_ and arg_386_1.time_ < var_389_15 + var_389_25 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_15) / var_389_25

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_15 + var_389_25 and arg_386_1.time_ < var_389_15 + var_389_25 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play1104704096 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1104704096
		arg_390_1.duration_ = 10.43

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1104704097(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["1047ui_story"].transform
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.var_.moveOldPos1047ui_story = var_393_0.localPosition
			end

			local var_393_2 = 0.001

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2
				local var_393_4 = Vector3.New(0, -1.13, -6.2)

				var_393_0.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1047ui_story, var_393_4, var_393_3)

				local var_393_5 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_5.x, var_393_5.y, var_393_5.z)

				local var_393_6 = var_393_0.localEulerAngles

				var_393_6.z = 0
				var_393_6.x = 0
				var_393_0.localEulerAngles = var_393_6
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 then
				var_393_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_393_7 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_7.x, var_393_7.y, var_393_7.z)

				local var_393_8 = var_393_0.localEulerAngles

				var_393_8.z = 0
				var_393_8.x = 0
				var_393_0.localEulerAngles = var_393_8
			end

			local var_393_9 = 0

			if var_393_9 < arg_390_1.time_ and arg_390_1.time_ <= var_393_9 + arg_393_0 then
				arg_390_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action467")
			end

			local var_393_10 = 0

			if var_393_10 < arg_390_1.time_ and arg_390_1.time_ <= var_393_10 + arg_393_0 then
				arg_390_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_393_11 = 0
			local var_393_12 = 0.9

			if var_393_11 < arg_390_1.time_ and arg_390_1.time_ <= var_393_11 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_13 = arg_390_1:FormatText(StoryNameCfg[1296].name)

				arg_390_1.leftNameTxt_.text = var_393_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_14 = arg_390_1:GetWordFromCfg(1104704096)
				local var_393_15 = arg_390_1:FormatText(var_393_14.content)

				arg_390_1.text_.text = var_393_15

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_16 = 36
				local var_393_17 = utf8.len(var_393_15)
				local var_393_18 = var_393_16 <= 0 and var_393_12 or var_393_12 * (var_393_17 / var_393_16)

				if var_393_18 > 0 and var_393_12 < var_393_18 then
					arg_390_1.talkMaxDuration = var_393_18

					if var_393_18 + var_393_11 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_18 + var_393_11
					end
				end

				arg_390_1.text_.text = var_393_15
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704096", "story_v_side_new_1104704.awb") ~= 0 then
					local var_393_19 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704096", "story_v_side_new_1104704.awb") / 1000

					if var_393_19 + var_393_11 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_19 + var_393_11
					end

					if var_393_14.prefab_name ~= "" and arg_390_1.actors_[var_393_14.prefab_name] ~= nil then
						local var_393_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_14.prefab_name].transform, "story_v_side_new_1104704", "1104704096", "story_v_side_new_1104704.awb")

						arg_390_1:RecordAudio("1104704096", var_393_20)
						arg_390_1:RecordAudio("1104704096", var_393_20)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704096", "story_v_side_new_1104704.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704096", "story_v_side_new_1104704.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_21 = math.max(var_393_12, arg_390_1.talkMaxDuration)

			if var_393_11 <= arg_390_1.time_ and arg_390_1.time_ < var_393_11 + var_393_21 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_11) / var_393_21

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_11 + var_393_21 and arg_390_1.time_ < var_393_11 + var_393_21 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play1104704097 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1104704097
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1104704098(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1047ui_story"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1047ui_story == nil then
				arg_394_1.var_.characterEffect1047ui_story = var_397_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.characterEffect1047ui_story and not isNil(var_397_0) then
					local var_397_4 = Mathf.Lerp(0, 0.5, var_397_3)

					arg_394_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1047ui_story.fillRatio = var_397_4
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1047ui_story then
				local var_397_5 = 0.5

				arg_394_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1047ui_story.fillRatio = var_397_5
			end

			local var_397_6 = arg_394_1.actors_["1047ui_story"].transform
			local var_397_7 = 0

			if var_397_7 < arg_394_1.time_ and arg_394_1.time_ <= var_397_7 + arg_397_0 then
				arg_394_1.var_.moveOldPos1047ui_story = var_397_6.localPosition
			end

			local var_397_8 = 0.001

			if var_397_7 <= arg_394_1.time_ and arg_394_1.time_ < var_397_7 + var_397_8 then
				local var_397_9 = (arg_394_1.time_ - var_397_7) / var_397_8
				local var_397_10 = Vector3.New(0, 100, 0)

				var_397_6.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1047ui_story, var_397_10, var_397_9)

				local var_397_11 = manager.ui.mainCamera.transform.position - var_397_6.position

				var_397_6.forward = Vector3.New(var_397_11.x, var_397_11.y, var_397_11.z)

				local var_397_12 = var_397_6.localEulerAngles

				var_397_12.z = 0
				var_397_12.x = 0
				var_397_6.localEulerAngles = var_397_12
			end

			if arg_394_1.time_ >= var_397_7 + var_397_8 and arg_394_1.time_ < var_397_7 + var_397_8 + arg_397_0 then
				var_397_6.localPosition = Vector3.New(0, 100, 0)

				local var_397_13 = manager.ui.mainCamera.transform.position - var_397_6.position

				var_397_6.forward = Vector3.New(var_397_13.x, var_397_13.y, var_397_13.z)

				local var_397_14 = var_397_6.localEulerAngles

				var_397_14.z = 0
				var_397_14.x = 0
				var_397_6.localEulerAngles = var_397_14
			end

			local var_397_15 = 0
			local var_397_16 = 0.8

			if var_397_15 < arg_394_1.time_ and arg_394_1.time_ <= var_397_15 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_17 = arg_394_1:GetWordFromCfg(1104704097)
				local var_397_18 = arg_394_1:FormatText(var_397_17.content)

				arg_394_1.text_.text = var_397_18

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_19 = 32
				local var_397_20 = utf8.len(var_397_18)
				local var_397_21 = var_397_19 <= 0 and var_397_16 or var_397_16 * (var_397_20 / var_397_19)

				if var_397_21 > 0 and var_397_16 < var_397_21 then
					arg_394_1.talkMaxDuration = var_397_21

					if var_397_21 + var_397_15 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_21 + var_397_15
					end
				end

				arg_394_1.text_.text = var_397_18
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_22 = math.max(var_397_16, arg_394_1.talkMaxDuration)

			if var_397_15 <= arg_394_1.time_ and arg_394_1.time_ < var_397_15 + var_397_22 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_15) / var_397_22

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_15 + var_397_22 and arg_394_1.time_ < var_397_15 + var_397_22 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play1104704098 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1104704098
		arg_398_1.duration_ = 4.9

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1104704099(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 0.525

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_2 = arg_398_1:FormatText(StoryNameCfg[1516].name)

				arg_398_1.leftNameTxt_.text = var_401_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_3 = arg_398_1:GetWordFromCfg(1104704098)
				local var_401_4 = arg_398_1:FormatText(var_401_3.content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 21
				local var_401_6 = utf8.len(var_401_4)
				local var_401_7 = var_401_5 <= 0 and var_401_1 or var_401_1 * (var_401_6 / var_401_5)

				if var_401_7 > 0 and var_401_1 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_4
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704098", "story_v_side_new_1104704.awb") ~= 0 then
					local var_401_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704098", "story_v_side_new_1104704.awb") / 1000

					if var_401_8 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_8 + var_401_0
					end

					if var_401_3.prefab_name ~= "" and arg_398_1.actors_[var_401_3.prefab_name] ~= nil then
						local var_401_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_3.prefab_name].transform, "story_v_side_new_1104704", "1104704098", "story_v_side_new_1104704.awb")

						arg_398_1:RecordAudio("1104704098", var_401_9)
						arg_398_1:RecordAudio("1104704098", var_401_9)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704098", "story_v_side_new_1104704.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704098", "story_v_side_new_1104704.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_10 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_10 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_10

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_10 and arg_398_1.time_ < var_401_0 + var_401_10 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1104704099 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1104704099
		arg_402_1.duration_ = 6.03

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1104704100(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0
			local var_405_1 = 0.85

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_2 = arg_402_1:FormatText(StoryNameCfg[1516].name)

				arg_402_1.leftNameTxt_.text = var_405_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_3 = arg_402_1:GetWordFromCfg(1104704099)
				local var_405_4 = arg_402_1:FormatText(var_405_3.content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 34
				local var_405_6 = utf8.len(var_405_4)
				local var_405_7 = var_405_5 <= 0 and var_405_1 or var_405_1 * (var_405_6 / var_405_5)

				if var_405_7 > 0 and var_405_1 < var_405_7 then
					arg_402_1.talkMaxDuration = var_405_7

					if var_405_7 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_4
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704099", "story_v_side_new_1104704.awb") ~= 0 then
					local var_405_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704099", "story_v_side_new_1104704.awb") / 1000

					if var_405_8 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_8 + var_405_0
					end

					if var_405_3.prefab_name ~= "" and arg_402_1.actors_[var_405_3.prefab_name] ~= nil then
						local var_405_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_3.prefab_name].transform, "story_v_side_new_1104704", "1104704099", "story_v_side_new_1104704.awb")

						arg_402_1:RecordAudio("1104704099", var_405_9)
						arg_402_1:RecordAudio("1104704099", var_405_9)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704099", "story_v_side_new_1104704.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704099", "story_v_side_new_1104704.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_10 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_10 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_10

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_10 and arg_402_1.time_ < var_405_0 + var_405_10 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1104704100 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1104704100
		arg_406_1.duration_ = 3.1

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1104704101(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0
			local var_409_1 = 0.35

			if var_409_0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_2 = arg_406_1:FormatText(StoryNameCfg[1517].name)

				arg_406_1.leftNameTxt_.text = var_409_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_3 = arg_406_1:GetWordFromCfg(1104704100)
				local var_409_4 = arg_406_1:FormatText(var_409_3.content)

				arg_406_1.text_.text = var_409_4

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_5 = 14
				local var_409_6 = utf8.len(var_409_4)
				local var_409_7 = var_409_5 <= 0 and var_409_1 or var_409_1 * (var_409_6 / var_409_5)

				if var_409_7 > 0 and var_409_1 < var_409_7 then
					arg_406_1.talkMaxDuration = var_409_7

					if var_409_7 + var_409_0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_7 + var_409_0
					end
				end

				arg_406_1.text_.text = var_409_4
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704100", "story_v_side_new_1104704.awb") ~= 0 then
					local var_409_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704100", "story_v_side_new_1104704.awb") / 1000

					if var_409_8 + var_409_0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_8 + var_409_0
					end

					if var_409_3.prefab_name ~= "" and arg_406_1.actors_[var_409_3.prefab_name] ~= nil then
						local var_409_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_3.prefab_name].transform, "story_v_side_new_1104704", "1104704100", "story_v_side_new_1104704.awb")

						arg_406_1:RecordAudio("1104704100", var_409_9)
						arg_406_1:RecordAudio("1104704100", var_409_9)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704100", "story_v_side_new_1104704.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704100", "story_v_side_new_1104704.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_10 = math.max(var_409_1, arg_406_1.talkMaxDuration)

			if var_409_0 <= arg_406_1.time_ and arg_406_1.time_ < var_409_0 + var_409_10 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_0) / var_409_10

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_0 + var_409_10 and arg_406_1.time_ < var_409_0 + var_409_10 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play1104704101 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1104704101
		arg_410_1.duration_ = 4.57

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1104704102(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0
			local var_413_1 = 0.575

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_2 = arg_410_1:FormatText(StoryNameCfg[1516].name)

				arg_410_1.leftNameTxt_.text = var_413_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_3 = arg_410_1:GetWordFromCfg(1104704101)
				local var_413_4 = arg_410_1:FormatText(var_413_3.content)

				arg_410_1.text_.text = var_413_4

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 23
				local var_413_6 = utf8.len(var_413_4)
				local var_413_7 = var_413_5 <= 0 and var_413_1 or var_413_1 * (var_413_6 / var_413_5)

				if var_413_7 > 0 and var_413_1 < var_413_7 then
					arg_410_1.talkMaxDuration = var_413_7

					if var_413_7 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_7 + var_413_0
					end
				end

				arg_410_1.text_.text = var_413_4
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704101", "story_v_side_new_1104704.awb") ~= 0 then
					local var_413_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704101", "story_v_side_new_1104704.awb") / 1000

					if var_413_8 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_8 + var_413_0
					end

					if var_413_3.prefab_name ~= "" and arg_410_1.actors_[var_413_3.prefab_name] ~= nil then
						local var_413_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_3.prefab_name].transform, "story_v_side_new_1104704", "1104704101", "story_v_side_new_1104704.awb")

						arg_410_1:RecordAudio("1104704101", var_413_9)
						arg_410_1:RecordAudio("1104704101", var_413_9)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704101", "story_v_side_new_1104704.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704101", "story_v_side_new_1104704.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_10 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_10 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_10

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_10 and arg_410_1.time_ < var_413_0 + var_413_10 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play1104704102 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1104704102
		arg_414_1.duration_ = 4.5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1104704103(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["1047ui_story"].transform
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 then
				arg_414_1.var_.moveOldPos1047ui_story = var_417_0.localPosition
			end

			local var_417_2 = 0.001

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2
				local var_417_4 = Vector3.New(0, -1.13, -6.2)

				var_417_0.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1047ui_story, var_417_4, var_417_3)

				local var_417_5 = manager.ui.mainCamera.transform.position - var_417_0.position

				var_417_0.forward = Vector3.New(var_417_5.x, var_417_5.y, var_417_5.z)

				local var_417_6 = var_417_0.localEulerAngles

				var_417_6.z = 0
				var_417_6.x = 0
				var_417_0.localEulerAngles = var_417_6
			end

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 then
				var_417_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_417_7 = manager.ui.mainCamera.transform.position - var_417_0.position

				var_417_0.forward = Vector3.New(var_417_7.x, var_417_7.y, var_417_7.z)

				local var_417_8 = var_417_0.localEulerAngles

				var_417_8.z = 0
				var_417_8.x = 0
				var_417_0.localEulerAngles = var_417_8
			end

			local var_417_9 = arg_414_1.actors_["1047ui_story"]
			local var_417_10 = 0

			if var_417_10 < arg_414_1.time_ and arg_414_1.time_ <= var_417_10 + arg_417_0 and not isNil(var_417_9) and arg_414_1.var_.characterEffect1047ui_story == nil then
				arg_414_1.var_.characterEffect1047ui_story = var_417_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_11 = 0.200000002980232

			if var_417_10 <= arg_414_1.time_ and arg_414_1.time_ < var_417_10 + var_417_11 and not isNil(var_417_9) then
				local var_417_12 = (arg_414_1.time_ - var_417_10) / var_417_11

				if arg_414_1.var_.characterEffect1047ui_story and not isNil(var_417_9) then
					arg_414_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= var_417_10 + var_417_11 and arg_414_1.time_ < var_417_10 + var_417_11 + arg_417_0 and not isNil(var_417_9) and arg_414_1.var_.characterEffect1047ui_story then
				arg_414_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_417_13 = 0

			if var_417_13 < arg_414_1.time_ and arg_414_1.time_ <= var_417_13 + arg_417_0 then
				arg_414_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			local var_417_14 = 0

			if var_417_14 < arg_414_1.time_ and arg_414_1.time_ <= var_417_14 + arg_417_0 then
				arg_414_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_417_15 = 0
			local var_417_16 = 0.4

			if var_417_15 < arg_414_1.time_ and arg_414_1.time_ <= var_417_15 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_17 = arg_414_1:FormatText(StoryNameCfg[1296].name)

				arg_414_1.leftNameTxt_.text = var_417_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_18 = arg_414_1:GetWordFromCfg(1104704102)
				local var_417_19 = arg_414_1:FormatText(var_417_18.content)

				arg_414_1.text_.text = var_417_19

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_20 = 16
				local var_417_21 = utf8.len(var_417_19)
				local var_417_22 = var_417_20 <= 0 and var_417_16 or var_417_16 * (var_417_21 / var_417_20)

				if var_417_22 > 0 and var_417_16 < var_417_22 then
					arg_414_1.talkMaxDuration = var_417_22

					if var_417_22 + var_417_15 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_22 + var_417_15
					end
				end

				arg_414_1.text_.text = var_417_19
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704102", "story_v_side_new_1104704.awb") ~= 0 then
					local var_417_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704102", "story_v_side_new_1104704.awb") / 1000

					if var_417_23 + var_417_15 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_23 + var_417_15
					end

					if var_417_18.prefab_name ~= "" and arg_414_1.actors_[var_417_18.prefab_name] ~= nil then
						local var_417_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_18.prefab_name].transform, "story_v_side_new_1104704", "1104704102", "story_v_side_new_1104704.awb")

						arg_414_1:RecordAudio("1104704102", var_417_24)
						arg_414_1:RecordAudio("1104704102", var_417_24)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704102", "story_v_side_new_1104704.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704102", "story_v_side_new_1104704.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_25 = math.max(var_417_16, arg_414_1.talkMaxDuration)

			if var_417_15 <= arg_414_1.time_ and arg_414_1.time_ < var_417_15 + var_417_25 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_15) / var_417_25

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_15 + var_417_25 and arg_414_1.time_ < var_417_15 + var_417_25 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play1104704103 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1104704103
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1104704104(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["1047ui_story"]
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect1047ui_story == nil then
				arg_418_1.var_.characterEffect1047ui_story = var_421_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_2 = 0.200000002980232

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 and not isNil(var_421_0) then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2

				if arg_418_1.var_.characterEffect1047ui_story and not isNil(var_421_0) then
					local var_421_4 = Mathf.Lerp(0, 0.5, var_421_3)

					arg_418_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_418_1.var_.characterEffect1047ui_story.fillRatio = var_421_4
				end
			end

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect1047ui_story then
				local var_421_5 = 0.5

				arg_418_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_418_1.var_.characterEffect1047ui_story.fillRatio = var_421_5
			end

			local var_421_6 = arg_418_1.actors_["1047ui_story"].transform
			local var_421_7 = 0

			if var_421_7 < arg_418_1.time_ and arg_418_1.time_ <= var_421_7 + arg_421_0 then
				arg_418_1.var_.moveOldPos1047ui_story = var_421_6.localPosition
			end

			local var_421_8 = 0.001

			if var_421_7 <= arg_418_1.time_ and arg_418_1.time_ < var_421_7 + var_421_8 then
				local var_421_9 = (arg_418_1.time_ - var_421_7) / var_421_8
				local var_421_10 = Vector3.New(0, 100, 0)

				var_421_6.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1047ui_story, var_421_10, var_421_9)

				local var_421_11 = manager.ui.mainCamera.transform.position - var_421_6.position

				var_421_6.forward = Vector3.New(var_421_11.x, var_421_11.y, var_421_11.z)

				local var_421_12 = var_421_6.localEulerAngles

				var_421_12.z = 0
				var_421_12.x = 0
				var_421_6.localEulerAngles = var_421_12
			end

			if arg_418_1.time_ >= var_421_7 + var_421_8 and arg_418_1.time_ < var_421_7 + var_421_8 + arg_421_0 then
				var_421_6.localPosition = Vector3.New(0, 100, 0)

				local var_421_13 = manager.ui.mainCamera.transform.position - var_421_6.position

				var_421_6.forward = Vector3.New(var_421_13.x, var_421_13.y, var_421_13.z)

				local var_421_14 = var_421_6.localEulerAngles

				var_421_14.z = 0
				var_421_14.x = 0
				var_421_6.localEulerAngles = var_421_14
			end

			local var_421_15 = 0
			local var_421_16 = 0.45

			if var_421_15 < arg_418_1.time_ and arg_418_1.time_ <= var_421_15 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_17 = arg_418_1:GetWordFromCfg(1104704103)
				local var_421_18 = arg_418_1:FormatText(var_421_17.content)

				arg_418_1.text_.text = var_421_18

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_19 = 18
				local var_421_20 = utf8.len(var_421_18)
				local var_421_21 = var_421_19 <= 0 and var_421_16 or var_421_16 * (var_421_20 / var_421_19)

				if var_421_21 > 0 and var_421_16 < var_421_21 then
					arg_418_1.talkMaxDuration = var_421_21

					if var_421_21 + var_421_15 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_21 + var_421_15
					end
				end

				arg_418_1.text_.text = var_421_18
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_22 = math.max(var_421_16, arg_418_1.talkMaxDuration)

			if var_421_15 <= arg_418_1.time_ and arg_418_1.time_ < var_421_15 + var_421_22 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_15) / var_421_22

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_15 + var_421_22 and arg_418_1.time_ < var_421_15 + var_421_22 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_418_1:InitPlayNodeList()
	end,
	Play1104704104 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1104704104
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1104704105(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0
			local var_425_1 = 0.75

			if var_425_0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_2 = arg_422_1:GetWordFromCfg(1104704104)
				local var_425_3 = arg_422_1:FormatText(var_425_2.content)

				arg_422_1.text_.text = var_425_3

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_4 = 30
				local var_425_5 = utf8.len(var_425_3)
				local var_425_6 = var_425_4 <= 0 and var_425_1 or var_425_1 * (var_425_5 / var_425_4)

				if var_425_6 > 0 and var_425_1 < var_425_6 then
					arg_422_1.talkMaxDuration = var_425_6

					if var_425_6 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_6 + var_425_0
					end
				end

				arg_422_1.text_.text = var_425_3
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_7 = math.max(var_425_1, arg_422_1.talkMaxDuration)

			if var_425_0 <= arg_422_1.time_ and arg_422_1.time_ < var_425_0 + var_425_7 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_0) / var_425_7

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_0 + var_425_7 and arg_422_1.time_ < var_425_0 + var_425_7 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play1104704105 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1104704105
		arg_426_1.duration_ = 2.4

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1104704106(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["1047ui_story"].transform
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.var_.moveOldPos1047ui_story = var_429_0.localPosition
			end

			local var_429_2 = 0.001

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2
				local var_429_4 = Vector3.New(0, -1.13, -6.2)

				var_429_0.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1047ui_story, var_429_4, var_429_3)

				local var_429_5 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_5.x, var_429_5.y, var_429_5.z)

				local var_429_6 = var_429_0.localEulerAngles

				var_429_6.z = 0
				var_429_6.x = 0
				var_429_0.localEulerAngles = var_429_6
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 then
				var_429_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_429_7 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_7.x, var_429_7.y, var_429_7.z)

				local var_429_8 = var_429_0.localEulerAngles

				var_429_8.z = 0
				var_429_8.x = 0
				var_429_0.localEulerAngles = var_429_8
			end

			local var_429_9 = arg_426_1.actors_["1047ui_story"]
			local var_429_10 = 0

			if var_429_10 < arg_426_1.time_ and arg_426_1.time_ <= var_429_10 + arg_429_0 and not isNil(var_429_9) and arg_426_1.var_.characterEffect1047ui_story == nil then
				arg_426_1.var_.characterEffect1047ui_story = var_429_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_11 = 0.200000002980232

			if var_429_10 <= arg_426_1.time_ and arg_426_1.time_ < var_429_10 + var_429_11 and not isNil(var_429_9) then
				local var_429_12 = (arg_426_1.time_ - var_429_10) / var_429_11

				if arg_426_1.var_.characterEffect1047ui_story and not isNil(var_429_9) then
					arg_426_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= var_429_10 + var_429_11 and arg_426_1.time_ < var_429_10 + var_429_11 + arg_429_0 and not isNil(var_429_9) and arg_426_1.var_.characterEffect1047ui_story then
				arg_426_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_429_13 = 0

			if var_429_13 < arg_426_1.time_ and arg_426_1.time_ <= var_429_13 + arg_429_0 then
				arg_426_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_429_14 = 0

			if var_429_14 < arg_426_1.time_ and arg_426_1.time_ <= var_429_14 + arg_429_0 then
				arg_426_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_429_15 = 0
			local var_429_16 = 0.3

			if var_429_15 < arg_426_1.time_ and arg_426_1.time_ <= var_429_15 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_17 = arg_426_1:FormatText(StoryNameCfg[1296].name)

				arg_426_1.leftNameTxt_.text = var_429_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_18 = arg_426_1:GetWordFromCfg(1104704105)
				local var_429_19 = arg_426_1:FormatText(var_429_18.content)

				arg_426_1.text_.text = var_429_19

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_20 = 12
				local var_429_21 = utf8.len(var_429_19)
				local var_429_22 = var_429_20 <= 0 and var_429_16 or var_429_16 * (var_429_21 / var_429_20)

				if var_429_22 > 0 and var_429_16 < var_429_22 then
					arg_426_1.talkMaxDuration = var_429_22

					if var_429_22 + var_429_15 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_22 + var_429_15
					end
				end

				arg_426_1.text_.text = var_429_19
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704105", "story_v_side_new_1104704.awb") ~= 0 then
					local var_429_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704105", "story_v_side_new_1104704.awb") / 1000

					if var_429_23 + var_429_15 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_23 + var_429_15
					end

					if var_429_18.prefab_name ~= "" and arg_426_1.actors_[var_429_18.prefab_name] ~= nil then
						local var_429_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_18.prefab_name].transform, "story_v_side_new_1104704", "1104704105", "story_v_side_new_1104704.awb")

						arg_426_1:RecordAudio("1104704105", var_429_24)
						arg_426_1:RecordAudio("1104704105", var_429_24)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704105", "story_v_side_new_1104704.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704105", "story_v_side_new_1104704.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_25 = math.max(var_429_16, arg_426_1.talkMaxDuration)

			if var_429_15 <= arg_426_1.time_ and arg_426_1.time_ < var_429_15 + var_429_25 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_15) / var_429_25

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_15 + var_429_25 and arg_426_1.time_ < var_429_15 + var_429_25 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play1104704106 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1104704106
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1104704107(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["1047ui_story"]
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1047ui_story == nil then
				arg_430_1.var_.characterEffect1047ui_story = var_433_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.200000002980232

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 and not isNil(var_433_0) then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2

				if arg_430_1.var_.characterEffect1047ui_story and not isNil(var_433_0) then
					local var_433_4 = Mathf.Lerp(0, 0.5, var_433_3)

					arg_430_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_430_1.var_.characterEffect1047ui_story.fillRatio = var_433_4
				end
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1047ui_story then
				local var_433_5 = 0.5

				arg_430_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_430_1.var_.characterEffect1047ui_story.fillRatio = var_433_5
			end

			local var_433_6 = arg_430_1.actors_["1047ui_story"].transform
			local var_433_7 = 0

			if var_433_7 < arg_430_1.time_ and arg_430_1.time_ <= var_433_7 + arg_433_0 then
				arg_430_1.var_.moveOldPos1047ui_story = var_433_6.localPosition
			end

			local var_433_8 = 0.001

			if var_433_7 <= arg_430_1.time_ and arg_430_1.time_ < var_433_7 + var_433_8 then
				local var_433_9 = (arg_430_1.time_ - var_433_7) / var_433_8
				local var_433_10 = Vector3.New(0, 100, 0)

				var_433_6.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1047ui_story, var_433_10, var_433_9)

				local var_433_11 = manager.ui.mainCamera.transform.position - var_433_6.position

				var_433_6.forward = Vector3.New(var_433_11.x, var_433_11.y, var_433_11.z)

				local var_433_12 = var_433_6.localEulerAngles

				var_433_12.z = 0
				var_433_12.x = 0
				var_433_6.localEulerAngles = var_433_12
			end

			if arg_430_1.time_ >= var_433_7 + var_433_8 and arg_430_1.time_ < var_433_7 + var_433_8 + arg_433_0 then
				var_433_6.localPosition = Vector3.New(0, 100, 0)

				local var_433_13 = manager.ui.mainCamera.transform.position - var_433_6.position

				var_433_6.forward = Vector3.New(var_433_13.x, var_433_13.y, var_433_13.z)

				local var_433_14 = var_433_6.localEulerAngles

				var_433_14.z = 0
				var_433_14.x = 0
				var_433_6.localEulerAngles = var_433_14
			end

			local var_433_15 = 0
			local var_433_16 = 0.1

			if var_433_15 < arg_430_1.time_ and arg_430_1.time_ <= var_433_15 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_17 = arg_430_1:FormatText(StoryNameCfg[7].name)

				arg_430_1.leftNameTxt_.text = var_433_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_18 = arg_430_1:GetWordFromCfg(1104704106)
				local var_433_19 = arg_430_1:FormatText(var_433_18.content)

				arg_430_1.text_.text = var_433_19

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_20 = 4
				local var_433_21 = utf8.len(var_433_19)
				local var_433_22 = var_433_20 <= 0 and var_433_16 or var_433_16 * (var_433_21 / var_433_20)

				if var_433_22 > 0 and var_433_16 < var_433_22 then
					arg_430_1.talkMaxDuration = var_433_22

					if var_433_22 + var_433_15 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_22 + var_433_15
					end
				end

				arg_430_1.text_.text = var_433_19
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_23 = math.max(var_433_16, arg_430_1.talkMaxDuration)

			if var_433_15 <= arg_430_1.time_ and arg_430_1.time_ < var_433_15 + var_433_23 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_15) / var_433_23

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_15 + var_433_23 and arg_430_1.time_ < var_433_15 + var_433_23 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play1104704107 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1104704107
		arg_434_1.duration_ = 1.73

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1104704108(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0
			local var_437_1 = 0.125

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_2 = arg_434_1:FormatText(StoryNameCfg[1296].name)

				arg_434_1.leftNameTxt_.text = var_437_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_2")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_3 = arg_434_1:GetWordFromCfg(1104704107)
				local var_437_4 = arg_434_1:FormatText(var_437_3.content)

				arg_434_1.text_.text = var_437_4

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 5
				local var_437_6 = utf8.len(var_437_4)
				local var_437_7 = var_437_5 <= 0 and var_437_1 or var_437_1 * (var_437_6 / var_437_5)

				if var_437_7 > 0 and var_437_1 < var_437_7 then
					arg_434_1.talkMaxDuration = var_437_7

					if var_437_7 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_7 + var_437_0
					end
				end

				arg_434_1.text_.text = var_437_4
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704107", "story_v_side_new_1104704.awb") ~= 0 then
					local var_437_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704107", "story_v_side_new_1104704.awb") / 1000

					if var_437_8 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_8 + var_437_0
					end

					if var_437_3.prefab_name ~= "" and arg_434_1.actors_[var_437_3.prefab_name] ~= nil then
						local var_437_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_3.prefab_name].transform, "story_v_side_new_1104704", "1104704107", "story_v_side_new_1104704.awb")

						arg_434_1:RecordAudio("1104704107", var_437_9)
						arg_434_1:RecordAudio("1104704107", var_437_9)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704107", "story_v_side_new_1104704.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704107", "story_v_side_new_1104704.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_10 = math.max(var_437_1, arg_434_1.talkMaxDuration)

			if var_437_0 <= arg_434_1.time_ and arg_434_1.time_ < var_437_0 + var_437_10 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_0) / var_437_10

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_0 + var_437_10 and arg_434_1.time_ < var_437_0 + var_437_10 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1104704108 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1104704108
		arg_438_1.duration_ = 4.27

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1104704109(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0

			if var_441_0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_0 + arg_441_0 then
				arg_438_1.mask_.enabled = true
				arg_438_1.mask_.raycastTarget = true

				arg_438_1:SetGaussion(false)
			end

			local var_441_1 = 2

			if var_441_0 <= arg_438_1.time_ and arg_438_1.time_ < var_441_0 + var_441_1 then
				local var_441_2 = (arg_438_1.time_ - var_441_0) / var_441_1
				local var_441_3 = Color.New(0, 0, 0)

				var_441_3.a = Mathf.Lerp(0, 1, var_441_2)
				arg_438_1.mask_.color = var_441_3
			end

			if arg_438_1.time_ >= var_441_0 + var_441_1 and arg_438_1.time_ < var_441_0 + var_441_1 + arg_441_0 then
				local var_441_4 = Color.New(0, 0, 0)

				var_441_4.a = 1
				arg_438_1.mask_.color = var_441_4
			end

			local var_441_5 = 2

			if var_441_5 < arg_438_1.time_ and arg_438_1.time_ <= var_441_5 + arg_441_0 then
				arg_438_1.mask_.enabled = true
				arg_438_1.mask_.raycastTarget = true

				arg_438_1:SetGaussion(false)
			end

			local var_441_6 = 2

			if var_441_5 <= arg_438_1.time_ and arg_438_1.time_ < var_441_5 + var_441_6 then
				local var_441_7 = (arg_438_1.time_ - var_441_5) / var_441_6
				local var_441_8 = Color.New(0, 0, 0)

				var_441_8.a = Mathf.Lerp(1, 0, var_441_7)
				arg_438_1.mask_.color = var_441_8
			end

			if arg_438_1.time_ >= var_441_5 + var_441_6 and arg_438_1.time_ < var_441_5 + var_441_6 + arg_441_0 then
				local var_441_9 = Color.New(0, 0, 0)
				local var_441_10 = 0

				arg_438_1.mask_.enabled = false
				var_441_9.a = var_441_10
				arg_438_1.mask_.color = var_441_9
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1104704108,
				charCount = 34,
				enableLayoutChange = true,
				duration = 2.26666666666667,
				groupID = "shengrixuyuan",
				startTime = 2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play1104704109 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1104704109
		arg_442_1.duration_ = 1.73

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1104704110(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			return
		end

		arg_442_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1104704109,
				charCount = 26,
				enableLayoutChange = true,
				duration = 1.73333333333333,
				groupID = "shengrixuyuan",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play1104704110 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1104704110
		arg_446_1.duration_ = 3.43

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1104704111(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = "STblack"

			if arg_446_1.bgs_[var_449_0] == nil then
				local var_449_1 = Object.Instantiate(arg_446_1.paintGo_)

				var_449_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_449_0)
				var_449_1.name = var_449_0
				var_449_1.transform.parent = arg_446_1.stage_.transform
				var_449_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_446_1.bgs_[var_449_0] = var_449_1
			end

			local var_449_2 = 0.7

			if var_449_2 < arg_446_1.time_ and arg_446_1.time_ <= var_449_2 + arg_449_0 then
				local var_449_3 = manager.ui.mainCamera.transform.localPosition
				local var_449_4 = Vector3.New(0, 0, 10) + Vector3.New(var_449_3.x, var_449_3.y, 0)
				local var_449_5 = arg_446_1.bgs_.STblack

				var_449_5.transform.localPosition = var_449_4
				var_449_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_449_6 = var_449_5:GetComponent("SpriteRenderer")

				if var_449_6 and var_449_6.sprite then
					local var_449_7 = (var_449_5.transform.localPosition - var_449_3).z
					local var_449_8 = manager.ui.mainCameraCom_
					local var_449_9 = 2 * var_449_7 * Mathf.Tan(var_449_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_449_10 = var_449_9 * var_449_8.aspect
					local var_449_11 = var_449_6.sprite.bounds.size.x
					local var_449_12 = var_449_6.sprite.bounds.size.y
					local var_449_13 = var_449_10 / var_449_11
					local var_449_14 = var_449_9 / var_449_12
					local var_449_15 = var_449_14 < var_449_13 and var_449_13 or var_449_14

					var_449_5.transform.localScale = Vector3.New(var_449_15, var_449_15, 0)
				end

				for iter_449_0, iter_449_1 in pairs(arg_446_1.bgs_) do
					if iter_449_0 ~= "STblack" then
						iter_449_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_449_16 = 2

			if var_449_16 < arg_446_1.time_ and arg_446_1.time_ <= var_449_16 + arg_449_0 then
				arg_446_1.allBtn_.enabled = false
			end

			local var_449_17 = 0.3

			if arg_446_1.time_ >= var_449_16 + var_449_17 and arg_446_1.time_ < var_449_16 + var_449_17 + arg_449_0 then
				arg_446_1.allBtn_.enabled = true
			end

			local var_449_18 = manager.ui.mainCamera.transform
			local var_449_19 = 0

			if var_449_19 < arg_446_1.time_ and arg_446_1.time_ <= var_449_19 + arg_449_0 then
				local var_449_20 = arg_446_1.var_.effectzhuanchangyixia1
				local var_449_21
				local var_449_22 = var_449_18

				if not var_449_20 then
					var_449_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_449_22)
					var_449_20.name = "zhuanchangyixia1"
					arg_446_1.var_.effectzhuanchangyixia1 = var_449_20
				else
					var_449_20.transform:SetParent(var_449_22)
				end

				var_449_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_449_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_449_23 = 1.7777777777777777
				local var_449_24 = Screen.width / Screen.height
				local var_449_25 = var_449_24 / var_449_23
				local var_449_26 = Mathf.Max(var_449_23 / var_449_24, 1)
				local var_449_27 = Mathf.Max(var_449_25, var_449_26)

				var_449_20.transform.localScale = Vector3.New(var_449_20.transform.localScale.x * var_449_27, var_449_20.transform.localScale.y * var_449_27, var_449_20.transform.localScale.z * var_449_27)
			end

			local var_449_28 = 0.3
			local var_449_29 = 1

			if var_449_28 < arg_446_1.time_ and arg_446_1.time_ <= var_449_28 + arg_449_0 then
				local var_449_30 = "play"
				local var_449_31 = "effect"

				arg_446_1:AudioAction(var_449_30, var_449_31, "se_story_151", "se_story_151_fire", "")
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				groupID = "shengrixuyuan",
				duration = 0.3,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1104704110,
				charCount = 31,
				enableLayoutChange = true,
				duration = 2.06666666666667,
				groupID = "shengrixuyuan1",
				startTime = 1.36666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play1104704111 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1104704111
		arg_450_1.duration_ = 2.13

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1104704112(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0
			local var_453_1 = 0.2

			if var_453_0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0

				arg_450_1.dialog_:SetActive(true)

				arg_450_1.dialogCg_.alpha = 0

				local var_453_2 = LeanTween.value(arg_450_1.dialog_, 0, 1, 0.3)

				var_453_2:setOnUpdate(LuaHelper.FloatAction(function(arg_454_0)
					arg_450_1.dialogCg_.alpha = arg_454_0
				end))
				var_453_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_450_1.dialog_)
					var_453_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_450_1.duration_ = arg_450_1.duration_ + 0.3

				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_3 = arg_450_1:FormatText(StoryNameCfg[1516].name)

				arg_450_1.leftNameTxt_.text = var_453_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_4 = arg_450_1:GetWordFromCfg(1104704111)
				local var_453_5 = arg_450_1:FormatText(var_453_4.content)

				arg_450_1.text_.text = var_453_5

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_6 = 8
				local var_453_7 = utf8.len(var_453_5)
				local var_453_8 = var_453_6 <= 0 and var_453_1 or var_453_1 * (var_453_7 / var_453_6)

				if var_453_8 > 0 and var_453_1 < var_453_8 then
					arg_450_1.talkMaxDuration = var_453_8
					var_453_0 = var_453_0 + 0.3

					if var_453_8 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_8 + var_453_0
					end
				end

				arg_450_1.text_.text = var_453_5
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704111", "story_v_side_new_1104704.awb") ~= 0 then
					local var_453_9 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704111", "story_v_side_new_1104704.awb") / 1000

					if var_453_9 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_9 + var_453_0
					end

					if var_453_4.prefab_name ~= "" and arg_450_1.actors_[var_453_4.prefab_name] ~= nil then
						local var_453_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_4.prefab_name].transform, "story_v_side_new_1104704", "1104704111", "story_v_side_new_1104704.awb")

						arg_450_1:RecordAudio("1104704111", var_453_10)
						arg_450_1:RecordAudio("1104704111", var_453_10)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704111", "story_v_side_new_1104704.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704111", "story_v_side_new_1104704.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_11 = var_453_0 + 0.3
			local var_453_12 = math.max(var_453_1, arg_450_1.talkMaxDuration)

			if var_453_11 <= arg_450_1.time_ and arg_450_1.time_ < var_453_11 + var_453_12 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_11) / var_453_12

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_11 + var_453_12 and arg_450_1.time_ < var_453_11 + var_453_12 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				groupID = "shengrixuyuan2",
				duration = 1,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_ALL_TEXT_GROUP
			}
		}

		arg_450_1:InitPlayNodeList()
	end,
	Play1104704112 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1104704112
		arg_456_1.duration_ = 1.97

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1104704113(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0
			local var_459_1 = 0.225

			if var_459_0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_2 = arg_456_1:FormatText(StoryNameCfg[1518].name)

				arg_456_1.leftNameTxt_.text = var_459_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, true)
				arg_456_1.iconController_:SetSelectedState("hero")

				arg_456_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_456_1.callingController_:SetSelectedState("normal")

				arg_456_1.keyicon_.color = Color.New(1, 1, 1)
				arg_456_1.icon_.color = Color.New(1, 1, 1)

				local var_459_3 = arg_456_1:GetWordFromCfg(1104704112)
				local var_459_4 = arg_456_1:FormatText(var_459_3.content)

				arg_456_1.text_.text = var_459_4

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_5 = 9
				local var_459_6 = utf8.len(var_459_4)
				local var_459_7 = var_459_5 <= 0 and var_459_1 or var_459_1 * (var_459_6 / var_459_5)

				if var_459_7 > 0 and var_459_1 < var_459_7 then
					arg_456_1.talkMaxDuration = var_459_7

					if var_459_7 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_7 + var_459_0
					end
				end

				arg_456_1.text_.text = var_459_4
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704112", "story_v_side_new_1104704.awb") ~= 0 then
					local var_459_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704112", "story_v_side_new_1104704.awb") / 1000

					if var_459_8 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_8 + var_459_0
					end

					if var_459_3.prefab_name ~= "" and arg_456_1.actors_[var_459_3.prefab_name] ~= nil then
						local var_459_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_3.prefab_name].transform, "story_v_side_new_1104704", "1104704112", "story_v_side_new_1104704.awb")

						arg_456_1:RecordAudio("1104704112", var_459_9)
						arg_456_1:RecordAudio("1104704112", var_459_9)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704112", "story_v_side_new_1104704.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704112", "story_v_side_new_1104704.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_10 = math.max(var_459_1, arg_456_1.talkMaxDuration)

			if var_459_0 <= arg_456_1.time_ and arg_456_1.time_ < var_459_0 + var_459_10 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_0) / var_459_10

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_0 + var_459_10 and arg_456_1.time_ < var_459_0 + var_459_10 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1104704113 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1104704113
		arg_460_1.duration_ = 7.03

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1104704114(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0

			if var_463_0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				local var_463_1 = manager.ui.mainCamera.transform.localPosition
				local var_463_2 = Vector3.New(0, 0, 10) + Vector3.New(var_463_1.x, var_463_1.y, 0)
				local var_463_3 = arg_460_1.bgs_.ST84a

				var_463_3.transform.localPosition = var_463_2
				var_463_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_463_4 = var_463_3:GetComponent("SpriteRenderer")

				if var_463_4 and var_463_4.sprite then
					local var_463_5 = (var_463_3.transform.localPosition - var_463_1).z
					local var_463_6 = manager.ui.mainCameraCom_
					local var_463_7 = 2 * var_463_5 * Mathf.Tan(var_463_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_463_8 = var_463_7 * var_463_6.aspect
					local var_463_9 = var_463_4.sprite.bounds.size.x
					local var_463_10 = var_463_4.sprite.bounds.size.y
					local var_463_11 = var_463_8 / var_463_9
					local var_463_12 = var_463_7 / var_463_10
					local var_463_13 = var_463_12 < var_463_11 and var_463_11 or var_463_12

					var_463_3.transform.localScale = Vector3.New(var_463_13, var_463_13, 0)
				end

				for iter_463_0, iter_463_1 in pairs(arg_460_1.bgs_) do
					if iter_463_0 ~= "ST84a" then
						iter_463_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_463_14 = 2

			if var_463_14 < arg_460_1.time_ and arg_460_1.time_ <= var_463_14 + arg_463_0 then
				arg_460_1.allBtn_.enabled = false
			end

			local var_463_15 = 0.273181093794604

			if arg_460_1.time_ >= var_463_14 + var_463_15 and arg_460_1.time_ < var_463_14 + var_463_15 + arg_463_0 then
				arg_460_1.allBtn_.enabled = true
			end

			local var_463_16 = 0

			if var_463_16 < arg_460_1.time_ and arg_460_1.time_ <= var_463_16 + arg_463_0 then
				arg_460_1.mask_.enabled = true
				arg_460_1.mask_.raycastTarget = true

				arg_460_1:SetGaussion(false)
			end

			local var_463_17 = 2

			if var_463_16 <= arg_460_1.time_ and arg_460_1.time_ < var_463_16 + var_463_17 then
				local var_463_18 = (arg_460_1.time_ - var_463_16) / var_463_17
				local var_463_19 = Color.New(0, 0, 0)

				var_463_19.a = Mathf.Lerp(1, 0, var_463_18)
				arg_460_1.mask_.color = var_463_19
			end

			if arg_460_1.time_ >= var_463_16 + var_463_17 and arg_460_1.time_ < var_463_16 + var_463_17 + arg_463_0 then
				local var_463_20 = Color.New(0, 0, 0)
				local var_463_21 = 0

				arg_460_1.mask_.enabled = false
				var_463_20.a = var_463_21
				arg_460_1.mask_.color = var_463_20
			end

			local var_463_22 = 0.3
			local var_463_23 = 1

			if var_463_22 < arg_460_1.time_ and arg_460_1.time_ <= var_463_22 + arg_463_0 then
				local var_463_24 = "play"
				local var_463_25 = "effect"

				arg_460_1:AudioAction(var_463_24, var_463_25, "se_story_147", "se_story_147_light_button_off", "")
			end

			if arg_460_1.frameCnt_ <= 1 then
				arg_460_1.dialog_:SetActive(false)
			end

			local var_463_26 = 2
			local var_463_27 = 0.575

			if var_463_26 < arg_460_1.time_ and arg_460_1.time_ <= var_463_26 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0

				arg_460_1.dialog_:SetActive(true)

				arg_460_1.dialogCg_.alpha = 0

				local var_463_28 = LeanTween.value(arg_460_1.dialog_, 0, 1, 0.3)

				var_463_28:setOnUpdate(LuaHelper.FloatAction(function(arg_464_0)
					arg_460_1.dialogCg_.alpha = arg_464_0
				end))
				var_463_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_460_1.dialog_)
					var_463_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_460_1.duration_ = arg_460_1.duration_ + 0.3

				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_29 = arg_460_1:FormatText(StoryNameCfg[1296].name)

				arg_460_1.leftNameTxt_.text = var_463_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_2")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_30 = arg_460_1:GetWordFromCfg(1104704113)
				local var_463_31 = arg_460_1:FormatText(var_463_30.content)

				arg_460_1.text_.text = var_463_31

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_32 = 23
				local var_463_33 = utf8.len(var_463_31)
				local var_463_34 = var_463_32 <= 0 and var_463_27 or var_463_27 * (var_463_33 / var_463_32)

				if var_463_34 > 0 and var_463_27 < var_463_34 then
					arg_460_1.talkMaxDuration = var_463_34
					var_463_26 = var_463_26 + 0.3

					if var_463_34 + var_463_26 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_34 + var_463_26
					end
				end

				arg_460_1.text_.text = var_463_31
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704113", "story_v_side_new_1104704.awb") ~= 0 then
					local var_463_35 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704113", "story_v_side_new_1104704.awb") / 1000

					if var_463_35 + var_463_26 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_35 + var_463_26
					end

					if var_463_30.prefab_name ~= "" and arg_460_1.actors_[var_463_30.prefab_name] ~= nil then
						local var_463_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_30.prefab_name].transform, "story_v_side_new_1104704", "1104704113", "story_v_side_new_1104704.awb")

						arg_460_1:RecordAudio("1104704113", var_463_36)
						arg_460_1:RecordAudio("1104704113", var_463_36)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704113", "story_v_side_new_1104704.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704113", "story_v_side_new_1104704.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_37 = var_463_26 + 0.3
			local var_463_38 = math.max(var_463_27, arg_460_1.talkMaxDuration)

			if var_463_37 <= arg_460_1.time_ and arg_460_1.time_ < var_463_37 + var_463_38 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_37) / var_463_38

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_37 + var_463_38 and arg_460_1.time_ < var_463_37 + var_463_38 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play1104704114 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1104704114
		arg_466_1.duration_ = 1

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"

			SetActive(arg_466_1.choicesGo_, true)

			for iter_467_0, iter_467_1 in ipairs(arg_466_1.choices_) do
				local var_467_0 = iter_467_0 <= 2

				SetActive(iter_467_1.go, var_467_0)
			end

			arg_466_1.choices_[1].txt.text = arg_466_1:FormatText(StoryChoiceCfg[1662].name)
			arg_466_1.choices_[2].txt.text = arg_466_1:FormatText(StoryChoiceCfg[1663].name)
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1104704115(arg_466_1)
			end

			if arg_468_0 == 2 then
				arg_466_0:Play1104704115(arg_466_1)
			end

			arg_466_1:RecordChoiceLog(1104704114, 1662, 1663)
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0

			if var_469_0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1.allBtn_.enabled = false
			end

			local var_469_1 = 0.566666666666667

			if arg_466_1.time_ >= var_469_0 + var_469_1 and arg_466_1.time_ < var_469_0 + var_469_1 + arg_469_0 then
				arg_466_1.allBtn_.enabled = true
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1104704115 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1104704115
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1104704116(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0
			local var_473_1 = 0.45

			if var_473_0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_2 = arg_470_1:GetWordFromCfg(1104704115)
				local var_473_3 = arg_470_1:FormatText(var_473_2.content)

				arg_470_1.text_.text = var_473_3

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_4 = 18
				local var_473_5 = utf8.len(var_473_3)
				local var_473_6 = var_473_4 <= 0 and var_473_1 or var_473_1 * (var_473_5 / var_473_4)

				if var_473_6 > 0 and var_473_1 < var_473_6 then
					arg_470_1.talkMaxDuration = var_473_6

					if var_473_6 + var_473_0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_6 + var_473_0
					end
				end

				arg_470_1.text_.text = var_473_3
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_7 = math.max(var_473_1, arg_470_1.talkMaxDuration)

			if var_473_0 <= arg_470_1.time_ and arg_470_1.time_ < var_473_0 + var_473_7 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_0) / var_473_7

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_0 + var_473_7 and arg_470_1.time_ < var_473_0 + var_473_7 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play1104704116 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1104704116
		arg_474_1.duration_ = 4.1

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1104704117(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0
			local var_477_1 = 0.5

			if var_477_0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_2 = arg_474_1:FormatText(StoryNameCfg[1517].name)

				arg_474_1.leftNameTxt_.text = var_477_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_3 = arg_474_1:GetWordFromCfg(1104704116)
				local var_477_4 = arg_474_1:FormatText(var_477_3.content)

				arg_474_1.text_.text = var_477_4

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_5 = 20
				local var_477_6 = utf8.len(var_477_4)
				local var_477_7 = var_477_5 <= 0 and var_477_1 or var_477_1 * (var_477_6 / var_477_5)

				if var_477_7 > 0 and var_477_1 < var_477_7 then
					arg_474_1.talkMaxDuration = var_477_7

					if var_477_7 + var_477_0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_7 + var_477_0
					end
				end

				arg_474_1.text_.text = var_477_4
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704116", "story_v_side_new_1104704.awb") ~= 0 then
					local var_477_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704116", "story_v_side_new_1104704.awb") / 1000

					if var_477_8 + var_477_0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_8 + var_477_0
					end

					if var_477_3.prefab_name ~= "" and arg_474_1.actors_[var_477_3.prefab_name] ~= nil then
						local var_477_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_3.prefab_name].transform, "story_v_side_new_1104704", "1104704116", "story_v_side_new_1104704.awb")

						arg_474_1:RecordAudio("1104704116", var_477_9)
						arg_474_1:RecordAudio("1104704116", var_477_9)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704116", "story_v_side_new_1104704.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704116", "story_v_side_new_1104704.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_10 = math.max(var_477_1, arg_474_1.talkMaxDuration)

			if var_477_0 <= arg_474_1.time_ and arg_474_1.time_ < var_477_0 + var_477_10 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_0) / var_477_10

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_0 + var_477_10 and arg_474_1.time_ < var_477_0 + var_477_10 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play1104704117 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 1104704117
		arg_478_1.duration_ = 2.13

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play1104704118(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0
			local var_481_1 = 0.2

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_2 = arg_478_1:FormatText(StoryNameCfg[1296].name)

				arg_478_1.leftNameTxt_.text = var_481_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_7")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_3 = arg_478_1:GetWordFromCfg(1104704117)
				local var_481_4 = arg_478_1:FormatText(var_481_3.content)

				arg_478_1.text_.text = var_481_4

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_5 = 8
				local var_481_6 = utf8.len(var_481_4)
				local var_481_7 = var_481_5 <= 0 and var_481_1 or var_481_1 * (var_481_6 / var_481_5)

				if var_481_7 > 0 and var_481_1 < var_481_7 then
					arg_478_1.talkMaxDuration = var_481_7

					if var_481_7 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_7 + var_481_0
					end
				end

				arg_478_1.text_.text = var_481_4
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704117", "story_v_side_new_1104704.awb") ~= 0 then
					local var_481_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704117", "story_v_side_new_1104704.awb") / 1000

					if var_481_8 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_8 + var_481_0
					end

					if var_481_3.prefab_name ~= "" and arg_478_1.actors_[var_481_3.prefab_name] ~= nil then
						local var_481_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_3.prefab_name].transform, "story_v_side_new_1104704", "1104704117", "story_v_side_new_1104704.awb")

						arg_478_1:RecordAudio("1104704117", var_481_9)
						arg_478_1:RecordAudio("1104704117", var_481_9)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704117", "story_v_side_new_1104704.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704117", "story_v_side_new_1104704.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_10 = math.max(var_481_1, arg_478_1.talkMaxDuration)

			if var_481_0 <= arg_478_1.time_ and arg_478_1.time_ < var_481_0 + var_481_10 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_0) / var_481_10

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_0 + var_481_10 and arg_478_1.time_ < var_481_0 + var_481_10 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play1104704118 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1104704118
		arg_482_1.duration_ = 4.17

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1104704119(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0
			local var_485_1 = 0.525

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_2 = arg_482_1:FormatText(StoryNameCfg[1296].name)

				arg_482_1.leftNameTxt_.text = var_485_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_2")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_3 = arg_482_1:GetWordFromCfg(1104704118)
				local var_485_4 = arg_482_1:FormatText(var_485_3.content)

				arg_482_1.text_.text = var_485_4

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 21
				local var_485_6 = utf8.len(var_485_4)
				local var_485_7 = var_485_5 <= 0 and var_485_1 or var_485_1 * (var_485_6 / var_485_5)

				if var_485_7 > 0 and var_485_1 < var_485_7 then
					arg_482_1.talkMaxDuration = var_485_7

					if var_485_7 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_0
					end
				end

				arg_482_1.text_.text = var_485_4
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704118", "story_v_side_new_1104704.awb") ~= 0 then
					local var_485_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704118", "story_v_side_new_1104704.awb") / 1000

					if var_485_8 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_8 + var_485_0
					end

					if var_485_3.prefab_name ~= "" and arg_482_1.actors_[var_485_3.prefab_name] ~= nil then
						local var_485_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_3.prefab_name].transform, "story_v_side_new_1104704", "1104704118", "story_v_side_new_1104704.awb")

						arg_482_1:RecordAudio("1104704118", var_485_9)
						arg_482_1:RecordAudio("1104704118", var_485_9)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704118", "story_v_side_new_1104704.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704118", "story_v_side_new_1104704.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_10 = math.max(var_485_1, arg_482_1.talkMaxDuration)

			if var_485_0 <= arg_482_1.time_ and arg_482_1.time_ < var_485_0 + var_485_10 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_0) / var_485_10

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_0 + var_485_10 and arg_482_1.time_ < var_485_0 + var_485_10 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play1104704119 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1104704119
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1104704120(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0
			local var_489_1 = 0.825

			if var_489_0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_2 = arg_486_1:GetWordFromCfg(1104704119)
				local var_489_3 = arg_486_1:FormatText(var_489_2.content)

				arg_486_1.text_.text = var_489_3

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_4 = 33
				local var_489_5 = utf8.len(var_489_3)
				local var_489_6 = var_489_4 <= 0 and var_489_1 or var_489_1 * (var_489_5 / var_489_4)

				if var_489_6 > 0 and var_489_1 < var_489_6 then
					arg_486_1.talkMaxDuration = var_489_6

					if var_489_6 + var_489_0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_6 + var_489_0
					end
				end

				arg_486_1.text_.text = var_489_3
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_7 = math.max(var_489_1, arg_486_1.talkMaxDuration)

			if var_489_0 <= arg_486_1.time_ and arg_486_1.time_ < var_489_0 + var_489_7 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_0) / var_489_7

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_0 + var_489_7 and arg_486_1.time_ < var_489_0 + var_489_7 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play1104704120 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1104704120
		arg_490_1.duration_ = 3.27

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1104704121(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0
			local var_493_1 = 0.25

			if var_493_0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_2 = arg_490_1:FormatText(StoryNameCfg[1296].name)

				arg_490_1.leftNameTxt_.text = var_493_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, true)
				arg_490_1.iconController_:SetSelectedState("hero")

				arg_490_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_2")

				arg_490_1.callingController_:SetSelectedState("normal")

				arg_490_1.keyicon_.color = Color.New(1, 1, 1)
				arg_490_1.icon_.color = Color.New(1, 1, 1)

				local var_493_3 = arg_490_1:GetWordFromCfg(1104704120)
				local var_493_4 = arg_490_1:FormatText(var_493_3.content)

				arg_490_1.text_.text = var_493_4

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_5 = 10
				local var_493_6 = utf8.len(var_493_4)
				local var_493_7 = var_493_5 <= 0 and var_493_1 or var_493_1 * (var_493_6 / var_493_5)

				if var_493_7 > 0 and var_493_1 < var_493_7 then
					arg_490_1.talkMaxDuration = var_493_7

					if var_493_7 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_7 + var_493_0
					end
				end

				arg_490_1.text_.text = var_493_4
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704120", "story_v_side_new_1104704.awb") ~= 0 then
					local var_493_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704120", "story_v_side_new_1104704.awb") / 1000

					if var_493_8 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_8 + var_493_0
					end

					if var_493_3.prefab_name ~= "" and arg_490_1.actors_[var_493_3.prefab_name] ~= nil then
						local var_493_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_3.prefab_name].transform, "story_v_side_new_1104704", "1104704120", "story_v_side_new_1104704.awb")

						arg_490_1:RecordAudio("1104704120", var_493_9)
						arg_490_1:RecordAudio("1104704120", var_493_9)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704120", "story_v_side_new_1104704.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704120", "story_v_side_new_1104704.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_10 = math.max(var_493_1, arg_490_1.talkMaxDuration)

			if var_493_0 <= arg_490_1.time_ and arg_490_1.time_ < var_493_0 + var_493_10 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_0) / var_493_10

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_0 + var_493_10 and arg_490_1.time_ < var_493_0 + var_493_10 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play1104704121 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1104704121
		arg_494_1.duration_ = 6.9

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1104704122(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 2

			if var_497_0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_0 + arg_497_0 then
				arg_494_1.allBtn_.enabled = false
			end

			local var_497_1 = 0.3

			if arg_494_1.time_ >= var_497_0 + var_497_1 and arg_494_1.time_ < var_497_0 + var_497_1 + arg_497_0 then
				arg_494_1.allBtn_.enabled = true
			end

			local var_497_2 = 0

			if var_497_2 < arg_494_1.time_ and arg_494_1.time_ <= var_497_2 + arg_497_0 then
				arg_494_1.mask_.enabled = true
				arg_494_1.mask_.raycastTarget = true

				arg_494_1:SetGaussion(false)
			end

			local var_497_3 = 1

			if var_497_2 <= arg_494_1.time_ and arg_494_1.time_ < var_497_2 + var_497_3 then
				local var_497_4 = (arg_494_1.time_ - var_497_2) / var_497_3
				local var_497_5 = Color.New(0, 0, 0)

				var_497_5.a = Mathf.Lerp(0, 1, var_497_4)
				arg_494_1.mask_.color = var_497_5
			end

			if arg_494_1.time_ >= var_497_2 + var_497_3 and arg_494_1.time_ < var_497_2 + var_497_3 + arg_497_0 then
				local var_497_6 = Color.New(0, 0, 0)

				var_497_6.a = 1
				arg_494_1.mask_.color = var_497_6
			end

			local var_497_7 = 1

			if var_497_7 < arg_494_1.time_ and arg_494_1.time_ <= var_497_7 + arg_497_0 then
				arg_494_1.mask_.enabled = true
				arg_494_1.mask_.raycastTarget = true

				arg_494_1:SetGaussion(false)
			end

			local var_497_8 = 1

			if var_497_7 <= arg_494_1.time_ and arg_494_1.time_ < var_497_7 + var_497_8 then
				local var_497_9 = (arg_494_1.time_ - var_497_7) / var_497_8
				local var_497_10 = Color.New(0, 0, 0)

				var_497_10.a = Mathf.Lerp(1, 0, var_497_9)
				arg_494_1.mask_.color = var_497_10
			end

			if arg_494_1.time_ >= var_497_7 + var_497_8 and arg_494_1.time_ < var_497_7 + var_497_8 + arg_497_0 then
				local var_497_11 = Color.New(0, 0, 0)
				local var_497_12 = 0

				arg_494_1.mask_.enabled = false
				var_497_11.a = var_497_12
				arg_494_1.mask_.color = var_497_11
			end

			local var_497_13 = 0

			if var_497_13 < arg_494_1.time_ and arg_494_1.time_ <= var_497_13 + arg_497_0 then
				arg_494_1.allBtn_.enabled = false
			end

			local var_497_14 = 1.674999999999

			if arg_494_1.time_ >= var_497_13 + var_497_14 and arg_494_1.time_ < var_497_13 + var_497_14 + arg_497_0 then
				arg_494_1.allBtn_.enabled = true
			end

			if arg_494_1.frameCnt_ <= 1 then
				arg_494_1.dialog_:SetActive(false)
			end

			local var_497_15 = 2
			local var_497_16 = 0.325

			if var_497_15 < arg_494_1.time_ and arg_494_1.time_ <= var_497_15 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0

				arg_494_1.dialog_:SetActive(true)

				arg_494_1.dialogCg_.alpha = 0

				local var_497_17 = LeanTween.value(arg_494_1.dialog_, 0, 1, 0.3)

				var_497_17:setOnUpdate(LuaHelper.FloatAction(function(arg_498_0)
					arg_494_1.dialogCg_.alpha = arg_498_0
				end))
				var_497_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_494_1.dialog_)
					var_497_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_494_1.duration_ = arg_494_1.duration_ + 0.3

				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_18 = arg_494_1:FormatText(StoryNameCfg[1517].name)

				arg_494_1.leftNameTxt_.text = var_497_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_19 = arg_494_1:GetWordFromCfg(1104704121)
				local var_497_20 = arg_494_1:FormatText(var_497_19.content)

				arg_494_1.text_.text = var_497_20

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_21 = 13
				local var_497_22 = utf8.len(var_497_20)
				local var_497_23 = var_497_21 <= 0 and var_497_16 or var_497_16 * (var_497_22 / var_497_21)

				if var_497_23 > 0 and var_497_16 < var_497_23 then
					arg_494_1.talkMaxDuration = var_497_23
					var_497_15 = var_497_15 + 0.3

					if var_497_23 + var_497_15 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_23 + var_497_15
					end
				end

				arg_494_1.text_.text = var_497_20
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704121", "story_v_side_new_1104704.awb") ~= 0 then
					local var_497_24 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704121", "story_v_side_new_1104704.awb") / 1000

					if var_497_24 + var_497_15 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_24 + var_497_15
					end

					if var_497_19.prefab_name ~= "" and arg_494_1.actors_[var_497_19.prefab_name] ~= nil then
						local var_497_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_19.prefab_name].transform, "story_v_side_new_1104704", "1104704121", "story_v_side_new_1104704.awb")

						arg_494_1:RecordAudio("1104704121", var_497_25)
						arg_494_1:RecordAudio("1104704121", var_497_25)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704121", "story_v_side_new_1104704.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704121", "story_v_side_new_1104704.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_26 = var_497_15 + 0.3
			local var_497_27 = math.max(var_497_16, arg_494_1.talkMaxDuration)

			if var_497_26 <= arg_494_1.time_ and arg_494_1.time_ < var_497_26 + var_497_27 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_26) / var_497_27

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_26 + var_497_27 and arg_494_1.time_ < var_497_26 + var_497_27 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play1104704122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1104704122
		arg_500_1.duration_ = 2.8

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1104704123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 0.25

			if var_503_0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_2 = arg_500_1:FormatText(StoryNameCfg[1518].name)

				arg_500_1.leftNameTxt_.text = var_503_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, true)
				arg_500_1.iconController_:SetSelectedState("hero")

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_3 = arg_500_1:GetWordFromCfg(1104704122)
				local var_503_4 = arg_500_1:FormatText(var_503_3.content)

				arg_500_1.text_.text = var_503_4

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_5 = 10
				local var_503_6 = utf8.len(var_503_4)
				local var_503_7 = var_503_5 <= 0 and var_503_1 or var_503_1 * (var_503_6 / var_503_5)

				if var_503_7 > 0 and var_503_1 < var_503_7 then
					arg_500_1.talkMaxDuration = var_503_7

					if var_503_7 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_7 + var_503_0
					end
				end

				arg_500_1.text_.text = var_503_4
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704122", "story_v_side_new_1104704.awb") ~= 0 then
					local var_503_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704122", "story_v_side_new_1104704.awb") / 1000

					if var_503_8 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_8 + var_503_0
					end

					if var_503_3.prefab_name ~= "" and arg_500_1.actors_[var_503_3.prefab_name] ~= nil then
						local var_503_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_3.prefab_name].transform, "story_v_side_new_1104704", "1104704122", "story_v_side_new_1104704.awb")

						arg_500_1:RecordAudio("1104704122", var_503_9)
						arg_500_1:RecordAudio("1104704122", var_503_9)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704122", "story_v_side_new_1104704.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704122", "story_v_side_new_1104704.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_10 = math.max(var_503_1, arg_500_1.talkMaxDuration)

			if var_503_0 <= arg_500_1.time_ and arg_500_1.time_ < var_503_0 + var_503_10 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_0) / var_503_10

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_0 + var_503_10 and arg_500_1.time_ < var_503_0 + var_503_10 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play1104704123 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 1104704123
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play1104704124(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 0.55

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_2 = arg_504_1:FormatText(StoryNameCfg[7].name)

				arg_504_1.leftNameTxt_.text = var_507_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, true)
				arg_504_1.iconController_:SetSelectedState("hero")

				arg_504_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_504_1.callingController_:SetSelectedState("normal")

				arg_504_1.keyicon_.color = Color.New(1, 1, 1)
				arg_504_1.icon_.color = Color.New(1, 1, 1)

				local var_507_3 = arg_504_1:GetWordFromCfg(1104704123)
				local var_507_4 = arg_504_1:FormatText(var_507_3.content)

				arg_504_1.text_.text = var_507_4

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 22
				local var_507_6 = utf8.len(var_507_4)
				local var_507_7 = var_507_5 <= 0 and var_507_1 or var_507_1 * (var_507_6 / var_507_5)

				if var_507_7 > 0 and var_507_1 < var_507_7 then
					arg_504_1.talkMaxDuration = var_507_7

					if var_507_7 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_7 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_4
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_8 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_8 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_8

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_8 and arg_504_1.time_ < var_507_0 + var_507_8 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play1104704124 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 1104704124
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play1104704125(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0
			local var_511_1 = 1.175

			if var_511_0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, false)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_2 = arg_508_1:GetWordFromCfg(1104704124)
				local var_511_3 = arg_508_1:FormatText(var_511_2.content)

				arg_508_1.text_.text = var_511_3

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_4 = 47
				local var_511_5 = utf8.len(var_511_3)
				local var_511_6 = var_511_4 <= 0 and var_511_1 or var_511_1 * (var_511_5 / var_511_4)

				if var_511_6 > 0 and var_511_1 < var_511_6 then
					arg_508_1.talkMaxDuration = var_511_6

					if var_511_6 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_6 + var_511_0
					end
				end

				arg_508_1.text_.text = var_511_3
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_7 = math.max(var_511_1, arg_508_1.talkMaxDuration)

			if var_511_0 <= arg_508_1.time_ and arg_508_1.time_ < var_511_0 + var_511_7 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_0) / var_511_7

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_0 + var_511_7 and arg_508_1.time_ < var_511_0 + var_511_7 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play1104704125 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 1104704125
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play1104704126(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = 0
			local var_515_1 = 0.166666666666667

			if var_515_0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_0 + arg_515_0 then
				local var_515_2 = "play"
				local var_515_3 = "effect"

				arg_512_1:AudioAction(var_515_2, var_515_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_515_4 = 0.166666666666667
			local var_515_5 = 0.833333333333333

			if var_515_4 < arg_512_1.time_ and arg_512_1.time_ <= var_515_4 + arg_515_0 then
				local var_515_6 = "play"
				local var_515_7 = "music"

				arg_512_1:AudioAction(var_515_6, var_515_7, "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_515_8 = ""
				local var_515_9 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if var_515_9 ~= "" then
					if arg_512_1.bgmTxt_.text ~= var_515_9 and arg_512_1.bgmTxt_.text ~= "" then
						if arg_512_1.bgmTxt2_.text ~= "" then
							arg_512_1.bgmTxt_.text = arg_512_1.bgmTxt2_.text
						end

						arg_512_1.bgmTxt2_.text = var_515_9

						arg_512_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_512_1.bgmTxt_.text = var_515_9
						arg_512_1.bgmTxt2_.text = var_515_9
					end

					if arg_512_1.bgmTimer then
						arg_512_1.bgmTimer:Stop()

						arg_512_1.bgmTimer = nil
					end

					if arg_512_1.settingData.show_music_name == 1 then
						arg_512_1.musicController:SetSelectedState("show")
						arg_512_1.musicAnimator_:Play("open", 0, 0)

						if arg_512_1.settingData.music_time ~= 0 then
							arg_512_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_512_1.settingData.music_time), function()
								if arg_512_1 == nil or isNil(arg_512_1.bgmTxt_) then
									return
								end

								arg_512_1.musicController:SetSelectedState("hide")
								arg_512_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_515_10 = 0
			local var_515_11 = 0.35

			if var_515_10 < arg_512_1.time_ and arg_512_1.time_ <= var_515_10 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_12 = arg_512_1:FormatText(StoryNameCfg[7].name)

				arg_512_1.leftNameTxt_.text = var_515_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, true)
				arg_512_1.iconController_:SetSelectedState("hero")

				arg_512_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_512_1.callingController_:SetSelectedState("normal")

				arg_512_1.keyicon_.color = Color.New(1, 1, 1)
				arg_512_1.icon_.color = Color.New(1, 1, 1)

				local var_515_13 = arg_512_1:GetWordFromCfg(1104704125)
				local var_515_14 = arg_512_1:FormatText(var_515_13.content)

				arg_512_1.text_.text = var_515_14

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_15 = 14
				local var_515_16 = utf8.len(var_515_14)
				local var_515_17 = var_515_15 <= 0 and var_515_11 or var_515_11 * (var_515_16 / var_515_15)

				if var_515_17 > 0 and var_515_11 < var_515_17 then
					arg_512_1.talkMaxDuration = var_515_17

					if var_515_17 + var_515_10 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_17 + var_515_10
					end
				end

				arg_512_1.text_.text = var_515_14
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_18 = math.max(var_515_11, arg_512_1.talkMaxDuration)

			if var_515_10 <= arg_512_1.time_ and arg_512_1.time_ < var_515_10 + var_515_18 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_10) / var_515_18

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_10 + var_515_18 and arg_512_1.time_ < var_515_10 + var_515_18 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play1104704126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1104704126
		arg_517_1.duration_ = 9

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1104704127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = "R4701"

			if arg_517_1.bgs_[var_520_0] == nil then
				local var_520_1 = Object.Instantiate(arg_517_1.paintGo_)

				var_520_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_520_0)
				var_520_1.name = var_520_0
				var_520_1.transform.parent = arg_517_1.stage_.transform
				var_520_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_517_1.bgs_[var_520_0] = var_520_1
			end

			local var_520_2 = 2

			if var_520_2 < arg_517_1.time_ and arg_517_1.time_ <= var_520_2 + arg_520_0 then
				local var_520_3 = manager.ui.mainCamera.transform.localPosition
				local var_520_4 = Vector3.New(0, 0, 10) + Vector3.New(var_520_3.x, var_520_3.y, 0)
				local var_520_5 = arg_517_1.bgs_.R4701

				var_520_5.transform.localPosition = var_520_4
				var_520_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_520_6 = var_520_5:GetComponent("SpriteRenderer")

				if var_520_6 and var_520_6.sprite then
					local var_520_7 = (var_520_5.transform.localPosition - var_520_3).z
					local var_520_8 = manager.ui.mainCameraCom_
					local var_520_9 = 2 * var_520_7 * Mathf.Tan(var_520_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_520_10 = var_520_9 * var_520_8.aspect
					local var_520_11 = var_520_6.sprite.bounds.size.x
					local var_520_12 = var_520_6.sprite.bounds.size.y
					local var_520_13 = var_520_10 / var_520_11
					local var_520_14 = var_520_9 / var_520_12
					local var_520_15 = var_520_14 < var_520_13 and var_520_13 or var_520_14

					var_520_5.transform.localScale = Vector3.New(var_520_15, var_520_15, 0)
				end

				for iter_520_0, iter_520_1 in pairs(arg_517_1.bgs_) do
					if iter_520_0 ~= "R4701" then
						iter_520_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_520_16 = 4

			if var_520_16 < arg_517_1.time_ and arg_517_1.time_ <= var_520_16 + arg_520_0 then
				arg_517_1.allBtn_.enabled = false
			end

			local var_520_17 = 0.3

			if arg_517_1.time_ >= var_520_16 + var_520_17 and arg_517_1.time_ < var_520_16 + var_520_17 + arg_520_0 then
				arg_517_1.allBtn_.enabled = true
			end

			local var_520_18 = 0

			if var_520_18 < arg_517_1.time_ and arg_517_1.time_ <= var_520_18 + arg_520_0 then
				arg_517_1.mask_.enabled = true
				arg_517_1.mask_.raycastTarget = true

				arg_517_1:SetGaussion(false)
			end

			local var_520_19 = 2

			if var_520_18 <= arg_517_1.time_ and arg_517_1.time_ < var_520_18 + var_520_19 then
				local var_520_20 = (arg_517_1.time_ - var_520_18) / var_520_19
				local var_520_21 = Color.New(0, 0, 0)

				var_520_21.a = Mathf.Lerp(0, 1, var_520_20)
				arg_517_1.mask_.color = var_520_21
			end

			if arg_517_1.time_ >= var_520_18 + var_520_19 and arg_517_1.time_ < var_520_18 + var_520_19 + arg_520_0 then
				local var_520_22 = Color.New(0, 0, 0)

				var_520_22.a = 1
				arg_517_1.mask_.color = var_520_22
			end

			local var_520_23 = 2

			if var_520_23 < arg_517_1.time_ and arg_517_1.time_ <= var_520_23 + arg_520_0 then
				arg_517_1.mask_.enabled = true
				arg_517_1.mask_.raycastTarget = true

				arg_517_1:SetGaussion(false)
			end

			local var_520_24 = 2

			if var_520_23 <= arg_517_1.time_ and arg_517_1.time_ < var_520_23 + var_520_24 then
				local var_520_25 = (arg_517_1.time_ - var_520_23) / var_520_24
				local var_520_26 = Color.New(0, 0, 0)

				var_520_26.a = Mathf.Lerp(1, 0, var_520_25)
				arg_517_1.mask_.color = var_520_26
			end

			if arg_517_1.time_ >= var_520_23 + var_520_24 and arg_517_1.time_ < var_520_23 + var_520_24 + arg_520_0 then
				local var_520_27 = Color.New(0, 0, 0)
				local var_520_28 = 0

				arg_517_1.mask_.enabled = false
				var_520_27.a = var_520_28
				arg_517_1.mask_.color = var_520_27
			end

			local var_520_29 = arg_517_1.bgs_.R4701.transform
			local var_520_30 = 2

			if var_520_30 < arg_517_1.time_ and arg_517_1.time_ <= var_520_30 + arg_520_0 then
				arg_517_1.var_.moveOldPosR4701 = var_520_29.localPosition
			end

			local var_520_31 = 3.05

			if var_520_30 <= arg_517_1.time_ and arg_517_1.time_ < var_520_30 + var_520_31 then
				local var_520_32 = (arg_517_1.time_ - var_520_30) / var_520_31
				local var_520_33 = Vector3.New(0, 0, 6)

				var_520_29.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPosR4701, var_520_33, var_520_32)
			end

			if arg_517_1.time_ >= var_520_30 + var_520_31 and arg_517_1.time_ < var_520_30 + var_520_31 + arg_520_0 then
				var_520_29.localPosition = Vector3.New(0, 0, 6)
			end

			if arg_517_1.frameCnt_ <= 1 then
				arg_517_1.dialog_:SetActive(false)
			end

			local var_520_34 = 4
			local var_520_35 = 1.05

			if var_520_34 < arg_517_1.time_ and arg_517_1.time_ <= var_520_34 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0

				arg_517_1.dialog_:SetActive(true)

				arg_517_1.dialogCg_.alpha = 0

				local var_520_36 = LeanTween.value(arg_517_1.dialog_, 0, 1, 0.3)

				var_520_36:setOnUpdate(LuaHelper.FloatAction(function(arg_521_0)
					arg_517_1.dialogCg_.alpha = arg_521_0
				end))
				var_520_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_517_1.dialog_)
					var_520_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_517_1.duration_ = arg_517_1.duration_ + 0.3

				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_37 = arg_517_1:GetWordFromCfg(1104704126)
				local var_520_38 = arg_517_1:FormatText(var_520_37.content)

				arg_517_1.text_.text = var_520_38

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_39 = 42
				local var_520_40 = utf8.len(var_520_38)
				local var_520_41 = var_520_39 <= 0 and var_520_35 or var_520_35 * (var_520_40 / var_520_39)

				if var_520_41 > 0 and var_520_35 < var_520_41 then
					arg_517_1.talkMaxDuration = var_520_41
					var_520_34 = var_520_34 + 0.3

					if var_520_41 + var_520_34 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_41 + var_520_34
					end
				end

				arg_517_1.text_.text = var_520_38
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_42 = var_520_34 + 0.3
			local var_520_43 = math.max(var_520_35, arg_517_1.talkMaxDuration)

			if var_520_42 <= arg_517_1.time_ and arg_517_1.time_ < var_520_42 + var_520_43 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_42) / var_520_43

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_42 + var_520_43 and arg_517_1.time_ < var_520_42 + var_520_43 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R4701",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.05,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 4),
					endPos = Vector3.New(0, 0, 6),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_517_1:InitPlayNodeList()
	end,
	Play1104704127 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1104704127
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1104704128(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0
			local var_526_1 = 0.125

			if var_526_0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_2 = arg_523_1:FormatText(StoryNameCfg[7].name)

				arg_523_1.leftNameTxt_.text = var_526_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_3 = arg_523_1:GetWordFromCfg(1104704127)
				local var_526_4 = arg_523_1:FormatText(var_526_3.content)

				arg_523_1.text_.text = var_526_4

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 5
				local var_526_6 = utf8.len(var_526_4)
				local var_526_7 = var_526_5 <= 0 and var_526_1 or var_526_1 * (var_526_6 / var_526_5)

				if var_526_7 > 0 and var_526_1 < var_526_7 then
					arg_523_1.talkMaxDuration = var_526_7

					if var_526_7 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_7 + var_526_0
					end
				end

				arg_523_1.text_.text = var_526_4
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_8 = math.max(var_526_1, arg_523_1.talkMaxDuration)

			if var_526_0 <= arg_523_1.time_ and arg_523_1.time_ < var_526_0 + var_526_8 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_0) / var_526_8

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_0 + var_526_8 and arg_523_1.time_ < var_526_0 + var_526_8 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1104704128 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1104704128
		arg_527_1.duration_ = 4.13

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1104704129(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0
			local var_530_1 = 0.2

			if var_530_0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_2 = arg_527_1:FormatText(StoryNameCfg[1296].name)

				arg_527_1.leftNameTxt_.text = var_530_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_3 = arg_527_1:GetWordFromCfg(1104704128)
				local var_530_4 = arg_527_1:FormatText(var_530_3.content)

				arg_527_1.text_.text = var_530_4

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_5 = 8
				local var_530_6 = utf8.len(var_530_4)
				local var_530_7 = var_530_5 <= 0 and var_530_1 or var_530_1 * (var_530_6 / var_530_5)

				if var_530_7 > 0 and var_530_1 < var_530_7 then
					arg_527_1.talkMaxDuration = var_530_7

					if var_530_7 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_7 + var_530_0
					end
				end

				arg_527_1.text_.text = var_530_4
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704128", "story_v_side_new_1104704.awb") ~= 0 then
					local var_530_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704128", "story_v_side_new_1104704.awb") / 1000

					if var_530_8 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_8 + var_530_0
					end

					if var_530_3.prefab_name ~= "" and arg_527_1.actors_[var_530_3.prefab_name] ~= nil then
						local var_530_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_3.prefab_name].transform, "story_v_side_new_1104704", "1104704128", "story_v_side_new_1104704.awb")

						arg_527_1:RecordAudio("1104704128", var_530_9)
						arg_527_1:RecordAudio("1104704128", var_530_9)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704128", "story_v_side_new_1104704.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704128", "story_v_side_new_1104704.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_10 = math.max(var_530_1, arg_527_1.talkMaxDuration)

			if var_530_0 <= arg_527_1.time_ and arg_527_1.time_ < var_530_0 + var_530_10 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_0) / var_530_10

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_0 + var_530_10 and arg_527_1.time_ < var_530_0 + var_530_10 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1104704129 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1104704129
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1104704130(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0
			local var_534_1 = 0.775

			if var_534_0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_2 = arg_531_1:FormatText(StoryNameCfg[7].name)

				arg_531_1.leftNameTxt_.text = var_534_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_3 = arg_531_1:GetWordFromCfg(1104704129)
				local var_534_4 = arg_531_1:FormatText(var_534_3.content)

				arg_531_1.text_.text = var_534_4

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_5 = 31
				local var_534_6 = utf8.len(var_534_4)
				local var_534_7 = var_534_5 <= 0 and var_534_1 or var_534_1 * (var_534_6 / var_534_5)

				if var_534_7 > 0 and var_534_1 < var_534_7 then
					arg_531_1.talkMaxDuration = var_534_7

					if var_534_7 + var_534_0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_7 + var_534_0
					end
				end

				arg_531_1.text_.text = var_534_4
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_8 = math.max(var_534_1, arg_531_1.talkMaxDuration)

			if var_534_0 <= arg_531_1.time_ and arg_531_1.time_ < var_534_0 + var_534_8 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_0) / var_534_8

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_0 + var_534_8 and arg_531_1.time_ < var_534_0 + var_534_8 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1104704130 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1104704130
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1104704131(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = arg_535_1.bgs_.R4701.transform
			local var_538_1 = 0

			if var_538_1 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.var_.moveOldPosR4701 = var_538_0.localPosition
			end

			local var_538_2 = 3.05

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_2 then
				local var_538_3 = (arg_535_1.time_ - var_538_1) / var_538_2
				local var_538_4 = Vector3.New(0, 0, 5.5)

				var_538_0.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPosR4701, var_538_4, var_538_3)
			end

			if arg_535_1.time_ >= var_538_1 + var_538_2 and arg_535_1.time_ < var_538_1 + var_538_2 + arg_538_0 then
				var_538_0.localPosition = Vector3.New(0, 0, 5.5)
			end

			local var_538_5 = 0
			local var_538_6 = 1.05

			if var_538_5 < arg_535_1.time_ and arg_535_1.time_ <= var_538_5 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_7 = arg_535_1:GetWordFromCfg(1104704130)
				local var_538_8 = arg_535_1:FormatText(var_538_7.content)

				arg_535_1.text_.text = var_538_8

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_9 = 42
				local var_538_10 = utf8.len(var_538_8)
				local var_538_11 = var_538_9 <= 0 and var_538_6 or var_538_6 * (var_538_10 / var_538_9)

				if var_538_11 > 0 and var_538_6 < var_538_11 then
					arg_535_1.talkMaxDuration = var_538_11

					if var_538_11 + var_538_5 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_11 + var_538_5
					end
				end

				arg_535_1.text_.text = var_538_8
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_12 = math.max(var_538_6, arg_535_1.talkMaxDuration)

			if var_538_5 <= arg_535_1.time_ and arg_535_1.time_ < var_538_5 + var_538_12 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_5) / var_538_12

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_5 + var_538_12 and arg_535_1.time_ < var_538_5 + var_538_12 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R4701",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.05,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0, 6),
					endPos = Vector3.New(0, 0, 5.5),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play1104704131 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1104704131
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1104704132(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0
			local var_542_1 = 0.375

			if var_542_0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_2 = arg_539_1:FormatText(StoryNameCfg[7].name)

				arg_539_1.leftNameTxt_.text = var_542_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_3 = arg_539_1:GetWordFromCfg(1104704131)
				local var_542_4 = arg_539_1:FormatText(var_542_3.content)

				arg_539_1.text_.text = var_542_4

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_5 = 15
				local var_542_6 = utf8.len(var_542_4)
				local var_542_7 = var_542_5 <= 0 and var_542_1 or var_542_1 * (var_542_6 / var_542_5)

				if var_542_7 > 0 and var_542_1 < var_542_7 then
					arg_539_1.talkMaxDuration = var_542_7

					if var_542_7 + var_542_0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_7 + var_542_0
					end
				end

				arg_539_1.text_.text = var_542_4
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_8 = math.max(var_542_1, arg_539_1.talkMaxDuration)

			if var_542_0 <= arg_539_1.time_ and arg_539_1.time_ < var_542_0 + var_542_8 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_0) / var_542_8

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_0 + var_542_8 and arg_539_1.time_ < var_542_0 + var_542_8 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1104704132 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1104704132
		arg_543_1.duration_ = 6.7

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1104704133(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = "R4701a"

			if arg_543_1.bgs_[var_546_0] == nil then
				local var_546_1 = Object.Instantiate(arg_543_1.paintGo_)

				var_546_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_546_0)
				var_546_1.name = var_546_0
				var_546_1.transform.parent = arg_543_1.stage_.transform
				var_546_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_543_1.bgs_[var_546_0] = var_546_1
			end

			local var_546_2 = 0.533333333333333

			if var_546_2 < arg_543_1.time_ and arg_543_1.time_ <= var_546_2 + arg_546_0 then
				local var_546_3 = manager.ui.mainCamera.transform.localPosition
				local var_546_4 = Vector3.New(0, 0, 10) + Vector3.New(var_546_3.x, var_546_3.y, 0)
				local var_546_5 = arg_543_1.bgs_.R4701a

				var_546_5.transform.localPosition = var_546_4
				var_546_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_546_6 = var_546_5:GetComponent("SpriteRenderer")

				if var_546_6 and var_546_6.sprite then
					local var_546_7 = (var_546_5.transform.localPosition - var_546_3).z
					local var_546_8 = manager.ui.mainCameraCom_
					local var_546_9 = 2 * var_546_7 * Mathf.Tan(var_546_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_546_10 = var_546_9 * var_546_8.aspect
					local var_546_11 = var_546_6.sprite.bounds.size.x
					local var_546_12 = var_546_6.sprite.bounds.size.y
					local var_546_13 = var_546_10 / var_546_11
					local var_546_14 = var_546_9 / var_546_12
					local var_546_15 = var_546_14 < var_546_13 and var_546_13 or var_546_14

					var_546_5.transform.localScale = Vector3.New(var_546_15, var_546_15, 0)
				end

				for iter_546_0, iter_546_1 in pairs(arg_543_1.bgs_) do
					if iter_546_0 ~= "R4701a" then
						iter_546_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_546_16 = 1.699999999999

			if var_546_16 < arg_543_1.time_ and arg_543_1.time_ <= var_546_16 + arg_546_0 then
				arg_543_1.allBtn_.enabled = false
			end

			local var_546_17 = 0.3

			if arg_543_1.time_ >= var_546_16 + var_546_17 and arg_543_1.time_ < var_546_16 + var_546_17 + arg_546_0 then
				arg_543_1.allBtn_.enabled = true
			end

			local var_546_18 = manager.ui.mainCamera.transform
			local var_546_19 = 0

			if var_546_19 < arg_543_1.time_ and arg_543_1.time_ <= var_546_19 + arg_546_0 then
				local var_546_20 = arg_543_1.var_.effectzhuanchangyixia1
				local var_546_21
				local var_546_22 = var_546_18

				if not var_546_20 then
					var_546_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_546_22)
					var_546_20.name = "zhuanchangyixia1"
					arg_543_1.var_.effectzhuanchangyixia1 = var_546_20
				else
					var_546_20.transform:SetParent(var_546_22)
				end

				var_546_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_546_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_546_23 = 1.7777777777777777
				local var_546_24 = Screen.width / Screen.height
				local var_546_25 = var_546_24 / var_546_23
				local var_546_26 = Mathf.Max(var_546_23 / var_546_24, 1)
				local var_546_27 = Mathf.Max(var_546_25, var_546_26)

				var_546_20.transform.localScale = Vector3.New(var_546_20.transform.localScale.x * var_546_27, var_546_20.transform.localScale.y * var_546_27, var_546_20.transform.localScale.z * var_546_27)
			end

			local var_546_28 = arg_543_1.bgs_.R4701.transform
			local var_546_29 = 0.533333333333333

			if var_546_29 < arg_543_1.time_ and arg_543_1.time_ <= var_546_29 + arg_546_0 then
				arg_543_1.var_.moveOldPosR4701 = var_546_28.localPosition
			end

			local var_546_30 = 1.7

			if var_546_29 <= arg_543_1.time_ and arg_543_1.time_ < var_546_29 + var_546_30 then
				local var_546_31 = (arg_543_1.time_ - var_546_29) / var_546_30
				local var_546_32 = Vector3.New(0, 0, -2000)

				var_546_28.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPosR4701, var_546_32, var_546_31)
			end

			if arg_543_1.time_ >= var_546_29 + var_546_30 and arg_543_1.time_ < var_546_29 + var_546_30 + arg_546_0 then
				var_546_28.localPosition = Vector3.New(0, 0, -2000)
			end

			if arg_543_1.frameCnt_ <= 1 then
				arg_543_1.dialog_:SetActive(false)
			end

			local var_546_33 = 1.699999999999
			local var_546_34 = 0.825

			if var_546_33 < arg_543_1.time_ and arg_543_1.time_ <= var_546_33 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0

				arg_543_1.dialog_:SetActive(true)

				arg_543_1.dialogCg_.alpha = 0

				local var_546_35 = LeanTween.value(arg_543_1.dialog_, 0, 1, 0.3)

				var_546_35:setOnUpdate(LuaHelper.FloatAction(function(arg_547_0)
					arg_543_1.dialogCg_.alpha = arg_547_0
				end))
				var_546_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_543_1.dialog_)
					var_546_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_543_1.duration_ = arg_543_1.duration_ + 0.3

				SetActive(arg_543_1.leftNameGo_, false)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_36 = arg_543_1:GetWordFromCfg(1104704132)
				local var_546_37 = arg_543_1:FormatText(var_546_36.content)

				arg_543_1.text_.text = var_546_37

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_38 = 33
				local var_546_39 = utf8.len(var_546_37)
				local var_546_40 = var_546_38 <= 0 and var_546_34 or var_546_34 * (var_546_39 / var_546_38)

				if var_546_40 > 0 and var_546_34 < var_546_40 then
					arg_543_1.talkMaxDuration = var_546_40
					var_546_33 = var_546_33 + 0.3

					if var_546_40 + var_546_33 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_40 + var_546_33
					end
				end

				arg_543_1.text_.text = var_546_37
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_41 = var_546_33 + 0.3
			local var_546_42 = math.max(var_546_34, arg_543_1.talkMaxDuration)

			if var_546_41 <= arg_543_1.time_ and arg_543_1.time_ < var_546_41 + var_546_42 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_41) / var_546_42

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_41 + var_546_42 and arg_543_1.time_ < var_546_41 + var_546_42 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R4701",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.7,
				startTime = 0.533333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0, -2000),
					endPos = Vector3.New(0, 0, -2000),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play1104704133 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1104704133
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1104704134(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 1

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, false)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_2 = arg_549_1:GetWordFromCfg(1104704133)
				local var_552_3 = arg_549_1:FormatText(var_552_2.content)

				arg_549_1.text_.text = var_552_3

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_4 = 40
				local var_552_5 = utf8.len(var_552_3)
				local var_552_6 = var_552_4 <= 0 and var_552_1 or var_552_1 * (var_552_5 / var_552_4)

				if var_552_6 > 0 and var_552_1 < var_552_6 then
					arg_549_1.talkMaxDuration = var_552_6

					if var_552_6 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_6 + var_552_0
					end
				end

				arg_549_1.text_.text = var_552_3
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_7 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_7 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_7

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_7 and arg_549_1.time_ < var_552_0 + var_552_7 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1104704134 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1104704134
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1104704135(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0
			local var_556_1 = 0.875

			if var_556_0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, false)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_2 = arg_553_1:GetWordFromCfg(1104704134)
				local var_556_3 = arg_553_1:FormatText(var_556_2.content)

				arg_553_1.text_.text = var_556_3

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_4 = 35
				local var_556_5 = utf8.len(var_556_3)
				local var_556_6 = var_556_4 <= 0 and var_556_1 or var_556_1 * (var_556_5 / var_556_4)

				if var_556_6 > 0 and var_556_1 < var_556_6 then
					arg_553_1.talkMaxDuration = var_556_6

					if var_556_6 + var_556_0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_6 + var_556_0
					end
				end

				arg_553_1.text_.text = var_556_3
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_7 = math.max(var_556_1, arg_553_1.talkMaxDuration)

			if var_556_0 <= arg_553_1.time_ and arg_553_1.time_ < var_556_0 + var_556_7 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_0) / var_556_7

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_0 + var_556_7 and arg_553_1.time_ < var_556_0 + var_556_7 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1104704135 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1104704135
		arg_557_1.duration_ = 8.97

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1104704136(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0
			local var_560_1 = 0.55

			if var_560_0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_2 = arg_557_1:FormatText(StoryNameCfg[1296].name)

				arg_557_1.leftNameTxt_.text = var_560_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_3 = arg_557_1:GetWordFromCfg(1104704135)
				local var_560_4 = arg_557_1:FormatText(var_560_3.content)

				arg_557_1.text_.text = var_560_4

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_5 = 22
				local var_560_6 = utf8.len(var_560_4)
				local var_560_7 = var_560_5 <= 0 and var_560_1 or var_560_1 * (var_560_6 / var_560_5)

				if var_560_7 > 0 and var_560_1 < var_560_7 then
					arg_557_1.talkMaxDuration = var_560_7

					if var_560_7 + var_560_0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_7 + var_560_0
					end
				end

				arg_557_1.text_.text = var_560_4
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704135", "story_v_side_new_1104704.awb") ~= 0 then
					local var_560_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704135", "story_v_side_new_1104704.awb") / 1000

					if var_560_8 + var_560_0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_8 + var_560_0
					end

					if var_560_3.prefab_name ~= "" and arg_557_1.actors_[var_560_3.prefab_name] ~= nil then
						local var_560_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_3.prefab_name].transform, "story_v_side_new_1104704", "1104704135", "story_v_side_new_1104704.awb")

						arg_557_1:RecordAudio("1104704135", var_560_9)
						arg_557_1:RecordAudio("1104704135", var_560_9)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704135", "story_v_side_new_1104704.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704135", "story_v_side_new_1104704.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_10 = math.max(var_560_1, arg_557_1.talkMaxDuration)

			if var_560_0 <= arg_557_1.time_ and arg_557_1.time_ < var_560_0 + var_560_10 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_0) / var_560_10

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_0 + var_560_10 and arg_557_1.time_ < var_560_0 + var_560_10 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1104704136 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1104704136
		arg_561_1.duration_ = 6.57

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1104704137(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = arg_561_1.bgs_.R4701a.transform
			local var_564_1 = 0

			if var_564_1 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 then
				arg_561_1.var_.moveOldPosR4701a = var_564_0.localPosition
			end

			local var_564_2 = 2.46666666666667

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_2 then
				local var_564_3 = (arg_561_1.time_ - var_564_1) / var_564_2
				local var_564_4 = Vector3.New(0, 2, 7)

				var_564_0.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPosR4701a, var_564_4, var_564_3)
			end

			if arg_561_1.time_ >= var_564_1 + var_564_2 and arg_561_1.time_ < var_564_1 + var_564_2 + arg_564_0 then
				var_564_0.localPosition = Vector3.New(0, 2, 7)
			end

			local var_564_5 = 0

			if var_564_5 < arg_561_1.time_ and arg_561_1.time_ <= var_564_5 + arg_564_0 then
				arg_561_1.allBtn_.enabled = false
			end

			local var_564_6 = 1.674999999999

			if arg_561_1.time_ >= var_564_5 + var_564_6 and arg_561_1.time_ < var_564_5 + var_564_6 + arg_564_0 then
				arg_561_1.allBtn_.enabled = true
			end

			if arg_561_1.frameCnt_ <= 1 then
				arg_561_1.dialog_:SetActive(false)
			end

			local var_564_7 = 1.56666666666667
			local var_564_8 = 0.9

			if var_564_7 < arg_561_1.time_ and arg_561_1.time_ <= var_564_7 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0

				arg_561_1.dialog_:SetActive(true)

				arg_561_1.dialogCg_.alpha = 0

				local var_564_9 = LeanTween.value(arg_561_1.dialog_, 0, 1, 0.3)

				var_564_9:setOnUpdate(LuaHelper.FloatAction(function(arg_565_0)
					arg_561_1.dialogCg_.alpha = arg_565_0
				end))
				var_564_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_561_1.dialog_)
					var_564_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_561_1.duration_ = arg_561_1.duration_ + 0.3

				SetActive(arg_561_1.leftNameGo_, false)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_10 = arg_561_1:GetWordFromCfg(1104704136)
				local var_564_11 = arg_561_1:FormatText(var_564_10.content)

				arg_561_1.text_.text = var_564_11

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_12 = 36
				local var_564_13 = utf8.len(var_564_11)
				local var_564_14 = var_564_12 <= 0 and var_564_8 or var_564_8 * (var_564_13 / var_564_12)

				if var_564_14 > 0 and var_564_8 < var_564_14 then
					arg_561_1.talkMaxDuration = var_564_14
					var_564_7 = var_564_7 + 0.3

					if var_564_14 + var_564_7 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_14 + var_564_7
					end
				end

				arg_561_1.text_.text = var_564_11
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_15 = var_564_7 + 0.3
			local var_564_16 = math.max(var_564_8, arg_561_1.talkMaxDuration)

			if var_564_15 <= arg_561_1.time_ and arg_561_1.time_ < var_564_15 + var_564_16 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_15) / var_564_16

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_15 + var_564_16 and arg_561_1.time_ < var_564_15 + var_564_16 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R4701a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.46666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 2, 7),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play1104704137 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1104704137
		arg_567_1.duration_ = 7.78

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1104704138(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 2

			if var_570_0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_0 + arg_570_0 then
				local var_570_1 = manager.ui.mainCamera.transform.localPosition
				local var_570_2 = Vector3.New(0, 0, 10) + Vector3.New(var_570_1.x, var_570_1.y, 0)
				local var_570_3 = arg_567_1.bgs_.STblack

				var_570_3.transform.localPosition = var_570_2
				var_570_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_570_4 = var_570_3:GetComponent("SpriteRenderer")

				if var_570_4 and var_570_4.sprite then
					local var_570_5 = (var_570_3.transform.localPosition - var_570_1).z
					local var_570_6 = manager.ui.mainCameraCom_
					local var_570_7 = 2 * var_570_5 * Mathf.Tan(var_570_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_570_8 = var_570_7 * var_570_6.aspect
					local var_570_9 = var_570_4.sprite.bounds.size.x
					local var_570_10 = var_570_4.sprite.bounds.size.y
					local var_570_11 = var_570_8 / var_570_9
					local var_570_12 = var_570_7 / var_570_10
					local var_570_13 = var_570_12 < var_570_11 and var_570_11 or var_570_12

					var_570_3.transform.localScale = Vector3.New(var_570_13, var_570_13, 0)
				end

				for iter_570_0, iter_570_1 in pairs(arg_567_1.bgs_) do
					if iter_570_0 ~= "STblack" then
						iter_570_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_570_14 = 0

			if var_570_14 < arg_567_1.time_ and arg_567_1.time_ <= var_570_14 + arg_570_0 then
				arg_567_1.mask_.enabled = true
				arg_567_1.mask_.raycastTarget = true

				arg_567_1:SetGaussion(false)
			end

			local var_570_15 = 2

			if var_570_14 <= arg_567_1.time_ and arg_567_1.time_ < var_570_14 + var_570_15 then
				local var_570_16 = (arg_567_1.time_ - var_570_14) / var_570_15
				local var_570_17 = Color.New(0, 0, 0)

				var_570_17.a = Mathf.Lerp(0, 1, var_570_16)
				arg_567_1.mask_.color = var_570_17
			end

			if arg_567_1.time_ >= var_570_14 + var_570_15 and arg_567_1.time_ < var_570_14 + var_570_15 + arg_570_0 then
				local var_570_18 = Color.New(0, 0, 0)

				var_570_18.a = 1
				arg_567_1.mask_.color = var_570_18
			end

			local var_570_19 = 2

			if var_570_19 < arg_567_1.time_ and arg_567_1.time_ <= var_570_19 + arg_570_0 then
				arg_567_1.mask_.enabled = true
				arg_567_1.mask_.raycastTarget = true

				arg_567_1:SetGaussion(false)
			end

			local var_570_20 = 2

			if var_570_19 <= arg_567_1.time_ and arg_567_1.time_ < var_570_19 + var_570_20 then
				local var_570_21 = (arg_567_1.time_ - var_570_19) / var_570_20
				local var_570_22 = Color.New(0, 0, 0)

				var_570_22.a = Mathf.Lerp(1, 0, var_570_21)
				arg_567_1.mask_.color = var_570_22
			end

			if arg_567_1.time_ >= var_570_19 + var_570_20 and arg_567_1.time_ < var_570_19 + var_570_20 + arg_570_0 then
				local var_570_23 = Color.New(0, 0, 0)
				local var_570_24 = 0

				arg_567_1.mask_.enabled = false
				var_570_23.a = var_570_24
				arg_567_1.mask_.color = var_570_23
			end

			if arg_567_1.frameCnt_ <= 1 then
				arg_567_1.dialog_:SetActive(false)
			end

			local var_570_25 = 2.775
			local var_570_26 = 1.225

			if var_570_25 < arg_567_1.time_ and arg_567_1.time_ <= var_570_25 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0

				arg_567_1.dialog_:SetActive(true)

				arg_567_1.dialogCg_.alpha = 0

				local var_570_27 = LeanTween.value(arg_567_1.dialog_, 0, 1, 0.3)

				var_570_27:setOnUpdate(LuaHelper.FloatAction(function(arg_571_0)
					arg_567_1.dialogCg_.alpha = arg_571_0
				end))
				var_570_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_567_1.dialog_)
					var_570_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_567_1.duration_ = arg_567_1.duration_ + 0.3

				SetActive(arg_567_1.leftNameGo_, false)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_28 = arg_567_1:GetWordFromCfg(1104704137)
				local var_570_29 = arg_567_1:FormatText(var_570_28.content)

				arg_567_1.text_.text = var_570_29

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_30 = 49
				local var_570_31 = utf8.len(var_570_29)
				local var_570_32 = var_570_30 <= 0 and var_570_26 or var_570_26 * (var_570_31 / var_570_30)

				if var_570_32 > 0 and var_570_26 < var_570_32 then
					arg_567_1.talkMaxDuration = var_570_32
					var_570_25 = var_570_25 + 0.3

					if var_570_32 + var_570_25 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_32 + var_570_25
					end
				end

				arg_567_1.text_.text = var_570_29
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_33 = var_570_25 + 0.3
			local var_570_34 = math.max(var_570_26, arg_567_1.talkMaxDuration)

			if var_570_33 <= arg_567_1.time_ and arg_567_1.time_ < var_570_33 + var_570_34 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_33) / var_570_34

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_33 + var_570_34 and arg_567_1.time_ < var_570_33 + var_570_34 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play1104704138 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1104704138
		arg_573_1.duration_ = 4.53

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1104704139(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = "ST05a"

			if arg_573_1.bgs_[var_576_0] == nil then
				local var_576_1 = Object.Instantiate(arg_573_1.paintGo_)

				var_576_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_576_0)
				var_576_1.name = var_576_0
				var_576_1.transform.parent = arg_573_1.stage_.transform
				var_576_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_573_1.bgs_[var_576_0] = var_576_1
			end

			local var_576_2 = 0

			if var_576_2 < arg_573_1.time_ and arg_573_1.time_ <= var_576_2 + arg_576_0 then
				local var_576_3 = manager.ui.mainCamera.transform.localPosition
				local var_576_4 = Vector3.New(0, 0, 10) + Vector3.New(var_576_3.x, var_576_3.y, 0)
				local var_576_5 = arg_573_1.bgs_.ST05a

				var_576_5.transform.localPosition = var_576_4
				var_576_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_576_6 = var_576_5:GetComponent("SpriteRenderer")

				if var_576_6 and var_576_6.sprite then
					local var_576_7 = (var_576_5.transform.localPosition - var_576_3).z
					local var_576_8 = manager.ui.mainCameraCom_
					local var_576_9 = 2 * var_576_7 * Mathf.Tan(var_576_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_576_10 = var_576_9 * var_576_8.aspect
					local var_576_11 = var_576_6.sprite.bounds.size.x
					local var_576_12 = var_576_6.sprite.bounds.size.y
					local var_576_13 = var_576_10 / var_576_11
					local var_576_14 = var_576_9 / var_576_12
					local var_576_15 = var_576_14 < var_576_13 and var_576_13 or var_576_14

					var_576_5.transform.localScale = Vector3.New(var_576_15, var_576_15, 0)
				end

				for iter_576_0, iter_576_1 in pairs(arg_573_1.bgs_) do
					if iter_576_0 ~= "ST05a" then
						iter_576_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_576_16 = 1.999999999999

			if var_576_16 < arg_573_1.time_ and arg_573_1.time_ <= var_576_16 + arg_576_0 then
				arg_573_1.allBtn_.enabled = false
			end

			local var_576_17 = 0.3

			if arg_573_1.time_ >= var_576_16 + var_576_17 and arg_573_1.time_ < var_576_16 + var_576_17 + arg_576_0 then
				arg_573_1.allBtn_.enabled = true
			end

			local var_576_18 = 0

			if var_576_18 < arg_573_1.time_ and arg_573_1.time_ <= var_576_18 + arg_576_0 then
				arg_573_1.mask_.enabled = true
				arg_573_1.mask_.raycastTarget = true

				arg_573_1:SetGaussion(false)
			end

			local var_576_19 = 2

			if var_576_18 <= arg_573_1.time_ and arg_573_1.time_ < var_576_18 + var_576_19 then
				local var_576_20 = (arg_573_1.time_ - var_576_18) / var_576_19
				local var_576_21 = Color.New(0, 0, 0)

				var_576_21.a = Mathf.Lerp(1, 0, var_576_20)
				arg_573_1.mask_.color = var_576_21
			end

			if arg_573_1.time_ >= var_576_18 + var_576_19 and arg_573_1.time_ < var_576_18 + var_576_19 + arg_576_0 then
				local var_576_22 = Color.New(0, 0, 0)
				local var_576_23 = 0

				arg_573_1.mask_.enabled = false
				var_576_22.a = var_576_23
				arg_573_1.mask_.color = var_576_22
			end

			local var_576_24 = 1.2
			local var_576_25 = 1

			if var_576_24 < arg_573_1.time_ and arg_573_1.time_ <= var_576_24 + arg_576_0 then
				local var_576_26 = "play"
				local var_576_27 = "effect"

				arg_573_1:AudioAction(var_576_26, var_576_27, "se_story_143", "se_story_143_amb_club", "")
			end

			local var_576_28 = 0.1
			local var_576_29 = 1

			if var_576_28 < arg_573_1.time_ and arg_573_1.time_ <= var_576_28 + arg_576_0 then
				local var_576_30 = "stop"
				local var_576_31 = "effect"

				arg_573_1:AudioAction(var_576_30, var_576_31, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_573_1.frameCnt_ <= 1 then
				arg_573_1.dialog_:SetActive(false)
			end

			local var_576_32 = 2
			local var_576_33 = 0.35

			if var_576_32 < arg_573_1.time_ and arg_573_1.time_ <= var_576_32 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0

				arg_573_1.dialog_:SetActive(true)

				arg_573_1.dialogCg_.alpha = 0

				local var_576_34 = LeanTween.value(arg_573_1.dialog_, 0, 1, 0.3)

				var_576_34:setOnUpdate(LuaHelper.FloatAction(function(arg_577_0)
					arg_573_1.dialogCg_.alpha = arg_577_0
				end))
				var_576_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_573_1.dialog_)
					var_576_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_573_1.duration_ = arg_573_1.duration_ + 0.3

				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_35 = arg_573_1:FormatText(StoryNameCfg[331].name)

				arg_573_1.leftNameTxt_.text = var_576_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, true)
				arg_573_1.iconController_:SetSelectedState("hero")

				arg_573_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_573_1.callingController_:SetSelectedState("normal")

				arg_573_1.keyicon_.color = Color.New(1, 1, 1)
				arg_573_1.icon_.color = Color.New(1, 1, 1)

				local var_576_36 = arg_573_1:GetWordFromCfg(1104704138)
				local var_576_37 = arg_573_1:FormatText(var_576_36.content)

				arg_573_1.text_.text = var_576_37

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_38 = 14
				local var_576_39 = utf8.len(var_576_37)
				local var_576_40 = var_576_38 <= 0 and var_576_33 or var_576_33 * (var_576_39 / var_576_38)

				if var_576_40 > 0 and var_576_33 < var_576_40 then
					arg_573_1.talkMaxDuration = var_576_40
					var_576_32 = var_576_32 + 0.3

					if var_576_40 + var_576_32 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_40 + var_576_32
					end
				end

				arg_573_1.text_.text = var_576_37
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704138", "story_v_side_new_1104704.awb") ~= 0 then
					local var_576_41 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704138", "story_v_side_new_1104704.awb") / 1000

					if var_576_41 + var_576_32 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_41 + var_576_32
					end

					if var_576_36.prefab_name ~= "" and arg_573_1.actors_[var_576_36.prefab_name] ~= nil then
						local var_576_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_36.prefab_name].transform, "story_v_side_new_1104704", "1104704138", "story_v_side_new_1104704.awb")

						arg_573_1:RecordAudio("1104704138", var_576_42)
						arg_573_1:RecordAudio("1104704138", var_576_42)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704138", "story_v_side_new_1104704.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704138", "story_v_side_new_1104704.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_43 = var_576_32 + 0.3
			local var_576_44 = math.max(var_576_33, arg_573_1.talkMaxDuration)

			if var_576_43 <= arg_573_1.time_ and arg_573_1.time_ < var_576_43 + var_576_44 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_43) / var_576_44

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_43 + var_576_44 and arg_573_1.time_ < var_576_43 + var_576_44 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play1104704139 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1104704139
		arg_579_1.duration_ = 7.4

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1104704140(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0
			local var_582_1 = 0.875

			if var_582_0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				local var_582_2 = arg_579_1:FormatText(StoryNameCfg[331].name)

				arg_579_1.leftNameTxt_.text = var_582_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_3 = arg_579_1:GetWordFromCfg(1104704139)
				local var_582_4 = arg_579_1:FormatText(var_582_3.content)

				arg_579_1.text_.text = var_582_4

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_5 = 35
				local var_582_6 = utf8.len(var_582_4)
				local var_582_7 = var_582_5 <= 0 and var_582_1 or var_582_1 * (var_582_6 / var_582_5)

				if var_582_7 > 0 and var_582_1 < var_582_7 then
					arg_579_1.talkMaxDuration = var_582_7

					if var_582_7 + var_582_0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_7 + var_582_0
					end
				end

				arg_579_1.text_.text = var_582_4
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704139", "story_v_side_new_1104704.awb") ~= 0 then
					local var_582_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704139", "story_v_side_new_1104704.awb") / 1000

					if var_582_8 + var_582_0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_8 + var_582_0
					end

					if var_582_3.prefab_name ~= "" and arg_579_1.actors_[var_582_3.prefab_name] ~= nil then
						local var_582_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_3.prefab_name].transform, "story_v_side_new_1104704", "1104704139", "story_v_side_new_1104704.awb")

						arg_579_1:RecordAudio("1104704139", var_582_9)
						arg_579_1:RecordAudio("1104704139", var_582_9)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704139", "story_v_side_new_1104704.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704139", "story_v_side_new_1104704.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_10 = math.max(var_582_1, arg_579_1.talkMaxDuration)

			if var_582_0 <= arg_579_1.time_ and arg_579_1.time_ < var_582_0 + var_582_10 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_0) / var_582_10

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_0 + var_582_10 and arg_579_1.time_ < var_582_0 + var_582_10 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1104704140 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1104704140
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1104704141(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0
			local var_586_1 = 0.8

			if var_586_0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, false)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_2 = arg_583_1:GetWordFromCfg(1104704140)
				local var_586_3 = arg_583_1:FormatText(var_586_2.content)

				arg_583_1.text_.text = var_586_3

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_4 = 32
				local var_586_5 = utf8.len(var_586_3)
				local var_586_6 = var_586_4 <= 0 and var_586_1 or var_586_1 * (var_586_5 / var_586_4)

				if var_586_6 > 0 and var_586_1 < var_586_6 then
					arg_583_1.talkMaxDuration = var_586_6

					if var_586_6 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_6 + var_586_0
					end
				end

				arg_583_1.text_.text = var_586_3
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_7 = math.max(var_586_1, arg_583_1.talkMaxDuration)

			if var_586_0 <= arg_583_1.time_ and arg_583_1.time_ < var_586_0 + var_586_7 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_0) / var_586_7

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_0 + var_586_7 and arg_583_1.time_ < var_586_0 + var_586_7 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1104704141 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1104704141
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1104704142(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0
			local var_590_1 = 0.625

			if var_590_0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				local var_590_2 = arg_587_1:FormatText(StoryNameCfg[7].name)

				arg_587_1.leftNameTxt_.text = var_590_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, true)
				arg_587_1.iconController_:SetSelectedState("hero")

				arg_587_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_587_1.callingController_:SetSelectedState("normal")

				arg_587_1.keyicon_.color = Color.New(1, 1, 1)
				arg_587_1.icon_.color = Color.New(1, 1, 1)

				local var_590_3 = arg_587_1:GetWordFromCfg(1104704141)
				local var_590_4 = arg_587_1:FormatText(var_590_3.content)

				arg_587_1.text_.text = var_590_4

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_5 = 25
				local var_590_6 = utf8.len(var_590_4)
				local var_590_7 = var_590_5 <= 0 and var_590_1 or var_590_1 * (var_590_6 / var_590_5)

				if var_590_7 > 0 and var_590_1 < var_590_7 then
					arg_587_1.talkMaxDuration = var_590_7

					if var_590_7 + var_590_0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_7 + var_590_0
					end
				end

				arg_587_1.text_.text = var_590_4
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_8 = math.max(var_590_1, arg_587_1.talkMaxDuration)

			if var_590_0 <= arg_587_1.time_ and arg_587_1.time_ < var_590_0 + var_590_8 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_0) / var_590_8

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_0 + var_590_8 and arg_587_1.time_ < var_590_0 + var_590_8 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play1104704142 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1104704142
		arg_591_1.duration_ = 1.43

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1104704143(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0
			local var_594_1 = 0.125

			if var_594_0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				local var_594_2 = arg_591_1:FormatText(StoryNameCfg[1296].name)

				arg_591_1.leftNameTxt_.text = var_594_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_2")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_3 = arg_591_1:GetWordFromCfg(1104704142)
				local var_594_4 = arg_591_1:FormatText(var_594_3.content)

				arg_591_1.text_.text = var_594_4

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_5 = 5
				local var_594_6 = utf8.len(var_594_4)
				local var_594_7 = var_594_5 <= 0 and var_594_1 or var_594_1 * (var_594_6 / var_594_5)

				if var_594_7 > 0 and var_594_1 < var_594_7 then
					arg_591_1.talkMaxDuration = var_594_7

					if var_594_7 + var_594_0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_7 + var_594_0
					end
				end

				arg_591_1.text_.text = var_594_4
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704142", "story_v_side_new_1104704.awb") ~= 0 then
					local var_594_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704142", "story_v_side_new_1104704.awb") / 1000

					if var_594_8 + var_594_0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_8 + var_594_0
					end

					if var_594_3.prefab_name ~= "" and arg_591_1.actors_[var_594_3.prefab_name] ~= nil then
						local var_594_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_3.prefab_name].transform, "story_v_side_new_1104704", "1104704142", "story_v_side_new_1104704.awb")

						arg_591_1:RecordAudio("1104704142", var_594_9)
						arg_591_1:RecordAudio("1104704142", var_594_9)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704142", "story_v_side_new_1104704.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704142", "story_v_side_new_1104704.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_10 = math.max(var_594_1, arg_591_1.talkMaxDuration)

			if var_594_0 <= arg_591_1.time_ and arg_591_1.time_ < var_594_0 + var_594_10 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_0) / var_594_10

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_0 + var_594_10 and arg_591_1.time_ < var_594_0 + var_594_10 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1104704143 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1104704143
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1104704144(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0
			local var_598_1 = 0.725

			if var_598_0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, false)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_2 = arg_595_1:GetWordFromCfg(1104704143)
				local var_598_3 = arg_595_1:FormatText(var_598_2.content)

				arg_595_1.text_.text = var_598_3

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_4 = 29
				local var_598_5 = utf8.len(var_598_3)
				local var_598_6 = var_598_4 <= 0 and var_598_1 or var_598_1 * (var_598_5 / var_598_4)

				if var_598_6 > 0 and var_598_1 < var_598_6 then
					arg_595_1.talkMaxDuration = var_598_6

					if var_598_6 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_6 + var_598_0
					end
				end

				arg_595_1.text_.text = var_598_3
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_7 = math.max(var_598_1, arg_595_1.talkMaxDuration)

			if var_598_0 <= arg_595_1.time_ and arg_595_1.time_ < var_598_0 + var_598_7 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_0) / var_598_7

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_0 + var_598_7 and arg_595_1.time_ < var_598_0 + var_598_7 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1104704144 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1104704144
		arg_599_1.duration_ = 4.47

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1104704145(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = arg_599_1.actors_["1047ui_story"].transform
			local var_602_1 = 0

			if var_602_1 < arg_599_1.time_ and arg_599_1.time_ <= var_602_1 + arg_602_0 then
				arg_599_1.var_.moveOldPos1047ui_story = var_602_0.localPosition
			end

			local var_602_2 = 0.001

			if var_602_1 <= arg_599_1.time_ and arg_599_1.time_ < var_602_1 + var_602_2 then
				local var_602_3 = (arg_599_1.time_ - var_602_1) / var_602_2
				local var_602_4 = Vector3.New(0, -1.13, -6.2)

				var_602_0.localPosition = Vector3.Lerp(arg_599_1.var_.moveOldPos1047ui_story, var_602_4, var_602_3)

				local var_602_5 = manager.ui.mainCamera.transform.position - var_602_0.position

				var_602_0.forward = Vector3.New(var_602_5.x, var_602_5.y, var_602_5.z)

				local var_602_6 = var_602_0.localEulerAngles

				var_602_6.z = 0
				var_602_6.x = 0
				var_602_0.localEulerAngles = var_602_6
			end

			if arg_599_1.time_ >= var_602_1 + var_602_2 and arg_599_1.time_ < var_602_1 + var_602_2 + arg_602_0 then
				var_602_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_602_7 = manager.ui.mainCamera.transform.position - var_602_0.position

				var_602_0.forward = Vector3.New(var_602_7.x, var_602_7.y, var_602_7.z)

				local var_602_8 = var_602_0.localEulerAngles

				var_602_8.z = 0
				var_602_8.x = 0
				var_602_0.localEulerAngles = var_602_8
			end

			local var_602_9 = arg_599_1.actors_["1047ui_story"]
			local var_602_10 = 0

			if var_602_10 < arg_599_1.time_ and arg_599_1.time_ <= var_602_10 + arg_602_0 and not isNil(var_602_9) and arg_599_1.var_.characterEffect1047ui_story == nil then
				arg_599_1.var_.characterEffect1047ui_story = var_602_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_11 = 0.200000002980232

			if var_602_10 <= arg_599_1.time_ and arg_599_1.time_ < var_602_10 + var_602_11 and not isNil(var_602_9) then
				local var_602_12 = (arg_599_1.time_ - var_602_10) / var_602_11

				if arg_599_1.var_.characterEffect1047ui_story and not isNil(var_602_9) then
					arg_599_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_599_1.time_ >= var_602_10 + var_602_11 and arg_599_1.time_ < var_602_10 + var_602_11 + arg_602_0 and not isNil(var_602_9) and arg_599_1.var_.characterEffect1047ui_story then
				arg_599_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_602_13 = 0

			if var_602_13 < arg_599_1.time_ and arg_599_1.time_ <= var_602_13 + arg_602_0 then
				arg_599_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			local var_602_14 = 0

			if var_602_14 < arg_599_1.time_ and arg_599_1.time_ <= var_602_14 + arg_602_0 then
				arg_599_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_602_15 = 0
			local var_602_16 = 0.5

			if var_602_15 < arg_599_1.time_ and arg_599_1.time_ <= var_602_15 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_17 = arg_599_1:FormatText(StoryNameCfg[1296].name)

				arg_599_1.leftNameTxt_.text = var_602_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_18 = arg_599_1:GetWordFromCfg(1104704144)
				local var_602_19 = arg_599_1:FormatText(var_602_18.content)

				arg_599_1.text_.text = var_602_19

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_20 = 20
				local var_602_21 = utf8.len(var_602_19)
				local var_602_22 = var_602_20 <= 0 and var_602_16 or var_602_16 * (var_602_21 / var_602_20)

				if var_602_22 > 0 and var_602_16 < var_602_22 then
					arg_599_1.talkMaxDuration = var_602_22

					if var_602_22 + var_602_15 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_22 + var_602_15
					end
				end

				arg_599_1.text_.text = var_602_19
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704144", "story_v_side_new_1104704.awb") ~= 0 then
					local var_602_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704144", "story_v_side_new_1104704.awb") / 1000

					if var_602_23 + var_602_15 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_23 + var_602_15
					end

					if var_602_18.prefab_name ~= "" and arg_599_1.actors_[var_602_18.prefab_name] ~= nil then
						local var_602_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_18.prefab_name].transform, "story_v_side_new_1104704", "1104704144", "story_v_side_new_1104704.awb")

						arg_599_1:RecordAudio("1104704144", var_602_24)
						arg_599_1:RecordAudio("1104704144", var_602_24)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704144", "story_v_side_new_1104704.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704144", "story_v_side_new_1104704.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_25 = math.max(var_602_16, arg_599_1.talkMaxDuration)

			if var_602_15 <= arg_599_1.time_ and arg_599_1.time_ < var_602_15 + var_602_25 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_15) / var_602_25

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_15 + var_602_25 and arg_599_1.time_ < var_602_15 + var_602_25 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_599_1:InitPlayNodeList()
	end,
	Play1104704145 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1104704145
		arg_603_1.duration_ = 1

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"

			SetActive(arg_603_1.choicesGo_, true)

			for iter_604_0, iter_604_1 in ipairs(arg_603_1.choices_) do
				local var_604_0 = iter_604_0 <= 1

				SetActive(iter_604_1.go, var_604_0)
			end

			arg_603_1.choices_[1].txt.text = arg_603_1:FormatText(StoryChoiceCfg[1664].name)
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1104704146(arg_603_1)
			end

			arg_603_1:RecordChoiceLog(1104704145, 1664)
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = arg_603_1.actors_["1047ui_story"]
			local var_606_1 = 0

			if var_606_1 < arg_603_1.time_ and arg_603_1.time_ <= var_606_1 + arg_606_0 and not isNil(var_606_0) and arg_603_1.var_.characterEffect1047ui_story == nil then
				arg_603_1.var_.characterEffect1047ui_story = var_606_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_2 = 0.200000002980232

			if var_606_1 <= arg_603_1.time_ and arg_603_1.time_ < var_606_1 + var_606_2 and not isNil(var_606_0) then
				local var_606_3 = (arg_603_1.time_ - var_606_1) / var_606_2

				if arg_603_1.var_.characterEffect1047ui_story and not isNil(var_606_0) then
					local var_606_4 = Mathf.Lerp(0, 0.5, var_606_3)

					arg_603_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_603_1.var_.characterEffect1047ui_story.fillRatio = var_606_4
				end
			end

			if arg_603_1.time_ >= var_606_1 + var_606_2 and arg_603_1.time_ < var_606_1 + var_606_2 + arg_606_0 and not isNil(var_606_0) and arg_603_1.var_.characterEffect1047ui_story then
				local var_606_5 = 0.5

				arg_603_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_603_1.var_.characterEffect1047ui_story.fillRatio = var_606_5
			end

			local var_606_6 = 0

			if var_606_6 < arg_603_1.time_ and arg_603_1.time_ <= var_606_6 + arg_606_0 then
				arg_603_1.allBtn_.enabled = false
			end

			local var_606_7 = 0.200000002980232

			if arg_603_1.time_ >= var_606_6 + var_606_7 and arg_603_1.time_ < var_606_6 + var_606_7 + arg_606_0 then
				arg_603_1.allBtn_.enabled = true
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1104704146 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1104704146
		arg_607_1.duration_ = 3.1

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1104704147(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = arg_607_1.actors_["1047ui_story"]
			local var_610_1 = 0

			if var_610_1 < arg_607_1.time_ and arg_607_1.time_ <= var_610_1 + arg_610_0 and not isNil(var_610_0) and arg_607_1.var_.characterEffect1047ui_story == nil then
				arg_607_1.var_.characterEffect1047ui_story = var_610_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_2 = 0.200000002980232

			if var_610_1 <= arg_607_1.time_ and arg_607_1.time_ < var_610_1 + var_610_2 and not isNil(var_610_0) then
				local var_610_3 = (arg_607_1.time_ - var_610_1) / var_610_2

				if arg_607_1.var_.characterEffect1047ui_story and not isNil(var_610_0) then
					arg_607_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_607_1.time_ >= var_610_1 + var_610_2 and arg_607_1.time_ < var_610_1 + var_610_2 + arg_610_0 and not isNil(var_610_0) and arg_607_1.var_.characterEffect1047ui_story then
				arg_607_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_610_4 = 0

			if var_610_4 < arg_607_1.time_ and arg_607_1.time_ <= var_610_4 + arg_610_0 then
				arg_607_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			local var_610_5 = 0
			local var_610_6 = 0.3

			if var_610_5 < arg_607_1.time_ and arg_607_1.time_ <= var_610_5 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				local var_610_7 = arg_607_1:FormatText(StoryNameCfg[1296].name)

				arg_607_1.leftNameTxt_.text = var_610_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_8 = arg_607_1:GetWordFromCfg(1104704146)
				local var_610_9 = arg_607_1:FormatText(var_610_8.content)

				arg_607_1.text_.text = var_610_9

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_10 = 12
				local var_610_11 = utf8.len(var_610_9)
				local var_610_12 = var_610_10 <= 0 and var_610_6 or var_610_6 * (var_610_11 / var_610_10)

				if var_610_12 > 0 and var_610_6 < var_610_12 then
					arg_607_1.talkMaxDuration = var_610_12

					if var_610_12 + var_610_5 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_12 + var_610_5
					end
				end

				arg_607_1.text_.text = var_610_9
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704146", "story_v_side_new_1104704.awb") ~= 0 then
					local var_610_13 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704146", "story_v_side_new_1104704.awb") / 1000

					if var_610_13 + var_610_5 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_13 + var_610_5
					end

					if var_610_8.prefab_name ~= "" and arg_607_1.actors_[var_610_8.prefab_name] ~= nil then
						local var_610_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_8.prefab_name].transform, "story_v_side_new_1104704", "1104704146", "story_v_side_new_1104704.awb")

						arg_607_1:RecordAudio("1104704146", var_610_14)
						arg_607_1:RecordAudio("1104704146", var_610_14)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704146", "story_v_side_new_1104704.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704146", "story_v_side_new_1104704.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_15 = math.max(var_610_6, arg_607_1.talkMaxDuration)

			if var_610_5 <= arg_607_1.time_ and arg_607_1.time_ < var_610_5 + var_610_15 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_5) / var_610_15

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_5 + var_610_15 and arg_607_1.time_ < var_610_5 + var_610_15 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1104704147 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1104704147
		arg_611_1.duration_ = 5

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1104704148(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = arg_611_1.actors_["1047ui_story"]
			local var_614_1 = 0

			if var_614_1 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1047ui_story == nil then
				arg_611_1.var_.characterEffect1047ui_story = var_614_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_2 = 0.200000002980232

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_2 and not isNil(var_614_0) then
				local var_614_3 = (arg_611_1.time_ - var_614_1) / var_614_2

				if arg_611_1.var_.characterEffect1047ui_story and not isNil(var_614_0) then
					local var_614_4 = Mathf.Lerp(0, 0.5, var_614_3)

					arg_611_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_611_1.var_.characterEffect1047ui_story.fillRatio = var_614_4
				end
			end

			if arg_611_1.time_ >= var_614_1 + var_614_2 and arg_611_1.time_ < var_614_1 + var_614_2 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1047ui_story then
				local var_614_5 = 0.5

				arg_611_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_611_1.var_.characterEffect1047ui_story.fillRatio = var_614_5
			end

			local var_614_6 = 0
			local var_614_7 = 0.4

			if var_614_6 < arg_611_1.time_ and arg_611_1.time_ <= var_614_6 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_8 = arg_611_1:FormatText(StoryNameCfg[7].name)

				arg_611_1.leftNameTxt_.text = var_614_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_611_1.callingController_:SetSelectedState("normal")

				arg_611_1.keyicon_.color = Color.New(1, 1, 1)
				arg_611_1.icon_.color = Color.New(1, 1, 1)

				local var_614_9 = arg_611_1:GetWordFromCfg(1104704147)
				local var_614_10 = arg_611_1:FormatText(var_614_9.content)

				arg_611_1.text_.text = var_614_10

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_11 = 16
				local var_614_12 = utf8.len(var_614_10)
				local var_614_13 = var_614_11 <= 0 and var_614_7 or var_614_7 * (var_614_12 / var_614_11)

				if var_614_13 > 0 and var_614_7 < var_614_13 then
					arg_611_1.talkMaxDuration = var_614_13

					if var_614_13 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_13 + var_614_6
					end
				end

				arg_611_1.text_.text = var_614_10
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_14 = math.max(var_614_7, arg_611_1.talkMaxDuration)

			if var_614_6 <= arg_611_1.time_ and arg_611_1.time_ < var_614_6 + var_614_14 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_6) / var_614_14

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_6 + var_614_14 and arg_611_1.time_ < var_614_6 + var_614_14 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play1104704148 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1104704148
		arg_615_1.duration_ = 3.37

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1104704149(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = arg_615_1.actors_["1047ui_story"]
			local var_618_1 = 0

			if var_618_1 < arg_615_1.time_ and arg_615_1.time_ <= var_618_1 + arg_618_0 and not isNil(var_618_0) and arg_615_1.var_.characterEffect1047ui_story == nil then
				arg_615_1.var_.characterEffect1047ui_story = var_618_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_2 = 0.200000002980232

			if var_618_1 <= arg_615_1.time_ and arg_615_1.time_ < var_618_1 + var_618_2 and not isNil(var_618_0) then
				local var_618_3 = (arg_615_1.time_ - var_618_1) / var_618_2

				if arg_615_1.var_.characterEffect1047ui_story and not isNil(var_618_0) then
					arg_615_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_615_1.time_ >= var_618_1 + var_618_2 and arg_615_1.time_ < var_618_1 + var_618_2 + arg_618_0 and not isNil(var_618_0) and arg_615_1.var_.characterEffect1047ui_story then
				arg_615_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_618_4 = 0

			if var_618_4 < arg_615_1.time_ and arg_615_1.time_ <= var_618_4 + arg_618_0 then
				arg_615_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			local var_618_5 = 0

			if var_618_5 < arg_615_1.time_ and arg_615_1.time_ <= var_618_5 + arg_618_0 then
				arg_615_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_618_6 = 0
			local var_618_7 = 0.45

			if var_618_6 < arg_615_1.time_ and arg_615_1.time_ <= var_618_6 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				local var_618_8 = arg_615_1:FormatText(StoryNameCfg[1296].name)

				arg_615_1.leftNameTxt_.text = var_618_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_9 = arg_615_1:GetWordFromCfg(1104704148)
				local var_618_10 = arg_615_1:FormatText(var_618_9.content)

				arg_615_1.text_.text = var_618_10

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_11 = 18
				local var_618_12 = utf8.len(var_618_10)
				local var_618_13 = var_618_11 <= 0 and var_618_7 or var_618_7 * (var_618_12 / var_618_11)

				if var_618_13 > 0 and var_618_7 < var_618_13 then
					arg_615_1.talkMaxDuration = var_618_13

					if var_618_13 + var_618_6 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_13 + var_618_6
					end
				end

				arg_615_1.text_.text = var_618_10
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704148", "story_v_side_new_1104704.awb") ~= 0 then
					local var_618_14 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704148", "story_v_side_new_1104704.awb") / 1000

					if var_618_14 + var_618_6 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_14 + var_618_6
					end

					if var_618_9.prefab_name ~= "" and arg_615_1.actors_[var_618_9.prefab_name] ~= nil then
						local var_618_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_615_1.actors_[var_618_9.prefab_name].transform, "story_v_side_new_1104704", "1104704148", "story_v_side_new_1104704.awb")

						arg_615_1:RecordAudio("1104704148", var_618_15)
						arg_615_1:RecordAudio("1104704148", var_618_15)
					else
						arg_615_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704148", "story_v_side_new_1104704.awb")
					end

					arg_615_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704148", "story_v_side_new_1104704.awb")
				end

				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_16 = math.max(var_618_7, arg_615_1.talkMaxDuration)

			if var_618_6 <= arg_615_1.time_ and arg_615_1.time_ < var_618_6 + var_618_16 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_6) / var_618_16

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_6 + var_618_16 and arg_615_1.time_ < var_618_6 + var_618_16 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play1104704149 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1104704149
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1104704150(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = arg_619_1.actors_["1047ui_story"]
			local var_622_1 = 0

			if var_622_1 < arg_619_1.time_ and arg_619_1.time_ <= var_622_1 + arg_622_0 and not isNil(var_622_0) and arg_619_1.var_.characterEffect1047ui_story == nil then
				arg_619_1.var_.characterEffect1047ui_story = var_622_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_2 = 0.200000002980232

			if var_622_1 <= arg_619_1.time_ and arg_619_1.time_ < var_622_1 + var_622_2 and not isNil(var_622_0) then
				local var_622_3 = (arg_619_1.time_ - var_622_1) / var_622_2

				if arg_619_1.var_.characterEffect1047ui_story and not isNil(var_622_0) then
					local var_622_4 = Mathf.Lerp(0, 0.5, var_622_3)

					arg_619_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_619_1.var_.characterEffect1047ui_story.fillRatio = var_622_4
				end
			end

			if arg_619_1.time_ >= var_622_1 + var_622_2 and arg_619_1.time_ < var_622_1 + var_622_2 + arg_622_0 and not isNil(var_622_0) and arg_619_1.var_.characterEffect1047ui_story then
				local var_622_5 = 0.5

				arg_619_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_619_1.var_.characterEffect1047ui_story.fillRatio = var_622_5
			end

			local var_622_6 = 0
			local var_622_7 = 0.35

			if var_622_6 < arg_619_1.time_ and arg_619_1.time_ <= var_622_6 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				local var_622_8 = arg_619_1:FormatText(StoryNameCfg[7].name)

				arg_619_1.leftNameTxt_.text = var_622_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, true)
				arg_619_1.iconController_:SetSelectedState("hero")

				arg_619_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_619_1.callingController_:SetSelectedState("normal")

				arg_619_1.keyicon_.color = Color.New(1, 1, 1)
				arg_619_1.icon_.color = Color.New(1, 1, 1)

				local var_622_9 = arg_619_1:GetWordFromCfg(1104704149)
				local var_622_10 = arg_619_1:FormatText(var_622_9.content)

				arg_619_1.text_.text = var_622_10

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_11 = 14
				local var_622_12 = utf8.len(var_622_10)
				local var_622_13 = var_622_11 <= 0 and var_622_7 or var_622_7 * (var_622_12 / var_622_11)

				if var_622_13 > 0 and var_622_7 < var_622_13 then
					arg_619_1.talkMaxDuration = var_622_13

					if var_622_13 + var_622_6 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_13 + var_622_6
					end
				end

				arg_619_1.text_.text = var_622_10
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_14 = math.max(var_622_7, arg_619_1.talkMaxDuration)

			if var_622_6 <= arg_619_1.time_ and arg_619_1.time_ < var_622_6 + var_622_14 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_6) / var_622_14

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_6 + var_622_14 and arg_619_1.time_ < var_622_6 + var_622_14 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play1104704150 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1104704150
		arg_623_1.duration_ = 3.97

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1104704151(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = arg_623_1.actors_["1047ui_story"]
			local var_626_1 = 0

			if var_626_1 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 and not isNil(var_626_0) and arg_623_1.var_.characterEffect1047ui_story == nil then
				arg_623_1.var_.characterEffect1047ui_story = var_626_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_2 = 0.200000002980232

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_2 and not isNil(var_626_0) then
				local var_626_3 = (arg_623_1.time_ - var_626_1) / var_626_2

				if arg_623_1.var_.characterEffect1047ui_story and not isNil(var_626_0) then
					arg_623_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_623_1.time_ >= var_626_1 + var_626_2 and arg_623_1.time_ < var_626_1 + var_626_2 + arg_626_0 and not isNil(var_626_0) and arg_623_1.var_.characterEffect1047ui_story then
				arg_623_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_626_4 = 0

			if var_626_4 < arg_623_1.time_ and arg_623_1.time_ <= var_626_4 + arg_626_0 then
				arg_623_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action442")
			end

			local var_626_5 = 0

			if var_626_5 < arg_623_1.time_ and arg_623_1.time_ <= var_626_5 + arg_626_0 then
				arg_623_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_626_6 = 0
			local var_626_7 = 0.35

			if var_626_6 < arg_623_1.time_ and arg_623_1.time_ <= var_626_6 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				local var_626_8 = arg_623_1:FormatText(StoryNameCfg[1296].name)

				arg_623_1.leftNameTxt_.text = var_626_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_9 = arg_623_1:GetWordFromCfg(1104704150)
				local var_626_10 = arg_623_1:FormatText(var_626_9.content)

				arg_623_1.text_.text = var_626_10

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_11 = 14
				local var_626_12 = utf8.len(var_626_10)
				local var_626_13 = var_626_11 <= 0 and var_626_7 or var_626_7 * (var_626_12 / var_626_11)

				if var_626_13 > 0 and var_626_7 < var_626_13 then
					arg_623_1.talkMaxDuration = var_626_13

					if var_626_13 + var_626_6 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_13 + var_626_6
					end
				end

				arg_623_1.text_.text = var_626_10
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704150", "story_v_side_new_1104704.awb") ~= 0 then
					local var_626_14 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704150", "story_v_side_new_1104704.awb") / 1000

					if var_626_14 + var_626_6 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_14 + var_626_6
					end

					if var_626_9.prefab_name ~= "" and arg_623_1.actors_[var_626_9.prefab_name] ~= nil then
						local var_626_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_9.prefab_name].transform, "story_v_side_new_1104704", "1104704150", "story_v_side_new_1104704.awb")

						arg_623_1:RecordAudio("1104704150", var_626_15)
						arg_623_1:RecordAudio("1104704150", var_626_15)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704150", "story_v_side_new_1104704.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704150", "story_v_side_new_1104704.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_16 = math.max(var_626_7, arg_623_1.talkMaxDuration)

			if var_626_6 <= arg_623_1.time_ and arg_623_1.time_ < var_626_6 + var_626_16 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_6) / var_626_16

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_6 + var_626_16 and arg_623_1.time_ < var_626_6 + var_626_16 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1104704151 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1104704151
		arg_627_1.duration_ = 2

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1104704152(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = arg_627_1.actors_["1047ui_story"]
			local var_630_1 = 0

			if var_630_1 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 and not isNil(var_630_0) and arg_627_1.var_.characterEffect1047ui_story == nil then
				arg_627_1.var_.characterEffect1047ui_story = var_630_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_2 = 0.200000002980232

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_2 and not isNil(var_630_0) then
				local var_630_3 = (arg_627_1.time_ - var_630_1) / var_630_2

				if arg_627_1.var_.characterEffect1047ui_story and not isNil(var_630_0) then
					local var_630_4 = Mathf.Lerp(0, 0.5, var_630_3)

					arg_627_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_627_1.var_.characterEffect1047ui_story.fillRatio = var_630_4
				end
			end

			if arg_627_1.time_ >= var_630_1 + var_630_2 and arg_627_1.time_ < var_630_1 + var_630_2 + arg_630_0 and not isNil(var_630_0) and arg_627_1.var_.characterEffect1047ui_story then
				local var_630_5 = 0.5

				arg_627_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_627_1.var_.characterEffect1047ui_story.fillRatio = var_630_5
			end

			local var_630_6 = 0

			if var_630_6 < arg_627_1.time_ and arg_627_1.time_ <= var_630_6 + arg_630_0 then
				arg_627_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			local var_630_7 = 0
			local var_630_8 = 0.15

			if var_630_7 < arg_627_1.time_ and arg_627_1.time_ <= var_630_7 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				local var_630_9 = arg_627_1:FormatText(StoryNameCfg[331].name)

				arg_627_1.leftNameTxt_.text = var_630_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_10 = arg_627_1:GetWordFromCfg(1104704151)
				local var_630_11 = arg_627_1:FormatText(var_630_10.content)

				arg_627_1.text_.text = var_630_11

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_12 = 6
				local var_630_13 = utf8.len(var_630_11)
				local var_630_14 = var_630_12 <= 0 and var_630_8 or var_630_8 * (var_630_13 / var_630_12)

				if var_630_14 > 0 and var_630_8 < var_630_14 then
					arg_627_1.talkMaxDuration = var_630_14

					if var_630_14 + var_630_7 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_14 + var_630_7
					end
				end

				arg_627_1.text_.text = var_630_11
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704151", "story_v_side_new_1104704.awb") ~= 0 then
					local var_630_15 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704151", "story_v_side_new_1104704.awb") / 1000

					if var_630_15 + var_630_7 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_15 + var_630_7
					end

					if var_630_10.prefab_name ~= "" and arg_627_1.actors_[var_630_10.prefab_name] ~= nil then
						local var_630_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_10.prefab_name].transform, "story_v_side_new_1104704", "1104704151", "story_v_side_new_1104704.awb")

						arg_627_1:RecordAudio("1104704151", var_630_16)
						arg_627_1:RecordAudio("1104704151", var_630_16)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704151", "story_v_side_new_1104704.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704151", "story_v_side_new_1104704.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_17 = math.max(var_630_8, arg_627_1.talkMaxDuration)

			if var_630_7 <= arg_627_1.time_ and arg_627_1.time_ < var_630_7 + var_630_17 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_7) / var_630_17

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_7 + var_630_17 and arg_627_1.time_ < var_630_7 + var_630_17 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play1104704152 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1104704152
		arg_631_1.duration_ = 6.9

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1104704153(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = arg_631_1.actors_["1047ui_story"]
			local var_634_1 = 0

			if var_634_1 < arg_631_1.time_ and arg_631_1.time_ <= var_634_1 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect1047ui_story == nil then
				arg_631_1.var_.characterEffect1047ui_story = var_634_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_2 = 0.200000002980232

			if var_634_1 <= arg_631_1.time_ and arg_631_1.time_ < var_634_1 + var_634_2 and not isNil(var_634_0) then
				local var_634_3 = (arg_631_1.time_ - var_634_1) / var_634_2

				if arg_631_1.var_.characterEffect1047ui_story and not isNil(var_634_0) then
					arg_631_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_631_1.time_ >= var_634_1 + var_634_2 and arg_631_1.time_ < var_634_1 + var_634_2 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect1047ui_story then
				arg_631_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_634_4 = 0

			if var_634_4 < arg_631_1.time_ and arg_631_1.time_ <= var_634_4 + arg_634_0 then
				arg_631_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaB", "EmotionTimelineAnimator")
			end

			local var_634_5 = 0
			local var_634_6 = 0.35

			if var_634_5 < arg_631_1.time_ and arg_631_1.time_ <= var_634_5 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				local var_634_7 = arg_631_1:FormatText(StoryNameCfg[1296].name)

				arg_631_1.leftNameTxt_.text = var_634_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_8 = arg_631_1:GetWordFromCfg(1104704152)
				local var_634_9 = arg_631_1:FormatText(var_634_8.content)

				arg_631_1.text_.text = var_634_9

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_10 = 14
				local var_634_11 = utf8.len(var_634_9)
				local var_634_12 = var_634_10 <= 0 and var_634_6 or var_634_6 * (var_634_11 / var_634_10)

				if var_634_12 > 0 and var_634_6 < var_634_12 then
					arg_631_1.talkMaxDuration = var_634_12

					if var_634_12 + var_634_5 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_12 + var_634_5
					end
				end

				arg_631_1.text_.text = var_634_9
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704152", "story_v_side_new_1104704.awb") ~= 0 then
					local var_634_13 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704152", "story_v_side_new_1104704.awb") / 1000

					if var_634_13 + var_634_5 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_13 + var_634_5
					end

					if var_634_8.prefab_name ~= "" and arg_631_1.actors_[var_634_8.prefab_name] ~= nil then
						local var_634_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_8.prefab_name].transform, "story_v_side_new_1104704", "1104704152", "story_v_side_new_1104704.awb")

						arg_631_1:RecordAudio("1104704152", var_634_14)
						arg_631_1:RecordAudio("1104704152", var_634_14)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704152", "story_v_side_new_1104704.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704152", "story_v_side_new_1104704.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_15 = math.max(var_634_6, arg_631_1.talkMaxDuration)

			if var_634_5 <= arg_631_1.time_ and arg_631_1.time_ < var_634_5 + var_634_15 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_5) / var_634_15

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_5 + var_634_15 and arg_631_1.time_ < var_634_5 + var_634_15 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play1104704153 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1104704153
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1104704154(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = 0

			if var_638_0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_0 + arg_638_0 then
				arg_635_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_638_1 = 0
			local var_638_2 = 0.65

			if var_638_1 < arg_635_1.time_ and arg_635_1.time_ <= var_638_1 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, false)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_3 = arg_635_1:GetWordFromCfg(1104704153)
				local var_638_4 = arg_635_1:FormatText(var_638_3.content)

				arg_635_1.text_.text = var_638_4

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_5 = 26
				local var_638_6 = utf8.len(var_638_4)
				local var_638_7 = var_638_5 <= 0 and var_638_2 or var_638_2 * (var_638_6 / var_638_5)

				if var_638_7 > 0 and var_638_2 < var_638_7 then
					arg_635_1.talkMaxDuration = var_638_7

					if var_638_7 + var_638_1 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_7 + var_638_1
					end
				end

				arg_635_1.text_.text = var_638_4
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_8 = math.max(var_638_2, arg_635_1.talkMaxDuration)

			if var_638_1 <= arg_635_1.time_ and arg_635_1.time_ < var_638_1 + var_638_8 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_1) / var_638_8

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_1 + var_638_8 and arg_635_1.time_ < var_638_1 + var_638_8 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play1104704154 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1104704154
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1104704155(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = arg_639_1.actors_["1047ui_story"].transform
			local var_642_1 = 0

			if var_642_1 < arg_639_1.time_ and arg_639_1.time_ <= var_642_1 + arg_642_0 then
				arg_639_1.var_.moveOldPos1047ui_story = var_642_0.localPosition
			end

			local var_642_2 = 0.001

			if var_642_1 <= arg_639_1.time_ and arg_639_1.time_ < var_642_1 + var_642_2 then
				local var_642_3 = (arg_639_1.time_ - var_642_1) / var_642_2
				local var_642_4 = Vector3.New(0, 100, 0)

				var_642_0.localPosition = Vector3.Lerp(arg_639_1.var_.moveOldPos1047ui_story, var_642_4, var_642_3)

				local var_642_5 = manager.ui.mainCamera.transform.position - var_642_0.position

				var_642_0.forward = Vector3.New(var_642_5.x, var_642_5.y, var_642_5.z)

				local var_642_6 = var_642_0.localEulerAngles

				var_642_6.z = 0
				var_642_6.x = 0
				var_642_0.localEulerAngles = var_642_6
			end

			if arg_639_1.time_ >= var_642_1 + var_642_2 and arg_639_1.time_ < var_642_1 + var_642_2 + arg_642_0 then
				var_642_0.localPosition = Vector3.New(0, 100, 0)

				local var_642_7 = manager.ui.mainCamera.transform.position - var_642_0.position

				var_642_0.forward = Vector3.New(var_642_7.x, var_642_7.y, var_642_7.z)

				local var_642_8 = var_642_0.localEulerAngles

				var_642_8.z = 0
				var_642_8.x = 0
				var_642_0.localEulerAngles = var_642_8
			end

			local var_642_9 = 0.3
			local var_642_10 = 1

			if var_642_9 < arg_639_1.time_ and arg_639_1.time_ <= var_642_9 + arg_642_0 then
				local var_642_11 = "play"
				local var_642_12 = "effect"

				arg_639_1:AudioAction(var_642_11, var_642_12, "se_story_221_00", "se_story_221_00_cheers", "")
			end

			local var_642_13 = 0
			local var_642_14 = 0.35

			if var_642_13 < arg_639_1.time_ and arg_639_1.time_ <= var_642_13 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, false)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_15 = arg_639_1:GetWordFromCfg(1104704154)
				local var_642_16 = arg_639_1:FormatText(var_642_15.content)

				arg_639_1.text_.text = var_642_16

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_17 = 14
				local var_642_18 = utf8.len(var_642_16)
				local var_642_19 = var_642_17 <= 0 and var_642_14 or var_642_14 * (var_642_18 / var_642_17)

				if var_642_19 > 0 and var_642_14 < var_642_19 then
					arg_639_1.talkMaxDuration = var_642_19

					if var_642_19 + var_642_13 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_19 + var_642_13
					end
				end

				arg_639_1.text_.text = var_642_16
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_20 = math.max(var_642_14, arg_639_1.talkMaxDuration)

			if var_642_13 <= arg_639_1.time_ and arg_639_1.time_ < var_642_13 + var_642_20 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_13) / var_642_20

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_13 + var_642_20 and arg_639_1.time_ < var_642_13 + var_642_20 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_639_1:InitPlayNodeList()
	end,
	Play1104704155 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1104704155
		arg_643_1.duration_ = 5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1104704156(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = 0
			local var_646_1 = 0.95

			if var_646_0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_0 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, false)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_2 = arg_643_1:GetWordFromCfg(1104704155)
				local var_646_3 = arg_643_1:FormatText(var_646_2.content)

				arg_643_1.text_.text = var_646_3

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_4 = 38
				local var_646_5 = utf8.len(var_646_3)
				local var_646_6 = var_646_4 <= 0 and var_646_1 or var_646_1 * (var_646_5 / var_646_4)

				if var_646_6 > 0 and var_646_1 < var_646_6 then
					arg_643_1.talkMaxDuration = var_646_6

					if var_646_6 + var_646_0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_6 + var_646_0
					end
				end

				arg_643_1.text_.text = var_646_3
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_7 = math.max(var_646_1, arg_643_1.talkMaxDuration)

			if var_646_0 <= arg_643_1.time_ and arg_643_1.time_ < var_646_0 + var_646_7 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_0) / var_646_7

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_0 + var_646_7 and arg_643_1.time_ < var_646_0 + var_646_7 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play1104704156 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 1104704156
		arg_647_1.duration_ = 5

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play1104704157(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 0
			local var_650_1 = 0.8

			if var_650_0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				local var_650_2 = arg_647_1:FormatText(StoryNameCfg[7].name)

				arg_647_1.leftNameTxt_.text = var_650_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, true)
				arg_647_1.iconController_:SetSelectedState("hero")

				arg_647_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_647_1.callingController_:SetSelectedState("normal")

				arg_647_1.keyicon_.color = Color.New(1, 1, 1)
				arg_647_1.icon_.color = Color.New(1, 1, 1)

				local var_650_3 = arg_647_1:GetWordFromCfg(1104704156)
				local var_650_4 = arg_647_1:FormatText(var_650_3.content)

				arg_647_1.text_.text = var_650_4

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_5 = 32
				local var_650_6 = utf8.len(var_650_4)
				local var_650_7 = var_650_5 <= 0 and var_650_1 or var_650_1 * (var_650_6 / var_650_5)

				if var_650_7 > 0 and var_650_1 < var_650_7 then
					arg_647_1.talkMaxDuration = var_650_7

					if var_650_7 + var_650_0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_7 + var_650_0
					end
				end

				arg_647_1.text_.text = var_650_4
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)
				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_8 = math.max(var_650_1, arg_647_1.talkMaxDuration)

			if var_650_0 <= arg_647_1.time_ and arg_647_1.time_ < var_650_0 + var_650_8 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_0) / var_650_8

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_0 + var_650_8 and arg_647_1.time_ < var_650_0 + var_650_8 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play1104704157 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 1104704157
		arg_651_1.duration_ = 3.8

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play1104704158(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = arg_651_1.actors_["1047ui_story"].transform
			local var_654_1 = 0

			if var_654_1 < arg_651_1.time_ and arg_651_1.time_ <= var_654_1 + arg_654_0 then
				arg_651_1.var_.moveOldPos1047ui_story = var_654_0.localPosition
			end

			local var_654_2 = 0.001

			if var_654_1 <= arg_651_1.time_ and arg_651_1.time_ < var_654_1 + var_654_2 then
				local var_654_3 = (arg_651_1.time_ - var_654_1) / var_654_2
				local var_654_4 = Vector3.New(0, -1.13, -6.2)

				var_654_0.localPosition = Vector3.Lerp(arg_651_1.var_.moveOldPos1047ui_story, var_654_4, var_654_3)

				local var_654_5 = manager.ui.mainCamera.transform.position - var_654_0.position

				var_654_0.forward = Vector3.New(var_654_5.x, var_654_5.y, var_654_5.z)

				local var_654_6 = var_654_0.localEulerAngles

				var_654_6.z = 0
				var_654_6.x = 0
				var_654_0.localEulerAngles = var_654_6
			end

			if arg_651_1.time_ >= var_654_1 + var_654_2 and arg_651_1.time_ < var_654_1 + var_654_2 + arg_654_0 then
				var_654_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_654_7 = manager.ui.mainCamera.transform.position - var_654_0.position

				var_654_0.forward = Vector3.New(var_654_7.x, var_654_7.y, var_654_7.z)

				local var_654_8 = var_654_0.localEulerAngles

				var_654_8.z = 0
				var_654_8.x = 0
				var_654_0.localEulerAngles = var_654_8
			end

			local var_654_9 = arg_651_1.actors_["1047ui_story"]
			local var_654_10 = 0

			if var_654_10 < arg_651_1.time_ and arg_651_1.time_ <= var_654_10 + arg_654_0 and not isNil(var_654_9) and arg_651_1.var_.characterEffect1047ui_story == nil then
				arg_651_1.var_.characterEffect1047ui_story = var_654_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_654_11 = 0.200000002980232

			if var_654_10 <= arg_651_1.time_ and arg_651_1.time_ < var_654_10 + var_654_11 and not isNil(var_654_9) then
				local var_654_12 = (arg_651_1.time_ - var_654_10) / var_654_11

				if arg_651_1.var_.characterEffect1047ui_story and not isNil(var_654_9) then
					arg_651_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_651_1.time_ >= var_654_10 + var_654_11 and arg_651_1.time_ < var_654_10 + var_654_11 + arg_654_0 and not isNil(var_654_9) and arg_651_1.var_.characterEffect1047ui_story then
				arg_651_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_654_13 = 0

			if var_654_13 < arg_651_1.time_ and arg_651_1.time_ <= var_654_13 + arg_654_0 then
				arg_651_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_654_14 = 0

			if var_654_14 < arg_651_1.time_ and arg_651_1.time_ <= var_654_14 + arg_654_0 then
				arg_651_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_654_15 = 0
			local var_654_16 = 0.4

			if var_654_15 < arg_651_1.time_ and arg_651_1.time_ <= var_654_15 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				local var_654_17 = arg_651_1:FormatText(StoryNameCfg[1296].name)

				arg_651_1.leftNameTxt_.text = var_654_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_18 = arg_651_1:GetWordFromCfg(1104704157)
				local var_654_19 = arg_651_1:FormatText(var_654_18.content)

				arg_651_1.text_.text = var_654_19

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_20 = 16
				local var_654_21 = utf8.len(var_654_19)
				local var_654_22 = var_654_20 <= 0 and var_654_16 or var_654_16 * (var_654_21 / var_654_20)

				if var_654_22 > 0 and var_654_16 < var_654_22 then
					arg_651_1.talkMaxDuration = var_654_22

					if var_654_22 + var_654_15 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_22 + var_654_15
					end
				end

				arg_651_1.text_.text = var_654_19
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704157", "story_v_side_new_1104704.awb") ~= 0 then
					local var_654_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704157", "story_v_side_new_1104704.awb") / 1000

					if var_654_23 + var_654_15 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_23 + var_654_15
					end

					if var_654_18.prefab_name ~= "" and arg_651_1.actors_[var_654_18.prefab_name] ~= nil then
						local var_654_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_651_1.actors_[var_654_18.prefab_name].transform, "story_v_side_new_1104704", "1104704157", "story_v_side_new_1104704.awb")

						arg_651_1:RecordAudio("1104704157", var_654_24)
						arg_651_1:RecordAudio("1104704157", var_654_24)
					else
						arg_651_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704157", "story_v_side_new_1104704.awb")
					end

					arg_651_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704157", "story_v_side_new_1104704.awb")
				end

				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_25 = math.max(var_654_16, arg_651_1.talkMaxDuration)

			if var_654_15 <= arg_651_1.time_ and arg_651_1.time_ < var_654_15 + var_654_25 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_15) / var_654_25

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_15 + var_654_25 and arg_651_1.time_ < var_654_15 + var_654_25 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_651_1:InitPlayNodeList()
	end,
	Play1104704158 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 1104704158
		arg_655_1.duration_ = 5

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play1104704159(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			local var_658_0 = arg_655_1.actors_["1047ui_story"]
			local var_658_1 = 0

			if var_658_1 < arg_655_1.time_ and arg_655_1.time_ <= var_658_1 + arg_658_0 and not isNil(var_658_0) and arg_655_1.var_.characterEffect1047ui_story == nil then
				arg_655_1.var_.characterEffect1047ui_story = var_658_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_658_2 = 0.200000002980232

			if var_658_1 <= arg_655_1.time_ and arg_655_1.time_ < var_658_1 + var_658_2 and not isNil(var_658_0) then
				local var_658_3 = (arg_655_1.time_ - var_658_1) / var_658_2

				if arg_655_1.var_.characterEffect1047ui_story and not isNil(var_658_0) then
					local var_658_4 = Mathf.Lerp(0, 0.5, var_658_3)

					arg_655_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_655_1.var_.characterEffect1047ui_story.fillRatio = var_658_4
				end
			end

			if arg_655_1.time_ >= var_658_1 + var_658_2 and arg_655_1.time_ < var_658_1 + var_658_2 + arg_658_0 and not isNil(var_658_0) and arg_655_1.var_.characterEffect1047ui_story then
				local var_658_5 = 0.5

				arg_655_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_655_1.var_.characterEffect1047ui_story.fillRatio = var_658_5
			end

			local var_658_6 = 0
			local var_658_7 = 0.4

			if var_658_6 < arg_655_1.time_ and arg_655_1.time_ <= var_658_6 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				local var_658_8 = arg_655_1:FormatText(StoryNameCfg[7].name)

				arg_655_1.leftNameTxt_.text = var_658_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, true)
				arg_655_1.iconController_:SetSelectedState("hero")

				arg_655_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_655_1.callingController_:SetSelectedState("normal")

				arg_655_1.keyicon_.color = Color.New(1, 1, 1)
				arg_655_1.icon_.color = Color.New(1, 1, 1)

				local var_658_9 = arg_655_1:GetWordFromCfg(1104704158)
				local var_658_10 = arg_655_1:FormatText(var_658_9.content)

				arg_655_1.text_.text = var_658_10

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_11 = 16
				local var_658_12 = utf8.len(var_658_10)
				local var_658_13 = var_658_11 <= 0 and var_658_7 or var_658_7 * (var_658_12 / var_658_11)

				if var_658_13 > 0 and var_658_7 < var_658_13 then
					arg_655_1.talkMaxDuration = var_658_13

					if var_658_13 + var_658_6 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_13 + var_658_6
					end
				end

				arg_655_1.text_.text = var_658_10
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)
				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_14 = math.max(var_658_7, arg_655_1.talkMaxDuration)

			if var_658_6 <= arg_655_1.time_ and arg_655_1.time_ < var_658_6 + var_658_14 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_6) / var_658_14

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_6 + var_658_14 and arg_655_1.time_ < var_658_6 + var_658_14 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play1104704159 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 1104704159
		arg_659_1.duration_ = 5

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play1104704160(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = arg_659_1.actors_["1047ui_story"]
			local var_662_1 = 0

			if var_662_1 < arg_659_1.time_ and arg_659_1.time_ <= var_662_1 + arg_662_0 and not isNil(var_662_0) and arg_659_1.var_.characterEffect1047ui_story == nil then
				arg_659_1.var_.characterEffect1047ui_story = var_662_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_662_2 = 0.200000002980232

			if var_662_1 <= arg_659_1.time_ and arg_659_1.time_ < var_662_1 + var_662_2 and not isNil(var_662_0) then
				local var_662_3 = (arg_659_1.time_ - var_662_1) / var_662_2

				if arg_659_1.var_.characterEffect1047ui_story and not isNil(var_662_0) then
					local var_662_4 = Mathf.Lerp(0, 0.5, var_662_3)

					arg_659_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_659_1.var_.characterEffect1047ui_story.fillRatio = var_662_4
				end
			end

			if arg_659_1.time_ >= var_662_1 + var_662_2 and arg_659_1.time_ < var_662_1 + var_662_2 + arg_662_0 and not isNil(var_662_0) and arg_659_1.var_.characterEffect1047ui_story then
				local var_662_5 = 0.5

				arg_659_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_659_1.var_.characterEffect1047ui_story.fillRatio = var_662_5
			end

			local var_662_6 = 0
			local var_662_7 = 0.9

			if var_662_6 < arg_659_1.time_ and arg_659_1.time_ <= var_662_6 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				local var_662_8 = arg_659_1:FormatText(StoryNameCfg[7].name)

				arg_659_1.leftNameTxt_.text = var_662_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, true)
				arg_659_1.iconController_:SetSelectedState("hero")

				arg_659_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_659_1.callingController_:SetSelectedState("normal")

				arg_659_1.keyicon_.color = Color.New(1, 1, 1)
				arg_659_1.icon_.color = Color.New(1, 1, 1)

				local var_662_9 = arg_659_1:GetWordFromCfg(1104704159)
				local var_662_10 = arg_659_1:FormatText(var_662_9.content)

				arg_659_1.text_.text = var_662_10

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_11 = 36
				local var_662_12 = utf8.len(var_662_10)
				local var_662_13 = var_662_11 <= 0 and var_662_7 or var_662_7 * (var_662_12 / var_662_11)

				if var_662_13 > 0 and var_662_7 < var_662_13 then
					arg_659_1.talkMaxDuration = var_662_13

					if var_662_13 + var_662_6 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_13 + var_662_6
					end
				end

				arg_659_1.text_.text = var_662_10
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)
				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_14 = math.max(var_662_7, arg_659_1.talkMaxDuration)

			if var_662_6 <= arg_659_1.time_ and arg_659_1.time_ < var_662_6 + var_662_14 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_6) / var_662_14

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_6 + var_662_14 and arg_659_1.time_ < var_662_6 + var_662_14 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play1104704160 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 1104704160
		arg_663_1.duration_ = 2.57

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play1104704161(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = arg_663_1.actors_["1047ui_story"].transform
			local var_666_1 = 0

			if var_666_1 < arg_663_1.time_ and arg_663_1.time_ <= var_666_1 + arg_666_0 then
				arg_663_1.var_.moveOldPos1047ui_story = var_666_0.localPosition
			end

			local var_666_2 = 0.001

			if var_666_1 <= arg_663_1.time_ and arg_663_1.time_ < var_666_1 + var_666_2 then
				local var_666_3 = (arg_663_1.time_ - var_666_1) / var_666_2
				local var_666_4 = Vector3.New(0, -1.13, -6.2)

				var_666_0.localPosition = Vector3.Lerp(arg_663_1.var_.moveOldPos1047ui_story, var_666_4, var_666_3)

				local var_666_5 = manager.ui.mainCamera.transform.position - var_666_0.position

				var_666_0.forward = Vector3.New(var_666_5.x, var_666_5.y, var_666_5.z)

				local var_666_6 = var_666_0.localEulerAngles

				var_666_6.z = 0
				var_666_6.x = 0
				var_666_0.localEulerAngles = var_666_6
			end

			if arg_663_1.time_ >= var_666_1 + var_666_2 and arg_663_1.time_ < var_666_1 + var_666_2 + arg_666_0 then
				var_666_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_666_7 = manager.ui.mainCamera.transform.position - var_666_0.position

				var_666_0.forward = Vector3.New(var_666_7.x, var_666_7.y, var_666_7.z)

				local var_666_8 = var_666_0.localEulerAngles

				var_666_8.z = 0
				var_666_8.x = 0
				var_666_0.localEulerAngles = var_666_8
			end

			local var_666_9 = arg_663_1.actors_["1047ui_story"]
			local var_666_10 = 0

			if var_666_10 < arg_663_1.time_ and arg_663_1.time_ <= var_666_10 + arg_666_0 and not isNil(var_666_9) and arg_663_1.var_.characterEffect1047ui_story == nil then
				arg_663_1.var_.characterEffect1047ui_story = var_666_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_11 = 0.200000002980232

			if var_666_10 <= arg_663_1.time_ and arg_663_1.time_ < var_666_10 + var_666_11 and not isNil(var_666_9) then
				local var_666_12 = (arg_663_1.time_ - var_666_10) / var_666_11

				if arg_663_1.var_.characterEffect1047ui_story and not isNil(var_666_9) then
					arg_663_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_663_1.time_ >= var_666_10 + var_666_11 and arg_663_1.time_ < var_666_10 + var_666_11 + arg_666_0 and not isNil(var_666_9) and arg_663_1.var_.characterEffect1047ui_story then
				arg_663_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_666_13 = 0

			if var_666_13 < arg_663_1.time_ and arg_663_1.time_ <= var_666_13 + arg_666_0 then
				arg_663_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			local var_666_14 = 0

			if var_666_14 < arg_663_1.time_ and arg_663_1.time_ <= var_666_14 + arg_666_0 then
				arg_663_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_666_15 = 0
			local var_666_16 = 0.2

			if var_666_15 < arg_663_1.time_ and arg_663_1.time_ <= var_666_15 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				local var_666_17 = arg_663_1:FormatText(StoryNameCfg[1296].name)

				arg_663_1.leftNameTxt_.text = var_666_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_18 = arg_663_1:GetWordFromCfg(1104704160)
				local var_666_19 = arg_663_1:FormatText(var_666_18.content)

				arg_663_1.text_.text = var_666_19

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_20 = 8
				local var_666_21 = utf8.len(var_666_19)
				local var_666_22 = var_666_20 <= 0 and var_666_16 or var_666_16 * (var_666_21 / var_666_20)

				if var_666_22 > 0 and var_666_16 < var_666_22 then
					arg_663_1.talkMaxDuration = var_666_22

					if var_666_22 + var_666_15 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_22 + var_666_15
					end
				end

				arg_663_1.text_.text = var_666_19
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704160", "story_v_side_new_1104704.awb") ~= 0 then
					local var_666_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704160", "story_v_side_new_1104704.awb") / 1000

					if var_666_23 + var_666_15 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_23 + var_666_15
					end

					if var_666_18.prefab_name ~= "" and arg_663_1.actors_[var_666_18.prefab_name] ~= nil then
						local var_666_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_663_1.actors_[var_666_18.prefab_name].transform, "story_v_side_new_1104704", "1104704160", "story_v_side_new_1104704.awb")

						arg_663_1:RecordAudio("1104704160", var_666_24)
						arg_663_1:RecordAudio("1104704160", var_666_24)
					else
						arg_663_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704160", "story_v_side_new_1104704.awb")
					end

					arg_663_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704160", "story_v_side_new_1104704.awb")
				end

				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_25 = math.max(var_666_16, arg_663_1.talkMaxDuration)

			if var_666_15 <= arg_663_1.time_ and arg_663_1.time_ < var_666_15 + var_666_25 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_15) / var_666_25

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_15 + var_666_25 and arg_663_1.time_ < var_666_15 + var_666_25 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_663_1:InitPlayNodeList()
	end,
	Play1104704161 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 1104704161
		arg_667_1.duration_ = 7.3

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play1104704162(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = 0
			local var_670_1 = 0.7

			if var_670_0 < arg_667_1.time_ and arg_667_1.time_ <= var_670_0 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				local var_670_2 = arg_667_1:FormatText(StoryNameCfg[1296].name)

				arg_667_1.leftNameTxt_.text = var_670_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_3 = arg_667_1:GetWordFromCfg(1104704161)
				local var_670_4 = arg_667_1:FormatText(var_670_3.content)

				arg_667_1.text_.text = var_670_4

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_5 = 28
				local var_670_6 = utf8.len(var_670_4)
				local var_670_7 = var_670_5 <= 0 and var_670_1 or var_670_1 * (var_670_6 / var_670_5)

				if var_670_7 > 0 and var_670_1 < var_670_7 then
					arg_667_1.talkMaxDuration = var_670_7

					if var_670_7 + var_670_0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_7 + var_670_0
					end
				end

				arg_667_1.text_.text = var_670_4
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704161", "story_v_side_new_1104704.awb") ~= 0 then
					local var_670_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704161", "story_v_side_new_1104704.awb") / 1000

					if var_670_8 + var_670_0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_8 + var_670_0
					end

					if var_670_3.prefab_name ~= "" and arg_667_1.actors_[var_670_3.prefab_name] ~= nil then
						local var_670_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_667_1.actors_[var_670_3.prefab_name].transform, "story_v_side_new_1104704", "1104704161", "story_v_side_new_1104704.awb")

						arg_667_1:RecordAudio("1104704161", var_670_9)
						arg_667_1:RecordAudio("1104704161", var_670_9)
					else
						arg_667_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704161", "story_v_side_new_1104704.awb")
					end

					arg_667_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704161", "story_v_side_new_1104704.awb")
				end

				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_10 = math.max(var_670_1, arg_667_1.talkMaxDuration)

			if var_670_0 <= arg_667_1.time_ and arg_667_1.time_ < var_670_0 + var_670_10 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_0) / var_670_10

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_0 + var_670_10 and arg_667_1.time_ < var_670_0 + var_670_10 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play1104704162 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 1104704162
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play1104704163(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = arg_671_1.actors_["1047ui_story"]
			local var_674_1 = 0

			if var_674_1 < arg_671_1.time_ and arg_671_1.time_ <= var_674_1 + arg_674_0 and not isNil(var_674_0) and arg_671_1.var_.characterEffect1047ui_story == nil then
				arg_671_1.var_.characterEffect1047ui_story = var_674_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_674_2 = 0.200000002980232

			if var_674_1 <= arg_671_1.time_ and arg_671_1.time_ < var_674_1 + var_674_2 and not isNil(var_674_0) then
				local var_674_3 = (arg_671_1.time_ - var_674_1) / var_674_2

				if arg_671_1.var_.characterEffect1047ui_story and not isNil(var_674_0) then
					local var_674_4 = Mathf.Lerp(0, 0.5, var_674_3)

					arg_671_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_671_1.var_.characterEffect1047ui_story.fillRatio = var_674_4
				end
			end

			if arg_671_1.time_ >= var_674_1 + var_674_2 and arg_671_1.time_ < var_674_1 + var_674_2 + arg_674_0 and not isNil(var_674_0) and arg_671_1.var_.characterEffect1047ui_story then
				local var_674_5 = 0.5

				arg_671_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_671_1.var_.characterEffect1047ui_story.fillRatio = var_674_5
			end

			local var_674_6 = 0
			local var_674_7 = 0.35

			if var_674_6 < arg_671_1.time_ and arg_671_1.time_ <= var_674_6 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				local var_674_8 = arg_671_1:FormatText(StoryNameCfg[7].name)

				arg_671_1.leftNameTxt_.text = var_674_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, true)
				arg_671_1.iconController_:SetSelectedState("hero")

				arg_671_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_671_1.callingController_:SetSelectedState("normal")

				arg_671_1.keyicon_.color = Color.New(1, 1, 1)
				arg_671_1.icon_.color = Color.New(1, 1, 1)

				local var_674_9 = arg_671_1:GetWordFromCfg(1104704162)
				local var_674_10 = arg_671_1:FormatText(var_674_9.content)

				arg_671_1.text_.text = var_674_10

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_11 = 14
				local var_674_12 = utf8.len(var_674_10)
				local var_674_13 = var_674_11 <= 0 and var_674_7 or var_674_7 * (var_674_12 / var_674_11)

				if var_674_13 > 0 and var_674_7 < var_674_13 then
					arg_671_1.talkMaxDuration = var_674_13

					if var_674_13 + var_674_6 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_13 + var_674_6
					end
				end

				arg_671_1.text_.text = var_674_10
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_14 = math.max(var_674_7, arg_671_1.talkMaxDuration)

			if var_674_6 <= arg_671_1.time_ and arg_671_1.time_ < var_674_6 + var_674_14 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_6) / var_674_14

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_6 + var_674_14 and arg_671_1.time_ < var_674_6 + var_674_14 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play1104704163 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 1104704163
		arg_675_1.duration_ = 5.77

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play1104704164(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = arg_675_1.actors_["1047ui_story"].transform
			local var_678_1 = 0

			if var_678_1 < arg_675_1.time_ and arg_675_1.time_ <= var_678_1 + arg_678_0 then
				arg_675_1.var_.moveOldPos1047ui_story = var_678_0.localPosition
			end

			local var_678_2 = 0.001

			if var_678_1 <= arg_675_1.time_ and arg_675_1.time_ < var_678_1 + var_678_2 then
				local var_678_3 = (arg_675_1.time_ - var_678_1) / var_678_2
				local var_678_4 = Vector3.New(0, -1.13, -6.2)

				var_678_0.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPos1047ui_story, var_678_4, var_678_3)

				local var_678_5 = manager.ui.mainCamera.transform.position - var_678_0.position

				var_678_0.forward = Vector3.New(var_678_5.x, var_678_5.y, var_678_5.z)

				local var_678_6 = var_678_0.localEulerAngles

				var_678_6.z = 0
				var_678_6.x = 0
				var_678_0.localEulerAngles = var_678_6
			end

			if arg_675_1.time_ >= var_678_1 + var_678_2 and arg_675_1.time_ < var_678_1 + var_678_2 + arg_678_0 then
				var_678_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_678_7 = manager.ui.mainCamera.transform.position - var_678_0.position

				var_678_0.forward = Vector3.New(var_678_7.x, var_678_7.y, var_678_7.z)

				local var_678_8 = var_678_0.localEulerAngles

				var_678_8.z = 0
				var_678_8.x = 0
				var_678_0.localEulerAngles = var_678_8
			end

			local var_678_9 = arg_675_1.actors_["1047ui_story"]
			local var_678_10 = 0

			if var_678_10 < arg_675_1.time_ and arg_675_1.time_ <= var_678_10 + arg_678_0 and not isNil(var_678_9) and arg_675_1.var_.characterEffect1047ui_story == nil then
				arg_675_1.var_.characterEffect1047ui_story = var_678_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_678_11 = 0.200000002980232

			if var_678_10 <= arg_675_1.time_ and arg_675_1.time_ < var_678_10 + var_678_11 and not isNil(var_678_9) then
				local var_678_12 = (arg_675_1.time_ - var_678_10) / var_678_11

				if arg_675_1.var_.characterEffect1047ui_story and not isNil(var_678_9) then
					arg_675_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_675_1.time_ >= var_678_10 + var_678_11 and arg_675_1.time_ < var_678_10 + var_678_11 + arg_678_0 and not isNil(var_678_9) and arg_675_1.var_.characterEffect1047ui_story then
				arg_675_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_678_13 = 0

			if var_678_13 < arg_675_1.time_ and arg_675_1.time_ <= var_678_13 + arg_678_0 then
				arg_675_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			local var_678_14 = 0

			if var_678_14 < arg_675_1.time_ and arg_675_1.time_ <= var_678_14 + arg_678_0 then
				arg_675_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_678_15 = 0
			local var_678_16 = 0.575

			if var_678_15 < arg_675_1.time_ and arg_675_1.time_ <= var_678_15 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				local var_678_17 = arg_675_1:FormatText(StoryNameCfg[1296].name)

				arg_675_1.leftNameTxt_.text = var_678_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_18 = arg_675_1:GetWordFromCfg(1104704163)
				local var_678_19 = arg_675_1:FormatText(var_678_18.content)

				arg_675_1.text_.text = var_678_19

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_20 = 23
				local var_678_21 = utf8.len(var_678_19)
				local var_678_22 = var_678_20 <= 0 and var_678_16 or var_678_16 * (var_678_21 / var_678_20)

				if var_678_22 > 0 and var_678_16 < var_678_22 then
					arg_675_1.talkMaxDuration = var_678_22

					if var_678_22 + var_678_15 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_22 + var_678_15
					end
				end

				arg_675_1.text_.text = var_678_19
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704163", "story_v_side_new_1104704.awb") ~= 0 then
					local var_678_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704163", "story_v_side_new_1104704.awb") / 1000

					if var_678_23 + var_678_15 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_23 + var_678_15
					end

					if var_678_18.prefab_name ~= "" and arg_675_1.actors_[var_678_18.prefab_name] ~= nil then
						local var_678_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_675_1.actors_[var_678_18.prefab_name].transform, "story_v_side_new_1104704", "1104704163", "story_v_side_new_1104704.awb")

						arg_675_1:RecordAudio("1104704163", var_678_24)
						arg_675_1:RecordAudio("1104704163", var_678_24)
					else
						arg_675_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704163", "story_v_side_new_1104704.awb")
					end

					arg_675_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704163", "story_v_side_new_1104704.awb")
				end

				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_25 = math.max(var_678_16, arg_675_1.talkMaxDuration)

			if var_678_15 <= arg_675_1.time_ and arg_675_1.time_ < var_678_15 + var_678_25 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_15) / var_678_25

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_15 + var_678_25 and arg_675_1.time_ < var_678_15 + var_678_25 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_675_1:InitPlayNodeList()
	end,
	Play1104704164 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 1104704164
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play1104704165(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = arg_679_1.actors_["1047ui_story"]
			local var_682_1 = 0

			if var_682_1 < arg_679_1.time_ and arg_679_1.time_ <= var_682_1 + arg_682_0 and not isNil(var_682_0) and arg_679_1.var_.characterEffect1047ui_story == nil then
				arg_679_1.var_.characterEffect1047ui_story = var_682_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_2 = 0.200000002980232

			if var_682_1 <= arg_679_1.time_ and arg_679_1.time_ < var_682_1 + var_682_2 and not isNil(var_682_0) then
				local var_682_3 = (arg_679_1.time_ - var_682_1) / var_682_2

				if arg_679_1.var_.characterEffect1047ui_story and not isNil(var_682_0) then
					local var_682_4 = Mathf.Lerp(0, 0.5, var_682_3)

					arg_679_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_679_1.var_.characterEffect1047ui_story.fillRatio = var_682_4
				end
			end

			if arg_679_1.time_ >= var_682_1 + var_682_2 and arg_679_1.time_ < var_682_1 + var_682_2 + arg_682_0 and not isNil(var_682_0) and arg_679_1.var_.characterEffect1047ui_story then
				local var_682_5 = 0.5

				arg_679_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_679_1.var_.characterEffect1047ui_story.fillRatio = var_682_5
			end

			local var_682_6 = 0
			local var_682_7 = 0.1

			if var_682_6 < arg_679_1.time_ and arg_679_1.time_ <= var_682_6 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				local var_682_8 = arg_679_1:FormatText(StoryNameCfg[7].name)

				arg_679_1.leftNameTxt_.text = var_682_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, true)
				arg_679_1.iconController_:SetSelectedState("hero")

				arg_679_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_679_1.callingController_:SetSelectedState("normal")

				arg_679_1.keyicon_.color = Color.New(1, 1, 1)
				arg_679_1.icon_.color = Color.New(1, 1, 1)

				local var_682_9 = arg_679_1:GetWordFromCfg(1104704164)
				local var_682_10 = arg_679_1:FormatText(var_682_9.content)

				arg_679_1.text_.text = var_682_10

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_11 = 4
				local var_682_12 = utf8.len(var_682_10)
				local var_682_13 = var_682_11 <= 0 and var_682_7 or var_682_7 * (var_682_12 / var_682_11)

				if var_682_13 > 0 and var_682_7 < var_682_13 then
					arg_679_1.talkMaxDuration = var_682_13

					if var_682_13 + var_682_6 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_13 + var_682_6
					end
				end

				arg_679_1.text_.text = var_682_10
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_14 = math.max(var_682_7, arg_679_1.talkMaxDuration)

			if var_682_6 <= arg_679_1.time_ and arg_679_1.time_ < var_682_6 + var_682_14 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_6) / var_682_14

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_6 + var_682_14 and arg_679_1.time_ < var_682_6 + var_682_14 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play1104704165 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1104704165
		arg_683_1.duration_ = 4.23

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1104704166(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = arg_683_1.actors_["1047ui_story"]
			local var_686_1 = 0

			if var_686_1 < arg_683_1.time_ and arg_683_1.time_ <= var_686_1 + arg_686_0 and not isNil(var_686_0) and arg_683_1.var_.characterEffect1047ui_story == nil then
				arg_683_1.var_.characterEffect1047ui_story = var_686_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_686_2 = 0.200000002980232

			if var_686_1 <= arg_683_1.time_ and arg_683_1.time_ < var_686_1 + var_686_2 and not isNil(var_686_0) then
				local var_686_3 = (arg_683_1.time_ - var_686_1) / var_686_2

				if arg_683_1.var_.characterEffect1047ui_story and not isNil(var_686_0) then
					arg_683_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_683_1.time_ >= var_686_1 + var_686_2 and arg_683_1.time_ < var_686_1 + var_686_2 + arg_686_0 and not isNil(var_686_0) and arg_683_1.var_.characterEffect1047ui_story then
				arg_683_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_686_4 = 0
			local var_686_5 = 0.5

			if var_686_4 < arg_683_1.time_ and arg_683_1.time_ <= var_686_4 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				local var_686_6 = arg_683_1:FormatText(StoryNameCfg[1296].name)

				arg_683_1.leftNameTxt_.text = var_686_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_7 = arg_683_1:GetWordFromCfg(1104704165)
				local var_686_8 = arg_683_1:FormatText(var_686_7.content)

				arg_683_1.text_.text = var_686_8

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_9 = 20
				local var_686_10 = utf8.len(var_686_8)
				local var_686_11 = var_686_9 <= 0 and var_686_5 or var_686_5 * (var_686_10 / var_686_9)

				if var_686_11 > 0 and var_686_5 < var_686_11 then
					arg_683_1.talkMaxDuration = var_686_11

					if var_686_11 + var_686_4 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_11 + var_686_4
					end
				end

				arg_683_1.text_.text = var_686_8
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704165", "story_v_side_new_1104704.awb") ~= 0 then
					local var_686_12 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704165", "story_v_side_new_1104704.awb") / 1000

					if var_686_12 + var_686_4 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_12 + var_686_4
					end

					if var_686_7.prefab_name ~= "" and arg_683_1.actors_[var_686_7.prefab_name] ~= nil then
						local var_686_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_683_1.actors_[var_686_7.prefab_name].transform, "story_v_side_new_1104704", "1104704165", "story_v_side_new_1104704.awb")

						arg_683_1:RecordAudio("1104704165", var_686_13)
						arg_683_1:RecordAudio("1104704165", var_686_13)
					else
						arg_683_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704165", "story_v_side_new_1104704.awb")
					end

					arg_683_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704165", "story_v_side_new_1104704.awb")
				end

				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_14 = math.max(var_686_5, arg_683_1.talkMaxDuration)

			if var_686_4 <= arg_683_1.time_ and arg_683_1.time_ < var_686_4 + var_686_14 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_4) / var_686_14

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_4 + var_686_14 and arg_683_1.time_ < var_686_4 + var_686_14 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play1104704166 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1104704166
		arg_687_1.duration_ = 6.4

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play1104704167(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = 0
			local var_690_1 = 0.75

			if var_690_0 < arg_687_1.time_ and arg_687_1.time_ <= var_690_0 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				local var_690_2 = arg_687_1:FormatText(StoryNameCfg[1296].name)

				arg_687_1.leftNameTxt_.text = var_690_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_3 = arg_687_1:GetWordFromCfg(1104704166)
				local var_690_4 = arg_687_1:FormatText(var_690_3.content)

				arg_687_1.text_.text = var_690_4

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_5 = 30
				local var_690_6 = utf8.len(var_690_4)
				local var_690_7 = var_690_5 <= 0 and var_690_1 or var_690_1 * (var_690_6 / var_690_5)

				if var_690_7 > 0 and var_690_1 < var_690_7 then
					arg_687_1.talkMaxDuration = var_690_7

					if var_690_7 + var_690_0 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_7 + var_690_0
					end
				end

				arg_687_1.text_.text = var_690_4
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704166", "story_v_side_new_1104704.awb") ~= 0 then
					local var_690_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704166", "story_v_side_new_1104704.awb") / 1000

					if var_690_8 + var_690_0 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_8 + var_690_0
					end

					if var_690_3.prefab_name ~= "" and arg_687_1.actors_[var_690_3.prefab_name] ~= nil then
						local var_690_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_687_1.actors_[var_690_3.prefab_name].transform, "story_v_side_new_1104704", "1104704166", "story_v_side_new_1104704.awb")

						arg_687_1:RecordAudio("1104704166", var_690_9)
						arg_687_1:RecordAudio("1104704166", var_690_9)
					else
						arg_687_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704166", "story_v_side_new_1104704.awb")
					end

					arg_687_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704166", "story_v_side_new_1104704.awb")
				end

				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_10 = math.max(var_690_1, arg_687_1.talkMaxDuration)

			if var_690_0 <= arg_687_1.time_ and arg_687_1.time_ < var_690_0 + var_690_10 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_0) / var_690_10

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_0 + var_690_10 and arg_687_1.time_ < var_690_0 + var_690_10 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play1104704167 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1104704167
		arg_691_1.duration_ = 7.27

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1104704168(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = 0
			local var_694_1 = 0.725

			if var_694_0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_0 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				local var_694_2 = arg_691_1:FormatText(StoryNameCfg[1296].name)

				arg_691_1.leftNameTxt_.text = var_694_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_3 = arg_691_1:GetWordFromCfg(1104704167)
				local var_694_4 = arg_691_1:FormatText(var_694_3.content)

				arg_691_1.text_.text = var_694_4

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_5 = 29
				local var_694_6 = utf8.len(var_694_4)
				local var_694_7 = var_694_5 <= 0 and var_694_1 or var_694_1 * (var_694_6 / var_694_5)

				if var_694_7 > 0 and var_694_1 < var_694_7 then
					arg_691_1.talkMaxDuration = var_694_7

					if var_694_7 + var_694_0 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_7 + var_694_0
					end
				end

				arg_691_1.text_.text = var_694_4
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704167", "story_v_side_new_1104704.awb") ~= 0 then
					local var_694_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704167", "story_v_side_new_1104704.awb") / 1000

					if var_694_8 + var_694_0 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_8 + var_694_0
					end

					if var_694_3.prefab_name ~= "" and arg_691_1.actors_[var_694_3.prefab_name] ~= nil then
						local var_694_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_3.prefab_name].transform, "story_v_side_new_1104704", "1104704167", "story_v_side_new_1104704.awb")

						arg_691_1:RecordAudio("1104704167", var_694_9)
						arg_691_1:RecordAudio("1104704167", var_694_9)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704167", "story_v_side_new_1104704.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704167", "story_v_side_new_1104704.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_10 = math.max(var_694_1, arg_691_1.talkMaxDuration)

			if var_694_0 <= arg_691_1.time_ and arg_691_1.time_ < var_694_0 + var_694_10 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_0) / var_694_10

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_0 + var_694_10 and arg_691_1.time_ < var_694_0 + var_694_10 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play1104704168 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 1104704168
		arg_695_1.duration_ = 5

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play1104704169(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = arg_695_1.actors_["1047ui_story"]
			local var_698_1 = 0

			if var_698_1 < arg_695_1.time_ and arg_695_1.time_ <= var_698_1 + arg_698_0 and not isNil(var_698_0) and arg_695_1.var_.characterEffect1047ui_story == nil then
				arg_695_1.var_.characterEffect1047ui_story = var_698_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_698_2 = 0.200000002980232

			if var_698_1 <= arg_695_1.time_ and arg_695_1.time_ < var_698_1 + var_698_2 and not isNil(var_698_0) then
				local var_698_3 = (arg_695_1.time_ - var_698_1) / var_698_2

				if arg_695_1.var_.characterEffect1047ui_story and not isNil(var_698_0) then
					local var_698_4 = Mathf.Lerp(0, 0.5, var_698_3)

					arg_695_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_695_1.var_.characterEffect1047ui_story.fillRatio = var_698_4
				end
			end

			if arg_695_1.time_ >= var_698_1 + var_698_2 and arg_695_1.time_ < var_698_1 + var_698_2 + arg_698_0 and not isNil(var_698_0) and arg_695_1.var_.characterEffect1047ui_story then
				local var_698_5 = 0.5

				arg_695_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_695_1.var_.characterEffect1047ui_story.fillRatio = var_698_5
			end

			local var_698_6 = 0
			local var_698_7 = 0.25

			if var_698_6 < arg_695_1.time_ and arg_695_1.time_ <= var_698_6 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				local var_698_8 = arg_695_1:FormatText(StoryNameCfg[7].name)

				arg_695_1.leftNameTxt_.text = var_698_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, true)
				arg_695_1.iconController_:SetSelectedState("hero")

				arg_695_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_695_1.callingController_:SetSelectedState("normal")

				arg_695_1.keyicon_.color = Color.New(1, 1, 1)
				arg_695_1.icon_.color = Color.New(1, 1, 1)

				local var_698_9 = arg_695_1:GetWordFromCfg(1104704168)
				local var_698_10 = arg_695_1:FormatText(var_698_9.content)

				arg_695_1.text_.text = var_698_10

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_11 = 10
				local var_698_12 = utf8.len(var_698_10)
				local var_698_13 = var_698_11 <= 0 and var_698_7 or var_698_7 * (var_698_12 / var_698_11)

				if var_698_13 > 0 and var_698_7 < var_698_13 then
					arg_695_1.talkMaxDuration = var_698_13

					if var_698_13 + var_698_6 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_13 + var_698_6
					end
				end

				arg_695_1.text_.text = var_698_10
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)
				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_14 = math.max(var_698_7, arg_695_1.talkMaxDuration)

			if var_698_6 <= arg_695_1.time_ and arg_695_1.time_ < var_698_6 + var_698_14 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_6) / var_698_14

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_6 + var_698_14 and arg_695_1.time_ < var_698_6 + var_698_14 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play1104704169 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 1104704169
		arg_699_1.duration_ = 5

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play1104704170(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = arg_699_1.actors_["1047ui_story"].transform
			local var_702_1 = 0

			if var_702_1 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 then
				arg_699_1.var_.moveOldPos1047ui_story = var_702_0.localPosition
			end

			local var_702_2 = 0.001

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_2 then
				local var_702_3 = (arg_699_1.time_ - var_702_1) / var_702_2
				local var_702_4 = Vector3.New(0, 100, 0)

				var_702_0.localPosition = Vector3.Lerp(arg_699_1.var_.moveOldPos1047ui_story, var_702_4, var_702_3)

				local var_702_5 = manager.ui.mainCamera.transform.position - var_702_0.position

				var_702_0.forward = Vector3.New(var_702_5.x, var_702_5.y, var_702_5.z)

				local var_702_6 = var_702_0.localEulerAngles

				var_702_6.z = 0
				var_702_6.x = 0
				var_702_0.localEulerAngles = var_702_6
			end

			if arg_699_1.time_ >= var_702_1 + var_702_2 and arg_699_1.time_ < var_702_1 + var_702_2 + arg_702_0 then
				var_702_0.localPosition = Vector3.New(0, 100, 0)

				local var_702_7 = manager.ui.mainCamera.transform.position - var_702_0.position

				var_702_0.forward = Vector3.New(var_702_7.x, var_702_7.y, var_702_7.z)

				local var_702_8 = var_702_0.localEulerAngles

				var_702_8.z = 0
				var_702_8.x = 0
				var_702_0.localEulerAngles = var_702_8
			end

			local var_702_9 = 0
			local var_702_10 = 0.425

			if var_702_9 < arg_699_1.time_ and arg_699_1.time_ <= var_702_9 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, false)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_11 = arg_699_1:GetWordFromCfg(1104704169)
				local var_702_12 = arg_699_1:FormatText(var_702_11.content)

				arg_699_1.text_.text = var_702_12

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_13 = 17
				local var_702_14 = utf8.len(var_702_12)
				local var_702_15 = var_702_13 <= 0 and var_702_10 or var_702_10 * (var_702_14 / var_702_13)

				if var_702_15 > 0 and var_702_10 < var_702_15 then
					arg_699_1.talkMaxDuration = var_702_15

					if var_702_15 + var_702_9 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_15 + var_702_9
					end
				end

				arg_699_1.text_.text = var_702_12
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)
				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_16 = math.max(var_702_10, arg_699_1.talkMaxDuration)

			if var_702_9 <= arg_699_1.time_ and arg_699_1.time_ < var_702_9 + var_702_16 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_9) / var_702_16

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_9 + var_702_16 and arg_699_1.time_ < var_702_9 + var_702_16 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_699_1:InitPlayNodeList()
	end,
	Play1104704170 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 1104704170
		arg_703_1.duration_ = 3.83

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play1104704171(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = arg_703_1.actors_["1047ui_story"].transform
			local var_706_1 = 0

			if var_706_1 < arg_703_1.time_ and arg_703_1.time_ <= var_706_1 + arg_706_0 then
				arg_703_1.var_.moveOldPos1047ui_story = var_706_0.localPosition
			end

			local var_706_2 = 0.001

			if var_706_1 <= arg_703_1.time_ and arg_703_1.time_ < var_706_1 + var_706_2 then
				local var_706_3 = (arg_703_1.time_ - var_706_1) / var_706_2
				local var_706_4 = Vector3.New(0, -1.13, -6.2)

				var_706_0.localPosition = Vector3.Lerp(arg_703_1.var_.moveOldPos1047ui_story, var_706_4, var_706_3)

				local var_706_5 = manager.ui.mainCamera.transform.position - var_706_0.position

				var_706_0.forward = Vector3.New(var_706_5.x, var_706_5.y, var_706_5.z)

				local var_706_6 = var_706_0.localEulerAngles

				var_706_6.z = 0
				var_706_6.x = 0
				var_706_0.localEulerAngles = var_706_6
			end

			if arg_703_1.time_ >= var_706_1 + var_706_2 and arg_703_1.time_ < var_706_1 + var_706_2 + arg_706_0 then
				var_706_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_706_7 = manager.ui.mainCamera.transform.position - var_706_0.position

				var_706_0.forward = Vector3.New(var_706_7.x, var_706_7.y, var_706_7.z)

				local var_706_8 = var_706_0.localEulerAngles

				var_706_8.z = 0
				var_706_8.x = 0
				var_706_0.localEulerAngles = var_706_8
			end

			local var_706_9 = arg_703_1.actors_["1047ui_story"]
			local var_706_10 = 0

			if var_706_10 < arg_703_1.time_ and arg_703_1.time_ <= var_706_10 + arg_706_0 and not isNil(var_706_9) and arg_703_1.var_.characterEffect1047ui_story == nil then
				arg_703_1.var_.characterEffect1047ui_story = var_706_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_11 = 0.200000002980232

			if var_706_10 <= arg_703_1.time_ and arg_703_1.time_ < var_706_10 + var_706_11 and not isNil(var_706_9) then
				local var_706_12 = (arg_703_1.time_ - var_706_10) / var_706_11

				if arg_703_1.var_.characterEffect1047ui_story and not isNil(var_706_9) then
					arg_703_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_703_1.time_ >= var_706_10 + var_706_11 and arg_703_1.time_ < var_706_10 + var_706_11 + arg_706_0 and not isNil(var_706_9) and arg_703_1.var_.characterEffect1047ui_story then
				arg_703_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_706_13 = 0

			if var_706_13 < arg_703_1.time_ and arg_703_1.time_ <= var_706_13 + arg_706_0 then
				arg_703_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_706_14 = 0

			if var_706_14 < arg_703_1.time_ and arg_703_1.time_ <= var_706_14 + arg_706_0 then
				arg_703_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_706_15 = 0
			local var_706_16 = 0.325

			if var_706_15 < arg_703_1.time_ and arg_703_1.time_ <= var_706_15 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				local var_706_17 = arg_703_1:FormatText(StoryNameCfg[1296].name)

				arg_703_1.leftNameTxt_.text = var_706_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_18 = arg_703_1:GetWordFromCfg(1104704170)
				local var_706_19 = arg_703_1:FormatText(var_706_18.content)

				arg_703_1.text_.text = var_706_19

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_20 = 13
				local var_706_21 = utf8.len(var_706_19)
				local var_706_22 = var_706_20 <= 0 and var_706_16 or var_706_16 * (var_706_21 / var_706_20)

				if var_706_22 > 0 and var_706_16 < var_706_22 then
					arg_703_1.talkMaxDuration = var_706_22

					if var_706_22 + var_706_15 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_22 + var_706_15
					end
				end

				arg_703_1.text_.text = var_706_19
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704170", "story_v_side_new_1104704.awb") ~= 0 then
					local var_706_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704170", "story_v_side_new_1104704.awb") / 1000

					if var_706_23 + var_706_15 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_23 + var_706_15
					end

					if var_706_18.prefab_name ~= "" and arg_703_1.actors_[var_706_18.prefab_name] ~= nil then
						local var_706_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_703_1.actors_[var_706_18.prefab_name].transform, "story_v_side_new_1104704", "1104704170", "story_v_side_new_1104704.awb")

						arg_703_1:RecordAudio("1104704170", var_706_24)
						arg_703_1:RecordAudio("1104704170", var_706_24)
					else
						arg_703_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704170", "story_v_side_new_1104704.awb")
					end

					arg_703_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704170", "story_v_side_new_1104704.awb")
				end

				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_25 = math.max(var_706_16, arg_703_1.talkMaxDuration)

			if var_706_15 <= arg_703_1.time_ and arg_703_1.time_ < var_706_15 + var_706_25 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_15) / var_706_25

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_15 + var_706_25 and arg_703_1.time_ < var_706_15 + var_706_25 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_703_1:InitPlayNodeList()
	end,
	Play1104704171 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 1104704171
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play1104704172(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = arg_707_1.actors_["1047ui_story"].transform
			local var_710_1 = 0

			if var_710_1 < arg_707_1.time_ and arg_707_1.time_ <= var_710_1 + arg_710_0 then
				arg_707_1.var_.moveOldPos1047ui_story = var_710_0.localPosition
			end

			local var_710_2 = 0.001

			if var_710_1 <= arg_707_1.time_ and arg_707_1.time_ < var_710_1 + var_710_2 then
				local var_710_3 = (arg_707_1.time_ - var_710_1) / var_710_2
				local var_710_4 = Vector3.New(0, 100, 0)

				var_710_0.localPosition = Vector3.Lerp(arg_707_1.var_.moveOldPos1047ui_story, var_710_4, var_710_3)

				local var_710_5 = manager.ui.mainCamera.transform.position - var_710_0.position

				var_710_0.forward = Vector3.New(var_710_5.x, var_710_5.y, var_710_5.z)

				local var_710_6 = var_710_0.localEulerAngles

				var_710_6.z = 0
				var_710_6.x = 0
				var_710_0.localEulerAngles = var_710_6
			end

			if arg_707_1.time_ >= var_710_1 + var_710_2 and arg_707_1.time_ < var_710_1 + var_710_2 + arg_710_0 then
				var_710_0.localPosition = Vector3.New(0, 100, 0)

				local var_710_7 = manager.ui.mainCamera.transform.position - var_710_0.position

				var_710_0.forward = Vector3.New(var_710_7.x, var_710_7.y, var_710_7.z)

				local var_710_8 = var_710_0.localEulerAngles

				var_710_8.z = 0
				var_710_8.x = 0
				var_710_0.localEulerAngles = var_710_8
			end

			local var_710_9 = 0
			local var_710_10 = 0.15

			if var_710_9 < arg_707_1.time_ and arg_707_1.time_ <= var_710_9 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, false)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_11 = arg_707_1:GetWordFromCfg(1104704171)
				local var_710_12 = arg_707_1:FormatText(var_710_11.content)

				arg_707_1.text_.text = var_710_12

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_13 = 6
				local var_710_14 = utf8.len(var_710_12)
				local var_710_15 = var_710_13 <= 0 and var_710_10 or var_710_10 * (var_710_14 / var_710_13)

				if var_710_15 > 0 and var_710_10 < var_710_15 then
					arg_707_1.talkMaxDuration = var_710_15

					if var_710_15 + var_710_9 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_15 + var_710_9
					end
				end

				arg_707_1.text_.text = var_710_12
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_16 = math.max(var_710_10, arg_707_1.talkMaxDuration)

			if var_710_9 <= arg_707_1.time_ and arg_707_1.time_ < var_710_9 + var_710_16 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_9) / var_710_16

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_9 + var_710_16 and arg_707_1.time_ < var_710_9 + var_710_16 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_707_1:InitPlayNodeList()
	end,
	Play1104704172 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 1104704172
		arg_711_1.duration_ = 2

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
			arg_711_1.auto_ = false
		end

		function arg_711_1.playNext_(arg_713_0)
			arg_711_1.onStoryFinished_()
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = arg_711_1.actors_["1047ui_story"].transform
			local var_714_1 = 0

			if var_714_1 < arg_711_1.time_ and arg_711_1.time_ <= var_714_1 + arg_714_0 then
				arg_711_1.var_.moveOldPos1047ui_story = var_714_0.localPosition
			end

			local var_714_2 = 0.001

			if var_714_1 <= arg_711_1.time_ and arg_711_1.time_ < var_714_1 + var_714_2 then
				local var_714_3 = (arg_711_1.time_ - var_714_1) / var_714_2
				local var_714_4 = Vector3.New(0, -1.13, -6.2)

				var_714_0.localPosition = Vector3.Lerp(arg_711_1.var_.moveOldPos1047ui_story, var_714_4, var_714_3)

				local var_714_5 = manager.ui.mainCamera.transform.position - var_714_0.position

				var_714_0.forward = Vector3.New(var_714_5.x, var_714_5.y, var_714_5.z)

				local var_714_6 = var_714_0.localEulerAngles

				var_714_6.z = 0
				var_714_6.x = 0
				var_714_0.localEulerAngles = var_714_6
			end

			if arg_711_1.time_ >= var_714_1 + var_714_2 and arg_711_1.time_ < var_714_1 + var_714_2 + arg_714_0 then
				var_714_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_714_7 = manager.ui.mainCamera.transform.position - var_714_0.position

				var_714_0.forward = Vector3.New(var_714_7.x, var_714_7.y, var_714_7.z)

				local var_714_8 = var_714_0.localEulerAngles

				var_714_8.z = 0
				var_714_8.x = 0
				var_714_0.localEulerAngles = var_714_8
			end

			local var_714_9 = arg_711_1.actors_["1047ui_story"]
			local var_714_10 = 0

			if var_714_10 < arg_711_1.time_ and arg_711_1.time_ <= var_714_10 + arg_714_0 and not isNil(var_714_9) and arg_711_1.var_.characterEffect1047ui_story == nil then
				arg_711_1.var_.characterEffect1047ui_story = var_714_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_714_11 = 0.200000002980232

			if var_714_10 <= arg_711_1.time_ and arg_711_1.time_ < var_714_10 + var_714_11 and not isNil(var_714_9) then
				local var_714_12 = (arg_711_1.time_ - var_714_10) / var_714_11

				if arg_711_1.var_.characterEffect1047ui_story and not isNil(var_714_9) then
					arg_711_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_711_1.time_ >= var_714_10 + var_714_11 and arg_711_1.time_ < var_714_10 + var_714_11 + arg_714_0 and not isNil(var_714_9) and arg_711_1.var_.characterEffect1047ui_story then
				arg_711_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_714_13 = 0

			if var_714_13 < arg_711_1.time_ and arg_711_1.time_ <= var_714_13 + arg_714_0 then
				arg_711_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			local var_714_14 = 0

			if var_714_14 < arg_711_1.time_ and arg_711_1.time_ <= var_714_14 + arg_714_0 then
				arg_711_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_714_15 = 0
			local var_714_16 = 0.325

			if var_714_15 < arg_711_1.time_ and arg_711_1.time_ <= var_714_15 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				local var_714_17 = arg_711_1:FormatText(StoryNameCfg[1296].name)

				arg_711_1.leftNameTxt_.text = var_714_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_18 = arg_711_1:GetWordFromCfg(1104704172)
				local var_714_19 = arg_711_1:FormatText(var_714_18.content)

				arg_711_1.text_.text = var_714_19

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_20 = 13
				local var_714_21 = utf8.len(var_714_19)
				local var_714_22 = var_714_20 <= 0 and var_714_16 or var_714_16 * (var_714_21 / var_714_20)

				if var_714_22 > 0 and var_714_16 < var_714_22 then
					arg_711_1.talkMaxDuration = var_714_22

					if var_714_22 + var_714_15 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_22 + var_714_15
					end
				end

				arg_711_1.text_.text = var_714_19
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704172", "story_v_side_new_1104704.awb") ~= 0 then
					local var_714_23 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704172", "story_v_side_new_1104704.awb") / 1000

					if var_714_23 + var_714_15 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_23 + var_714_15
					end

					if var_714_18.prefab_name ~= "" and arg_711_1.actors_[var_714_18.prefab_name] ~= nil then
						local var_714_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_711_1.actors_[var_714_18.prefab_name].transform, "story_v_side_new_1104704", "1104704172", "story_v_side_new_1104704.awb")

						arg_711_1:RecordAudio("1104704172", var_714_24)
						arg_711_1:RecordAudio("1104704172", var_714_24)
					else
						arg_711_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704172", "story_v_side_new_1104704.awb")
					end

					arg_711_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704172", "story_v_side_new_1104704.awb")
				end

				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_25 = math.max(var_714_16, arg_711_1.talkMaxDuration)

			if var_714_15 <= arg_711_1.time_ and arg_711_1.time_ < var_714_15 + var_714_25 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_15) / var_714_25

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_15 + var_714_25 and arg_711_1.time_ < var_714_15 + var_714_25 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_711_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST22a",
		"TextureConfig/Background/ST27a",
		"TextureConfig/Background/ST84a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/R4701",
		"TextureConfig/Background/R4701a",
		"TextureConfig/Background/ST05a"
	},
	voices = {
		"story_v_side_new_1104704.awb"
	}
}
