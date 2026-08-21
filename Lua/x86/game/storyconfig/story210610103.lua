return {
	Play1106103001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1106103001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1106103002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST29"

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
				local var_4_5 = arg_1_1.bgs_.ST29

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
					if iter_4_0 ~= "ST29" then
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

			local var_4_24 = 0.2
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_4_28 = 0
			local var_4_29 = 0.433333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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
			local var_4_35 = 0.725

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

				local var_4_37 = arg_1_1:GetWordFromCfg(1106103001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 29
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
	Play1106103002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1106103002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1106103003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[7].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(1106103002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 4
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_8 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_8 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_8

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_8 and arg_8_1.time_ < var_11_0 + var_11_8 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1106103003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1106103003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1106103004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.05

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(1106103003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 42
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1106103004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1106103004
		arg_16_1.duration_ = 2.43

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1106103005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1061ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["1061ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos1061ui_story = var_19_5.localPosition

				local var_19_7 = "1061ui_story"

				arg_16_1:ShowWeapon(arg_16_1.var_[var_19_7 .. "Animator"].transform, false)
			end

			local var_19_8 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_8 then
				local var_19_9 = (arg_16_1.time_ - var_19_6) / var_19_8
				local var_19_10 = Vector3.New(0, -1.18, -6.15)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1061ui_story, var_19_10, var_19_9)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_5.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_5.localEulerAngles = var_19_12
			end

			if arg_16_1.time_ >= var_19_6 + var_19_8 and arg_16_1.time_ < var_19_6 + var_19_8 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_19_13 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_13.x, var_19_13.y, var_19_13.z)

				local var_19_14 = var_19_5.localEulerAngles

				var_19_14.z = 0
				var_19_14.x = 0
				var_19_5.localEulerAngles = var_19_14
			end

			local var_19_15 = arg_16_1.actors_["1061ui_story"]
			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 and not isNil(var_19_15) and arg_16_1.var_.characterEffect1061ui_story == nil then
				arg_16_1.var_.characterEffect1061ui_story = var_19_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_17 = 0.200000002980232

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_17 and not isNil(var_19_15) then
				local var_19_18 = (arg_16_1.time_ - var_19_16) / var_19_17

				if arg_16_1.var_.characterEffect1061ui_story and not isNil(var_19_15) then
					arg_16_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 and not isNil(var_19_15) and arg_16_1.var_.characterEffect1061ui_story then
				arg_16_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_19_19 = 0

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_19_20 = 0

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_19_21 = 0
			local var_19_22 = 0.075

			if var_19_21 < arg_16_1.time_ and arg_16_1.time_ <= var_19_21 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_23 = arg_16_1:FormatText(StoryNameCfg[612].name)

				arg_16_1.leftNameTxt_.text = var_19_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_24 = arg_16_1:GetWordFromCfg(1106103004)
				local var_19_25 = arg_16_1:FormatText(var_19_24.content)

				arg_16_1.text_.text = var_19_25

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_26 = 3
				local var_19_27 = utf8.len(var_19_25)
				local var_19_28 = var_19_26 <= 0 and var_19_22 or var_19_22 * (var_19_27 / var_19_26)

				if var_19_28 > 0 and var_19_22 < var_19_28 then
					arg_16_1.talkMaxDuration = var_19_28

					if var_19_28 + var_19_21 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_21
					end
				end

				arg_16_1.text_.text = var_19_25
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103004", "story_v_side_new_1106103.awb") ~= 0 then
					local var_19_29 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103004", "story_v_side_new_1106103.awb") / 1000

					if var_19_29 + var_19_21 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_29 + var_19_21
					end

					if var_19_24.prefab_name ~= "" and arg_16_1.actors_[var_19_24.prefab_name] ~= nil then
						local var_19_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_24.prefab_name].transform, "story_v_side_new_1106103", "1106103004", "story_v_side_new_1106103.awb")

						arg_16_1:RecordAudio("1106103004", var_19_30)
						arg_16_1:RecordAudio("1106103004", var_19_30)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103004", "story_v_side_new_1106103.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103004", "story_v_side_new_1106103.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_31 = math.max(var_19_22, arg_16_1.talkMaxDuration)

			if var_19_21 <= arg_16_1.time_ and arg_16_1.time_ < var_19_21 + var_19_31 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_21) / var_19_31

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_21 + var_19_31 and arg_16_1.time_ < var_19_21 + var_19_31 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play1106103005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1106103005
		arg_20_1.duration_ = 9

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1106103006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 2

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				local var_23_1 = manager.ui.mainCamera.transform.localPosition
				local var_23_2 = Vector3.New(0, 0, 10) + Vector3.New(var_23_1.x, var_23_1.y, 0)
				local var_23_3 = arg_20_1.bgs_.ST29

				var_23_3.transform.localPosition = var_23_2
				var_23_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_4 = var_23_3:GetComponent("SpriteRenderer")

				if var_23_4 and var_23_4.sprite then
					local var_23_5 = (var_23_3.transform.localPosition - var_23_1).z
					local var_23_6 = manager.ui.mainCameraCom_
					local var_23_7 = 2 * var_23_5 * Mathf.Tan(var_23_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_23_8 = var_23_7 * var_23_6.aspect
					local var_23_9 = var_23_4.sprite.bounds.size.x
					local var_23_10 = var_23_4.sprite.bounds.size.y
					local var_23_11 = var_23_8 / var_23_9
					local var_23_12 = var_23_7 / var_23_10
					local var_23_13 = var_23_12 < var_23_11 and var_23_11 or var_23_12

					var_23_3.transform.localScale = Vector3.New(var_23_13, var_23_13, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "ST29" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_14 = 4

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			local var_23_15 = 0.3

			if arg_20_1.time_ >= var_23_14 + var_23_15 and arg_20_1.time_ < var_23_14 + var_23_15 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_16 = 0

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_17 = 2

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_17 then
				local var_23_18 = (arg_20_1.time_ - var_23_16) / var_23_17
				local var_23_19 = Color.New(0, 0, 0)

				var_23_19.a = Mathf.Lerp(0, 1, var_23_18)
				arg_20_1.mask_.color = var_23_19
			end

			if arg_20_1.time_ >= var_23_16 + var_23_17 and arg_20_1.time_ < var_23_16 + var_23_17 + arg_23_0 then
				local var_23_20 = Color.New(0, 0, 0)

				var_23_20.a = 1
				arg_20_1.mask_.color = var_23_20
			end

			local var_23_21 = 2

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_22 = 2

			if var_23_21 <= arg_20_1.time_ and arg_20_1.time_ < var_23_21 + var_23_22 then
				local var_23_23 = (arg_20_1.time_ - var_23_21) / var_23_22
				local var_23_24 = Color.New(0, 0, 0)

				var_23_24.a = Mathf.Lerp(1, 0, var_23_23)
				arg_20_1.mask_.color = var_23_24
			end

			if arg_20_1.time_ >= var_23_21 + var_23_22 and arg_20_1.time_ < var_23_21 + var_23_22 + arg_23_0 then
				local var_23_25 = Color.New(0, 0, 0)
				local var_23_26 = 0

				arg_20_1.mask_.enabled = false
				var_23_25.a = var_23_26
				arg_20_1.mask_.color = var_23_25
			end

			local var_23_27 = arg_20_1.actors_["1061ui_story"].transform
			local var_23_28 = 1.96599999815226

			if var_23_28 < arg_20_1.time_ and arg_20_1.time_ <= var_23_28 + arg_23_0 then
				arg_20_1.var_.moveOldPos1061ui_story = var_23_27.localPosition
			end

			local var_23_29 = 0.001

			if var_23_28 <= arg_20_1.time_ and arg_20_1.time_ < var_23_28 + var_23_29 then
				local var_23_30 = (arg_20_1.time_ - var_23_28) / var_23_29
				local var_23_31 = Vector3.New(0, 100, 0)

				var_23_27.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1061ui_story, var_23_31, var_23_30)

				local var_23_32 = manager.ui.mainCamera.transform.position - var_23_27.position

				var_23_27.forward = Vector3.New(var_23_32.x, var_23_32.y, var_23_32.z)

				local var_23_33 = var_23_27.localEulerAngles

				var_23_33.z = 0
				var_23_33.x = 0
				var_23_27.localEulerAngles = var_23_33
			end

			if arg_20_1.time_ >= var_23_28 + var_23_29 and arg_20_1.time_ < var_23_28 + var_23_29 + arg_23_0 then
				var_23_27.localPosition = Vector3.New(0, 100, 0)

				local var_23_34 = manager.ui.mainCamera.transform.position - var_23_27.position

				var_23_27.forward = Vector3.New(var_23_34.x, var_23_34.y, var_23_34.z)

				local var_23_35 = var_23_27.localEulerAngles

				var_23_35.z = 0
				var_23_35.x = 0
				var_23_27.localEulerAngles = var_23_35
			end

			local var_23_36 = arg_20_1.actors_["1061ui_story"]
			local var_23_37 = 1.96599999815226

			if var_23_37 < arg_20_1.time_ and arg_20_1.time_ <= var_23_37 + arg_23_0 and not isNil(var_23_36) and arg_20_1.var_.characterEffect1061ui_story == nil then
				arg_20_1.var_.characterEffect1061ui_story = var_23_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_38 = 0.034000001847744

			if var_23_37 <= arg_20_1.time_ and arg_20_1.time_ < var_23_37 + var_23_38 and not isNil(var_23_36) then
				local var_23_39 = (arg_20_1.time_ - var_23_37) / var_23_38

				if arg_20_1.var_.characterEffect1061ui_story and not isNil(var_23_36) then
					local var_23_40 = Mathf.Lerp(0, 0.5, var_23_39)

					arg_20_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1061ui_story.fillRatio = var_23_40
				end
			end

			if arg_20_1.time_ >= var_23_37 + var_23_38 and arg_20_1.time_ < var_23_37 + var_23_38 + arg_23_0 and not isNil(var_23_36) and arg_20_1.var_.characterEffect1061ui_story then
				local var_23_41 = 0.5

				arg_20_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1061ui_story.fillRatio = var_23_41
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_42 = 4
			local var_23_43 = 1.2

			if var_23_42 < arg_20_1.time_ and arg_20_1.time_ <= var_23_42 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_44 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_44:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_45 = arg_20_1:GetWordFromCfg(1106103005)
				local var_23_46 = arg_20_1:FormatText(var_23_45.content)

				arg_20_1.text_.text = var_23_46

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_47 = 48
				local var_23_48 = utf8.len(var_23_46)
				local var_23_49 = var_23_47 <= 0 and var_23_43 or var_23_43 * (var_23_48 / var_23_47)

				if var_23_49 > 0 and var_23_43 < var_23_49 then
					arg_20_1.talkMaxDuration = var_23_49
					var_23_42 = var_23_42 + 0.3

					if var_23_49 + var_23_42 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_49 + var_23_42
					end
				end

				arg_20_1.text_.text = var_23_46
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_50 = var_23_42 + 0.3
			local var_23_51 = math.max(var_23_43, arg_20_1.talkMaxDuration)

			if var_23_50 <= arg_20_1.time_ and arg_20_1.time_ < var_23_50 + var_23_51 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_50) / var_23_51

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_50 + var_23_51 and arg_20_1.time_ < var_23_50 + var_23_51 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play1106103006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 1106103006
		arg_26_1.duration_ = 1.2

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play1106103007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 0.125

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_2 = arg_26_1:FormatText(StoryNameCfg[1353].name)

				arg_26_1.leftNameTxt_.text = var_29_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_3 = arg_26_1:GetWordFromCfg(1106103006)
				local var_29_4 = arg_26_1:FormatText(var_29_3.content)

				arg_26_1.text_.text = var_29_4

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103006", "story_v_side_new_1106103.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103006", "story_v_side_new_1106103.awb") / 1000

					if var_29_8 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_0
					end

					if var_29_3.prefab_name ~= "" and arg_26_1.actors_[var_29_3.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_3.prefab_name].transform, "story_v_side_new_1106103", "1106103006", "story_v_side_new_1106103.awb")

						arg_26_1:RecordAudio("1106103006", var_29_9)
						arg_26_1:RecordAudio("1106103006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103006", "story_v_side_new_1106103.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103006", "story_v_side_new_1106103.awb")
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
	Play1106103007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 1106103007
		arg_30_1.duration_ = 2.4

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play1106103008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1061ui_story"].transform
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.var_.moveOldPos1061ui_story = var_33_0.localPosition
			end

			local var_33_2 = 0.001

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2
				local var_33_4 = Vector3.New(0, -1.18, -6.15)

				var_33_0.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1061ui_story, var_33_4, var_33_3)

				local var_33_5 = manager.ui.mainCamera.transform.position - var_33_0.position

				var_33_0.forward = Vector3.New(var_33_5.x, var_33_5.y, var_33_5.z)

				local var_33_6 = var_33_0.localEulerAngles

				var_33_6.z = 0
				var_33_6.x = 0
				var_33_0.localEulerAngles = var_33_6
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 then
				var_33_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_33_7 = manager.ui.mainCamera.transform.position - var_33_0.position

				var_33_0.forward = Vector3.New(var_33_7.x, var_33_7.y, var_33_7.z)

				local var_33_8 = var_33_0.localEulerAngles

				var_33_8.z = 0
				var_33_8.x = 0
				var_33_0.localEulerAngles = var_33_8
			end

			local var_33_9 = arg_30_1.actors_["1061ui_story"]
			local var_33_10 = 0

			if var_33_10 < arg_30_1.time_ and arg_30_1.time_ <= var_33_10 + arg_33_0 and not isNil(var_33_9) and arg_30_1.var_.characterEffect1061ui_story == nil then
				arg_30_1.var_.characterEffect1061ui_story = var_33_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_11 = 0.200000002980232

			if var_33_10 <= arg_30_1.time_ and arg_30_1.time_ < var_33_10 + var_33_11 and not isNil(var_33_9) then
				local var_33_12 = (arg_30_1.time_ - var_33_10) / var_33_11

				if arg_30_1.var_.characterEffect1061ui_story and not isNil(var_33_9) then
					arg_30_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_10 + var_33_11 and arg_30_1.time_ < var_33_10 + var_33_11 + arg_33_0 and not isNil(var_33_9) and arg_30_1.var_.characterEffect1061ui_story then
				arg_30_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_33_13 = 0

			if var_33_13 < arg_30_1.time_ and arg_30_1.time_ <= var_33_13 + arg_33_0 then
				arg_30_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_33_14 = 0

			if var_33_14 < arg_30_1.time_ and arg_30_1.time_ <= var_33_14 + arg_33_0 then
				arg_30_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_33_15 = 0
			local var_33_16 = 0.3

			if var_33_15 < arg_30_1.time_ and arg_30_1.time_ <= var_33_15 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_17 = arg_30_1:FormatText(StoryNameCfg[612].name)

				arg_30_1.leftNameTxt_.text = var_33_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_18 = arg_30_1:GetWordFromCfg(1106103007)
				local var_33_19 = arg_30_1:FormatText(var_33_18.content)

				arg_30_1.text_.text = var_33_19

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_20 = 12
				local var_33_21 = utf8.len(var_33_19)
				local var_33_22 = var_33_20 <= 0 and var_33_16 or var_33_16 * (var_33_21 / var_33_20)

				if var_33_22 > 0 and var_33_16 < var_33_22 then
					arg_30_1.talkMaxDuration = var_33_22

					if var_33_22 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_22 + var_33_15
					end
				end

				arg_30_1.text_.text = var_33_19
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103007", "story_v_side_new_1106103.awb") ~= 0 then
					local var_33_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103007", "story_v_side_new_1106103.awb") / 1000

					if var_33_23 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_23 + var_33_15
					end

					if var_33_18.prefab_name ~= "" and arg_30_1.actors_[var_33_18.prefab_name] ~= nil then
						local var_33_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_18.prefab_name].transform, "story_v_side_new_1106103", "1106103007", "story_v_side_new_1106103.awb")

						arg_30_1:RecordAudio("1106103007", var_33_24)
						arg_30_1:RecordAudio("1106103007", var_33_24)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103007", "story_v_side_new_1106103.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103007", "story_v_side_new_1106103.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_25 = math.max(var_33_16, arg_30_1.talkMaxDuration)

			if var_33_15 <= arg_30_1.time_ and arg_30_1.time_ < var_33_15 + var_33_25 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_15) / var_33_25

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_15 + var_33_25 and arg_30_1.time_ < var_33_15 + var_33_25 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play1106103008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 1106103008
		arg_34_1.duration_ = 4.57

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play1106103009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1061ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1061ui_story == nil then
				arg_34_1.var_.characterEffect1061ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect1061ui_story and not isNil(var_37_0) then
					local var_37_4 = Mathf.Lerp(0, 0.5, var_37_3)

					arg_34_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1061ui_story.fillRatio = var_37_4
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1061ui_story then
				local var_37_5 = 0.5

				arg_34_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1061ui_story.fillRatio = var_37_5
			end

			local var_37_6 = 0
			local var_37_7 = 0.625

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_8 = arg_34_1:FormatText(StoryNameCfg[1353].name)

				arg_34_1.leftNameTxt_.text = var_37_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_9 = arg_34_1:GetWordFromCfg(1106103008)
				local var_37_10 = arg_34_1:FormatText(var_37_9.content)

				arg_34_1.text_.text = var_37_10

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_11 = 25
				local var_37_12 = utf8.len(var_37_10)
				local var_37_13 = var_37_11 <= 0 and var_37_7 or var_37_7 * (var_37_12 / var_37_11)

				if var_37_13 > 0 and var_37_7 < var_37_13 then
					arg_34_1.talkMaxDuration = var_37_13

					if var_37_13 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_13 + var_37_6
					end
				end

				arg_34_1.text_.text = var_37_10
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103008", "story_v_side_new_1106103.awb") ~= 0 then
					local var_37_14 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103008", "story_v_side_new_1106103.awb") / 1000

					if var_37_14 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_14 + var_37_6
					end

					if var_37_9.prefab_name ~= "" and arg_34_1.actors_[var_37_9.prefab_name] ~= nil then
						local var_37_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_9.prefab_name].transform, "story_v_side_new_1106103", "1106103008", "story_v_side_new_1106103.awb")

						arg_34_1:RecordAudio("1106103008", var_37_15)
						arg_34_1:RecordAudio("1106103008", var_37_15)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103008", "story_v_side_new_1106103.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103008", "story_v_side_new_1106103.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_16 = math.max(var_37_7, arg_34_1.talkMaxDuration)

			if var_37_6 <= arg_34_1.time_ and arg_34_1.time_ < var_37_6 + var_37_16 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_6) / var_37_16

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_6 + var_37_16 and arg_34_1.time_ < var_37_6 + var_37_16 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play1106103009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 1106103009
		arg_38_1.duration_ = 5.3

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play1106103010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 0.775

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_2 = arg_38_1:FormatText(StoryNameCfg[1353].name)

				arg_38_1.leftNameTxt_.text = var_41_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_3 = arg_38_1:GetWordFromCfg(1106103009)
				local var_41_4 = arg_38_1:FormatText(var_41_3.content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 30
				local var_41_6 = utf8.len(var_41_4)
				local var_41_7 = var_41_5 <= 0 and var_41_1 or var_41_1 * (var_41_6 / var_41_5)

				if var_41_7 > 0 and var_41_1 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_4
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103009", "story_v_side_new_1106103.awb") ~= 0 then
					local var_41_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103009", "story_v_side_new_1106103.awb") / 1000

					if var_41_8 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_8 + var_41_0
					end

					if var_41_3.prefab_name ~= "" and arg_38_1.actors_[var_41_3.prefab_name] ~= nil then
						local var_41_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_3.prefab_name].transform, "story_v_side_new_1106103", "1106103009", "story_v_side_new_1106103.awb")

						arg_38_1:RecordAudio("1106103009", var_41_9)
						arg_38_1:RecordAudio("1106103009", var_41_9)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103009", "story_v_side_new_1106103.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103009", "story_v_side_new_1106103.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_10 and arg_38_1.time_ < var_41_0 + var_41_10 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play1106103010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 1106103010
		arg_42_1.duration_ = 9.4

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play1106103011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0
			local var_45_1 = 1.225

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_2 = arg_42_1:FormatText(StoryNameCfg[1353].name)

				arg_42_1.leftNameTxt_.text = var_45_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_3 = arg_42_1:GetWordFromCfg(1106103010)
				local var_45_4 = arg_42_1:FormatText(var_45_3.content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 49
				local var_45_6 = utf8.len(var_45_4)
				local var_45_7 = var_45_5 <= 0 and var_45_1 or var_45_1 * (var_45_6 / var_45_5)

				if var_45_7 > 0 and var_45_1 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_0
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103010", "story_v_side_new_1106103.awb") ~= 0 then
					local var_45_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103010", "story_v_side_new_1106103.awb") / 1000

					if var_45_8 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_0
					end

					if var_45_3.prefab_name ~= "" and arg_42_1.actors_[var_45_3.prefab_name] ~= nil then
						local var_45_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_3.prefab_name].transform, "story_v_side_new_1106103", "1106103010", "story_v_side_new_1106103.awb")

						arg_42_1:RecordAudio("1106103010", var_45_9)
						arg_42_1:RecordAudio("1106103010", var_45_9)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103010", "story_v_side_new_1106103.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103010", "story_v_side_new_1106103.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_10 = math.max(var_45_1, arg_42_1.talkMaxDuration)

			if var_45_0 <= arg_42_1.time_ and arg_42_1.time_ < var_45_0 + var_45_10 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_0) / var_45_10

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_0 + var_45_10 and arg_42_1.time_ < var_45_0 + var_45_10 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play1106103011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 1106103011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play1106103012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1061ui_story"].transform
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.var_.moveOldPos1061ui_story = var_49_0.localPosition
			end

			local var_49_2 = 0.001

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2
				local var_49_4 = Vector3.New(0, 100, 0)

				var_49_0.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1061ui_story, var_49_4, var_49_3)

				local var_49_5 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_5.x, var_49_5.y, var_49_5.z)

				local var_49_6 = var_49_0.localEulerAngles

				var_49_6.z = 0
				var_49_6.x = 0
				var_49_0.localEulerAngles = var_49_6
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 then
				var_49_0.localPosition = Vector3.New(0, 100, 0)

				local var_49_7 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_7.x, var_49_7.y, var_49_7.z)

				local var_49_8 = var_49_0.localEulerAngles

				var_49_8.z = 0
				var_49_8.x = 0
				var_49_0.localEulerAngles = var_49_8
			end

			local var_49_9 = 0
			local var_49_10 = 0.525

			if var_49_9 < arg_46_1.time_ and arg_46_1.time_ <= var_49_9 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_11 = arg_46_1:GetWordFromCfg(1106103011)
				local var_49_12 = arg_46_1:FormatText(var_49_11.content)

				arg_46_1.text_.text = var_49_12

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_13 = 21
				local var_49_14 = utf8.len(var_49_12)
				local var_49_15 = var_49_13 <= 0 and var_49_10 or var_49_10 * (var_49_14 / var_49_13)

				if var_49_15 > 0 and var_49_10 < var_49_15 then
					arg_46_1.talkMaxDuration = var_49_15

					if var_49_15 + var_49_9 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_15 + var_49_9
					end
				end

				arg_46_1.text_.text = var_49_12
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_16 = math.max(var_49_10, arg_46_1.talkMaxDuration)

			if var_49_9 <= arg_46_1.time_ and arg_46_1.time_ < var_49_9 + var_49_16 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_9) / var_49_16

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_9 + var_49_16 and arg_46_1.time_ < var_49_9 + var_49_16 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play1106103012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 1106103012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play1106103013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 0.35

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_2 = arg_50_1:FormatText(StoryNameCfg[7].name)

				arg_50_1.leftNameTxt_.text = var_53_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_3 = arg_50_1:GetWordFromCfg(1106103012)
				local var_53_4 = arg_50_1:FormatText(var_53_3.content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 14
				local var_53_6 = utf8.len(var_53_4)
				local var_53_7 = var_53_5 <= 0 and var_53_1 or var_53_1 * (var_53_6 / var_53_5)

				if var_53_7 > 0 and var_53_1 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_8 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_8 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_8

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_8 and arg_50_1.time_ < var_53_0 + var_53_8 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play1106103013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 1106103013
		arg_54_1.duration_ = 5.1

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play1106103014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1061ui_story"].transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.moveOldPos1061ui_story = var_57_0.localPosition
			end

			local var_57_2 = 0.001

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2
				local var_57_4 = Vector3.New(0, -1.18, -6.15)

				var_57_0.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1061ui_story, var_57_4, var_57_3)

				local var_57_5 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_5.x, var_57_5.y, var_57_5.z)

				local var_57_6 = var_57_0.localEulerAngles

				var_57_6.z = 0
				var_57_6.x = 0
				var_57_0.localEulerAngles = var_57_6
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 then
				var_57_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_57_7 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_7.x, var_57_7.y, var_57_7.z)

				local var_57_8 = var_57_0.localEulerAngles

				var_57_8.z = 0
				var_57_8.x = 0
				var_57_0.localEulerAngles = var_57_8
			end

			local var_57_9 = arg_54_1.actors_["1061ui_story"]
			local var_57_10 = 0

			if var_57_10 < arg_54_1.time_ and arg_54_1.time_ <= var_57_10 + arg_57_0 and not isNil(var_57_9) and arg_54_1.var_.characterEffect1061ui_story == nil then
				arg_54_1.var_.characterEffect1061ui_story = var_57_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_11 = 0.200000002980232

			if var_57_10 <= arg_54_1.time_ and arg_54_1.time_ < var_57_10 + var_57_11 and not isNil(var_57_9) then
				local var_57_12 = (arg_54_1.time_ - var_57_10) / var_57_11

				if arg_54_1.var_.characterEffect1061ui_story and not isNil(var_57_9) then
					arg_54_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_10 + var_57_11 and arg_54_1.time_ < var_57_10 + var_57_11 + arg_57_0 and not isNil(var_57_9) and arg_54_1.var_.characterEffect1061ui_story then
				arg_54_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_57_13 = 0

			if var_57_13 < arg_54_1.time_ and arg_54_1.time_ <= var_57_13 + arg_57_0 then
				arg_54_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_57_14 = 0

			if var_57_14 < arg_54_1.time_ and arg_54_1.time_ <= var_57_14 + arg_57_0 then
				arg_54_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_57_15 = 0
			local var_57_16 = 0.5

			if var_57_15 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_17 = arg_54_1:FormatText(StoryNameCfg[612].name)

				arg_54_1.leftNameTxt_.text = var_57_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_18 = arg_54_1:GetWordFromCfg(1106103013)
				local var_57_19 = arg_54_1:FormatText(var_57_18.content)

				arg_54_1.text_.text = var_57_19

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_20 = 20
				local var_57_21 = utf8.len(var_57_19)
				local var_57_22 = var_57_20 <= 0 and var_57_16 or var_57_16 * (var_57_21 / var_57_20)

				if var_57_22 > 0 and var_57_16 < var_57_22 then
					arg_54_1.talkMaxDuration = var_57_22

					if var_57_22 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_22 + var_57_15
					end
				end

				arg_54_1.text_.text = var_57_19
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103013", "story_v_side_new_1106103.awb") ~= 0 then
					local var_57_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103013", "story_v_side_new_1106103.awb") / 1000

					if var_57_23 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_23 + var_57_15
					end

					if var_57_18.prefab_name ~= "" and arg_54_1.actors_[var_57_18.prefab_name] ~= nil then
						local var_57_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_18.prefab_name].transform, "story_v_side_new_1106103", "1106103013", "story_v_side_new_1106103.awb")

						arg_54_1:RecordAudio("1106103013", var_57_24)
						arg_54_1:RecordAudio("1106103013", var_57_24)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103013", "story_v_side_new_1106103.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103013", "story_v_side_new_1106103.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_25 = math.max(var_57_16, arg_54_1.talkMaxDuration)

			if var_57_15 <= arg_54_1.time_ and arg_54_1.time_ < var_57_15 + var_57_25 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_15) / var_57_25

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_15 + var_57_25 and arg_54_1.time_ < var_57_15 + var_57_25 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play1106103014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 1106103014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play1106103015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1061ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1061ui_story == nil then
				arg_58_1.var_.characterEffect1061ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect1061ui_story and not isNil(var_61_0) then
					local var_61_4 = Mathf.Lerp(0, 0.5, var_61_3)

					arg_58_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1061ui_story.fillRatio = var_61_4
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1061ui_story then
				local var_61_5 = 0.5

				arg_58_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1061ui_story.fillRatio = var_61_5
			end

			local var_61_6 = 0
			local var_61_7 = 0.5

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_8 = arg_58_1:FormatText(StoryNameCfg[7].name)

				arg_58_1.leftNameTxt_.text = var_61_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_9 = arg_58_1:GetWordFromCfg(1106103014)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 20
				local var_61_12 = utf8.len(var_61_10)
				local var_61_13 = var_61_11 <= 0 and var_61_7 or var_61_7 * (var_61_12 / var_61_11)

				if var_61_13 > 0 and var_61_7 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_10
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_14 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_14 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_14

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_14 and arg_58_1.time_ < var_61_6 + var_61_14 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play1106103015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 1106103015
		arg_62_1.duration_ = 9

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play1106103016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = "ST47"

			if arg_62_1.bgs_[var_65_0] == nil then
				local var_65_1 = Object.Instantiate(arg_62_1.paintGo_)

				var_65_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_65_0)
				var_65_1.name = var_65_0
				var_65_1.transform.parent = arg_62_1.stage_.transform
				var_65_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.bgs_[var_65_0] = var_65_1
			end

			local var_65_2 = 2

			if var_65_2 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				local var_65_3 = manager.ui.mainCamera.transform.localPosition
				local var_65_4 = Vector3.New(0, 0, 10) + Vector3.New(var_65_3.x, var_65_3.y, 0)
				local var_65_5 = arg_62_1.bgs_.ST47

				var_65_5.transform.localPosition = var_65_4
				var_65_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_65_6 = var_65_5:GetComponent("SpriteRenderer")

				if var_65_6 and var_65_6.sprite then
					local var_65_7 = (var_65_5.transform.localPosition - var_65_3).z
					local var_65_8 = manager.ui.mainCameraCom_
					local var_65_9 = 2 * var_65_7 * Mathf.Tan(var_65_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_65_10 = var_65_9 * var_65_8.aspect
					local var_65_11 = var_65_6.sprite.bounds.size.x
					local var_65_12 = var_65_6.sprite.bounds.size.y
					local var_65_13 = var_65_10 / var_65_11
					local var_65_14 = var_65_9 / var_65_12
					local var_65_15 = var_65_14 < var_65_13 and var_65_13 or var_65_14

					var_65_5.transform.localScale = Vector3.New(var_65_15, var_65_15, 0)
				end

				for iter_65_0, iter_65_1 in pairs(arg_62_1.bgs_) do
					if iter_65_0 ~= "ST47" then
						iter_65_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_65_16 = 4

			if var_65_16 < arg_62_1.time_ and arg_62_1.time_ <= var_65_16 + arg_65_0 then
				arg_62_1.allBtn_.enabled = false
			end

			local var_65_17 = 0.3

			if arg_62_1.time_ >= var_65_16 + var_65_17 and arg_62_1.time_ < var_65_16 + var_65_17 + arg_65_0 then
				arg_62_1.allBtn_.enabled = true
			end

			local var_65_18 = 0

			if var_65_18 < arg_62_1.time_ and arg_62_1.time_ <= var_65_18 + arg_65_0 then
				arg_62_1.mask_.enabled = true
				arg_62_1.mask_.raycastTarget = true

				arg_62_1:SetGaussion(false)
			end

			local var_65_19 = 2

			if var_65_18 <= arg_62_1.time_ and arg_62_1.time_ < var_65_18 + var_65_19 then
				local var_65_20 = (arg_62_1.time_ - var_65_18) / var_65_19
				local var_65_21 = Color.New(0, 0, 0)

				var_65_21.a = Mathf.Lerp(0, 1, var_65_20)
				arg_62_1.mask_.color = var_65_21
			end

			if arg_62_1.time_ >= var_65_18 + var_65_19 and arg_62_1.time_ < var_65_18 + var_65_19 + arg_65_0 then
				local var_65_22 = Color.New(0, 0, 0)

				var_65_22.a = 1
				arg_62_1.mask_.color = var_65_22
			end

			local var_65_23 = 2

			if var_65_23 < arg_62_1.time_ and arg_62_1.time_ <= var_65_23 + arg_65_0 then
				arg_62_1.mask_.enabled = true
				arg_62_1.mask_.raycastTarget = true

				arg_62_1:SetGaussion(false)
			end

			local var_65_24 = 2

			if var_65_23 <= arg_62_1.time_ and arg_62_1.time_ < var_65_23 + var_65_24 then
				local var_65_25 = (arg_62_1.time_ - var_65_23) / var_65_24
				local var_65_26 = Color.New(0, 0, 0)

				var_65_26.a = Mathf.Lerp(1, 0, var_65_25)
				arg_62_1.mask_.color = var_65_26
			end

			if arg_62_1.time_ >= var_65_23 + var_65_24 and arg_62_1.time_ < var_65_23 + var_65_24 + arg_65_0 then
				local var_65_27 = Color.New(0, 0, 0)
				local var_65_28 = 0

				arg_62_1.mask_.enabled = false
				var_65_27.a = var_65_28
				arg_62_1.mask_.color = var_65_27
			end

			local var_65_29 = arg_62_1.actors_["1061ui_story"].transform
			local var_65_30 = 1.96599999815226

			if var_65_30 < arg_62_1.time_ and arg_62_1.time_ <= var_65_30 + arg_65_0 then
				arg_62_1.var_.moveOldPos1061ui_story = var_65_29.localPosition
			end

			local var_65_31 = 0.001

			if var_65_30 <= arg_62_1.time_ and arg_62_1.time_ < var_65_30 + var_65_31 then
				local var_65_32 = (arg_62_1.time_ - var_65_30) / var_65_31
				local var_65_33 = Vector3.New(0, 100, 0)

				var_65_29.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1061ui_story, var_65_33, var_65_32)

				local var_65_34 = manager.ui.mainCamera.transform.position - var_65_29.position

				var_65_29.forward = Vector3.New(var_65_34.x, var_65_34.y, var_65_34.z)

				local var_65_35 = var_65_29.localEulerAngles

				var_65_35.z = 0
				var_65_35.x = 0
				var_65_29.localEulerAngles = var_65_35
			end

			if arg_62_1.time_ >= var_65_30 + var_65_31 and arg_62_1.time_ < var_65_30 + var_65_31 + arg_65_0 then
				var_65_29.localPosition = Vector3.New(0, 100, 0)

				local var_65_36 = manager.ui.mainCamera.transform.position - var_65_29.position

				var_65_29.forward = Vector3.New(var_65_36.x, var_65_36.y, var_65_36.z)

				local var_65_37 = var_65_29.localEulerAngles

				var_65_37.z = 0
				var_65_37.x = 0
				var_65_29.localEulerAngles = var_65_37
			end

			local var_65_38 = 1.53333333333333
			local var_65_39 = 1

			if var_65_38 < arg_62_1.time_ and arg_62_1.time_ <= var_65_38 + arg_65_0 then
				local var_65_40 = "play"
				local var_65_41 = "effect"

				arg_62_1:AudioAction(var_65_40, var_65_41, "se_story_142", "se_story_142_amb_city_street", "")
			end

			local var_65_42 = 0
			local var_65_43 = 0.433333333333333

			if var_65_42 < arg_62_1.time_ and arg_62_1.time_ <= var_65_42 + arg_65_0 then
				local var_65_44 = "play"
				local var_65_45 = "music"

				arg_62_1:AudioAction(var_65_44, var_65_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_65_46 = ""
				local var_65_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_65_47 ~= "" then
					if arg_62_1.bgmTxt_.text ~= var_65_47 and arg_62_1.bgmTxt_.text ~= "" then
						if arg_62_1.bgmTxt2_.text ~= "" then
							arg_62_1.bgmTxt_.text = arg_62_1.bgmTxt2_.text
						end

						arg_62_1.bgmTxt2_.text = var_65_47

						arg_62_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_62_1.bgmTxt_.text = var_65_47
						arg_62_1.bgmTxt2_.text = var_65_47
					end

					if arg_62_1.bgmTimer then
						arg_62_1.bgmTimer:Stop()

						arg_62_1.bgmTimer = nil
					end

					if arg_62_1.settingData.show_music_name == 1 then
						arg_62_1.musicController:SetSelectedState("show")
						arg_62_1.musicAnimator_:Play("open", 0, 0)

						if arg_62_1.settingData.music_time ~= 0 then
							arg_62_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_62_1.settingData.music_time), function()
								if arg_62_1 == nil or isNil(arg_62_1.bgmTxt_) then
									return
								end

								arg_62_1.musicController:SetSelectedState("hide")
								arg_62_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_65_48 = 0.6
			local var_65_49 = 1

			if var_65_48 < arg_62_1.time_ and arg_62_1.time_ <= var_65_48 + arg_65_0 then
				local var_65_50 = "play"
				local var_65_51 = "music"

				arg_62_1:AudioAction(var_65_50, var_65_51, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_65_52 = ""
				local var_65_53 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if var_65_53 ~= "" then
					if arg_62_1.bgmTxt_.text ~= var_65_53 and arg_62_1.bgmTxt_.text ~= "" then
						if arg_62_1.bgmTxt2_.text ~= "" then
							arg_62_1.bgmTxt_.text = arg_62_1.bgmTxt2_.text
						end

						arg_62_1.bgmTxt2_.text = var_65_53

						arg_62_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_62_1.bgmTxt_.text = var_65_53
						arg_62_1.bgmTxt2_.text = var_65_53
					end

					if arg_62_1.bgmTimer then
						arg_62_1.bgmTimer:Stop()

						arg_62_1.bgmTimer = nil
					end

					if arg_62_1.settingData.show_music_name == 1 then
						arg_62_1.musicController:SetSelectedState("show")
						arg_62_1.musicAnimator_:Play("open", 0, 0)

						if arg_62_1.settingData.music_time ~= 0 then
							arg_62_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_62_1.settingData.music_time), function()
								if arg_62_1 == nil or isNil(arg_62_1.bgmTxt_) then
									return
								end

								arg_62_1.musicController:SetSelectedState("hide")
								arg_62_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_65_54 = 0.0666666666666667
			local var_65_55 = 1

			if var_65_54 < arg_62_1.time_ and arg_62_1.time_ <= var_65_54 + arg_65_0 then
				local var_65_56 = "stop"
				local var_65_57 = "effect"

				arg_62_1:AudioAction(var_65_56, var_65_57, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_62_1.frameCnt_ <= 1 then
				arg_62_1.dialog_:SetActive(false)
			end

			local var_65_58 = 4
			local var_65_59 = 1.35

			if var_65_58 < arg_62_1.time_ and arg_62_1.time_ <= var_65_58 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				arg_62_1.dialog_:SetActive(true)

				arg_62_1.dialogCg_.alpha = 0

				local var_65_60 = LeanTween.value(arg_62_1.dialog_, 0, 1, 0.3)

				var_65_60:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_62_1.dialogCg_.alpha = arg_68_0
				end))
				var_65_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_62_1.dialog_)
					var_65_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_62_1.duration_ = arg_62_1.duration_ + 0.3

				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_61 = arg_62_1:GetWordFromCfg(1106103015)
				local var_65_62 = arg_62_1:FormatText(var_65_61.content)

				arg_62_1.text_.text = var_65_62

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_63 = 54
				local var_65_64 = utf8.len(var_65_62)
				local var_65_65 = var_65_63 <= 0 and var_65_59 or var_65_59 * (var_65_64 / var_65_63)

				if var_65_65 > 0 and var_65_59 < var_65_65 then
					arg_62_1.talkMaxDuration = var_65_65
					var_65_58 = var_65_58 + 0.3

					if var_65_65 + var_65_58 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_65 + var_65_58
					end
				end

				arg_62_1.text_.text = var_65_62
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_66 = var_65_58 + 0.3
			local var_65_67 = math.max(var_65_59, arg_62_1.talkMaxDuration)

			if var_65_66 <= arg_62_1.time_ and arg_62_1.time_ < var_65_66 + var_65_67 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_66) / var_65_67

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_66 + var_65_67 and arg_62_1.time_ < var_65_66 + var_65_67 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play1106103016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 1106103016
		arg_70_1.duration_ = 5.47

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play1106103017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.625

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[1355].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:GetWordFromCfg(1106103016)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 25
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103016", "story_v_side_new_1106103.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103016", "story_v_side_new_1106103.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_side_new_1106103", "1106103016", "story_v_side_new_1106103.awb")

						arg_70_1:RecordAudio("1106103016", var_73_9)
						arg_70_1:RecordAudio("1106103016", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103016", "story_v_side_new_1106103.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103016", "story_v_side_new_1106103.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play1106103017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 1106103017
		arg_74_1.duration_ = 1.9

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play1106103018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.175

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[1356].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(1106103017)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 7
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103017", "story_v_side_new_1106103.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103017", "story_v_side_new_1106103.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_side_new_1106103", "1106103017", "story_v_side_new_1106103.awb")

						arg_74_1:RecordAudio("1106103017", var_77_9)
						arg_74_1:RecordAudio("1106103017", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103017", "story_v_side_new_1106103.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103017", "story_v_side_new_1106103.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play1106103018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 1106103018
		arg_78_1.duration_ = 4.77

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play1106103019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.6

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[1355].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_3 = arg_78_1:GetWordFromCfg(1106103018)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 24
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103018", "story_v_side_new_1106103.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103018", "story_v_side_new_1106103.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_side_new_1106103", "1106103018", "story_v_side_new_1106103.awb")

						arg_78_1:RecordAudio("1106103018", var_81_9)
						arg_78_1:RecordAudio("1106103018", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103018", "story_v_side_new_1106103.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103018", "story_v_side_new_1106103.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play1106103019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 1106103019
		arg_82_1.duration_ = 3.1

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play1106103020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.375

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[1355].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:GetWordFromCfg(1106103019)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 15
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103019", "story_v_side_new_1106103.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103019", "story_v_side_new_1106103.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_side_new_1106103", "1106103019", "story_v_side_new_1106103.awb")

						arg_82_1:RecordAudio("1106103019", var_85_9)
						arg_82_1:RecordAudio("1106103019", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103019", "story_v_side_new_1106103.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103019", "story_v_side_new_1106103.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play1106103020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 1106103020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play1106103021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 0.8

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_2 = arg_86_1:GetWordFromCfg(1106103020)
				local var_89_3 = arg_86_1:FormatText(var_89_2.content)

				arg_86_1.text_.text = var_89_3

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 32
				local var_89_5 = utf8.len(var_89_3)
				local var_89_6 = var_89_4 <= 0 and var_89_1 or var_89_1 * (var_89_5 / var_89_4)

				if var_89_6 > 0 and var_89_1 < var_89_6 then
					arg_86_1.talkMaxDuration = var_89_6

					if var_89_6 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_6 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_3
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_7 and arg_86_1.time_ < var_89_0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play1106103021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 1106103021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play1106103022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.625

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:GetWordFromCfg(1106103021)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 25
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_8 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_8 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_8

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_8 and arg_90_1.time_ < var_93_0 + var_93_8 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play1106103022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 1106103022
		arg_94_1.duration_ = 4.6

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play1106103023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1061ui_story"].transform
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.var_.moveOldPos1061ui_story = var_97_0.localPosition
			end

			local var_97_2 = 0.001

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2
				local var_97_4 = Vector3.New(0, -1.18, -6.15)

				var_97_0.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1061ui_story, var_97_4, var_97_3)

				local var_97_5 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_5.x, var_97_5.y, var_97_5.z)

				local var_97_6 = var_97_0.localEulerAngles

				var_97_6.z = 0
				var_97_6.x = 0
				var_97_0.localEulerAngles = var_97_6
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 then
				var_97_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_97_7 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_7.x, var_97_7.y, var_97_7.z)

				local var_97_8 = var_97_0.localEulerAngles

				var_97_8.z = 0
				var_97_8.x = 0
				var_97_0.localEulerAngles = var_97_8
			end

			local var_97_9 = arg_94_1.actors_["1061ui_story"]
			local var_97_10 = 0

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 and not isNil(var_97_9) and arg_94_1.var_.characterEffect1061ui_story == nil then
				arg_94_1.var_.characterEffect1061ui_story = var_97_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_11 = 0.200000002980232

			if var_97_10 <= arg_94_1.time_ and arg_94_1.time_ < var_97_10 + var_97_11 and not isNil(var_97_9) then
				local var_97_12 = (arg_94_1.time_ - var_97_10) / var_97_11

				if arg_94_1.var_.characterEffect1061ui_story and not isNil(var_97_9) then
					arg_94_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_10 + var_97_11 and arg_94_1.time_ < var_97_10 + var_97_11 + arg_97_0 and not isNil(var_97_9) and arg_94_1.var_.characterEffect1061ui_story then
				arg_94_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_97_13 = 0

			if var_97_13 < arg_94_1.time_ and arg_94_1.time_ <= var_97_13 + arg_97_0 then
				arg_94_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action7_1")
			end

			local var_97_14 = 0

			if var_97_14 < arg_94_1.time_ and arg_94_1.time_ <= var_97_14 + arg_97_0 then
				arg_94_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_97_15 = 0
			local var_97_16 = 0.6

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_17 = arg_94_1:FormatText(StoryNameCfg[612].name)

				arg_94_1.leftNameTxt_.text = var_97_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_18 = arg_94_1:GetWordFromCfg(1106103022)
				local var_97_19 = arg_94_1:FormatText(var_97_18.content)

				arg_94_1.text_.text = var_97_19

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_20 = 24
				local var_97_21 = utf8.len(var_97_19)
				local var_97_22 = var_97_20 <= 0 and var_97_16 or var_97_16 * (var_97_21 / var_97_20)

				if var_97_22 > 0 and var_97_16 < var_97_22 then
					arg_94_1.talkMaxDuration = var_97_22

					if var_97_22 + var_97_15 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_22 + var_97_15
					end
				end

				arg_94_1.text_.text = var_97_19
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103022", "story_v_side_new_1106103.awb") ~= 0 then
					local var_97_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103022", "story_v_side_new_1106103.awb") / 1000

					if var_97_23 + var_97_15 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_23 + var_97_15
					end

					if var_97_18.prefab_name ~= "" and arg_94_1.actors_[var_97_18.prefab_name] ~= nil then
						local var_97_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_18.prefab_name].transform, "story_v_side_new_1106103", "1106103022", "story_v_side_new_1106103.awb")

						arg_94_1:RecordAudio("1106103022", var_97_24)
						arg_94_1:RecordAudio("1106103022", var_97_24)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103022", "story_v_side_new_1106103.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103022", "story_v_side_new_1106103.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_25 = math.max(var_97_16, arg_94_1.talkMaxDuration)

			if var_97_15 <= arg_94_1.time_ and arg_94_1.time_ < var_97_15 + var_97_25 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_15) / var_97_25

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_15 + var_97_25 and arg_94_1.time_ < var_97_15 + var_97_25 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play1106103023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 1106103023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play1106103024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1061ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1061ui_story == nil then
				arg_98_1.var_.characterEffect1061ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1061ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1061ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1061ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1061ui_story.fillRatio = var_101_5
			end

			local var_101_6 = 0
			local var_101_7 = 0.425

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_8 = arg_98_1:FormatText(StoryNameCfg[7].name)

				arg_98_1.leftNameTxt_.text = var_101_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_9 = arg_98_1:GetWordFromCfg(1106103023)
				local var_101_10 = arg_98_1:FormatText(var_101_9.content)

				arg_98_1.text_.text = var_101_10

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_11 = 17
				local var_101_12 = utf8.len(var_101_10)
				local var_101_13 = var_101_11 <= 0 and var_101_7 or var_101_7 * (var_101_12 / var_101_11)

				if var_101_13 > 0 and var_101_7 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_10
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_14 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_14 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_14

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_14 and arg_98_1.time_ < var_101_6 + var_101_14 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play1106103024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 1106103024
		arg_102_1.duration_ = 2.97

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play1106103025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1061ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos1061ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(0, -1.18, -6.15)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1061ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = arg_102_1.actors_["1061ui_story"]
			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 and not isNil(var_105_9) and arg_102_1.var_.characterEffect1061ui_story == nil then
				arg_102_1.var_.characterEffect1061ui_story = var_105_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_11 = 0.200000002980232

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_11 and not isNil(var_105_9) then
				local var_105_12 = (arg_102_1.time_ - var_105_10) / var_105_11

				if arg_102_1.var_.characterEffect1061ui_story and not isNil(var_105_9) then
					arg_102_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_10 + var_105_11 and arg_102_1.time_ < var_105_10 + var_105_11 + arg_105_0 and not isNil(var_105_9) and arg_102_1.var_.characterEffect1061ui_story then
				arg_102_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_105_13 = 0

			if var_105_13 < arg_102_1.time_ and arg_102_1.time_ <= var_105_13 + arg_105_0 then
				arg_102_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action7_2")
			end

			local var_105_14 = 0

			if var_105_14 < arg_102_1.time_ and arg_102_1.time_ <= var_105_14 + arg_105_0 then
				arg_102_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_105_15 = 0
			local var_105_16 = 0.3

			if var_105_15 < arg_102_1.time_ and arg_102_1.time_ <= var_105_15 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_17 = arg_102_1:FormatText(StoryNameCfg[612].name)

				arg_102_1.leftNameTxt_.text = var_105_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_18 = arg_102_1:GetWordFromCfg(1106103024)
				local var_105_19 = arg_102_1:FormatText(var_105_18.content)

				arg_102_1.text_.text = var_105_19

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_20 = 12
				local var_105_21 = utf8.len(var_105_19)
				local var_105_22 = var_105_20 <= 0 and var_105_16 or var_105_16 * (var_105_21 / var_105_20)

				if var_105_22 > 0 and var_105_16 < var_105_22 then
					arg_102_1.talkMaxDuration = var_105_22

					if var_105_22 + var_105_15 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_22 + var_105_15
					end
				end

				arg_102_1.text_.text = var_105_19
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103024", "story_v_side_new_1106103.awb") ~= 0 then
					local var_105_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103024", "story_v_side_new_1106103.awb") / 1000

					if var_105_23 + var_105_15 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_23 + var_105_15
					end

					if var_105_18.prefab_name ~= "" and arg_102_1.actors_[var_105_18.prefab_name] ~= nil then
						local var_105_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_18.prefab_name].transform, "story_v_side_new_1106103", "1106103024", "story_v_side_new_1106103.awb")

						arg_102_1:RecordAudio("1106103024", var_105_24)
						arg_102_1:RecordAudio("1106103024", var_105_24)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103024", "story_v_side_new_1106103.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103024", "story_v_side_new_1106103.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_25 = math.max(var_105_16, arg_102_1.talkMaxDuration)

			if var_105_15 <= arg_102_1.time_ and arg_102_1.time_ < var_105_15 + var_105_25 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_15) / var_105_25

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_15 + var_105_25 and arg_102_1.time_ < var_105_15 + var_105_25 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play1106103025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 1106103025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play1106103026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1061ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos1061ui_story = var_109_0.localPosition
			end

			local var_109_2 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2
				local var_109_4 = Vector3.New(0, 100, 0)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1061ui_story, var_109_4, var_109_3)

				local var_109_5 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_5.x, var_109_5.y, var_109_5.z)

				local var_109_6 = var_109_0.localEulerAngles

				var_109_6.z = 0
				var_109_6.x = 0
				var_109_0.localEulerAngles = var_109_6
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(0, 100, 0)

				local var_109_7 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_7.x, var_109_7.y, var_109_7.z)

				local var_109_8 = var_109_0.localEulerAngles

				var_109_8.z = 0
				var_109_8.x = 0
				var_109_0.localEulerAngles = var_109_8
			end

			local var_109_9 = arg_106_1.actors_["1061ui_story"]
			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1061ui_story == nil then
				arg_106_1.var_.characterEffect1061ui_story = var_109_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_11 = 0.200000002980232

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_11 and not isNil(var_109_9) then
				local var_109_12 = (arg_106_1.time_ - var_109_10) / var_109_11

				if arg_106_1.var_.characterEffect1061ui_story and not isNil(var_109_9) then
					local var_109_13 = Mathf.Lerp(0, 0.5, var_109_12)

					arg_106_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1061ui_story.fillRatio = var_109_13
				end
			end

			if arg_106_1.time_ >= var_109_10 + var_109_11 and arg_106_1.time_ < var_109_10 + var_109_11 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1061ui_story then
				local var_109_14 = 0.5

				arg_106_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1061ui_story.fillRatio = var_109_14
			end

			local var_109_15 = 0
			local var_109_16 = 0.725

			if var_109_15 < arg_106_1.time_ and arg_106_1.time_ <= var_109_15 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_17 = arg_106_1:GetWordFromCfg(1106103025)
				local var_109_18 = arg_106_1:FormatText(var_109_17.content)

				arg_106_1.text_.text = var_109_18

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_19 = 29
				local var_109_20 = utf8.len(var_109_18)
				local var_109_21 = var_109_19 <= 0 and var_109_16 or var_109_16 * (var_109_20 / var_109_19)

				if var_109_21 > 0 and var_109_16 < var_109_21 then
					arg_106_1.talkMaxDuration = var_109_21

					if var_109_21 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_21 + var_109_15
					end
				end

				arg_106_1.text_.text = var_109_18
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_22 = math.max(var_109_16, arg_106_1.talkMaxDuration)

			if var_109_15 <= arg_106_1.time_ and arg_106_1.time_ < var_109_15 + var_109_22 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_15) / var_109_22

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_15 + var_109_22 and arg_106_1.time_ < var_109_15 + var_109_22 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play1106103026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1106103026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1106103027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.925

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_2 = arg_110_1:GetWordFromCfg(1106103026)
				local var_113_3 = arg_110_1:FormatText(var_113_2.content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 37
				local var_113_5 = utf8.len(var_113_3)
				local var_113_6 = var_113_4 <= 0 and var_113_1 or var_113_1 * (var_113_5 / var_113_4)

				if var_113_6 > 0 and var_113_1 < var_113_6 then
					arg_110_1.talkMaxDuration = var_113_6

					if var_113_6 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_6 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_7 and arg_110_1.time_ < var_113_0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play1106103027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1106103027
		arg_114_1.duration_ = 1.27

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play1106103028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1061ui_story"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos1061ui_story = var_117_0.localPosition
			end

			local var_117_2 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2
				local var_117_4 = Vector3.New(0, -1.18, -6.15)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1061ui_story, var_117_4, var_117_3)

				local var_117_5 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_5.x, var_117_5.y, var_117_5.z)

				local var_117_6 = var_117_0.localEulerAngles

				var_117_6.z = 0
				var_117_6.x = 0
				var_117_0.localEulerAngles = var_117_6
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_117_7 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_7.x, var_117_7.y, var_117_7.z)

				local var_117_8 = var_117_0.localEulerAngles

				var_117_8.z = 0
				var_117_8.x = 0
				var_117_0.localEulerAngles = var_117_8
			end

			local var_117_9 = arg_114_1.actors_["1061ui_story"]
			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 and not isNil(var_117_9) and arg_114_1.var_.characterEffect1061ui_story == nil then
				arg_114_1.var_.characterEffect1061ui_story = var_117_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_11 = 0.200000002980232

			if var_117_10 <= arg_114_1.time_ and arg_114_1.time_ < var_117_10 + var_117_11 and not isNil(var_117_9) then
				local var_117_12 = (arg_114_1.time_ - var_117_10) / var_117_11

				if arg_114_1.var_.characterEffect1061ui_story and not isNil(var_117_9) then
					arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_10 + var_117_11 and arg_114_1.time_ < var_117_10 + var_117_11 + arg_117_0 and not isNil(var_117_9) and arg_114_1.var_.characterEffect1061ui_story then
				arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_117_13 = 0

			if var_117_13 < arg_114_1.time_ and arg_114_1.time_ <= var_117_13 + arg_117_0 then
				arg_114_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_117_14 = 0

			if var_117_14 < arg_114_1.time_ and arg_114_1.time_ <= var_117_14 + arg_117_0 then
				arg_114_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_117_15 = 0
			local var_117_16 = 0.125

			if var_117_15 < arg_114_1.time_ and arg_114_1.time_ <= var_117_15 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_17 = arg_114_1:FormatText(StoryNameCfg[612].name)

				arg_114_1.leftNameTxt_.text = var_117_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_18 = arg_114_1:GetWordFromCfg(1106103027)
				local var_117_19 = arg_114_1:FormatText(var_117_18.content)

				arg_114_1.text_.text = var_117_19

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_20 = 5
				local var_117_21 = utf8.len(var_117_19)
				local var_117_22 = var_117_20 <= 0 and var_117_16 or var_117_16 * (var_117_21 / var_117_20)

				if var_117_22 > 0 and var_117_16 < var_117_22 then
					arg_114_1.talkMaxDuration = var_117_22

					if var_117_22 + var_117_15 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_22 + var_117_15
					end
				end

				arg_114_1.text_.text = var_117_19
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103027", "story_v_side_new_1106103.awb") ~= 0 then
					local var_117_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103027", "story_v_side_new_1106103.awb") / 1000

					if var_117_23 + var_117_15 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_23 + var_117_15
					end

					if var_117_18.prefab_name ~= "" and arg_114_1.actors_[var_117_18.prefab_name] ~= nil then
						local var_117_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_18.prefab_name].transform, "story_v_side_new_1106103", "1106103027", "story_v_side_new_1106103.awb")

						arg_114_1:RecordAudio("1106103027", var_117_24)
						arg_114_1:RecordAudio("1106103027", var_117_24)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103027", "story_v_side_new_1106103.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103027", "story_v_side_new_1106103.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_25 = math.max(var_117_16, arg_114_1.talkMaxDuration)

			if var_117_15 <= arg_114_1.time_ and arg_114_1.time_ < var_117_15 + var_117_25 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_15) / var_117_25

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_15 + var_117_25 and arg_114_1.time_ < var_117_15 + var_117_25 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play1106103028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1106103028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1106103029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1061ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1061ui_story == nil then
				arg_118_1.var_.characterEffect1061ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1061ui_story and not isNil(var_121_0) then
					local var_121_4 = Mathf.Lerp(0, 0.5, var_121_3)

					arg_118_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1061ui_story.fillRatio = var_121_4
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1061ui_story then
				local var_121_5 = 0.5

				arg_118_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1061ui_story.fillRatio = var_121_5
			end

			local var_121_6 = 0
			local var_121_7 = 0.425

			if var_121_6 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_8 = arg_118_1:FormatText(StoryNameCfg[7].name)

				arg_118_1.leftNameTxt_.text = var_121_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_9 = arg_118_1:GetWordFromCfg(1106103028)
				local var_121_10 = arg_118_1:FormatText(var_121_9.content)

				arg_118_1.text_.text = var_121_10

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 17
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
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_14 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_14 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_14

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_14 and arg_118_1.time_ < var_121_6 + var_121_14 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play1106103029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1106103029
		arg_122_1.duration_ = 3.23

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1106103030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1061ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos1061ui_story = var_125_0.localPosition
			end

			local var_125_2 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2
				local var_125_4 = Vector3.New(0, -1.18, -6.15)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1061ui_story, var_125_4, var_125_3)

				local var_125_5 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_5.x, var_125_5.y, var_125_5.z)

				local var_125_6 = var_125_0.localEulerAngles

				var_125_6.z = 0
				var_125_6.x = 0
				var_125_0.localEulerAngles = var_125_6
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_125_7 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_7.x, var_125_7.y, var_125_7.z)

				local var_125_8 = var_125_0.localEulerAngles

				var_125_8.z = 0
				var_125_8.x = 0
				var_125_0.localEulerAngles = var_125_8
			end

			local var_125_9 = arg_122_1.actors_["1061ui_story"]
			local var_125_10 = 0

			if var_125_10 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 and not isNil(var_125_9) and arg_122_1.var_.characterEffect1061ui_story == nil then
				arg_122_1.var_.characterEffect1061ui_story = var_125_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_11 = 0.200000002980232

			if var_125_10 <= arg_122_1.time_ and arg_122_1.time_ < var_125_10 + var_125_11 and not isNil(var_125_9) then
				local var_125_12 = (arg_122_1.time_ - var_125_10) / var_125_11

				if arg_122_1.var_.characterEffect1061ui_story and not isNil(var_125_9) then
					arg_122_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_10 + var_125_11 and arg_122_1.time_ < var_125_10 + var_125_11 + arg_125_0 and not isNil(var_125_9) and arg_122_1.var_.characterEffect1061ui_story then
				arg_122_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_125_13 = 0

			if var_125_13 < arg_122_1.time_ and arg_122_1.time_ <= var_125_13 + arg_125_0 then
				arg_122_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_125_14 = 0

			if var_125_14 < arg_122_1.time_ and arg_122_1.time_ <= var_125_14 + arg_125_0 then
				arg_122_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_125_15 = 0
			local var_125_16 = 0.4

			if var_125_15 < arg_122_1.time_ and arg_122_1.time_ <= var_125_15 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_17 = arg_122_1:FormatText(StoryNameCfg[612].name)

				arg_122_1.leftNameTxt_.text = var_125_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_18 = arg_122_1:GetWordFromCfg(1106103029)
				local var_125_19 = arg_122_1:FormatText(var_125_18.content)

				arg_122_1.text_.text = var_125_19

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_20 = 16
				local var_125_21 = utf8.len(var_125_19)
				local var_125_22 = var_125_20 <= 0 and var_125_16 or var_125_16 * (var_125_21 / var_125_20)

				if var_125_22 > 0 and var_125_16 < var_125_22 then
					arg_122_1.talkMaxDuration = var_125_22

					if var_125_22 + var_125_15 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_22 + var_125_15
					end
				end

				arg_122_1.text_.text = var_125_19
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103029", "story_v_side_new_1106103.awb") ~= 0 then
					local var_125_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103029", "story_v_side_new_1106103.awb") / 1000

					if var_125_23 + var_125_15 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_23 + var_125_15
					end

					if var_125_18.prefab_name ~= "" and arg_122_1.actors_[var_125_18.prefab_name] ~= nil then
						local var_125_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_18.prefab_name].transform, "story_v_side_new_1106103", "1106103029", "story_v_side_new_1106103.awb")

						arg_122_1:RecordAudio("1106103029", var_125_24)
						arg_122_1:RecordAudio("1106103029", var_125_24)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103029", "story_v_side_new_1106103.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103029", "story_v_side_new_1106103.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_25 = math.max(var_125_16, arg_122_1.talkMaxDuration)

			if var_125_15 <= arg_122_1.time_ and arg_122_1.time_ < var_125_15 + var_125_25 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_15) / var_125_25

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_15 + var_125_25 and arg_122_1.time_ < var_125_15 + var_125_25 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play1106103030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1106103030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1106103031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1061ui_story"].transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.moveOldPos1061ui_story = var_129_0.localPosition
			end

			local var_129_2 = 0.001

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2
				local var_129_4 = Vector3.New(0, 100, 0)

				var_129_0.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1061ui_story, var_129_4, var_129_3)

				local var_129_5 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_5.x, var_129_5.y, var_129_5.z)

				local var_129_6 = var_129_0.localEulerAngles

				var_129_6.z = 0
				var_129_6.x = 0
				var_129_0.localEulerAngles = var_129_6
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 then
				var_129_0.localPosition = Vector3.New(0, 100, 0)

				local var_129_7 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_7.x, var_129_7.y, var_129_7.z)

				local var_129_8 = var_129_0.localEulerAngles

				var_129_8.z = 0
				var_129_8.x = 0
				var_129_0.localEulerAngles = var_129_8
			end

			local var_129_9 = arg_126_1.actors_["1061ui_story"]
			local var_129_10 = 0

			if var_129_10 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 and not isNil(var_129_9) and arg_126_1.var_.characterEffect1061ui_story == nil then
				arg_126_1.var_.characterEffect1061ui_story = var_129_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_11 = 0.200000002980232

			if var_129_10 <= arg_126_1.time_ and arg_126_1.time_ < var_129_10 + var_129_11 and not isNil(var_129_9) then
				local var_129_12 = (arg_126_1.time_ - var_129_10) / var_129_11

				if arg_126_1.var_.characterEffect1061ui_story and not isNil(var_129_9) then
					local var_129_13 = Mathf.Lerp(0, 0.5, var_129_12)

					arg_126_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1061ui_story.fillRatio = var_129_13
				end
			end

			if arg_126_1.time_ >= var_129_10 + var_129_11 and arg_126_1.time_ < var_129_10 + var_129_11 + arg_129_0 and not isNil(var_129_9) and arg_126_1.var_.characterEffect1061ui_story then
				local var_129_14 = 0.5

				arg_126_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1061ui_story.fillRatio = var_129_14
			end

			local var_129_15 = 0
			local var_129_16 = 1.15

			if var_129_15 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_17 = arg_126_1:GetWordFromCfg(1106103030)
				local var_129_18 = arg_126_1:FormatText(var_129_17.content)

				arg_126_1.text_.text = var_129_18

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_19 = 46
				local var_129_20 = utf8.len(var_129_18)
				local var_129_21 = var_129_19 <= 0 and var_129_16 or var_129_16 * (var_129_20 / var_129_19)

				if var_129_21 > 0 and var_129_16 < var_129_21 then
					arg_126_1.talkMaxDuration = var_129_21

					if var_129_21 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_21 + var_129_15
					end
				end

				arg_126_1.text_.text = var_129_18
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_22 = math.max(var_129_16, arg_126_1.talkMaxDuration)

			if var_129_15 <= arg_126_1.time_ and arg_126_1.time_ < var_129_15 + var_129_22 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_15) / var_129_22

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_15 + var_129_22 and arg_126_1.time_ < var_129_15 + var_129_22 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play1106103031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 1106103031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play1106103032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.525

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(1106103031)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 21
				local var_133_5 = utf8.len(var_133_3)
				local var_133_6 = var_133_4 <= 0 and var_133_1 or var_133_1 * (var_133_5 / var_133_4)

				if var_133_6 > 0 and var_133_1 < var_133_6 then
					arg_130_1.talkMaxDuration = var_133_6

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_7 and arg_130_1.time_ < var_133_0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play1106103032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1106103032
		arg_134_1.duration_ = 2

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1106103033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1061ui_story"].transform
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.var_.moveOldPos1061ui_story = var_137_0.localPosition
			end

			local var_137_2 = 0.001

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2
				local var_137_4 = Vector3.New(0, -1.18, -6.15)

				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1061ui_story, var_137_4, var_137_3)

				local var_137_5 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_5.x, var_137_5.y, var_137_5.z)

				local var_137_6 = var_137_0.localEulerAngles

				var_137_6.z = 0
				var_137_6.x = 0
				var_137_0.localEulerAngles = var_137_6
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_137_7 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_7.x, var_137_7.y, var_137_7.z)

				local var_137_8 = var_137_0.localEulerAngles

				var_137_8.z = 0
				var_137_8.x = 0
				var_137_0.localEulerAngles = var_137_8
			end

			local var_137_9 = arg_134_1.actors_["1061ui_story"]
			local var_137_10 = 0

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 and not isNil(var_137_9) and arg_134_1.var_.characterEffect1061ui_story == nil then
				arg_134_1.var_.characterEffect1061ui_story = var_137_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_11 = 0.200000002980232

			if var_137_10 <= arg_134_1.time_ and arg_134_1.time_ < var_137_10 + var_137_11 and not isNil(var_137_9) then
				local var_137_12 = (arg_134_1.time_ - var_137_10) / var_137_11

				if arg_134_1.var_.characterEffect1061ui_story and not isNil(var_137_9) then
					arg_134_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_10 + var_137_11 and arg_134_1.time_ < var_137_10 + var_137_11 + arg_137_0 and not isNil(var_137_9) and arg_134_1.var_.characterEffect1061ui_story then
				arg_134_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_137_13 = 0

			if var_137_13 < arg_134_1.time_ and arg_134_1.time_ <= var_137_13 + arg_137_0 then
				arg_134_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_137_14 = 0

			if var_137_14 < arg_134_1.time_ and arg_134_1.time_ <= var_137_14 + arg_137_0 then
				arg_134_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_137_15 = 0
			local var_137_16 = 0.15

			if var_137_15 < arg_134_1.time_ and arg_134_1.time_ <= var_137_15 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_17 = arg_134_1:FormatText(StoryNameCfg[612].name)

				arg_134_1.leftNameTxt_.text = var_137_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_18 = arg_134_1:GetWordFromCfg(1106103032)
				local var_137_19 = arg_134_1:FormatText(var_137_18.content)

				arg_134_1.text_.text = var_137_19

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_20 = 6
				local var_137_21 = utf8.len(var_137_19)
				local var_137_22 = var_137_20 <= 0 and var_137_16 or var_137_16 * (var_137_21 / var_137_20)

				if var_137_22 > 0 and var_137_16 < var_137_22 then
					arg_134_1.talkMaxDuration = var_137_22

					if var_137_22 + var_137_15 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_22 + var_137_15
					end
				end

				arg_134_1.text_.text = var_137_19
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103032", "story_v_side_new_1106103.awb") ~= 0 then
					local var_137_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103032", "story_v_side_new_1106103.awb") / 1000

					if var_137_23 + var_137_15 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_23 + var_137_15
					end

					if var_137_18.prefab_name ~= "" and arg_134_1.actors_[var_137_18.prefab_name] ~= nil then
						local var_137_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_18.prefab_name].transform, "story_v_side_new_1106103", "1106103032", "story_v_side_new_1106103.awb")

						arg_134_1:RecordAudio("1106103032", var_137_24)
						arg_134_1:RecordAudio("1106103032", var_137_24)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103032", "story_v_side_new_1106103.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103032", "story_v_side_new_1106103.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_25 = math.max(var_137_16, arg_134_1.talkMaxDuration)

			if var_137_15 <= arg_134_1.time_ and arg_134_1.time_ < var_137_15 + var_137_25 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_15) / var_137_25

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_15 + var_137_25 and arg_134_1.time_ < var_137_15 + var_137_25 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play1106103033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1106103033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1106103034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1061ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1061ui_story == nil then
				arg_138_1.var_.characterEffect1061ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1061ui_story and not isNil(var_141_0) then
					local var_141_4 = Mathf.Lerp(0, 0.5, var_141_3)

					arg_138_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1061ui_story.fillRatio = var_141_4
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1061ui_story then
				local var_141_5 = 0.5

				arg_138_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1061ui_story.fillRatio = var_141_5
			end

			local var_141_6 = 0
			local var_141_7 = 0.125

			if var_141_6 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_8 = arg_138_1:FormatText(StoryNameCfg[7].name)

				arg_138_1.leftNameTxt_.text = var_141_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_9 = arg_138_1:GetWordFromCfg(1106103033)
				local var_141_10 = arg_138_1:FormatText(var_141_9.content)

				arg_138_1.text_.text = var_141_10

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 5
				local var_141_12 = utf8.len(var_141_10)
				local var_141_13 = var_141_11 <= 0 and var_141_7 or var_141_7 * (var_141_12 / var_141_11)

				if var_141_13 > 0 and var_141_7 < var_141_13 then
					arg_138_1.talkMaxDuration = var_141_13

					if var_141_13 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_13 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_10
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_14 = math.max(var_141_7, arg_138_1.talkMaxDuration)

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_14 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_6) / var_141_14

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_6 + var_141_14 and arg_138_1.time_ < var_141_6 + var_141_14 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play1106103034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1106103034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1106103035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.875

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[7].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(1106103034)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 35
				local var_145_6 = utf8.len(var_145_4)
				local var_145_7 = var_145_5 <= 0 and var_145_1 or var_145_1 * (var_145_6 / var_145_5)

				if var_145_7 > 0 and var_145_1 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_4
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_8 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_8 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_8

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_8 and arg_142_1.time_ < var_145_0 + var_145_8 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play1106103035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1106103035
		arg_146_1.duration_ = 3.53

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1106103036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1061ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos1061ui_story = var_149_0.localPosition
			end

			local var_149_2 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2
				local var_149_4 = Vector3.New(0, -1.18, -6.15)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1061ui_story, var_149_4, var_149_3)

				local var_149_5 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_5.x, var_149_5.y, var_149_5.z)

				local var_149_6 = var_149_0.localEulerAngles

				var_149_6.z = 0
				var_149_6.x = 0
				var_149_0.localEulerAngles = var_149_6
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_149_7 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_7.x, var_149_7.y, var_149_7.z)

				local var_149_8 = var_149_0.localEulerAngles

				var_149_8.z = 0
				var_149_8.x = 0
				var_149_0.localEulerAngles = var_149_8
			end

			local var_149_9 = arg_146_1.actors_["1061ui_story"]
			local var_149_10 = 0

			if var_149_10 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 and not isNil(var_149_9) and arg_146_1.var_.characterEffect1061ui_story == nil then
				arg_146_1.var_.characterEffect1061ui_story = var_149_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_11 = 0.200000002980232

			if var_149_10 <= arg_146_1.time_ and arg_146_1.time_ < var_149_10 + var_149_11 and not isNil(var_149_9) then
				local var_149_12 = (arg_146_1.time_ - var_149_10) / var_149_11

				if arg_146_1.var_.characterEffect1061ui_story and not isNil(var_149_9) then
					arg_146_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_10 + var_149_11 and arg_146_1.time_ < var_149_10 + var_149_11 + arg_149_0 and not isNil(var_149_9) and arg_146_1.var_.characterEffect1061ui_story then
				arg_146_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_149_13 = 0

			if var_149_13 < arg_146_1.time_ and arg_146_1.time_ <= var_149_13 + arg_149_0 then
				arg_146_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			local var_149_14 = 0

			if var_149_14 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 then
				arg_146_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_149_15 = 0
			local var_149_16 = 0.425

			if var_149_15 < arg_146_1.time_ and arg_146_1.time_ <= var_149_15 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_17 = arg_146_1:FormatText(StoryNameCfg[612].name)

				arg_146_1.leftNameTxt_.text = var_149_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_18 = arg_146_1:GetWordFromCfg(1106103035)
				local var_149_19 = arg_146_1:FormatText(var_149_18.content)

				arg_146_1.text_.text = var_149_19

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_20 = 17
				local var_149_21 = utf8.len(var_149_19)
				local var_149_22 = var_149_20 <= 0 and var_149_16 or var_149_16 * (var_149_21 / var_149_20)

				if var_149_22 > 0 and var_149_16 < var_149_22 then
					arg_146_1.talkMaxDuration = var_149_22

					if var_149_22 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_22 + var_149_15
					end
				end

				arg_146_1.text_.text = var_149_19
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103035", "story_v_side_new_1106103.awb") ~= 0 then
					local var_149_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103035", "story_v_side_new_1106103.awb") / 1000

					if var_149_23 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_23 + var_149_15
					end

					if var_149_18.prefab_name ~= "" and arg_146_1.actors_[var_149_18.prefab_name] ~= nil then
						local var_149_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_18.prefab_name].transform, "story_v_side_new_1106103", "1106103035", "story_v_side_new_1106103.awb")

						arg_146_1:RecordAudio("1106103035", var_149_24)
						arg_146_1:RecordAudio("1106103035", var_149_24)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103035", "story_v_side_new_1106103.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103035", "story_v_side_new_1106103.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_25 = math.max(var_149_16, arg_146_1.talkMaxDuration)

			if var_149_15 <= arg_146_1.time_ and arg_146_1.time_ < var_149_15 + var_149_25 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_15) / var_149_25

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_15 + var_149_25 and arg_146_1.time_ < var_149_15 + var_149_25 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play1106103036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1106103036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play1106103037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1061ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1061ui_story == nil then
				arg_150_1.var_.characterEffect1061ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect1061ui_story and not isNil(var_153_0) then
					local var_153_4 = Mathf.Lerp(0, 0.5, var_153_3)

					arg_150_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1061ui_story.fillRatio = var_153_4
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1061ui_story then
				local var_153_5 = 0.5

				arg_150_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1061ui_story.fillRatio = var_153_5
			end

			local var_153_6 = 0
			local var_153_7 = 0.5

			if var_153_6 < arg_150_1.time_ and arg_150_1.time_ <= var_153_6 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_8 = arg_150_1:FormatText(StoryNameCfg[7].name)

				arg_150_1.leftNameTxt_.text = var_153_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_9 = arg_150_1:GetWordFromCfg(1106103036)
				local var_153_10 = arg_150_1:FormatText(var_153_9.content)

				arg_150_1.text_.text = var_153_10

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_11 = 20
				local var_153_12 = utf8.len(var_153_10)
				local var_153_13 = var_153_11 <= 0 and var_153_7 or var_153_7 * (var_153_12 / var_153_11)

				if var_153_13 > 0 and var_153_7 < var_153_13 then
					arg_150_1.talkMaxDuration = var_153_13

					if var_153_13 + var_153_6 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_13 + var_153_6
					end
				end

				arg_150_1.text_.text = var_153_10
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_14 = math.max(var_153_7, arg_150_1.talkMaxDuration)

			if var_153_6 <= arg_150_1.time_ and arg_150_1.time_ < var_153_6 + var_153_14 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_6) / var_153_14

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_6 + var_153_14 and arg_150_1.time_ < var_153_6 + var_153_14 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play1106103037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1106103037
		arg_154_1.duration_ = 2.9

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play1106103038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1061ui_story"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos1061ui_story = var_157_0.localPosition
			end

			local var_157_2 = 0.001

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2
				local var_157_4 = Vector3.New(0, -1.18, -6.15)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1061ui_story, var_157_4, var_157_3)

				local var_157_5 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_5.x, var_157_5.y, var_157_5.z)

				local var_157_6 = var_157_0.localEulerAngles

				var_157_6.z = 0
				var_157_6.x = 0
				var_157_0.localEulerAngles = var_157_6
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_157_7 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_7.x, var_157_7.y, var_157_7.z)

				local var_157_8 = var_157_0.localEulerAngles

				var_157_8.z = 0
				var_157_8.x = 0
				var_157_0.localEulerAngles = var_157_8
			end

			local var_157_9 = arg_154_1.actors_["1061ui_story"]
			local var_157_10 = 0

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect1061ui_story == nil then
				arg_154_1.var_.characterEffect1061ui_story = var_157_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_11 = 0.200000002980232

			if var_157_10 <= arg_154_1.time_ and arg_154_1.time_ < var_157_10 + var_157_11 and not isNil(var_157_9) then
				local var_157_12 = (arg_154_1.time_ - var_157_10) / var_157_11

				if arg_154_1.var_.characterEffect1061ui_story and not isNil(var_157_9) then
					arg_154_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_10 + var_157_11 and arg_154_1.time_ < var_157_10 + var_157_11 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect1061ui_story then
				arg_154_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_157_13 = 0

			if var_157_13 < arg_154_1.time_ and arg_154_1.time_ <= var_157_13 + arg_157_0 then
				arg_154_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action452")
			end

			local var_157_14 = 0

			if var_157_14 < arg_154_1.time_ and arg_154_1.time_ <= var_157_14 + arg_157_0 then
				arg_154_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_157_15 = 0
			local var_157_16 = 0.3

			if var_157_15 < arg_154_1.time_ and arg_154_1.time_ <= var_157_15 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_17 = arg_154_1:FormatText(StoryNameCfg[612].name)

				arg_154_1.leftNameTxt_.text = var_157_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_18 = arg_154_1:GetWordFromCfg(1106103037)
				local var_157_19 = arg_154_1:FormatText(var_157_18.content)

				arg_154_1.text_.text = var_157_19

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_20 = 12
				local var_157_21 = utf8.len(var_157_19)
				local var_157_22 = var_157_20 <= 0 and var_157_16 or var_157_16 * (var_157_21 / var_157_20)

				if var_157_22 > 0 and var_157_16 < var_157_22 then
					arg_154_1.talkMaxDuration = var_157_22

					if var_157_22 + var_157_15 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_22 + var_157_15
					end
				end

				arg_154_1.text_.text = var_157_19
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103037", "story_v_side_new_1106103.awb") ~= 0 then
					local var_157_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103037", "story_v_side_new_1106103.awb") / 1000

					if var_157_23 + var_157_15 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_23 + var_157_15
					end

					if var_157_18.prefab_name ~= "" and arg_154_1.actors_[var_157_18.prefab_name] ~= nil then
						local var_157_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_18.prefab_name].transform, "story_v_side_new_1106103", "1106103037", "story_v_side_new_1106103.awb")

						arg_154_1:RecordAudio("1106103037", var_157_24)
						arg_154_1:RecordAudio("1106103037", var_157_24)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103037", "story_v_side_new_1106103.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103037", "story_v_side_new_1106103.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_25 = math.max(var_157_16, arg_154_1.talkMaxDuration)

			if var_157_15 <= arg_154_1.time_ and arg_154_1.time_ < var_157_15 + var_157_25 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_15) / var_157_25

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_15 + var_157_25 and arg_154_1.time_ < var_157_15 + var_157_25 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play1106103038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1106103038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1106103039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1061ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1061ui_story == nil then
				arg_158_1.var_.characterEffect1061ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect1061ui_story and not isNil(var_161_0) then
					local var_161_4 = Mathf.Lerp(0, 0.5, var_161_3)

					arg_158_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1061ui_story.fillRatio = var_161_4
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1061ui_story then
				local var_161_5 = 0.5

				arg_158_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1061ui_story.fillRatio = var_161_5
			end

			local var_161_6 = 0
			local var_161_7 = 0.375

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_8 = arg_158_1:FormatText(StoryNameCfg[7].name)

				arg_158_1.leftNameTxt_.text = var_161_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_9 = arg_158_1:GetWordFromCfg(1106103038)
				local var_161_10 = arg_158_1:FormatText(var_161_9.content)

				arg_158_1.text_.text = var_161_10

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_11 = 15
				local var_161_12 = utf8.len(var_161_10)
				local var_161_13 = var_161_11 <= 0 and var_161_7 or var_161_7 * (var_161_12 / var_161_11)

				if var_161_13 > 0 and var_161_7 < var_161_13 then
					arg_158_1.talkMaxDuration = var_161_13

					if var_161_13 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_13 + var_161_6
					end
				end

				arg_158_1.text_.text = var_161_10
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_14 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_14 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_14

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_14 and arg_158_1.time_ < var_161_6 + var_161_14 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play1106103039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1106103039
		arg_162_1.duration_ = 2.67

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1106103040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1061ui_story"].transform
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.var_.moveOldPos1061ui_story = var_165_0.localPosition
			end

			local var_165_2 = 0.001

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2
				local var_165_4 = Vector3.New(0, -1.18, -6.15)

				var_165_0.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1061ui_story, var_165_4, var_165_3)

				local var_165_5 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_5.x, var_165_5.y, var_165_5.z)

				local var_165_6 = var_165_0.localEulerAngles

				var_165_6.z = 0
				var_165_6.x = 0
				var_165_0.localEulerAngles = var_165_6
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 then
				var_165_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_165_7 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_7.x, var_165_7.y, var_165_7.z)

				local var_165_8 = var_165_0.localEulerAngles

				var_165_8.z = 0
				var_165_8.x = 0
				var_165_0.localEulerAngles = var_165_8
			end

			local var_165_9 = arg_162_1.actors_["1061ui_story"]
			local var_165_10 = 0

			if var_165_10 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 and not isNil(var_165_9) and arg_162_1.var_.characterEffect1061ui_story == nil then
				arg_162_1.var_.characterEffect1061ui_story = var_165_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_11 = 0.200000002980232

			if var_165_10 <= arg_162_1.time_ and arg_162_1.time_ < var_165_10 + var_165_11 and not isNil(var_165_9) then
				local var_165_12 = (arg_162_1.time_ - var_165_10) / var_165_11

				if arg_162_1.var_.characterEffect1061ui_story and not isNil(var_165_9) then
					arg_162_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_10 + var_165_11 and arg_162_1.time_ < var_165_10 + var_165_11 + arg_165_0 and not isNil(var_165_9) and arg_162_1.var_.characterEffect1061ui_story then
				arg_162_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_165_13 = 0

			if var_165_13 < arg_162_1.time_ and arg_162_1.time_ <= var_165_13 + arg_165_0 then
				arg_162_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			local var_165_14 = 0

			if var_165_14 < arg_162_1.time_ and arg_162_1.time_ <= var_165_14 + arg_165_0 then
				arg_162_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_165_15 = 0
			local var_165_16 = 0.3

			if var_165_15 < arg_162_1.time_ and arg_162_1.time_ <= var_165_15 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_17 = arg_162_1:FormatText(StoryNameCfg[612].name)

				arg_162_1.leftNameTxt_.text = var_165_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_18 = arg_162_1:GetWordFromCfg(1106103039)
				local var_165_19 = arg_162_1:FormatText(var_165_18.content)

				arg_162_1.text_.text = var_165_19

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_20 = 12
				local var_165_21 = utf8.len(var_165_19)
				local var_165_22 = var_165_20 <= 0 and var_165_16 or var_165_16 * (var_165_21 / var_165_20)

				if var_165_22 > 0 and var_165_16 < var_165_22 then
					arg_162_1.talkMaxDuration = var_165_22

					if var_165_22 + var_165_15 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_22 + var_165_15
					end
				end

				arg_162_1.text_.text = var_165_19
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103039", "story_v_side_new_1106103.awb") ~= 0 then
					local var_165_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103039", "story_v_side_new_1106103.awb") / 1000

					if var_165_23 + var_165_15 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_23 + var_165_15
					end

					if var_165_18.prefab_name ~= "" and arg_162_1.actors_[var_165_18.prefab_name] ~= nil then
						local var_165_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_18.prefab_name].transform, "story_v_side_new_1106103", "1106103039", "story_v_side_new_1106103.awb")

						arg_162_1:RecordAudio("1106103039", var_165_24)
						arg_162_1:RecordAudio("1106103039", var_165_24)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103039", "story_v_side_new_1106103.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103039", "story_v_side_new_1106103.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_25 = math.max(var_165_16, arg_162_1.talkMaxDuration)

			if var_165_15 <= arg_162_1.time_ and arg_162_1.time_ < var_165_15 + var_165_25 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_15) / var_165_25

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_15 + var_165_25 and arg_162_1.time_ < var_165_15 + var_165_25 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play1106103040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1106103040
		arg_166_1.duration_ = 9

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play1106103041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 2

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				local var_169_1 = manager.ui.mainCamera.transform.localPosition
				local var_169_2 = Vector3.New(0, 0, 10) + Vector3.New(var_169_1.x, var_169_1.y, 0)
				local var_169_3 = arg_166_1.bgs_.ST29

				var_169_3.transform.localPosition = var_169_2
				var_169_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_4 = var_169_3:GetComponent("SpriteRenderer")

				if var_169_4 and var_169_4.sprite then
					local var_169_5 = (var_169_3.transform.localPosition - var_169_1).z
					local var_169_6 = manager.ui.mainCameraCom_
					local var_169_7 = 2 * var_169_5 * Mathf.Tan(var_169_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_169_8 = var_169_7 * var_169_6.aspect
					local var_169_9 = var_169_4.sprite.bounds.size.x
					local var_169_10 = var_169_4.sprite.bounds.size.y
					local var_169_11 = var_169_8 / var_169_9
					local var_169_12 = var_169_7 / var_169_10
					local var_169_13 = var_169_12 < var_169_11 and var_169_11 or var_169_12

					var_169_3.transform.localScale = Vector3.New(var_169_13, var_169_13, 0)
				end

				for iter_169_0, iter_169_1 in pairs(arg_166_1.bgs_) do
					if iter_169_0 ~= "ST29" then
						iter_169_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_14 = 4

			if var_169_14 < arg_166_1.time_ and arg_166_1.time_ <= var_169_14 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			local var_169_15 = 0.3

			if arg_166_1.time_ >= var_169_14 + var_169_15 and arg_166_1.time_ < var_169_14 + var_169_15 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			local var_169_16 = 0

			if var_169_16 < arg_166_1.time_ and arg_166_1.time_ <= var_169_16 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_17 = 2

			if var_169_16 <= arg_166_1.time_ and arg_166_1.time_ < var_169_16 + var_169_17 then
				local var_169_18 = (arg_166_1.time_ - var_169_16) / var_169_17
				local var_169_19 = Color.New(0, 0, 0)

				var_169_19.a = Mathf.Lerp(0, 1, var_169_18)
				arg_166_1.mask_.color = var_169_19
			end

			if arg_166_1.time_ >= var_169_16 + var_169_17 and arg_166_1.time_ < var_169_16 + var_169_17 + arg_169_0 then
				local var_169_20 = Color.New(0, 0, 0)

				var_169_20.a = 1
				arg_166_1.mask_.color = var_169_20
			end

			local var_169_21 = 2

			if var_169_21 < arg_166_1.time_ and arg_166_1.time_ <= var_169_21 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_22 = 2

			if var_169_21 <= arg_166_1.time_ and arg_166_1.time_ < var_169_21 + var_169_22 then
				local var_169_23 = (arg_166_1.time_ - var_169_21) / var_169_22
				local var_169_24 = Color.New(0, 0, 0)

				var_169_24.a = Mathf.Lerp(1, 0, var_169_23)
				arg_166_1.mask_.color = var_169_24
			end

			if arg_166_1.time_ >= var_169_21 + var_169_22 and arg_166_1.time_ < var_169_21 + var_169_22 + arg_169_0 then
				local var_169_25 = Color.New(0, 0, 0)
				local var_169_26 = 0

				arg_166_1.mask_.enabled = false
				var_169_25.a = var_169_26
				arg_166_1.mask_.color = var_169_25
			end

			local var_169_27 = arg_166_1.actors_["1061ui_story"].transform
			local var_169_28 = 1.96599999815226

			if var_169_28 < arg_166_1.time_ and arg_166_1.time_ <= var_169_28 + arg_169_0 then
				arg_166_1.var_.moveOldPos1061ui_story = var_169_27.localPosition
			end

			local var_169_29 = 0.001

			if var_169_28 <= arg_166_1.time_ and arg_166_1.time_ < var_169_28 + var_169_29 then
				local var_169_30 = (arg_166_1.time_ - var_169_28) / var_169_29
				local var_169_31 = Vector3.New(0, 100, 0)

				var_169_27.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1061ui_story, var_169_31, var_169_30)

				local var_169_32 = manager.ui.mainCamera.transform.position - var_169_27.position

				var_169_27.forward = Vector3.New(var_169_32.x, var_169_32.y, var_169_32.z)

				local var_169_33 = var_169_27.localEulerAngles

				var_169_33.z = 0
				var_169_33.x = 0
				var_169_27.localEulerAngles = var_169_33
			end

			if arg_166_1.time_ >= var_169_28 + var_169_29 and arg_166_1.time_ < var_169_28 + var_169_29 + arg_169_0 then
				var_169_27.localPosition = Vector3.New(0, 100, 0)

				local var_169_34 = manager.ui.mainCamera.transform.position - var_169_27.position

				var_169_27.forward = Vector3.New(var_169_34.x, var_169_34.y, var_169_34.z)

				local var_169_35 = var_169_27.localEulerAngles

				var_169_35.z = 0
				var_169_35.x = 0
				var_169_27.localEulerAngles = var_169_35
			end

			local var_169_36 = arg_166_1.actors_["1061ui_story"]
			local var_169_37 = 1.96599999815226

			if var_169_37 < arg_166_1.time_ and arg_166_1.time_ <= var_169_37 + arg_169_0 and not isNil(var_169_36) and arg_166_1.var_.characterEffect1061ui_story == nil then
				arg_166_1.var_.characterEffect1061ui_story = var_169_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_38 = 0.034000001847744

			if var_169_37 <= arg_166_1.time_ and arg_166_1.time_ < var_169_37 + var_169_38 and not isNil(var_169_36) then
				local var_169_39 = (arg_166_1.time_ - var_169_37) / var_169_38

				if arg_166_1.var_.characterEffect1061ui_story and not isNil(var_169_36) then
					local var_169_40 = Mathf.Lerp(0, 0.5, var_169_39)

					arg_166_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1061ui_story.fillRatio = var_169_40
				end
			end

			if arg_166_1.time_ >= var_169_37 + var_169_38 and arg_166_1.time_ < var_169_37 + var_169_38 + arg_169_0 and not isNil(var_169_36) and arg_166_1.var_.characterEffect1061ui_story then
				local var_169_41 = 0.5

				arg_166_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1061ui_story.fillRatio = var_169_41
			end

			local var_169_42 = 1.53333333333333
			local var_169_43 = 1

			if var_169_42 < arg_166_1.time_ and arg_166_1.time_ <= var_169_42 + arg_169_0 then
				local var_169_44 = "play"
				local var_169_45 = "effect"

				arg_166_1:AudioAction(var_169_44, var_169_45, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_169_46 = 0.0666666666666667
			local var_169_47 = 1

			if var_169_46 < arg_166_1.time_ and arg_166_1.time_ <= var_169_46 + arg_169_0 then
				local var_169_48 = "stop"
				local var_169_49 = "effect"

				arg_166_1:AudioAction(var_169_48, var_169_49, "se_story_142", "se_story_142_amb_city_street", "")
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_50 = 4
			local var_169_51 = 0.475

			if var_169_50 < arg_166_1.time_ and arg_166_1.time_ <= var_169_50 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_52 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_52:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_166_1.dialogCg_.alpha = arg_170_0
				end))
				var_169_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_53 = arg_166_1:FormatText(StoryNameCfg[7].name)

				arg_166_1.leftNameTxt_.text = var_169_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_54 = arg_166_1:GetWordFromCfg(1106103040)
				local var_169_55 = arg_166_1:FormatText(var_169_54.content)

				arg_166_1.text_.text = var_169_55

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_56 = 19
				local var_169_57 = utf8.len(var_169_55)
				local var_169_58 = var_169_56 <= 0 and var_169_51 or var_169_51 * (var_169_57 / var_169_56)

				if var_169_58 > 0 and var_169_51 < var_169_58 then
					arg_166_1.talkMaxDuration = var_169_58
					var_169_50 = var_169_50 + 0.3

					if var_169_58 + var_169_50 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_58 + var_169_50
					end
				end

				arg_166_1.text_.text = var_169_55
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_59 = var_169_50 + 0.3
			local var_169_60 = math.max(var_169_51, arg_166_1.talkMaxDuration)

			if var_169_59 <= arg_166_1.time_ and arg_166_1.time_ < var_169_59 + var_169_60 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_59) / var_169_60

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_59 + var_169_60 and arg_166_1.time_ < var_169_59 + var_169_60 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play1106103041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1106103041
		arg_172_1.duration_ = 5.77

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1106103042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 0.65

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_2 = arg_172_1:FormatText(StoryNameCfg[1357].name)

				arg_172_1.leftNameTxt_.text = var_175_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:GetWordFromCfg(1106103041)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 26
				local var_175_6 = utf8.len(var_175_4)
				local var_175_7 = var_175_5 <= 0 and var_175_1 or var_175_1 * (var_175_6 / var_175_5)

				if var_175_7 > 0 and var_175_1 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103041", "story_v_side_new_1106103.awb") ~= 0 then
					local var_175_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103041", "story_v_side_new_1106103.awb") / 1000

					if var_175_8 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_0
					end

					if var_175_3.prefab_name ~= "" and arg_172_1.actors_[var_175_3.prefab_name] ~= nil then
						local var_175_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_3.prefab_name].transform, "story_v_side_new_1106103", "1106103041", "story_v_side_new_1106103.awb")

						arg_172_1:RecordAudio("1106103041", var_175_9)
						arg_172_1:RecordAudio("1106103041", var_175_9)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103041", "story_v_side_new_1106103.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103041", "story_v_side_new_1106103.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_10 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_10 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_10

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_10 and arg_172_1.time_ < var_175_0 + var_175_10 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play1106103042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1106103042
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1106103043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0
			local var_179_1 = 0.525

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_2 = arg_176_1:GetWordFromCfg(1106103042)
				local var_179_3 = arg_176_1:FormatText(var_179_2.content)

				arg_176_1.text_.text = var_179_3

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_4 = 21
				local var_179_5 = utf8.len(var_179_3)
				local var_179_6 = var_179_4 <= 0 and var_179_1 or var_179_1 * (var_179_5 / var_179_4)

				if var_179_6 > 0 and var_179_1 < var_179_6 then
					arg_176_1.talkMaxDuration = var_179_6

					if var_179_6 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_6 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_3
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_7 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_7 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_7

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_7 and arg_176_1.time_ < var_179_0 + var_179_7 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play1106103043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1106103043
		arg_180_1.duration_ = 1.77

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1106103044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1061ui_story"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos1061ui_story = var_183_0.localPosition
			end

			local var_183_2 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2
				local var_183_4 = Vector3.New(0, -1.18, -6.15)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1061ui_story, var_183_4, var_183_3)

				local var_183_5 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_5.x, var_183_5.y, var_183_5.z)

				local var_183_6 = var_183_0.localEulerAngles

				var_183_6.z = 0
				var_183_6.x = 0
				var_183_0.localEulerAngles = var_183_6
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_183_7 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_7.x, var_183_7.y, var_183_7.z)

				local var_183_8 = var_183_0.localEulerAngles

				var_183_8.z = 0
				var_183_8.x = 0
				var_183_0.localEulerAngles = var_183_8
			end

			local var_183_9 = arg_180_1.actors_["1061ui_story"]
			local var_183_10 = 0

			if var_183_10 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 and not isNil(var_183_9) and arg_180_1.var_.characterEffect1061ui_story == nil then
				arg_180_1.var_.characterEffect1061ui_story = var_183_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_11 = 0.200000002980232

			if var_183_10 <= arg_180_1.time_ and arg_180_1.time_ < var_183_10 + var_183_11 and not isNil(var_183_9) then
				local var_183_12 = (arg_180_1.time_ - var_183_10) / var_183_11

				if arg_180_1.var_.characterEffect1061ui_story and not isNil(var_183_9) then
					arg_180_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_10 + var_183_11 and arg_180_1.time_ < var_183_10 + var_183_11 + arg_183_0 and not isNil(var_183_9) and arg_180_1.var_.characterEffect1061ui_story then
				arg_180_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_183_13 = 0

			if var_183_13 < arg_180_1.time_ and arg_180_1.time_ <= var_183_13 + arg_183_0 then
				arg_180_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_183_14 = 0

			if var_183_14 < arg_180_1.time_ and arg_180_1.time_ <= var_183_14 + arg_183_0 then
				arg_180_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_183_15 = 0
			local var_183_16 = 0.225

			if var_183_15 < arg_180_1.time_ and arg_180_1.time_ <= var_183_15 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_17 = arg_180_1:FormatText(StoryNameCfg[612].name)

				arg_180_1.leftNameTxt_.text = var_183_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_18 = arg_180_1:GetWordFromCfg(1106103043)
				local var_183_19 = arg_180_1:FormatText(var_183_18.content)

				arg_180_1.text_.text = var_183_19

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_20 = 9
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103043", "story_v_side_new_1106103.awb") ~= 0 then
					local var_183_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103043", "story_v_side_new_1106103.awb") / 1000

					if var_183_23 + var_183_15 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_23 + var_183_15
					end

					if var_183_18.prefab_name ~= "" and arg_180_1.actors_[var_183_18.prefab_name] ~= nil then
						local var_183_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_18.prefab_name].transform, "story_v_side_new_1106103", "1106103043", "story_v_side_new_1106103.awb")

						arg_180_1:RecordAudio("1106103043", var_183_24)
						arg_180_1:RecordAudio("1106103043", var_183_24)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103043", "story_v_side_new_1106103.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103043", "story_v_side_new_1106103.awb")
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
				actorName = "1061ui_story",
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
	Play1106103044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1106103044
		arg_184_1.duration_ = 4.87

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1106103045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_187_2 = 0
			local var_187_3 = 0.55

			if var_187_2 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_4 = arg_184_1:FormatText(StoryNameCfg[612].name)

				arg_184_1.leftNameTxt_.text = var_187_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_5 = arg_184_1:GetWordFromCfg(1106103044)
				local var_187_6 = arg_184_1:FormatText(var_187_5.content)

				arg_184_1.text_.text = var_187_6

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 22
				local var_187_8 = utf8.len(var_187_6)
				local var_187_9 = var_187_7 <= 0 and var_187_3 or var_187_3 * (var_187_8 / var_187_7)

				if var_187_9 > 0 and var_187_3 < var_187_9 then
					arg_184_1.talkMaxDuration = var_187_9

					if var_187_9 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_9 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_6
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103044", "story_v_side_new_1106103.awb") ~= 0 then
					local var_187_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103044", "story_v_side_new_1106103.awb") / 1000

					if var_187_10 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_10 + var_187_2
					end

					if var_187_5.prefab_name ~= "" and arg_184_1.actors_[var_187_5.prefab_name] ~= nil then
						local var_187_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_5.prefab_name].transform, "story_v_side_new_1106103", "1106103044", "story_v_side_new_1106103.awb")

						arg_184_1:RecordAudio("1106103044", var_187_11)
						arg_184_1:RecordAudio("1106103044", var_187_11)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103044", "story_v_side_new_1106103.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103044", "story_v_side_new_1106103.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_12 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_12 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_12

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_12 and arg_184_1.time_ < var_187_2 + var_187_12 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play1106103045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1106103045
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

			arg_188_1.choices_[1].txt.text = arg_188_1:FormatText(StoryChoiceCfg[1392].name)
			arg_188_1.choices_[2].txt.text = arg_188_1:FormatText(StoryChoiceCfg[1393].name)
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1106103046(arg_188_1)
			end

			if arg_190_0 == 2 then
				arg_188_0:Play1106103046(arg_188_1)
			end

			arg_188_1:RecordChoiceLog(1106103045, 1392, 1393)
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1061ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1061ui_story == nil then
				arg_188_1.var_.characterEffect1061ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect1061ui_story and not isNil(var_191_0) then
					local var_191_4 = Mathf.Lerp(0, 0.5, var_191_3)

					arg_188_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1061ui_story.fillRatio = var_191_4
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1061ui_story then
				local var_191_5 = 0.5

				arg_188_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1061ui_story.fillRatio = var_191_5
			end

			local var_191_6 = 0

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.allBtn_.enabled = false
			end

			local var_191_7 = 0.6

			if arg_188_1.time_ >= var_191_6 + var_191_7 and arg_188_1.time_ < var_191_6 + var_191_7 + arg_191_0 then
				arg_188_1.allBtn_.enabled = true
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play1106103046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1106103046
		arg_192_1.duration_ = 4.77

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1106103047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1061ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1061ui_story == nil then
				arg_192_1.var_.characterEffect1061ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.200000002980232

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect1061ui_story and not isNil(var_195_0) then
					arg_192_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1061ui_story then
				arg_192_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_195_4 = "1061ui_story"

			if arg_192_1.actors_[var_195_4] == nil then
				local var_195_5 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_195_5) then
					local var_195_6 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_192_1.stage_.transform)

					var_195_6.name = var_195_4
					var_195_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_192_1.actors_[var_195_4] = var_195_6

					local var_195_7 = var_195_6:GetComponentInChildren(typeof(CharacterEffect))

					var_195_7.enabled = true

					local var_195_8 = GameObjectTools.GetOrAddComponent(var_195_6, typeof(DynamicBoneHelper))

					if var_195_8 then
						var_195_8:EnableDynamicBone(false)
					end

					arg_192_1:ShowWeapon(var_195_7.transform, false)

					arg_192_1.var_[var_195_4 .. "Animator"] = var_195_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_192_1.var_[var_195_4 .. "Animator"].applyRootMotion = true
					arg_192_1.var_[var_195_4 .. "LipSync"] = var_195_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_195_9 = 0

			if var_195_9 < arg_192_1.time_ and arg_192_1.time_ <= var_195_9 + arg_195_0 then
				arg_192_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action432")
			end

			local var_195_10 = "1061ui_story"

			if arg_192_1.actors_[var_195_10] == nil then
				local var_195_11 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_195_11) then
					local var_195_12 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_192_1.stage_.transform)

					var_195_12.name = var_195_10
					var_195_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_192_1.actors_[var_195_10] = var_195_12

					local var_195_13 = var_195_12:GetComponentInChildren(typeof(CharacterEffect))

					var_195_13.enabled = true

					local var_195_14 = GameObjectTools.GetOrAddComponent(var_195_12, typeof(DynamicBoneHelper))

					if var_195_14 then
						var_195_14:EnableDynamicBone(false)
					end

					arg_192_1:ShowWeapon(var_195_13.transform, false)

					arg_192_1.var_[var_195_10 .. "Animator"] = var_195_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_192_1.var_[var_195_10 .. "Animator"].applyRootMotion = true
					arg_192_1.var_[var_195_10 .. "LipSync"] = var_195_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_195_15 = 0

			if var_195_15 < arg_192_1.time_ and arg_192_1.time_ <= var_195_15 + arg_195_0 then
				arg_192_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_195_16 = 0
			local var_195_17 = 0.425

			if var_195_16 < arg_192_1.time_ and arg_192_1.time_ <= var_195_16 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_18 = arg_192_1:FormatText(StoryNameCfg[612].name)

				arg_192_1.leftNameTxt_.text = var_195_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_19 = arg_192_1:GetWordFromCfg(1106103046)
				local var_195_20 = arg_192_1:FormatText(var_195_19.content)

				arg_192_1.text_.text = var_195_20

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_21 = 17
				local var_195_22 = utf8.len(var_195_20)
				local var_195_23 = var_195_21 <= 0 and var_195_17 or var_195_17 * (var_195_22 / var_195_21)

				if var_195_23 > 0 and var_195_17 < var_195_23 then
					arg_192_1.talkMaxDuration = var_195_23

					if var_195_23 + var_195_16 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_23 + var_195_16
					end
				end

				arg_192_1.text_.text = var_195_20
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103046", "story_v_side_new_1106103.awb") ~= 0 then
					local var_195_24 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103046", "story_v_side_new_1106103.awb") / 1000

					if var_195_24 + var_195_16 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_24 + var_195_16
					end

					if var_195_19.prefab_name ~= "" and arg_192_1.actors_[var_195_19.prefab_name] ~= nil then
						local var_195_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_19.prefab_name].transform, "story_v_side_new_1106103", "1106103046", "story_v_side_new_1106103.awb")

						arg_192_1:RecordAudio("1106103046", var_195_25)
						arg_192_1:RecordAudio("1106103046", var_195_25)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103046", "story_v_side_new_1106103.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103046", "story_v_side_new_1106103.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_26 = math.max(var_195_17, arg_192_1.talkMaxDuration)

			if var_195_16 <= arg_192_1.time_ and arg_192_1.time_ < var_195_16 + var_195_26 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_16) / var_195_26

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_16 + var_195_26 and arg_192_1.time_ < var_195_16 + var_195_26 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play1106103047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1106103047
		arg_196_1.duration_ = 7.3

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1106103048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.775

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_2 = arg_196_1:FormatText(StoryNameCfg[612].name)

				arg_196_1.leftNameTxt_.text = var_199_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_3 = arg_196_1:GetWordFromCfg(1106103047)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 31
				local var_199_6 = utf8.len(var_199_4)
				local var_199_7 = var_199_5 <= 0 and var_199_1 or var_199_1 * (var_199_6 / var_199_5)

				if var_199_7 > 0 and var_199_1 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103047", "story_v_side_new_1106103.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103047", "story_v_side_new_1106103.awb") / 1000

					if var_199_8 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_0
					end

					if var_199_3.prefab_name ~= "" and arg_196_1.actors_[var_199_3.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_3.prefab_name].transform, "story_v_side_new_1106103", "1106103047", "story_v_side_new_1106103.awb")

						arg_196_1:RecordAudio("1106103047", var_199_9)
						arg_196_1:RecordAudio("1106103047", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103047", "story_v_side_new_1106103.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103047", "story_v_side_new_1106103.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_10 and arg_196_1.time_ < var_199_0 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play1106103048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1106103048
		arg_200_1.duration_ = 1

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"

			SetActive(arg_200_1.choicesGo_, true)

			for iter_201_0, iter_201_1 in ipairs(arg_200_1.choices_) do
				local var_201_0 = iter_201_0 <= 2

				SetActive(iter_201_1.go, var_201_0)
			end

			arg_200_1.choices_[1].txt.text = arg_200_1:FormatText(StoryChoiceCfg[1393].name)
			arg_200_1.choices_[2].txt.text = arg_200_1:FormatText(StoryChoiceCfg[1392].name)
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1106103049(arg_200_1)
			end

			if arg_202_0 == 2 then
				arg_200_0:Play1106103049(arg_200_1)
			end

			arg_200_1:RecordChoiceLog(1106103048, 1393, 1392)
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1061ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1061ui_story == nil then
				arg_200_1.var_.characterEffect1061ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.200000002980232

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect1061ui_story and not isNil(var_203_0) then
					local var_203_4 = Mathf.Lerp(0, 0.5, var_203_3)

					arg_200_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1061ui_story.fillRatio = var_203_4
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1061ui_story then
				local var_203_5 = 0.5

				arg_200_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1061ui_story.fillRatio = var_203_5
			end

			local var_203_6 = 0

			if var_203_6 < arg_200_1.time_ and arg_200_1.time_ <= var_203_6 + arg_203_0 then
				arg_200_1.allBtn_.enabled = false
			end

			local var_203_7 = 0.6

			if arg_200_1.time_ >= var_203_6 + var_203_7 and arg_200_1.time_ < var_203_6 + var_203_7 + arg_203_0 then
				arg_200_1.allBtn_.enabled = true
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play1106103049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1106103049
		arg_204_1.duration_ = 3.2

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1106103050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1061ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1061ui_story == nil then
				arg_204_1.var_.characterEffect1061ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect1061ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1061ui_story then
				arg_204_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_207_4 = "1061ui_story"

			if arg_204_1.actors_[var_207_4] == nil then
				local var_207_5 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_207_5) then
					local var_207_6 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_204_1.stage_.transform)

					var_207_6.name = var_207_4
					var_207_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_204_1.actors_[var_207_4] = var_207_6

					local var_207_7 = var_207_6:GetComponentInChildren(typeof(CharacterEffect))

					var_207_7.enabled = true

					local var_207_8 = GameObjectTools.GetOrAddComponent(var_207_6, typeof(DynamicBoneHelper))

					if var_207_8 then
						var_207_8:EnableDynamicBone(false)
					end

					arg_204_1:ShowWeapon(var_207_7.transform, false)

					arg_204_1.var_[var_207_4 .. "Animator"] = var_207_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_204_1.var_[var_207_4 .. "Animator"].applyRootMotion = true
					arg_204_1.var_[var_207_4 .. "LipSync"] = var_207_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_207_9 = 0

			if var_207_9 < arg_204_1.time_ and arg_204_1.time_ <= var_207_9 + arg_207_0 then
				arg_204_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action428")
			end

			local var_207_10 = "1061ui_story"

			if arg_204_1.actors_[var_207_10] == nil then
				local var_207_11 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_207_11) then
					local var_207_12 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_204_1.stage_.transform)

					var_207_12.name = var_207_10
					var_207_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_204_1.actors_[var_207_10] = var_207_12

					local var_207_13 = var_207_12:GetComponentInChildren(typeof(CharacterEffect))

					var_207_13.enabled = true

					local var_207_14 = GameObjectTools.GetOrAddComponent(var_207_12, typeof(DynamicBoneHelper))

					if var_207_14 then
						var_207_14:EnableDynamicBone(false)
					end

					arg_204_1:ShowWeapon(var_207_13.transform, false)

					arg_204_1.var_[var_207_10 .. "Animator"] = var_207_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_204_1.var_[var_207_10 .. "Animator"].applyRootMotion = true
					arg_204_1.var_[var_207_10 .. "LipSync"] = var_207_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_207_15 = 0

			if var_207_15 < arg_204_1.time_ and arg_204_1.time_ <= var_207_15 + arg_207_0 then
				arg_204_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_207_16 = 0
			local var_207_17 = 0.325

			if var_207_16 < arg_204_1.time_ and arg_204_1.time_ <= var_207_16 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_18 = arg_204_1:FormatText(StoryNameCfg[612].name)

				arg_204_1.leftNameTxt_.text = var_207_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_19 = arg_204_1:GetWordFromCfg(1106103049)
				local var_207_20 = arg_204_1:FormatText(var_207_19.content)

				arg_204_1.text_.text = var_207_20

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_21 = 13
				local var_207_22 = utf8.len(var_207_20)
				local var_207_23 = var_207_21 <= 0 and var_207_17 or var_207_17 * (var_207_22 / var_207_21)

				if var_207_23 > 0 and var_207_17 < var_207_23 then
					arg_204_1.talkMaxDuration = var_207_23

					if var_207_23 + var_207_16 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_23 + var_207_16
					end
				end

				arg_204_1.text_.text = var_207_20
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103049", "story_v_side_new_1106103.awb") ~= 0 then
					local var_207_24 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103049", "story_v_side_new_1106103.awb") / 1000

					if var_207_24 + var_207_16 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_24 + var_207_16
					end

					if var_207_19.prefab_name ~= "" and arg_204_1.actors_[var_207_19.prefab_name] ~= nil then
						local var_207_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_19.prefab_name].transform, "story_v_side_new_1106103", "1106103049", "story_v_side_new_1106103.awb")

						arg_204_1:RecordAudio("1106103049", var_207_25)
						arg_204_1:RecordAudio("1106103049", var_207_25)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103049", "story_v_side_new_1106103.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103049", "story_v_side_new_1106103.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_26 = math.max(var_207_17, arg_204_1.talkMaxDuration)

			if var_207_16 <= arg_204_1.time_ and arg_204_1.time_ < var_207_16 + var_207_26 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_16) / var_207_26

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_16 + var_207_26 and arg_204_1.time_ < var_207_16 + var_207_26 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play1106103050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1106103050
		arg_208_1.duration_ = 1.87

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1106103051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 0.225

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_2 = arg_208_1:FormatText(StoryNameCfg[612].name)

				arg_208_1.leftNameTxt_.text = var_211_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_3 = arg_208_1:GetWordFromCfg(1106103050)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 9
				local var_211_6 = utf8.len(var_211_4)
				local var_211_7 = var_211_5 <= 0 and var_211_1 or var_211_1 * (var_211_6 / var_211_5)

				if var_211_7 > 0 and var_211_1 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_4
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103050", "story_v_side_new_1106103.awb") ~= 0 then
					local var_211_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103050", "story_v_side_new_1106103.awb") / 1000

					if var_211_8 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_0
					end

					if var_211_3.prefab_name ~= "" and arg_208_1.actors_[var_211_3.prefab_name] ~= nil then
						local var_211_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_3.prefab_name].transform, "story_v_side_new_1106103", "1106103050", "story_v_side_new_1106103.awb")

						arg_208_1:RecordAudio("1106103050", var_211_9)
						arg_208_1:RecordAudio("1106103050", var_211_9)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103050", "story_v_side_new_1106103.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103050", "story_v_side_new_1106103.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_10 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_10 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_10

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_10 and arg_208_1.time_ < var_211_0 + var_211_10 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play1106103051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 1106103051
		arg_212_1.duration_ = 1

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"

			SetActive(arg_212_1.choicesGo_, true)

			for iter_213_0, iter_213_1 in ipairs(arg_212_1.choices_) do
				local var_213_0 = iter_213_0 <= 2

				SetActive(iter_213_1.go, var_213_0)
			end

			arg_212_1.choices_[1].txt.text = arg_212_1:FormatText(StoryChoiceCfg[1392].name)
			arg_212_1.choices_[2].txt.text = arg_212_1:FormatText(StoryChoiceCfg[1393].name)
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play1106103052(arg_212_1)
			end

			if arg_214_0 == 2 then
				arg_212_0:Play1106103052(arg_212_1)
			end

			arg_212_1:RecordChoiceLog(1106103051, 1392, 1393)
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1061ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1061ui_story == nil then
				arg_212_1.var_.characterEffect1061ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect1061ui_story and not isNil(var_215_0) then
					local var_215_4 = Mathf.Lerp(0, 0.5, var_215_3)

					arg_212_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1061ui_story.fillRatio = var_215_4
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1061ui_story then
				local var_215_5 = 0.5

				arg_212_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1061ui_story.fillRatio = var_215_5
			end

			local var_215_6 = 0

			if var_215_6 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 then
				arg_212_1.allBtn_.enabled = false
			end

			local var_215_7 = 0.6

			if arg_212_1.time_ >= var_215_6 + var_215_7 and arg_212_1.time_ < var_215_6 + var_215_7 + arg_215_0 then
				arg_212_1.allBtn_.enabled = true
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play1106103052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 1106103052
		arg_216_1.duration_ = 2

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play1106103053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1061ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1061ui_story == nil then
				arg_216_1.var_.characterEffect1061ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect1061ui_story and not isNil(var_219_0) then
					arg_216_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1061ui_story then
				arg_216_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_219_4 = "1061ui_story"

			if arg_216_1.actors_[var_219_4] == nil then
				local var_219_5 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_219_5) then
					local var_219_6 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_216_1.stage_.transform)

					var_219_6.name = var_219_4
					var_219_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_216_1.actors_[var_219_4] = var_219_6

					local var_219_7 = var_219_6:GetComponentInChildren(typeof(CharacterEffect))

					var_219_7.enabled = true

					local var_219_8 = GameObjectTools.GetOrAddComponent(var_219_6, typeof(DynamicBoneHelper))

					if var_219_8 then
						var_219_8:EnableDynamicBone(false)
					end

					arg_216_1:ShowWeapon(var_219_7.transform, false)

					arg_216_1.var_[var_219_4 .. "Animator"] = var_219_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_216_1.var_[var_219_4 .. "Animator"].applyRootMotion = true
					arg_216_1.var_[var_219_4 .. "LipSync"] = var_219_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_219_9 = 0

			if var_219_9 < arg_216_1.time_ and arg_216_1.time_ <= var_219_9 + arg_219_0 then
				arg_216_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action485")
			end

			local var_219_10 = "1061ui_story"

			if arg_216_1.actors_[var_219_10] == nil then
				local var_219_11 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_219_11) then
					local var_219_12 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_216_1.stage_.transform)

					var_219_12.name = var_219_10
					var_219_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_216_1.actors_[var_219_10] = var_219_12

					local var_219_13 = var_219_12:GetComponentInChildren(typeof(CharacterEffect))

					var_219_13.enabled = true

					local var_219_14 = GameObjectTools.GetOrAddComponent(var_219_12, typeof(DynamicBoneHelper))

					if var_219_14 then
						var_219_14:EnableDynamicBone(false)
					end

					arg_216_1:ShowWeapon(var_219_13.transform, false)

					arg_216_1.var_[var_219_10 .. "Animator"] = var_219_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_216_1.var_[var_219_10 .. "Animator"].applyRootMotion = true
					arg_216_1.var_[var_219_10 .. "LipSync"] = var_219_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_219_15 = 0

			if var_219_15 < arg_216_1.time_ and arg_216_1.time_ <= var_219_15 + arg_219_0 then
				arg_216_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_219_16 = 0
			local var_219_17 = 0.2

			if var_219_16 < arg_216_1.time_ and arg_216_1.time_ <= var_219_16 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_18 = arg_216_1:FormatText(StoryNameCfg[612].name)

				arg_216_1.leftNameTxt_.text = var_219_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_19 = arg_216_1:GetWordFromCfg(1106103052)
				local var_219_20 = arg_216_1:FormatText(var_219_19.content)

				arg_216_1.text_.text = var_219_20

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_21 = 8
				local var_219_22 = utf8.len(var_219_20)
				local var_219_23 = var_219_21 <= 0 and var_219_17 or var_219_17 * (var_219_22 / var_219_21)

				if var_219_23 > 0 and var_219_17 < var_219_23 then
					arg_216_1.talkMaxDuration = var_219_23

					if var_219_23 + var_219_16 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_23 + var_219_16
					end
				end

				arg_216_1.text_.text = var_219_20
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103052", "story_v_side_new_1106103.awb") ~= 0 then
					local var_219_24 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103052", "story_v_side_new_1106103.awb") / 1000

					if var_219_24 + var_219_16 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_24 + var_219_16
					end

					if var_219_19.prefab_name ~= "" and arg_216_1.actors_[var_219_19.prefab_name] ~= nil then
						local var_219_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_19.prefab_name].transform, "story_v_side_new_1106103", "1106103052", "story_v_side_new_1106103.awb")

						arg_216_1:RecordAudio("1106103052", var_219_25)
						arg_216_1:RecordAudio("1106103052", var_219_25)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103052", "story_v_side_new_1106103.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103052", "story_v_side_new_1106103.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_26 = math.max(var_219_17, arg_216_1.talkMaxDuration)

			if var_219_16 <= arg_216_1.time_ and arg_216_1.time_ < var_219_16 + var_219_26 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_16) / var_219_26

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_16 + var_219_26 and arg_216_1.time_ < var_219_16 + var_219_26 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play1106103053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 1106103053
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play1106103054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1061ui_story"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1061ui_story == nil then
				arg_220_1.var_.characterEffect1061ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.characterEffect1061ui_story and not isNil(var_223_0) then
					local var_223_4 = Mathf.Lerp(0, 0.5, var_223_3)

					arg_220_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1061ui_story.fillRatio = var_223_4
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1061ui_story then
				local var_223_5 = 0.5

				arg_220_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1061ui_story.fillRatio = var_223_5
			end

			local var_223_6 = 0
			local var_223_7 = 0.325

			if var_223_6 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_8 = arg_220_1:FormatText(StoryNameCfg[7].name)

				arg_220_1.leftNameTxt_.text = var_223_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_9 = arg_220_1:GetWordFromCfg(1106103053)
				local var_223_10 = arg_220_1:FormatText(var_223_9.content)

				arg_220_1.text_.text = var_223_10

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_11 = 13
				local var_223_12 = utf8.len(var_223_10)
				local var_223_13 = var_223_11 <= 0 and var_223_7 or var_223_7 * (var_223_12 / var_223_11)

				if var_223_13 > 0 and var_223_7 < var_223_13 then
					arg_220_1.talkMaxDuration = var_223_13

					if var_223_13 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_13 + var_223_6
					end
				end

				arg_220_1.text_.text = var_223_10
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_14 = math.max(var_223_7, arg_220_1.talkMaxDuration)

			if var_223_6 <= arg_220_1.time_ and arg_220_1.time_ < var_223_6 + var_223_14 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_6) / var_223_14

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_6 + var_223_14 and arg_220_1.time_ < var_223_6 + var_223_14 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play1106103054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 1106103054
		arg_224_1.duration_ = 6.07

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play1106103055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1061ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1061ui_story == nil then
				arg_224_1.var_.characterEffect1061ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect1061ui_story and not isNil(var_227_0) then
					arg_224_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1061ui_story then
				arg_224_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_227_4 = 0

			if var_227_4 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			local var_227_5 = 0

			if var_227_5 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 then
				arg_224_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_227_6 = 0
			local var_227_7 = 0.725

			if var_227_6 < arg_224_1.time_ and arg_224_1.time_ <= var_227_6 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_8 = arg_224_1:FormatText(StoryNameCfg[612].name)

				arg_224_1.leftNameTxt_.text = var_227_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_9 = arg_224_1:GetWordFromCfg(1106103054)
				local var_227_10 = arg_224_1:FormatText(var_227_9.content)

				arg_224_1.text_.text = var_227_10

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_11 = 29
				local var_227_12 = utf8.len(var_227_10)
				local var_227_13 = var_227_11 <= 0 and var_227_7 or var_227_7 * (var_227_12 / var_227_11)

				if var_227_13 > 0 and var_227_7 < var_227_13 then
					arg_224_1.talkMaxDuration = var_227_13

					if var_227_13 + var_227_6 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_13 + var_227_6
					end
				end

				arg_224_1.text_.text = var_227_10
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103054", "story_v_side_new_1106103.awb") ~= 0 then
					local var_227_14 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103054", "story_v_side_new_1106103.awb") / 1000

					if var_227_14 + var_227_6 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_14 + var_227_6
					end

					if var_227_9.prefab_name ~= "" and arg_224_1.actors_[var_227_9.prefab_name] ~= nil then
						local var_227_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_9.prefab_name].transform, "story_v_side_new_1106103", "1106103054", "story_v_side_new_1106103.awb")

						arg_224_1:RecordAudio("1106103054", var_227_15)
						arg_224_1:RecordAudio("1106103054", var_227_15)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103054", "story_v_side_new_1106103.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103054", "story_v_side_new_1106103.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_16 = math.max(var_227_7, arg_224_1.talkMaxDuration)

			if var_227_6 <= arg_224_1.time_ and arg_224_1.time_ < var_227_6 + var_227_16 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_6) / var_227_16

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_6 + var_227_16 and arg_224_1.time_ < var_227_6 + var_227_16 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play1106103055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1106103055
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play1106103056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1061ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1061ui_story == nil then
				arg_228_1.var_.characterEffect1061ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect1061ui_story and not isNil(var_231_0) then
					local var_231_4 = Mathf.Lerp(0, 0.5, var_231_3)

					arg_228_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1061ui_story.fillRatio = var_231_4
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1061ui_story then
				local var_231_5 = 0.5

				arg_228_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1061ui_story.fillRatio = var_231_5
			end

			local var_231_6 = 0
			local var_231_7 = 0.525

			if var_231_6 < arg_228_1.time_ and arg_228_1.time_ <= var_231_6 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_8 = arg_228_1:FormatText(StoryNameCfg[7].name)

				arg_228_1.leftNameTxt_.text = var_231_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_9 = arg_228_1:GetWordFromCfg(1106103055)
				local var_231_10 = arg_228_1:FormatText(var_231_9.content)

				arg_228_1.text_.text = var_231_10

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_11 = 21
				local var_231_12 = utf8.len(var_231_10)
				local var_231_13 = var_231_11 <= 0 and var_231_7 or var_231_7 * (var_231_12 / var_231_11)

				if var_231_13 > 0 and var_231_7 < var_231_13 then
					arg_228_1.talkMaxDuration = var_231_13

					if var_231_13 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_13 + var_231_6
					end
				end

				arg_228_1.text_.text = var_231_10
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_14 = math.max(var_231_7, arg_228_1.talkMaxDuration)

			if var_231_6 <= arg_228_1.time_ and arg_228_1.time_ < var_231_6 + var_231_14 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_6) / var_231_14

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_6 + var_231_14 and arg_228_1.time_ < var_231_6 + var_231_14 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play1106103056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1106103056
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1106103057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0
			local var_235_1 = 0.35

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_2 = arg_232_1:FormatText(StoryNameCfg[7].name)

				arg_232_1.leftNameTxt_.text = var_235_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_3 = arg_232_1:GetWordFromCfg(1106103056)
				local var_235_4 = arg_232_1:FormatText(var_235_3.content)

				arg_232_1.text_.text = var_235_4

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_5 = 14
				local var_235_6 = utf8.len(var_235_4)
				local var_235_7 = var_235_5 <= 0 and var_235_1 or var_235_1 * (var_235_6 / var_235_5)

				if var_235_7 > 0 and var_235_1 < var_235_7 then
					arg_232_1.talkMaxDuration = var_235_7

					if var_235_7 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_7 + var_235_0
					end
				end

				arg_232_1.text_.text = var_235_4
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_8 = math.max(var_235_1, arg_232_1.talkMaxDuration)

			if var_235_0 <= arg_232_1.time_ and arg_232_1.time_ < var_235_0 + var_235_8 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_0) / var_235_8

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_0 + var_235_8 and arg_232_1.time_ < var_235_0 + var_235_8 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play1106103057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 1106103057
		arg_236_1.duration_ = 2.7

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play1106103058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1061ui_story"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1061ui_story == nil then
				arg_236_1.var_.characterEffect1061ui_story = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.characterEffect1061ui_story and not isNil(var_239_0) then
					arg_236_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1061ui_story then
				arg_236_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_239_4 = 0

			if var_239_4 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_1")
			end

			local var_239_5 = 0

			if var_239_5 < arg_236_1.time_ and arg_236_1.time_ <= var_239_5 + arg_239_0 then
				arg_236_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_239_6 = 0
			local var_239_7 = 0.325

			if var_239_6 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_8 = arg_236_1:FormatText(StoryNameCfg[612].name)

				arg_236_1.leftNameTxt_.text = var_239_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_9 = arg_236_1:GetWordFromCfg(1106103057)
				local var_239_10 = arg_236_1:FormatText(var_239_9.content)

				arg_236_1.text_.text = var_239_10

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_11 = 13
				local var_239_12 = utf8.len(var_239_10)
				local var_239_13 = var_239_11 <= 0 and var_239_7 or var_239_7 * (var_239_12 / var_239_11)

				if var_239_13 > 0 and var_239_7 < var_239_13 then
					arg_236_1.talkMaxDuration = var_239_13

					if var_239_13 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_13 + var_239_6
					end
				end

				arg_236_1.text_.text = var_239_10
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103057", "story_v_side_new_1106103.awb") ~= 0 then
					local var_239_14 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103057", "story_v_side_new_1106103.awb") / 1000

					if var_239_14 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_14 + var_239_6
					end

					if var_239_9.prefab_name ~= "" and arg_236_1.actors_[var_239_9.prefab_name] ~= nil then
						local var_239_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_9.prefab_name].transform, "story_v_side_new_1106103", "1106103057", "story_v_side_new_1106103.awb")

						arg_236_1:RecordAudio("1106103057", var_239_15)
						arg_236_1:RecordAudio("1106103057", var_239_15)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103057", "story_v_side_new_1106103.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103057", "story_v_side_new_1106103.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_16 = math.max(var_239_7, arg_236_1.talkMaxDuration)

			if var_239_6 <= arg_236_1.time_ and arg_236_1.time_ < var_239_6 + var_239_16 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_6) / var_239_16

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_6 + var_239_16 and arg_236_1.time_ < var_239_6 + var_239_16 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play1106103058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 1106103058
		arg_240_1.duration_ = 4.4

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play1106103059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_2")
			end

			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_243_2 = 0
			local var_243_3 = 0.55

			if var_243_2 < arg_240_1.time_ and arg_240_1.time_ <= var_243_2 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_4 = arg_240_1:FormatText(StoryNameCfg[612].name)

				arg_240_1.leftNameTxt_.text = var_243_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_5 = arg_240_1:GetWordFromCfg(1106103058)
				local var_243_6 = arg_240_1:FormatText(var_243_5.content)

				arg_240_1.text_.text = var_243_6

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_7 = 22
				local var_243_8 = utf8.len(var_243_6)
				local var_243_9 = var_243_7 <= 0 and var_243_3 or var_243_3 * (var_243_8 / var_243_7)

				if var_243_9 > 0 and var_243_3 < var_243_9 then
					arg_240_1.talkMaxDuration = var_243_9

					if var_243_9 + var_243_2 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_9 + var_243_2
					end
				end

				arg_240_1.text_.text = var_243_6
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103058", "story_v_side_new_1106103.awb") ~= 0 then
					local var_243_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103058", "story_v_side_new_1106103.awb") / 1000

					if var_243_10 + var_243_2 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_10 + var_243_2
					end

					if var_243_5.prefab_name ~= "" and arg_240_1.actors_[var_243_5.prefab_name] ~= nil then
						local var_243_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_5.prefab_name].transform, "story_v_side_new_1106103", "1106103058", "story_v_side_new_1106103.awb")

						arg_240_1:RecordAudio("1106103058", var_243_11)
						arg_240_1:RecordAudio("1106103058", var_243_11)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103058", "story_v_side_new_1106103.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103058", "story_v_side_new_1106103.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_12 = math.max(var_243_3, arg_240_1.talkMaxDuration)

			if var_243_2 <= arg_240_1.time_ and arg_240_1.time_ < var_243_2 + var_243_12 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_2) / var_243_12

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_2 + var_243_12 and arg_240_1.time_ < var_243_2 + var_243_12 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play1106103059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 1106103059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play1106103060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1061ui_story"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1061ui_story == nil then
				arg_244_1.var_.characterEffect1061ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.characterEffect1061ui_story and not isNil(var_247_0) then
					local var_247_4 = Mathf.Lerp(0, 0.5, var_247_3)

					arg_244_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1061ui_story.fillRatio = var_247_4
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1061ui_story then
				local var_247_5 = 0.5

				arg_244_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1061ui_story.fillRatio = var_247_5
			end

			local var_247_6 = 0
			local var_247_7 = 0.525

			if var_247_6 < arg_244_1.time_ and arg_244_1.time_ <= var_247_6 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_8 = arg_244_1:FormatText(StoryNameCfg[7].name)

				arg_244_1.leftNameTxt_.text = var_247_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_9 = arg_244_1:GetWordFromCfg(1106103059)
				local var_247_10 = arg_244_1:FormatText(var_247_9.content)

				arg_244_1.text_.text = var_247_10

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_11 = 21
				local var_247_12 = utf8.len(var_247_10)
				local var_247_13 = var_247_11 <= 0 and var_247_7 or var_247_7 * (var_247_12 / var_247_11)

				if var_247_13 > 0 and var_247_7 < var_247_13 then
					arg_244_1.talkMaxDuration = var_247_13

					if var_247_13 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_13 + var_247_6
					end
				end

				arg_244_1.text_.text = var_247_10
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_14 = math.max(var_247_7, arg_244_1.talkMaxDuration)

			if var_247_6 <= arg_244_1.time_ and arg_244_1.time_ < var_247_6 + var_247_14 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_6) / var_247_14

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_6 + var_247_14 and arg_244_1.time_ < var_247_6 + var_247_14 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play1106103060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 1106103060
		arg_248_1.duration_ = 5.27

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play1106103061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["1061ui_story"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect1061ui_story == nil then
				arg_248_1.var_.characterEffect1061ui_story = var_251_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.characterEffect1061ui_story and not isNil(var_251_0) then
					arg_248_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect1061ui_story then
				arg_248_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_251_4 = 0

			if var_251_4 < arg_248_1.time_ and arg_248_1.time_ <= var_251_4 + arg_251_0 then
				arg_248_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_1")
			end

			local var_251_5 = 0

			if var_251_5 < arg_248_1.time_ and arg_248_1.time_ <= var_251_5 + arg_251_0 then
				arg_248_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_251_6 = 0
			local var_251_7 = 0.45

			if var_251_6 < arg_248_1.time_ and arg_248_1.time_ <= var_251_6 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_8 = arg_248_1:FormatText(StoryNameCfg[612].name)

				arg_248_1.leftNameTxt_.text = var_251_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_9 = arg_248_1:GetWordFromCfg(1106103060)
				local var_251_10 = arg_248_1:FormatText(var_251_9.content)

				arg_248_1.text_.text = var_251_10

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_11 = 18
				local var_251_12 = utf8.len(var_251_10)
				local var_251_13 = var_251_11 <= 0 and var_251_7 or var_251_7 * (var_251_12 / var_251_11)

				if var_251_13 > 0 and var_251_7 < var_251_13 then
					arg_248_1.talkMaxDuration = var_251_13

					if var_251_13 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_13 + var_251_6
					end
				end

				arg_248_1.text_.text = var_251_10
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103060", "story_v_side_new_1106103.awb") ~= 0 then
					local var_251_14 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103060", "story_v_side_new_1106103.awb") / 1000

					if var_251_14 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_14 + var_251_6
					end

					if var_251_9.prefab_name ~= "" and arg_248_1.actors_[var_251_9.prefab_name] ~= nil then
						local var_251_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_9.prefab_name].transform, "story_v_side_new_1106103", "1106103060", "story_v_side_new_1106103.awb")

						arg_248_1:RecordAudio("1106103060", var_251_15)
						arg_248_1:RecordAudio("1106103060", var_251_15)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103060", "story_v_side_new_1106103.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103060", "story_v_side_new_1106103.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_16 = math.max(var_251_7, arg_248_1.talkMaxDuration)

			if var_251_6 <= arg_248_1.time_ and arg_248_1.time_ < var_251_6 + var_251_16 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_6) / var_251_16

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_6 + var_251_16 and arg_248_1.time_ < var_251_6 + var_251_16 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play1106103061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 1106103061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play1106103062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["1061ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1061ui_story == nil then
				arg_252_1.var_.characterEffect1061ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect1061ui_story and not isNil(var_255_0) then
					local var_255_4 = Mathf.Lerp(0, 0.5, var_255_3)

					arg_252_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1061ui_story.fillRatio = var_255_4
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1061ui_story then
				local var_255_5 = 0.5

				arg_252_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1061ui_story.fillRatio = var_255_5
			end

			local var_255_6 = 0
			local var_255_7 = 0.125

			if var_255_6 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_8 = arg_252_1:FormatText(StoryNameCfg[7].name)

				arg_252_1.leftNameTxt_.text = var_255_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_9 = arg_252_1:GetWordFromCfg(1106103061)
				local var_255_10 = arg_252_1:FormatText(var_255_9.content)

				arg_252_1.text_.text = var_255_10

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_11 = 5
				local var_255_12 = utf8.len(var_255_10)
				local var_255_13 = var_255_11 <= 0 and var_255_7 or var_255_7 * (var_255_12 / var_255_11)

				if var_255_13 > 0 and var_255_7 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13

					if var_255_13 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_6
					end
				end

				arg_252_1.text_.text = var_255_10
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_7, arg_252_1.talkMaxDuration)

			if var_255_6 <= arg_252_1.time_ and arg_252_1.time_ < var_255_6 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_6) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_6 + var_255_14 and arg_252_1.time_ < var_255_6 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play1106103062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1106103062
		arg_256_1.duration_ = 4.47

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play1106103063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1061ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1061ui_story == nil then
				arg_256_1.var_.characterEffect1061ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect1061ui_story and not isNil(var_259_0) then
					arg_256_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1061ui_story then
				arg_256_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_259_4 = 0

			if var_259_4 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_2")
			end

			local var_259_5 = 0

			if var_259_5 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 then
				arg_256_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_259_6 = 0
			local var_259_7 = 0.575

			if var_259_6 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_8 = arg_256_1:FormatText(StoryNameCfg[612].name)

				arg_256_1.leftNameTxt_.text = var_259_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_9 = arg_256_1:GetWordFromCfg(1106103062)
				local var_259_10 = arg_256_1:FormatText(var_259_9.content)

				arg_256_1.text_.text = var_259_10

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_11 = 23
				local var_259_12 = utf8.len(var_259_10)
				local var_259_13 = var_259_11 <= 0 and var_259_7 or var_259_7 * (var_259_12 / var_259_11)

				if var_259_13 > 0 and var_259_7 < var_259_13 then
					arg_256_1.talkMaxDuration = var_259_13

					if var_259_13 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_13 + var_259_6
					end
				end

				arg_256_1.text_.text = var_259_10
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103062", "story_v_side_new_1106103.awb") ~= 0 then
					local var_259_14 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103062", "story_v_side_new_1106103.awb") / 1000

					if var_259_14 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_14 + var_259_6
					end

					if var_259_9.prefab_name ~= "" and arg_256_1.actors_[var_259_9.prefab_name] ~= nil then
						local var_259_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_9.prefab_name].transform, "story_v_side_new_1106103", "1106103062", "story_v_side_new_1106103.awb")

						arg_256_1:RecordAudio("1106103062", var_259_15)
						arg_256_1:RecordAudio("1106103062", var_259_15)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103062", "story_v_side_new_1106103.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103062", "story_v_side_new_1106103.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_16 = math.max(var_259_7, arg_256_1.talkMaxDuration)

			if var_259_6 <= arg_256_1.time_ and arg_256_1.time_ < var_259_6 + var_259_16 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_6) / var_259_16

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_6 + var_259_16 and arg_256_1.time_ < var_259_6 + var_259_16 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play1106103063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 1106103063
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play1106103064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1061ui_story"]
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1061ui_story == nil then
				arg_260_1.var_.characterEffect1061ui_story = var_263_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.200000002980232

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 and not isNil(var_263_0) then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2

				if arg_260_1.var_.characterEffect1061ui_story and not isNil(var_263_0) then
					local var_263_4 = Mathf.Lerp(0, 0.5, var_263_3)

					arg_260_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1061ui_story.fillRatio = var_263_4
				end
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1061ui_story then
				local var_263_5 = 0.5

				arg_260_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1061ui_story.fillRatio = var_263_5
			end

			local var_263_6 = 0
			local var_263_7 = 0.25

			if var_263_6 < arg_260_1.time_ and arg_260_1.time_ <= var_263_6 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_8 = arg_260_1:FormatText(StoryNameCfg[7].name)

				arg_260_1.leftNameTxt_.text = var_263_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_9 = arg_260_1:GetWordFromCfg(1106103063)
				local var_263_10 = arg_260_1:FormatText(var_263_9.content)

				arg_260_1.text_.text = var_263_10

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_11 = 10
				local var_263_12 = utf8.len(var_263_10)
				local var_263_13 = var_263_11 <= 0 and var_263_7 or var_263_7 * (var_263_12 / var_263_11)

				if var_263_13 > 0 and var_263_7 < var_263_13 then
					arg_260_1.talkMaxDuration = var_263_13

					if var_263_13 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_13 + var_263_6
					end
				end

				arg_260_1.text_.text = var_263_10
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_14 = math.max(var_263_7, arg_260_1.talkMaxDuration)

			if var_263_6 <= arg_260_1.time_ and arg_260_1.time_ < var_263_6 + var_263_14 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_6) / var_263_14

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_6 + var_263_14 and arg_260_1.time_ < var_263_6 + var_263_14 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play1106103064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 1106103064
		arg_264_1.duration_ = 3.9

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play1106103065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1061ui_story"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1061ui_story == nil then
				arg_264_1.var_.characterEffect1061ui_story = var_267_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.200000002980232

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.characterEffect1061ui_story and not isNil(var_267_0) then
					arg_264_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1061ui_story then
				arg_264_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_267_4 = 0

			if var_267_4 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_267_5 = 0

			if var_267_5 < arg_264_1.time_ and arg_264_1.time_ <= var_267_5 + arg_267_0 then
				arg_264_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_267_6 = 0
			local var_267_7 = 0.4

			if var_267_6 < arg_264_1.time_ and arg_264_1.time_ <= var_267_6 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_8 = arg_264_1:FormatText(StoryNameCfg[612].name)

				arg_264_1.leftNameTxt_.text = var_267_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_9 = arg_264_1:GetWordFromCfg(1106103064)
				local var_267_10 = arg_264_1:FormatText(var_267_9.content)

				arg_264_1.text_.text = var_267_10

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_11 = 16
				local var_267_12 = utf8.len(var_267_10)
				local var_267_13 = var_267_11 <= 0 and var_267_7 or var_267_7 * (var_267_12 / var_267_11)

				if var_267_13 > 0 and var_267_7 < var_267_13 then
					arg_264_1.talkMaxDuration = var_267_13

					if var_267_13 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_13 + var_267_6
					end
				end

				arg_264_1.text_.text = var_267_10
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103064", "story_v_side_new_1106103.awb") ~= 0 then
					local var_267_14 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103064", "story_v_side_new_1106103.awb") / 1000

					if var_267_14 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_14 + var_267_6
					end

					if var_267_9.prefab_name ~= "" and arg_264_1.actors_[var_267_9.prefab_name] ~= nil then
						local var_267_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_9.prefab_name].transform, "story_v_side_new_1106103", "1106103064", "story_v_side_new_1106103.awb")

						arg_264_1:RecordAudio("1106103064", var_267_15)
						arg_264_1:RecordAudio("1106103064", var_267_15)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103064", "story_v_side_new_1106103.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103064", "story_v_side_new_1106103.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_16 = math.max(var_267_7, arg_264_1.talkMaxDuration)

			if var_267_6 <= arg_264_1.time_ and arg_264_1.time_ < var_267_6 + var_267_16 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_6) / var_267_16

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_6 + var_267_16 and arg_264_1.time_ < var_267_6 + var_267_16 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play1106103065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 1106103065
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play1106103066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["1061ui_story"]
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.characterEffect1061ui_story == nil then
				arg_268_1.var_.characterEffect1061ui_story = var_271_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_2 = 0.200000002980232

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 and not isNil(var_271_0) then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2

				if arg_268_1.var_.characterEffect1061ui_story and not isNil(var_271_0) then
					local var_271_4 = Mathf.Lerp(0, 0.5, var_271_3)

					arg_268_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_268_1.var_.characterEffect1061ui_story.fillRatio = var_271_4
				end
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.characterEffect1061ui_story then
				local var_271_5 = 0.5

				arg_268_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_268_1.var_.characterEffect1061ui_story.fillRatio = var_271_5
			end

			local var_271_6 = 0
			local var_271_7 = 0.325

			if var_271_6 < arg_268_1.time_ and arg_268_1.time_ <= var_271_6 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_8 = arg_268_1:FormatText(StoryNameCfg[7].name)

				arg_268_1.leftNameTxt_.text = var_271_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_9 = arg_268_1:GetWordFromCfg(1106103065)
				local var_271_10 = arg_268_1:FormatText(var_271_9.content)

				arg_268_1.text_.text = var_271_10

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_11 = 13
				local var_271_12 = utf8.len(var_271_10)
				local var_271_13 = var_271_11 <= 0 and var_271_7 or var_271_7 * (var_271_12 / var_271_11)

				if var_271_13 > 0 and var_271_7 < var_271_13 then
					arg_268_1.talkMaxDuration = var_271_13

					if var_271_13 + var_271_6 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_13 + var_271_6
					end
				end

				arg_268_1.text_.text = var_271_10
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_14 = math.max(var_271_7, arg_268_1.talkMaxDuration)

			if var_271_6 <= arg_268_1.time_ and arg_268_1.time_ < var_271_6 + var_271_14 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_6) / var_271_14

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_6 + var_271_14 and arg_268_1.time_ < var_271_6 + var_271_14 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play1106103066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1106103066
		arg_272_1.duration_ = 4.13

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1106103067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["1061ui_story"]
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect1061ui_story == nil then
				arg_272_1.var_.characterEffect1061ui_story = var_275_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 and not isNil(var_275_0) then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2

				if arg_272_1.var_.characterEffect1061ui_story and not isNil(var_275_0) then
					arg_272_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect1061ui_story then
				arg_272_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_275_4 = 0

			if var_275_4 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_275_5 = 0

			if var_275_5 < arg_272_1.time_ and arg_272_1.time_ <= var_275_5 + arg_275_0 then
				arg_272_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_275_6 = 0
			local var_275_7 = 0.425

			if var_275_6 < arg_272_1.time_ and arg_272_1.time_ <= var_275_6 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_8 = arg_272_1:FormatText(StoryNameCfg[612].name)

				arg_272_1.leftNameTxt_.text = var_275_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_9 = arg_272_1:GetWordFromCfg(1106103066)
				local var_275_10 = arg_272_1:FormatText(var_275_9.content)

				arg_272_1.text_.text = var_275_10

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_11 = 17
				local var_275_12 = utf8.len(var_275_10)
				local var_275_13 = var_275_11 <= 0 and var_275_7 or var_275_7 * (var_275_12 / var_275_11)

				if var_275_13 > 0 and var_275_7 < var_275_13 then
					arg_272_1.talkMaxDuration = var_275_13

					if var_275_13 + var_275_6 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_13 + var_275_6
					end
				end

				arg_272_1.text_.text = var_275_10
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103066", "story_v_side_new_1106103.awb") ~= 0 then
					local var_275_14 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103066", "story_v_side_new_1106103.awb") / 1000

					if var_275_14 + var_275_6 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_14 + var_275_6
					end

					if var_275_9.prefab_name ~= "" and arg_272_1.actors_[var_275_9.prefab_name] ~= nil then
						local var_275_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_9.prefab_name].transform, "story_v_side_new_1106103", "1106103066", "story_v_side_new_1106103.awb")

						arg_272_1:RecordAudio("1106103066", var_275_15)
						arg_272_1:RecordAudio("1106103066", var_275_15)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103066", "story_v_side_new_1106103.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103066", "story_v_side_new_1106103.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_16 = math.max(var_275_7, arg_272_1.talkMaxDuration)

			if var_275_6 <= arg_272_1.time_ and arg_272_1.time_ < var_275_6 + var_275_16 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_6) / var_275_16

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_6 + var_275_16 and arg_272_1.time_ < var_275_6 + var_275_16 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play1106103067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1106103067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play1106103068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["1061ui_story"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect1061ui_story == nil then
				arg_276_1.var_.characterEffect1061ui_story = var_279_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.200000002980232

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.characterEffect1061ui_story and not isNil(var_279_0) then
					local var_279_4 = Mathf.Lerp(0, 0.5, var_279_3)

					arg_276_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1061ui_story.fillRatio = var_279_4
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect1061ui_story then
				local var_279_5 = 0.5

				arg_276_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1061ui_story.fillRatio = var_279_5
			end

			local var_279_6 = 0
			local var_279_7 = 0.525

			if var_279_6 < arg_276_1.time_ and arg_276_1.time_ <= var_279_6 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_8 = arg_276_1:FormatText(StoryNameCfg[7].name)

				arg_276_1.leftNameTxt_.text = var_279_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_9 = arg_276_1:GetWordFromCfg(1106103067)
				local var_279_10 = arg_276_1:FormatText(var_279_9.content)

				arg_276_1.text_.text = var_279_10

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_11 = 21
				local var_279_12 = utf8.len(var_279_10)
				local var_279_13 = var_279_11 <= 0 and var_279_7 or var_279_7 * (var_279_12 / var_279_11)

				if var_279_13 > 0 and var_279_7 < var_279_13 then
					arg_276_1.talkMaxDuration = var_279_13

					if var_279_13 + var_279_6 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_13 + var_279_6
					end
				end

				arg_276_1.text_.text = var_279_10
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_14 = math.max(var_279_7, arg_276_1.talkMaxDuration)

			if var_279_6 <= arg_276_1.time_ and arg_276_1.time_ < var_279_6 + var_279_14 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_6) / var_279_14

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_6 + var_279_14 and arg_276_1.time_ < var_279_6 + var_279_14 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play1106103068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1106103068
		arg_280_1.duration_ = 5.5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play1106103069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["1061ui_story"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1061ui_story == nil then
				arg_280_1.var_.characterEffect1061ui_story = var_283_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.characterEffect1061ui_story and not isNil(var_283_0) then
					arg_280_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1061ui_story then
				arg_280_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_283_4 = 0

			if var_283_4 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action423")
			end

			local var_283_5 = 0

			if var_283_5 < arg_280_1.time_ and arg_280_1.time_ <= var_283_5 + arg_283_0 then
				arg_280_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_283_6 = 0
			local var_283_7 = 0.575

			if var_283_6 < arg_280_1.time_ and arg_280_1.time_ <= var_283_6 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_8 = arg_280_1:FormatText(StoryNameCfg[612].name)

				arg_280_1.leftNameTxt_.text = var_283_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_9 = arg_280_1:GetWordFromCfg(1106103068)
				local var_283_10 = arg_280_1:FormatText(var_283_9.content)

				arg_280_1.text_.text = var_283_10

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_11 = 23
				local var_283_12 = utf8.len(var_283_10)
				local var_283_13 = var_283_11 <= 0 and var_283_7 or var_283_7 * (var_283_12 / var_283_11)

				if var_283_13 > 0 and var_283_7 < var_283_13 then
					arg_280_1.talkMaxDuration = var_283_13

					if var_283_13 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_13 + var_283_6
					end
				end

				arg_280_1.text_.text = var_283_10
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103068", "story_v_side_new_1106103.awb") ~= 0 then
					local var_283_14 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103068", "story_v_side_new_1106103.awb") / 1000

					if var_283_14 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_14 + var_283_6
					end

					if var_283_9.prefab_name ~= "" and arg_280_1.actors_[var_283_9.prefab_name] ~= nil then
						local var_283_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_9.prefab_name].transform, "story_v_side_new_1106103", "1106103068", "story_v_side_new_1106103.awb")

						arg_280_1:RecordAudio("1106103068", var_283_15)
						arg_280_1:RecordAudio("1106103068", var_283_15)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103068", "story_v_side_new_1106103.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103068", "story_v_side_new_1106103.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_16 = math.max(var_283_7, arg_280_1.talkMaxDuration)

			if var_283_6 <= arg_280_1.time_ and arg_280_1.time_ < var_283_6 + var_283_16 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_6) / var_283_16

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_6 + var_283_16 and arg_280_1.time_ < var_283_6 + var_283_16 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play1106103069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1106103069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1106103070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1061ui_story"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1061ui_story == nil then
				arg_284_1.var_.characterEffect1061ui_story = var_287_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.characterEffect1061ui_story and not isNil(var_287_0) then
					local var_287_4 = Mathf.Lerp(0, 0.5, var_287_3)

					arg_284_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1061ui_story.fillRatio = var_287_4
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1061ui_story then
				local var_287_5 = 0.5

				arg_284_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1061ui_story.fillRatio = var_287_5
			end

			local var_287_6 = 0
			local var_287_7 = 0.5

			if var_287_6 < arg_284_1.time_ and arg_284_1.time_ <= var_287_6 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_8 = arg_284_1:FormatText(StoryNameCfg[7].name)

				arg_284_1.leftNameTxt_.text = var_287_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_9 = arg_284_1:GetWordFromCfg(1106103069)
				local var_287_10 = arg_284_1:FormatText(var_287_9.content)

				arg_284_1.text_.text = var_287_10

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_11 = 20
				local var_287_12 = utf8.len(var_287_10)
				local var_287_13 = var_287_11 <= 0 and var_287_7 or var_287_7 * (var_287_12 / var_287_11)

				if var_287_13 > 0 and var_287_7 < var_287_13 then
					arg_284_1.talkMaxDuration = var_287_13

					if var_287_13 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_13 + var_287_6
					end
				end

				arg_284_1.text_.text = var_287_10
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_14 = math.max(var_287_7, arg_284_1.talkMaxDuration)

			if var_287_6 <= arg_284_1.time_ and arg_284_1.time_ < var_287_6 + var_287_14 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_6) / var_287_14

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_6 + var_287_14 and arg_284_1.time_ < var_287_6 + var_287_14 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play1106103070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1106103070
		arg_288_1.duration_ = 2

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1106103071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1061ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1061ui_story == nil then
				arg_288_1.var_.characterEffect1061ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect1061ui_story and not isNil(var_291_0) then
					arg_288_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1061ui_story then
				arg_288_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_291_4 = 0

			if var_291_4 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_291_5 = 0

			if var_291_5 < arg_288_1.time_ and arg_288_1.time_ <= var_291_5 + arg_291_0 then
				arg_288_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_291_6 = 0
			local var_291_7 = 0.1

			if var_291_6 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_8 = arg_288_1:FormatText(StoryNameCfg[612].name)

				arg_288_1.leftNameTxt_.text = var_291_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_9 = arg_288_1:GetWordFromCfg(1106103070)
				local var_291_10 = arg_288_1:FormatText(var_291_9.content)

				arg_288_1.text_.text = var_291_10

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_11 = 4
				local var_291_12 = utf8.len(var_291_10)
				local var_291_13 = var_291_11 <= 0 and var_291_7 or var_291_7 * (var_291_12 / var_291_11)

				if var_291_13 > 0 and var_291_7 < var_291_13 then
					arg_288_1.talkMaxDuration = var_291_13

					if var_291_13 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_13 + var_291_6
					end
				end

				arg_288_1.text_.text = var_291_10
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103070", "story_v_side_new_1106103.awb") ~= 0 then
					local var_291_14 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103070", "story_v_side_new_1106103.awb") / 1000

					if var_291_14 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_14 + var_291_6
					end

					if var_291_9.prefab_name ~= "" and arg_288_1.actors_[var_291_9.prefab_name] ~= nil then
						local var_291_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_9.prefab_name].transform, "story_v_side_new_1106103", "1106103070", "story_v_side_new_1106103.awb")

						arg_288_1:RecordAudio("1106103070", var_291_15)
						arg_288_1:RecordAudio("1106103070", var_291_15)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103070", "story_v_side_new_1106103.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103070", "story_v_side_new_1106103.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_16 = math.max(var_291_7, arg_288_1.talkMaxDuration)

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_16 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_6) / var_291_16

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_6 + var_291_16 and arg_288_1.time_ < var_291_6 + var_291_16 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1106103071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1106103071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1106103072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1061ui_story"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1061ui_story == nil then
				arg_292_1.var_.characterEffect1061ui_story = var_295_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.characterEffect1061ui_story and not isNil(var_295_0) then
					local var_295_4 = Mathf.Lerp(0, 0.5, var_295_3)

					arg_292_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1061ui_story.fillRatio = var_295_4
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1061ui_story then
				local var_295_5 = 0.5

				arg_292_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1061ui_story.fillRatio = var_295_5
			end

			local var_295_6 = 0
			local var_295_7 = 0.375

			if var_295_6 < arg_292_1.time_ and arg_292_1.time_ <= var_295_6 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_8 = arg_292_1:FormatText(StoryNameCfg[7].name)

				arg_292_1.leftNameTxt_.text = var_295_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_9 = arg_292_1:GetWordFromCfg(1106103071)
				local var_295_10 = arg_292_1:FormatText(var_295_9.content)

				arg_292_1.text_.text = var_295_10

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_11 = 15
				local var_295_12 = utf8.len(var_295_10)
				local var_295_13 = var_295_11 <= 0 and var_295_7 or var_295_7 * (var_295_12 / var_295_11)

				if var_295_13 > 0 and var_295_7 < var_295_13 then
					arg_292_1.talkMaxDuration = var_295_13

					if var_295_13 + var_295_6 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_13 + var_295_6
					end
				end

				arg_292_1.text_.text = var_295_10
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_14 = math.max(var_295_7, arg_292_1.talkMaxDuration)

			if var_295_6 <= arg_292_1.time_ and arg_292_1.time_ < var_295_6 + var_295_14 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_6) / var_295_14

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_6 + var_295_14 and arg_292_1.time_ < var_295_6 + var_295_14 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play1106103072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1106103072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1106103073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["1061ui_story"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos1061ui_story = var_299_0.localPosition
			end

			local var_299_2 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2
				local var_299_4 = Vector3.New(0, 100, 0)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1061ui_story, var_299_4, var_299_3)

				local var_299_5 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_5.x, var_299_5.y, var_299_5.z)

				local var_299_6 = var_299_0.localEulerAngles

				var_299_6.z = 0
				var_299_6.x = 0
				var_299_0.localEulerAngles = var_299_6
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(0, 100, 0)

				local var_299_7 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_7.x, var_299_7.y, var_299_7.z)

				local var_299_8 = var_299_0.localEulerAngles

				var_299_8.z = 0
				var_299_8.x = 0
				var_299_0.localEulerAngles = var_299_8
			end

			local var_299_9 = 0
			local var_299_10 = 0.7

			if var_299_9 < arg_296_1.time_ and arg_296_1.time_ <= var_299_9 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_11 = arg_296_1:GetWordFromCfg(1106103072)
				local var_299_12 = arg_296_1:FormatText(var_299_11.content)

				arg_296_1.text_.text = var_299_12

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_13 = 28
				local var_299_14 = utf8.len(var_299_12)
				local var_299_15 = var_299_13 <= 0 and var_299_10 or var_299_10 * (var_299_14 / var_299_13)

				if var_299_15 > 0 and var_299_10 < var_299_15 then
					arg_296_1.talkMaxDuration = var_299_15

					if var_299_15 + var_299_9 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_15 + var_299_9
					end
				end

				arg_296_1.text_.text = var_299_12
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_16 = math.max(var_299_10, arg_296_1.talkMaxDuration)

			if var_299_9 <= arg_296_1.time_ and arg_296_1.time_ < var_299_9 + var_299_16 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_9) / var_299_16

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_9 + var_299_16 and arg_296_1.time_ < var_299_9 + var_299_16 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play1106103073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1106103073
		arg_300_1.duration_ = 7.27

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1106103074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 0.7

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_2 = arg_300_1:FormatText(StoryNameCfg[1357].name)

				arg_300_1.leftNameTxt_.text = var_303_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_3 = arg_300_1:GetWordFromCfg(1106103073)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103073", "story_v_side_new_1106103.awb") ~= 0 then
					local var_303_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103073", "story_v_side_new_1106103.awb") / 1000

					if var_303_8 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_8 + var_303_0
					end

					if var_303_3.prefab_name ~= "" and arg_300_1.actors_[var_303_3.prefab_name] ~= nil then
						local var_303_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_3.prefab_name].transform, "story_v_side_new_1106103", "1106103073", "story_v_side_new_1106103.awb")

						arg_300_1:RecordAudio("1106103073", var_303_9)
						arg_300_1:RecordAudio("1106103073", var_303_9)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103073", "story_v_side_new_1106103.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103073", "story_v_side_new_1106103.awb")
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
	Play1106103074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1106103074
		arg_304_1.duration_ = 6.57

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1106103075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 0.675

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_2 = arg_304_1:FormatText(StoryNameCfg[1357].name)

				arg_304_1.leftNameTxt_.text = var_307_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_3 = arg_304_1:GetWordFromCfg(1106103074)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 27
				local var_307_6 = utf8.len(var_307_4)
				local var_307_7 = var_307_5 <= 0 and var_307_1 or var_307_1 * (var_307_6 / var_307_5)

				if var_307_7 > 0 and var_307_1 < var_307_7 then
					arg_304_1.talkMaxDuration = var_307_7

					if var_307_7 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_4
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103074", "story_v_side_new_1106103.awb") ~= 0 then
					local var_307_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103074", "story_v_side_new_1106103.awb") / 1000

					if var_307_8 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_8 + var_307_0
					end

					if var_307_3.prefab_name ~= "" and arg_304_1.actors_[var_307_3.prefab_name] ~= nil then
						local var_307_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_3.prefab_name].transform, "story_v_side_new_1106103", "1106103074", "story_v_side_new_1106103.awb")

						arg_304_1:RecordAudio("1106103074", var_307_9)
						arg_304_1:RecordAudio("1106103074", var_307_9)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103074", "story_v_side_new_1106103.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103074", "story_v_side_new_1106103.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_10 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_10 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_10

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_10 and arg_304_1.time_ < var_307_0 + var_307_10 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play1106103075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1106103075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1106103076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0
			local var_311_1 = 0.2

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_2 = arg_308_1:FormatText(StoryNameCfg[7].name)

				arg_308_1.leftNameTxt_.text = var_311_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_3 = arg_308_1:GetWordFromCfg(1106103075)
				local var_311_4 = arg_308_1:FormatText(var_311_3.content)

				arg_308_1.text_.text = var_311_4

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_5 = 8
				local var_311_6 = utf8.len(var_311_4)
				local var_311_7 = var_311_5 <= 0 and var_311_1 or var_311_1 * (var_311_6 / var_311_5)

				if var_311_7 > 0 and var_311_1 < var_311_7 then
					arg_308_1.talkMaxDuration = var_311_7

					if var_311_7 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_7 + var_311_0
					end
				end

				arg_308_1.text_.text = var_311_4
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_8 = math.max(var_311_1, arg_308_1.talkMaxDuration)

			if var_311_0 <= arg_308_1.time_ and arg_308_1.time_ < var_311_0 + var_311_8 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_0) / var_311_8

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_0 + var_311_8 and arg_308_1.time_ < var_311_0 + var_311_8 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play1106103076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1106103076
		arg_312_1.duration_ = 2.23

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1106103077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1061ui_story"].transform
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.var_.moveOldPos1061ui_story = var_315_0.localPosition
			end

			local var_315_2 = 0.001

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2
				local var_315_4 = Vector3.New(0, -1.18, -6.15)

				var_315_0.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1061ui_story, var_315_4, var_315_3)

				local var_315_5 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_5.x, var_315_5.y, var_315_5.z)

				local var_315_6 = var_315_0.localEulerAngles

				var_315_6.z = 0
				var_315_6.x = 0
				var_315_0.localEulerAngles = var_315_6
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 then
				var_315_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_315_7 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_7.x, var_315_7.y, var_315_7.z)

				local var_315_8 = var_315_0.localEulerAngles

				var_315_8.z = 0
				var_315_8.x = 0
				var_315_0.localEulerAngles = var_315_8
			end

			local var_315_9 = arg_312_1.actors_["1061ui_story"]
			local var_315_10 = 0

			if var_315_10 < arg_312_1.time_ and arg_312_1.time_ <= var_315_10 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect1061ui_story == nil then
				arg_312_1.var_.characterEffect1061ui_story = var_315_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_11 = 0.200000002980232

			if var_315_10 <= arg_312_1.time_ and arg_312_1.time_ < var_315_10 + var_315_11 and not isNil(var_315_9) then
				local var_315_12 = (arg_312_1.time_ - var_315_10) / var_315_11

				if arg_312_1.var_.characterEffect1061ui_story and not isNil(var_315_9) then
					arg_312_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= var_315_10 + var_315_11 and arg_312_1.time_ < var_315_10 + var_315_11 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect1061ui_story then
				arg_312_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_315_13 = 0

			if var_315_13 < arg_312_1.time_ and arg_312_1.time_ <= var_315_13 + arg_315_0 then
				arg_312_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_315_14 = 0

			if var_315_14 < arg_312_1.time_ and arg_312_1.time_ <= var_315_14 + arg_315_0 then
				arg_312_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_315_15 = 0
			local var_315_16 = 0.275

			if var_315_15 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_17 = arg_312_1:FormatText(StoryNameCfg[612].name)

				arg_312_1.leftNameTxt_.text = var_315_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_18 = arg_312_1:GetWordFromCfg(1106103076)
				local var_315_19 = arg_312_1:FormatText(var_315_18.content)

				arg_312_1.text_.text = var_315_19

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_20 = 11
				local var_315_21 = utf8.len(var_315_19)
				local var_315_22 = var_315_20 <= 0 and var_315_16 or var_315_16 * (var_315_21 / var_315_20)

				if var_315_22 > 0 and var_315_16 < var_315_22 then
					arg_312_1.talkMaxDuration = var_315_22

					if var_315_22 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_22 + var_315_15
					end
				end

				arg_312_1.text_.text = var_315_19
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103076", "story_v_side_new_1106103.awb") ~= 0 then
					local var_315_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103076", "story_v_side_new_1106103.awb") / 1000

					if var_315_23 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_23 + var_315_15
					end

					if var_315_18.prefab_name ~= "" and arg_312_1.actors_[var_315_18.prefab_name] ~= nil then
						local var_315_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_18.prefab_name].transform, "story_v_side_new_1106103", "1106103076", "story_v_side_new_1106103.awb")

						arg_312_1:RecordAudio("1106103076", var_315_24)
						arg_312_1:RecordAudio("1106103076", var_315_24)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103076", "story_v_side_new_1106103.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103076", "story_v_side_new_1106103.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_25 = math.max(var_315_16, arg_312_1.talkMaxDuration)

			if var_315_15 <= arg_312_1.time_ and arg_312_1.time_ < var_315_15 + var_315_25 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_15) / var_315_25

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_15 + var_315_25 and arg_312_1.time_ < var_315_15 + var_315_25 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play1106103077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1106103077
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1106103078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["1061ui_story"].transform
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.var_.moveOldPos1061ui_story = var_319_0.localPosition
			end

			local var_319_2 = 0.001

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2
				local var_319_4 = Vector3.New(0, 100, 0)

				var_319_0.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1061ui_story, var_319_4, var_319_3)

				local var_319_5 = manager.ui.mainCamera.transform.position - var_319_0.position

				var_319_0.forward = Vector3.New(var_319_5.x, var_319_5.y, var_319_5.z)

				local var_319_6 = var_319_0.localEulerAngles

				var_319_6.z = 0
				var_319_6.x = 0
				var_319_0.localEulerAngles = var_319_6
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 then
				var_319_0.localPosition = Vector3.New(0, 100, 0)

				local var_319_7 = manager.ui.mainCamera.transform.position - var_319_0.position

				var_319_0.forward = Vector3.New(var_319_7.x, var_319_7.y, var_319_7.z)

				local var_319_8 = var_319_0.localEulerAngles

				var_319_8.z = 0
				var_319_8.x = 0
				var_319_0.localEulerAngles = var_319_8
			end

			local var_319_9 = arg_316_1.actors_["1061ui_story"]
			local var_319_10 = 0

			if var_319_10 < arg_316_1.time_ and arg_316_1.time_ <= var_319_10 + arg_319_0 and not isNil(var_319_9) and arg_316_1.var_.characterEffect1061ui_story == nil then
				arg_316_1.var_.characterEffect1061ui_story = var_319_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_11 = 0.200000002980232

			if var_319_10 <= arg_316_1.time_ and arg_316_1.time_ < var_319_10 + var_319_11 and not isNil(var_319_9) then
				local var_319_12 = (arg_316_1.time_ - var_319_10) / var_319_11

				if arg_316_1.var_.characterEffect1061ui_story and not isNil(var_319_9) then
					local var_319_13 = Mathf.Lerp(0, 0.5, var_319_12)

					arg_316_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1061ui_story.fillRatio = var_319_13
				end
			end

			if arg_316_1.time_ >= var_319_10 + var_319_11 and arg_316_1.time_ < var_319_10 + var_319_11 + arg_319_0 and not isNil(var_319_9) and arg_316_1.var_.characterEffect1061ui_story then
				local var_319_14 = 0.5

				arg_316_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1061ui_story.fillRatio = var_319_14
			end

			local var_319_15 = 0
			local var_319_16 = 1.15

			if var_319_15 < arg_316_1.time_ and arg_316_1.time_ <= var_319_15 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_17 = arg_316_1:GetWordFromCfg(1106103077)
				local var_319_18 = arg_316_1:FormatText(var_319_17.content)

				arg_316_1.text_.text = var_319_18

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_19 = 46
				local var_319_20 = utf8.len(var_319_18)
				local var_319_21 = var_319_19 <= 0 and var_319_16 or var_319_16 * (var_319_20 / var_319_19)

				if var_319_21 > 0 and var_319_16 < var_319_21 then
					arg_316_1.talkMaxDuration = var_319_21

					if var_319_21 + var_319_15 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_21 + var_319_15
					end
				end

				arg_316_1.text_.text = var_319_18
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_22 = math.max(var_319_16, arg_316_1.talkMaxDuration)

			if var_319_15 <= arg_316_1.time_ and arg_316_1.time_ < var_319_15 + var_319_22 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_15) / var_319_22

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_15 + var_319_22 and arg_316_1.time_ < var_319_15 + var_319_22 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play1106103078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1106103078
		arg_320_1.duration_ = 6.4

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1106103079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.mask_.enabled = true
				arg_320_1.mask_.raycastTarget = true

				arg_320_1:SetGaussion(false)
			end

			local var_323_1 = 1.4

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_1 then
				local var_323_2 = (arg_320_1.time_ - var_323_0) / var_323_1
				local var_323_3 = Color.New(0.01886791, 0.01886791, 0.01886791)

				var_323_3.a = Mathf.Lerp(1, 0, var_323_2)
				arg_320_1.mask_.color = var_323_3
			end

			if arg_320_1.time_ >= var_323_0 + var_323_1 and arg_320_1.time_ < var_323_0 + var_323_1 + arg_323_0 then
				local var_323_4 = Color.New(0.01886791, 0.01886791, 0.01886791)
				local var_323_5 = 0

				arg_320_1.mask_.enabled = false
				var_323_4.a = var_323_5
				arg_320_1.mask_.color = var_323_4
			end

			if arg_320_1.frameCnt_ <= 1 then
				arg_320_1.dialog_:SetActive(false)
			end

			local var_323_6 = 1.4
			local var_323_7 = 0.15

			if var_323_6 < arg_320_1.time_ and arg_320_1.time_ <= var_323_6 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0

				arg_320_1.dialog_:SetActive(true)

				arg_320_1.dialogCg_.alpha = 0

				local var_323_8 = LeanTween.value(arg_320_1.dialog_, 0, 1, 0.3)

				var_323_8:setOnUpdate(LuaHelper.FloatAction(function(arg_324_0)
					arg_320_1.dialogCg_.alpha = arg_324_0
				end))
				var_323_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_320_1.dialog_)
					var_323_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_320_1.duration_ = arg_320_1.duration_ + 0.3

				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_9 = arg_320_1:GetWordFromCfg(1106103078)
				local var_323_10 = arg_320_1:FormatText(var_323_9.content)

				arg_320_1.text_.text = var_323_10

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_11 = 6
				local var_323_12 = utf8.len(var_323_10)
				local var_323_13 = var_323_11 <= 0 and var_323_7 or var_323_7 * (var_323_12 / var_323_11)

				if var_323_13 > 0 and var_323_7 < var_323_13 then
					arg_320_1.talkMaxDuration = var_323_13
					var_323_6 = var_323_6 + 0.3

					if var_323_13 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_13 + var_323_6
					end
				end

				arg_320_1.text_.text = var_323_10
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_14 = var_323_6 + 0.3
			local var_323_15 = math.max(var_323_7, arg_320_1.talkMaxDuration)

			if var_323_14 <= arg_320_1.time_ and arg_320_1.time_ < var_323_14 + var_323_15 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_14) / var_323_15

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_14 + var_323_15 and arg_320_1.time_ < var_323_14 + var_323_15 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1106103079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1106103079
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1106103080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.2

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[7].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_3 = arg_326_1:GetWordFromCfg(1106103079)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 8
				local var_329_6 = utf8.len(var_329_4)
				local var_329_7 = var_329_5 <= 0 and var_329_1 or var_329_1 * (var_329_6 / var_329_5)

				if var_329_7 > 0 and var_329_1 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_8 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_8 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_8

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_8 and arg_326_1.time_ < var_329_0 + var_329_8 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1106103080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1106103080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1106103081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 1

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				local var_333_2 = "play"
				local var_333_3 = "effect"

				arg_330_1:AudioAction(var_333_2, var_333_3, "se_story_side_1061", "se_story_side_1061_drop", "")
			end

			local var_333_4 = 0
			local var_333_5 = 0.95

			if var_333_4 < arg_330_1.time_ and arg_330_1.time_ <= var_333_4 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_6 = arg_330_1:GetWordFromCfg(1106103080)
				local var_333_7 = arg_330_1:FormatText(var_333_6.content)

				arg_330_1.text_.text = var_333_7

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_8 = 38
				local var_333_9 = utf8.len(var_333_7)
				local var_333_10 = var_333_8 <= 0 and var_333_5 or var_333_5 * (var_333_9 / var_333_8)

				if var_333_10 > 0 and var_333_5 < var_333_10 then
					arg_330_1.talkMaxDuration = var_333_10

					if var_333_10 + var_333_4 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_10 + var_333_4
					end
				end

				arg_330_1.text_.text = var_333_7
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_11 = math.max(var_333_5, arg_330_1.talkMaxDuration)

			if var_333_4 <= arg_330_1.time_ and arg_330_1.time_ < var_333_4 + var_333_11 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_4) / var_333_11

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_4 + var_333_11 and arg_330_1.time_ < var_333_4 + var_333_11 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1106103081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1106103081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1106103082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.125

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_2 = arg_334_1:FormatText(StoryNameCfg[7].name)

				arg_334_1.leftNameTxt_.text = var_337_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:GetWordFromCfg(1106103081)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 5
				local var_337_6 = utf8.len(var_337_4)
				local var_337_7 = var_337_5 <= 0 and var_337_1 or var_337_1 * (var_337_6 / var_337_5)

				if var_337_7 > 0 and var_337_1 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7

					if var_337_7 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_8 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_8 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_8

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_8 and arg_334_1.time_ < var_337_0 + var_337_8 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play1106103082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1106103082
		arg_338_1.duration_ = 1.3

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1106103083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1061ui_story"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1061ui_story == nil then
				arg_338_1.var_.characterEffect1061ui_story = var_341_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.characterEffect1061ui_story and not isNil(var_341_0) then
					arg_338_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1061ui_story then
				arg_338_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_341_4 = 0
			local var_341_5 = 0.125

			if var_341_4 < arg_338_1.time_ and arg_338_1.time_ <= var_341_4 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_6 = arg_338_1:FormatText(StoryNameCfg[612].name)

				arg_338_1.leftNameTxt_.text = var_341_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_7 = arg_338_1:GetWordFromCfg(1106103082)
				local var_341_8 = arg_338_1:FormatText(var_341_7.content)

				arg_338_1.text_.text = var_341_8

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_9 = 5
				local var_341_10 = utf8.len(var_341_8)
				local var_341_11 = var_341_9 <= 0 and var_341_5 or var_341_5 * (var_341_10 / var_341_9)

				if var_341_11 > 0 and var_341_5 < var_341_11 then
					arg_338_1.talkMaxDuration = var_341_11

					if var_341_11 + var_341_4 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_11 + var_341_4
					end
				end

				arg_338_1.text_.text = var_341_8
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103082", "story_v_side_new_1106103.awb") ~= 0 then
					local var_341_12 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103082", "story_v_side_new_1106103.awb") / 1000

					if var_341_12 + var_341_4 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_12 + var_341_4
					end

					if var_341_7.prefab_name ~= "" and arg_338_1.actors_[var_341_7.prefab_name] ~= nil then
						local var_341_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_7.prefab_name].transform, "story_v_side_new_1106103", "1106103082", "story_v_side_new_1106103.awb")

						arg_338_1:RecordAudio("1106103082", var_341_13)
						arg_338_1:RecordAudio("1106103082", var_341_13)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103082", "story_v_side_new_1106103.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103082", "story_v_side_new_1106103.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_14 = math.max(var_341_5, arg_338_1.talkMaxDuration)

			if var_341_4 <= arg_338_1.time_ and arg_338_1.time_ < var_341_4 + var_341_14 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_4) / var_341_14

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_4 + var_341_14 and arg_338_1.time_ < var_341_4 + var_341_14 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play1106103083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1106103083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1106103084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1061ui_story"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1061ui_story == nil then
				arg_342_1.var_.characterEffect1061ui_story = var_345_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.characterEffect1061ui_story and not isNil(var_345_0) then
					local var_345_4 = Mathf.Lerp(0, 0.5, var_345_3)

					arg_342_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1061ui_story.fillRatio = var_345_4
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1061ui_story then
				local var_345_5 = 0.5

				arg_342_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1061ui_story.fillRatio = var_345_5
			end

			local var_345_6 = 0
			local var_345_7 = 0.225

			if var_345_6 < arg_342_1.time_ and arg_342_1.time_ <= var_345_6 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_8 = arg_342_1:FormatText(StoryNameCfg[7].name)

				arg_342_1.leftNameTxt_.text = var_345_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_9 = arg_342_1:GetWordFromCfg(1106103083)
				local var_345_10 = arg_342_1:FormatText(var_345_9.content)

				arg_342_1.text_.text = var_345_10

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_11 = 9
				local var_345_12 = utf8.len(var_345_10)
				local var_345_13 = var_345_11 <= 0 and var_345_7 or var_345_7 * (var_345_12 / var_345_11)

				if var_345_13 > 0 and var_345_7 < var_345_13 then
					arg_342_1.talkMaxDuration = var_345_13

					if var_345_13 + var_345_6 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_13 + var_345_6
					end
				end

				arg_342_1.text_.text = var_345_10
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_14 = math.max(var_345_7, arg_342_1.talkMaxDuration)

			if var_345_6 <= arg_342_1.time_ and arg_342_1.time_ < var_345_6 + var_345_14 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_6) / var_345_14

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_6 + var_345_14 and arg_342_1.time_ < var_345_6 + var_345_14 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play1106103084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1106103084
		arg_346_1.duration_ = 3.17

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1106103085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1061ui_story"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1061ui_story == nil then
				arg_346_1.var_.characterEffect1061ui_story = var_349_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.characterEffect1061ui_story and not isNil(var_349_0) then
					arg_346_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1061ui_story then
				arg_346_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_349_4 = 0
			local var_349_5 = 0.3

			if var_349_4 < arg_346_1.time_ and arg_346_1.time_ <= var_349_4 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_6 = arg_346_1:FormatText(StoryNameCfg[612].name)

				arg_346_1.leftNameTxt_.text = var_349_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_7 = arg_346_1:GetWordFromCfg(1106103084)
				local var_349_8 = arg_346_1:FormatText(var_349_7.content)

				arg_346_1.text_.text = var_349_8

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_9 = 12
				local var_349_10 = utf8.len(var_349_8)
				local var_349_11 = var_349_9 <= 0 and var_349_5 or var_349_5 * (var_349_10 / var_349_9)

				if var_349_11 > 0 and var_349_5 < var_349_11 then
					arg_346_1.talkMaxDuration = var_349_11

					if var_349_11 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_11 + var_349_4
					end
				end

				arg_346_1.text_.text = var_349_8
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103084", "story_v_side_new_1106103.awb") ~= 0 then
					local var_349_12 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103084", "story_v_side_new_1106103.awb") / 1000

					if var_349_12 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_12 + var_349_4
					end

					if var_349_7.prefab_name ~= "" and arg_346_1.actors_[var_349_7.prefab_name] ~= nil then
						local var_349_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_7.prefab_name].transform, "story_v_side_new_1106103", "1106103084", "story_v_side_new_1106103.awb")

						arg_346_1:RecordAudio("1106103084", var_349_13)
						arg_346_1:RecordAudio("1106103084", var_349_13)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103084", "story_v_side_new_1106103.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103084", "story_v_side_new_1106103.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_14 = math.max(var_349_5, arg_346_1.talkMaxDuration)

			if var_349_4 <= arg_346_1.time_ and arg_346_1.time_ < var_349_4 + var_349_14 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_4) / var_349_14

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_4 + var_349_14 and arg_346_1.time_ < var_349_4 + var_349_14 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play1106103085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1106103085
		arg_350_1.duration_ = 6.9

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1106103086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0.566666666666667

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				local var_353_1 = manager.ui.mainCamera.transform.localPosition
				local var_353_2 = Vector3.New(0, 0, 10) + Vector3.New(var_353_1.x, var_353_1.y, 0)
				local var_353_3 = arg_350_1.bgs_.ST29

				var_353_3.transform.localPosition = var_353_2
				var_353_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_353_4 = var_353_3:GetComponent("SpriteRenderer")

				if var_353_4 and var_353_4.sprite then
					local var_353_5 = (var_353_3.transform.localPosition - var_353_1).z
					local var_353_6 = manager.ui.mainCameraCom_
					local var_353_7 = 2 * var_353_5 * Mathf.Tan(var_353_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_353_8 = var_353_7 * var_353_6.aspect
					local var_353_9 = var_353_4.sprite.bounds.size.x
					local var_353_10 = var_353_4.sprite.bounds.size.y
					local var_353_11 = var_353_8 / var_353_9
					local var_353_12 = var_353_7 / var_353_10
					local var_353_13 = var_353_12 < var_353_11 and var_353_11 or var_353_12

					var_353_3.transform.localScale = Vector3.New(var_353_13, var_353_13, 0)
				end

				for iter_353_0, iter_353_1 in pairs(arg_350_1.bgs_) do
					if iter_353_0 ~= "ST29" then
						iter_353_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_353_14 = 2.1

			if var_353_14 < arg_350_1.time_ and arg_350_1.time_ <= var_353_14 + arg_353_0 then
				arg_350_1.allBtn_.enabled = false
			end

			local var_353_15 = 0.3

			if arg_350_1.time_ >= var_353_14 + var_353_15 and arg_350_1.time_ < var_353_14 + var_353_15 + arg_353_0 then
				arg_350_1.allBtn_.enabled = true
			end

			local var_353_16 = 0

			if var_353_16 < arg_350_1.time_ and arg_350_1.time_ <= var_353_16 + arg_353_0 then
				arg_350_1.mask_.enabled = true
				arg_350_1.mask_.raycastTarget = true

				arg_350_1:SetGaussion(false)
			end

			local var_353_17 = 0.566666666666667

			if var_353_16 <= arg_350_1.time_ and arg_350_1.time_ < var_353_16 + var_353_17 then
				local var_353_18 = (arg_350_1.time_ - var_353_16) / var_353_17
				local var_353_19 = Color.New(0, 0, 0)

				var_353_19.a = Mathf.Lerp(0, 1, var_353_18)
				arg_350_1.mask_.color = var_353_19
			end

			if arg_350_1.time_ >= var_353_16 + var_353_17 and arg_350_1.time_ < var_353_16 + var_353_17 + arg_353_0 then
				local var_353_20 = Color.New(0, 0, 0)

				var_353_20.a = 1
				arg_350_1.mask_.color = var_353_20
			end

			local var_353_21 = 0.566666666666667

			if var_353_21 < arg_350_1.time_ and arg_350_1.time_ <= var_353_21 + arg_353_0 then
				arg_350_1.mask_.enabled = true
				arg_350_1.mask_.raycastTarget = true

				arg_350_1:SetGaussion(false)
			end

			local var_353_22 = 1.53333333333333

			if var_353_21 <= arg_350_1.time_ and arg_350_1.time_ < var_353_21 + var_353_22 then
				local var_353_23 = (arg_350_1.time_ - var_353_21) / var_353_22
				local var_353_24 = Color.New(0, 0, 0)

				var_353_24.a = Mathf.Lerp(1, 0, var_353_23)
				arg_350_1.mask_.color = var_353_24
			end

			if arg_350_1.time_ >= var_353_21 + var_353_22 and arg_350_1.time_ < var_353_21 + var_353_22 + arg_353_0 then
				local var_353_25 = Color.New(0, 0, 0)
				local var_353_26 = 0

				arg_350_1.mask_.enabled = false
				var_353_25.a = var_353_26
				arg_350_1.mask_.color = var_353_25
			end

			local var_353_27 = arg_350_1.actors_["1061ui_story"]
			local var_353_28 = 0.466666666666667

			if var_353_28 < arg_350_1.time_ and arg_350_1.time_ <= var_353_28 + arg_353_0 and not isNil(var_353_27) and arg_350_1.var_.characterEffect1061ui_story == nil then
				arg_350_1.var_.characterEffect1061ui_story = var_353_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_29 = 0.1

			if var_353_28 <= arg_350_1.time_ and arg_350_1.time_ < var_353_28 + var_353_29 and not isNil(var_353_27) then
				local var_353_30 = (arg_350_1.time_ - var_353_28) / var_353_29

				if arg_350_1.var_.characterEffect1061ui_story and not isNil(var_353_27) then
					local var_353_31 = Mathf.Lerp(0, 0.5, var_353_30)

					arg_350_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_350_1.var_.characterEffect1061ui_story.fillRatio = var_353_31
				end
			end

			if arg_350_1.time_ >= var_353_28 + var_353_29 and arg_350_1.time_ < var_353_28 + var_353_29 + arg_353_0 and not isNil(var_353_27) and arg_350_1.var_.characterEffect1061ui_story then
				local var_353_32 = 0.5

				arg_350_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_350_1.var_.characterEffect1061ui_story.fillRatio = var_353_32
			end

			if arg_350_1.frameCnt_ <= 1 then
				arg_350_1.dialog_:SetActive(false)
			end

			local var_353_33 = 1.9
			local var_353_34 = 0.5

			if var_353_33 < arg_350_1.time_ and arg_350_1.time_ <= var_353_33 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0

				arg_350_1.dialog_:SetActive(true)

				arg_350_1.dialogCg_.alpha = 0

				local var_353_35 = LeanTween.value(arg_350_1.dialog_, 0, 1, 0.3)

				var_353_35:setOnUpdate(LuaHelper.FloatAction(function(arg_354_0)
					arg_350_1.dialogCg_.alpha = arg_354_0
				end))
				var_353_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_350_1.dialog_)
					var_353_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_350_1.duration_ = arg_350_1.duration_ + 0.3

				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_36 = arg_350_1:GetWordFromCfg(1106103085)
				local var_353_37 = arg_350_1:FormatText(var_353_36.content)

				arg_350_1.text_.text = var_353_37

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_38 = 20
				local var_353_39 = utf8.len(var_353_37)
				local var_353_40 = var_353_38 <= 0 and var_353_34 or var_353_34 * (var_353_39 / var_353_38)

				if var_353_40 > 0 and var_353_34 < var_353_40 then
					arg_350_1.talkMaxDuration = var_353_40
					var_353_33 = var_353_33 + 0.3

					if var_353_40 + var_353_33 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_40 + var_353_33
					end
				end

				arg_350_1.text_.text = var_353_37
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_41 = var_353_33 + 0.3
			local var_353_42 = math.max(var_353_34, arg_350_1.talkMaxDuration)

			if var_353_41 <= arg_350_1.time_ and arg_350_1.time_ < var_353_41 + var_353_42 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_41) / var_353_42

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_41 + var_353_42 and arg_350_1.time_ < var_353_41 + var_353_42 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play1106103086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1106103086
		arg_356_1.duration_ = 5.27

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1106103087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 0.625

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_2 = arg_356_1:FormatText(StoryNameCfg[1357].name)

				arg_356_1.leftNameTxt_.text = var_359_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_3 = arg_356_1:GetWordFromCfg(1106103086)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 25
				local var_359_6 = utf8.len(var_359_4)
				local var_359_7 = var_359_5 <= 0 and var_359_1 or var_359_1 * (var_359_6 / var_359_5)

				if var_359_7 > 0 and var_359_1 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103086", "story_v_side_new_1106103.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103086", "story_v_side_new_1106103.awb") / 1000

					if var_359_8 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_0
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_side_new_1106103", "1106103086", "story_v_side_new_1106103.awb")

						arg_356_1:RecordAudio("1106103086", var_359_9)
						arg_356_1:RecordAudio("1106103086", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103086", "story_v_side_new_1106103.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103086", "story_v_side_new_1106103.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_10 and arg_356_1.time_ < var_359_0 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1106103087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1106103087
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1106103088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0.733333333333333
			local var_363_1 = 1

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				local var_363_2 = "play"
				local var_363_3 = "effect"

				arg_360_1:AudioAction(var_363_2, var_363_3, "se_story_side_1061", "se_story_side_1061_teacup02", "")
			end

			local var_363_4 = 0
			local var_363_5 = 0.525

			if var_363_4 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_6 = arg_360_1:GetWordFromCfg(1106103087)
				local var_363_7 = arg_360_1:FormatText(var_363_6.content)

				arg_360_1.text_.text = var_363_7

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_8 = 21
				local var_363_9 = utf8.len(var_363_7)
				local var_363_10 = var_363_8 <= 0 and var_363_5 or var_363_5 * (var_363_9 / var_363_8)

				if var_363_10 > 0 and var_363_5 < var_363_10 then
					arg_360_1.talkMaxDuration = var_363_10

					if var_363_10 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_10 + var_363_4
					end
				end

				arg_360_1.text_.text = var_363_7
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_11 = math.max(var_363_5, arg_360_1.talkMaxDuration)

			if var_363_4 <= arg_360_1.time_ and arg_360_1.time_ < var_363_4 + var_363_11 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_4) / var_363_11

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_4 + var_363_11 and arg_360_1.time_ < var_363_4 + var_363_11 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play1106103088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1106103088
		arg_364_1.duration_ = 1.9

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1106103089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.2

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[1357].name)

				arg_364_1.leftNameTxt_.text = var_367_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_3 = arg_364_1:GetWordFromCfg(1106103088)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 8
				local var_367_6 = utf8.len(var_367_4)
				local var_367_7 = var_367_5 <= 0 and var_367_1 or var_367_1 * (var_367_6 / var_367_5)

				if var_367_7 > 0 and var_367_1 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103088", "story_v_side_new_1106103.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103088", "story_v_side_new_1106103.awb") / 1000

					if var_367_8 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_0
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_side_new_1106103", "1106103088", "story_v_side_new_1106103.awb")

						arg_364_1:RecordAudio("1106103088", var_367_9)
						arg_364_1:RecordAudio("1106103088", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103088", "story_v_side_new_1106103.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103088", "story_v_side_new_1106103.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_10 and arg_364_1.time_ < var_367_0 + var_367_10 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1106103089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1106103089
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1106103090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.2

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[7].name)

				arg_368_1.leftNameTxt_.text = var_371_2

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

				local var_371_3 = arg_368_1:GetWordFromCfg(1106103089)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 8
				local var_371_6 = utf8.len(var_371_4)
				local var_371_7 = var_371_5 <= 0 and var_371_1 or var_371_1 * (var_371_6 / var_371_5)

				if var_371_7 > 0 and var_371_1 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_8 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_8 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_8

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_8 and arg_368_1.time_ < var_371_0 + var_371_8 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play1106103090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1106103090
		arg_372_1.duration_ = 5.33

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1106103091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0
			local var_375_1 = 0.725

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_2 = arg_372_1:FormatText(StoryNameCfg[1357].name)

				arg_372_1.leftNameTxt_.text = var_375_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_3 = arg_372_1:GetWordFromCfg(1106103090)
				local var_375_4 = arg_372_1:FormatText(var_375_3.content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 29
				local var_375_6 = utf8.len(var_375_4)
				local var_375_7 = var_375_5 <= 0 and var_375_1 or var_375_1 * (var_375_6 / var_375_5)

				if var_375_7 > 0 and var_375_1 < var_375_7 then
					arg_372_1.talkMaxDuration = var_375_7

					if var_375_7 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_7 + var_375_0
					end
				end

				arg_372_1.text_.text = var_375_4
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103090", "story_v_side_new_1106103.awb") ~= 0 then
					local var_375_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103090", "story_v_side_new_1106103.awb") / 1000

					if var_375_8 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_8 + var_375_0
					end

					if var_375_3.prefab_name ~= "" and arg_372_1.actors_[var_375_3.prefab_name] ~= nil then
						local var_375_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_3.prefab_name].transform, "story_v_side_new_1106103", "1106103090", "story_v_side_new_1106103.awb")

						arg_372_1:RecordAudio("1106103090", var_375_9)
						arg_372_1:RecordAudio("1106103090", var_375_9)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103090", "story_v_side_new_1106103.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103090", "story_v_side_new_1106103.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_10 = math.max(var_375_1, arg_372_1.talkMaxDuration)

			if var_375_0 <= arg_372_1.time_ and arg_372_1.time_ < var_375_0 + var_375_10 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_0) / var_375_10

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_0 + var_375_10 and arg_372_1.time_ < var_375_0 + var_375_10 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1106103091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1106103091
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1106103092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 0.525

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

				local var_379_3 = arg_376_1:GetWordFromCfg(1106103091)
				local var_379_4 = arg_376_1:FormatText(var_379_3.content)

				arg_376_1.text_.text = var_379_4

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 21
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
	Play1106103092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1106103092
		arg_380_1.duration_ = 3.3

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1106103093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 0.375

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_2 = arg_380_1:FormatText(StoryNameCfg[1357].name)

				arg_380_1.leftNameTxt_.text = var_383_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_3 = arg_380_1:GetWordFromCfg(1106103092)
				local var_383_4 = arg_380_1:FormatText(var_383_3.content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 15
				local var_383_6 = utf8.len(var_383_4)
				local var_383_7 = var_383_5 <= 0 and var_383_1 or var_383_1 * (var_383_6 / var_383_5)

				if var_383_7 > 0 and var_383_1 < var_383_7 then
					arg_380_1.talkMaxDuration = var_383_7

					if var_383_7 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_7 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103092", "story_v_side_new_1106103.awb") ~= 0 then
					local var_383_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103092", "story_v_side_new_1106103.awb") / 1000

					if var_383_8 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_8 + var_383_0
					end

					if var_383_3.prefab_name ~= "" and arg_380_1.actors_[var_383_3.prefab_name] ~= nil then
						local var_383_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_3.prefab_name].transform, "story_v_side_new_1106103", "1106103092", "story_v_side_new_1106103.awb")

						arg_380_1:RecordAudio("1106103092", var_383_9)
						arg_380_1:RecordAudio("1106103092", var_383_9)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103092", "story_v_side_new_1106103.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103092", "story_v_side_new_1106103.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_10 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_10 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_10

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_10 and arg_380_1.time_ < var_383_0 + var_383_10 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1106103093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1106103093
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1106103094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0
			local var_387_1 = 0.475

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_2 = arg_384_1:FormatText(StoryNameCfg[7].name)

				arg_384_1.leftNameTxt_.text = var_387_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_3 = arg_384_1:GetWordFromCfg(1106103093)
				local var_387_4 = arg_384_1:FormatText(var_387_3.content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 19
				local var_387_6 = utf8.len(var_387_4)
				local var_387_7 = var_387_5 <= 0 and var_387_1 or var_387_1 * (var_387_6 / var_387_5)

				if var_387_7 > 0 and var_387_1 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_0
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_8 = math.max(var_387_1, arg_384_1.talkMaxDuration)

			if var_387_0 <= arg_384_1.time_ and arg_384_1.time_ < var_387_0 + var_387_8 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_0) / var_387_8

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_0 + var_387_8 and arg_384_1.time_ < var_387_0 + var_387_8 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play1106103094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1106103094
		arg_388_1.duration_ = 5.8

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1106103095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0
			local var_391_1 = 0.55

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_2 = arg_388_1:FormatText(StoryNameCfg[1357].name)

				arg_388_1.leftNameTxt_.text = var_391_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_3 = arg_388_1:GetWordFromCfg(1106103094)
				local var_391_4 = arg_388_1:FormatText(var_391_3.content)

				arg_388_1.text_.text = var_391_4

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_5 = 22
				local var_391_6 = utf8.len(var_391_4)
				local var_391_7 = var_391_5 <= 0 and var_391_1 or var_391_1 * (var_391_6 / var_391_5)

				if var_391_7 > 0 and var_391_1 < var_391_7 then
					arg_388_1.talkMaxDuration = var_391_7

					if var_391_7 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_7 + var_391_0
					end
				end

				arg_388_1.text_.text = var_391_4
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103094", "story_v_side_new_1106103.awb") ~= 0 then
					local var_391_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103094", "story_v_side_new_1106103.awb") / 1000

					if var_391_8 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_8 + var_391_0
					end

					if var_391_3.prefab_name ~= "" and arg_388_1.actors_[var_391_3.prefab_name] ~= nil then
						local var_391_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_3.prefab_name].transform, "story_v_side_new_1106103", "1106103094", "story_v_side_new_1106103.awb")

						arg_388_1:RecordAudio("1106103094", var_391_9)
						arg_388_1:RecordAudio("1106103094", var_391_9)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103094", "story_v_side_new_1106103.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103094", "story_v_side_new_1106103.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_10 = math.max(var_391_1, arg_388_1.talkMaxDuration)

			if var_391_0 <= arg_388_1.time_ and arg_388_1.time_ < var_391_0 + var_391_10 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_0) / var_391_10

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_0 + var_391_10 and arg_388_1.time_ < var_391_0 + var_391_10 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play1106103095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1106103095
		arg_392_1.duration_ = 7.77

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1106103096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0
			local var_395_1 = 0.875

			if var_395_0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_2 = arg_392_1:FormatText(StoryNameCfg[1357].name)

				arg_392_1.leftNameTxt_.text = var_395_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_3 = arg_392_1:GetWordFromCfg(1106103095)
				local var_395_4 = arg_392_1:FormatText(var_395_3.content)

				arg_392_1.text_.text = var_395_4

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103095", "story_v_side_new_1106103.awb") ~= 0 then
					local var_395_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103095", "story_v_side_new_1106103.awb") / 1000

					if var_395_8 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_8 + var_395_0
					end

					if var_395_3.prefab_name ~= "" and arg_392_1.actors_[var_395_3.prefab_name] ~= nil then
						local var_395_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_3.prefab_name].transform, "story_v_side_new_1106103", "1106103095", "story_v_side_new_1106103.awb")

						arg_392_1:RecordAudio("1106103095", var_395_9)
						arg_392_1:RecordAudio("1106103095", var_395_9)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103095", "story_v_side_new_1106103.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103095", "story_v_side_new_1106103.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_10 = math.max(var_395_1, arg_392_1.talkMaxDuration)

			if var_395_0 <= arg_392_1.time_ and arg_392_1.time_ < var_395_0 + var_395_10 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_0) / var_395_10

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_0 + var_395_10 and arg_392_1.time_ < var_395_0 + var_395_10 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play1106103096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1106103096
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1106103097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0
			local var_399_1 = 0.35

			if var_399_0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_2 = arg_396_1:FormatText(StoryNameCfg[7].name)

				arg_396_1.leftNameTxt_.text = var_399_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_3 = arg_396_1:GetWordFromCfg(1106103096)
				local var_399_4 = arg_396_1:FormatText(var_399_3.content)

				arg_396_1.text_.text = var_399_4

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_5 = 14
				local var_399_6 = utf8.len(var_399_4)
				local var_399_7 = var_399_5 <= 0 and var_399_1 or var_399_1 * (var_399_6 / var_399_5)

				if var_399_7 > 0 and var_399_1 < var_399_7 then
					arg_396_1.talkMaxDuration = var_399_7

					if var_399_7 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_0
					end
				end

				arg_396_1.text_.text = var_399_4
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_8 = math.max(var_399_1, arg_396_1.talkMaxDuration)

			if var_399_0 <= arg_396_1.time_ and arg_396_1.time_ < var_399_0 + var_399_8 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_0) / var_399_8

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_0 + var_399_8 and arg_396_1.time_ < var_399_0 + var_399_8 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play1106103097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1106103097
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1106103098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 0.625

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

				local var_403_2 = arg_400_1:GetWordFromCfg(1106103097)
				local var_403_3 = arg_400_1:FormatText(var_403_2.content)

				arg_400_1.text_.text = var_403_3

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_4 = 25
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
	Play1106103098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1106103098
		arg_404_1.duration_ = 7.87

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1106103099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0
			local var_407_1 = 0.825

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_2 = arg_404_1:FormatText(StoryNameCfg[1357].name)

				arg_404_1.leftNameTxt_.text = var_407_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_3 = arg_404_1:GetWordFromCfg(1106103098)
				local var_407_4 = arg_404_1:FormatText(var_407_3.content)

				arg_404_1.text_.text = var_407_4

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103098", "story_v_side_new_1106103.awb") ~= 0 then
					local var_407_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103098", "story_v_side_new_1106103.awb") / 1000

					if var_407_8 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_8 + var_407_0
					end

					if var_407_3.prefab_name ~= "" and arg_404_1.actors_[var_407_3.prefab_name] ~= nil then
						local var_407_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_3.prefab_name].transform, "story_v_side_new_1106103", "1106103098", "story_v_side_new_1106103.awb")

						arg_404_1:RecordAudio("1106103098", var_407_9)
						arg_404_1:RecordAudio("1106103098", var_407_9)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103098", "story_v_side_new_1106103.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103098", "story_v_side_new_1106103.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_10 = math.max(var_407_1, arg_404_1.talkMaxDuration)

			if var_407_0 <= arg_404_1.time_ and arg_404_1.time_ < var_407_0 + var_407_10 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_0) / var_407_10

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_0 + var_407_10 and arg_404_1.time_ < var_407_0 + var_407_10 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play1106103099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1106103099
		arg_408_1.duration_ = 7.9

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1106103100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 0.825

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_2 = arg_408_1:FormatText(StoryNameCfg[1357].name)

				arg_408_1.leftNameTxt_.text = var_411_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_3 = arg_408_1:GetWordFromCfg(1106103099)
				local var_411_4 = arg_408_1:FormatText(var_411_3.content)

				arg_408_1.text_.text = var_411_4

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 33
				local var_411_6 = utf8.len(var_411_4)
				local var_411_7 = var_411_5 <= 0 and var_411_1 or var_411_1 * (var_411_6 / var_411_5)

				if var_411_7 > 0 and var_411_1 < var_411_7 then
					arg_408_1.talkMaxDuration = var_411_7

					if var_411_7 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_7 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_4
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103099", "story_v_side_new_1106103.awb") ~= 0 then
					local var_411_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103099", "story_v_side_new_1106103.awb") / 1000

					if var_411_8 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_8 + var_411_0
					end

					if var_411_3.prefab_name ~= "" and arg_408_1.actors_[var_411_3.prefab_name] ~= nil then
						local var_411_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_3.prefab_name].transform, "story_v_side_new_1106103", "1106103099", "story_v_side_new_1106103.awb")

						arg_408_1:RecordAudio("1106103099", var_411_9)
						arg_408_1:RecordAudio("1106103099", var_411_9)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103099", "story_v_side_new_1106103.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103099", "story_v_side_new_1106103.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_10 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_10 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_10

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_10 and arg_408_1.time_ < var_411_0 + var_411_10 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1106103100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1106103100
		arg_412_1.duration_ = 5.5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1106103101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 0.6

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_2 = arg_412_1:FormatText(StoryNameCfg[1357].name)

				arg_412_1.leftNameTxt_.text = var_415_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_3 = arg_412_1:GetWordFromCfg(1106103100)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103100", "story_v_side_new_1106103.awb") ~= 0 then
					local var_415_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103100", "story_v_side_new_1106103.awb") / 1000

					if var_415_8 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_8 + var_415_0
					end

					if var_415_3.prefab_name ~= "" and arg_412_1.actors_[var_415_3.prefab_name] ~= nil then
						local var_415_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_3.prefab_name].transform, "story_v_side_new_1106103", "1106103100", "story_v_side_new_1106103.awb")

						arg_412_1:RecordAudio("1106103100", var_415_9)
						arg_412_1:RecordAudio("1106103100", var_415_9)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103100", "story_v_side_new_1106103.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103100", "story_v_side_new_1106103.awb")
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
	Play1106103101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1106103101
		arg_416_1.duration_ = 2.3

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1106103102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = "106101ui_story"

			if arg_416_1.actors_[var_419_0] == nil then
				local var_419_1 = Asset.Load("Char/" .. "106101ui_story")

				if not isNil(var_419_1) then
					local var_419_2 = Object.Instantiate(Asset.Load("Char/" .. "106101ui_story"), arg_416_1.stage_.transform)

					var_419_2.name = var_419_0
					var_419_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_416_1.actors_[var_419_0] = var_419_2

					local var_419_3 = var_419_2:GetComponentInChildren(typeof(CharacterEffect))

					var_419_3.enabled = true

					local var_419_4 = GameObjectTools.GetOrAddComponent(var_419_2, typeof(DynamicBoneHelper))

					if var_419_4 then
						var_419_4:EnableDynamicBone(false)
					end

					arg_416_1:ShowWeapon(var_419_3.transform, false)

					arg_416_1.var_[var_419_0 .. "Animator"] = var_419_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_416_1.var_[var_419_0 .. "Animator"].applyRootMotion = true
					arg_416_1.var_[var_419_0 .. "LipSync"] = var_419_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_419_5 = arg_416_1.actors_["106101ui_story"].transform
			local var_419_6 = 0

			if var_419_6 < arg_416_1.time_ and arg_416_1.time_ <= var_419_6 + arg_419_0 then
				arg_416_1.var_.moveOldPos106101ui_story = var_419_5.localPosition

				local var_419_7 = "106101ui_story"

				arg_416_1:ShowWeapon(arg_416_1.var_[var_419_7 .. "Animator"].transform, false)
			end

			local var_419_8 = 0.001

			if var_419_6 <= arg_416_1.time_ and arg_416_1.time_ < var_419_6 + var_419_8 then
				local var_419_9 = (arg_416_1.time_ - var_419_6) / var_419_8
				local var_419_10 = Vector3.New(0, -1.18, -6.15)

				var_419_5.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos106101ui_story, var_419_10, var_419_9)

				local var_419_11 = manager.ui.mainCamera.transform.position - var_419_5.position

				var_419_5.forward = Vector3.New(var_419_11.x, var_419_11.y, var_419_11.z)

				local var_419_12 = var_419_5.localEulerAngles

				var_419_12.z = 0
				var_419_12.x = 0
				var_419_5.localEulerAngles = var_419_12
			end

			if arg_416_1.time_ >= var_419_6 + var_419_8 and arg_416_1.time_ < var_419_6 + var_419_8 + arg_419_0 then
				var_419_5.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_419_13 = manager.ui.mainCamera.transform.position - var_419_5.position

				var_419_5.forward = Vector3.New(var_419_13.x, var_419_13.y, var_419_13.z)

				local var_419_14 = var_419_5.localEulerAngles

				var_419_14.z = 0
				var_419_14.x = 0
				var_419_5.localEulerAngles = var_419_14
			end

			local var_419_15 = arg_416_1.actors_["106101ui_story"]
			local var_419_16 = 0

			if var_419_16 < arg_416_1.time_ and arg_416_1.time_ <= var_419_16 + arg_419_0 and not isNil(var_419_15) and arg_416_1.var_.characterEffect106101ui_story == nil then
				arg_416_1.var_.characterEffect106101ui_story = var_419_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_17 = 0.200000002980232

			if var_419_16 <= arg_416_1.time_ and arg_416_1.time_ < var_419_16 + var_419_17 and not isNil(var_419_15) then
				local var_419_18 = (arg_416_1.time_ - var_419_16) / var_419_17

				if arg_416_1.var_.characterEffect106101ui_story and not isNil(var_419_15) then
					arg_416_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= var_419_16 + var_419_17 and arg_416_1.time_ < var_419_16 + var_419_17 + arg_419_0 and not isNil(var_419_15) and arg_416_1.var_.characterEffect106101ui_story then
				arg_416_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			local var_419_19 = 0

			if var_419_19 < arg_416_1.time_ and arg_416_1.time_ <= var_419_19 + arg_419_0 then
				arg_416_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action9_1")
			end

			local var_419_20 = 0

			if var_419_20 < arg_416_1.time_ and arg_416_1.time_ <= var_419_20 + arg_419_0 then
				arg_416_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_419_21 = arg_416_1.actors_["1061ui_story"].transform
			local var_419_22 = 0

			if var_419_22 < arg_416_1.time_ and arg_416_1.time_ <= var_419_22 + arg_419_0 then
				arg_416_1.var_.moveOldPos1061ui_story = var_419_21.localPosition

				local var_419_23 = "1061ui_story"

				arg_416_1:ShowWeapon(arg_416_1.var_[var_419_23 .. "Animator"].transform, false)
			end

			local var_419_24 = 0.001

			if var_419_22 <= arg_416_1.time_ and arg_416_1.time_ < var_419_22 + var_419_24 then
				local var_419_25 = (arg_416_1.time_ - var_419_22) / var_419_24
				local var_419_26 = Vector3.New(0, 100, 0)

				var_419_21.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos1061ui_story, var_419_26, var_419_25)

				local var_419_27 = manager.ui.mainCamera.transform.position - var_419_21.position

				var_419_21.forward = Vector3.New(var_419_27.x, var_419_27.y, var_419_27.z)

				local var_419_28 = var_419_21.localEulerAngles

				var_419_28.z = 0
				var_419_28.x = 0
				var_419_21.localEulerAngles = var_419_28
			end

			if arg_416_1.time_ >= var_419_22 + var_419_24 and arg_416_1.time_ < var_419_22 + var_419_24 + arg_419_0 then
				var_419_21.localPosition = Vector3.New(0, 100, 0)

				local var_419_29 = manager.ui.mainCamera.transform.position - var_419_21.position

				var_419_21.forward = Vector3.New(var_419_29.x, var_419_29.y, var_419_29.z)

				local var_419_30 = var_419_21.localEulerAngles

				var_419_30.z = 0
				var_419_30.x = 0
				var_419_21.localEulerAngles = var_419_30
			end

			local var_419_31 = 0
			local var_419_32 = 0.275

			if var_419_31 < arg_416_1.time_ and arg_416_1.time_ <= var_419_31 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_33 = arg_416_1:FormatText(StoryNameCfg[612].name)

				arg_416_1.leftNameTxt_.text = var_419_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_34 = arg_416_1:GetWordFromCfg(1106103101)
				local var_419_35 = arg_416_1:FormatText(var_419_34.content)

				arg_416_1.text_.text = var_419_35

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_36 = 11
				local var_419_37 = utf8.len(var_419_35)
				local var_419_38 = var_419_36 <= 0 and var_419_32 or var_419_32 * (var_419_37 / var_419_36)

				if var_419_38 > 0 and var_419_32 < var_419_38 then
					arg_416_1.talkMaxDuration = var_419_38

					if var_419_38 + var_419_31 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_38 + var_419_31
					end
				end

				arg_416_1.text_.text = var_419_35
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103101", "story_v_side_new_1106103.awb") ~= 0 then
					local var_419_39 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103101", "story_v_side_new_1106103.awb") / 1000

					if var_419_39 + var_419_31 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_39 + var_419_31
					end

					if var_419_34.prefab_name ~= "" and arg_416_1.actors_[var_419_34.prefab_name] ~= nil then
						local var_419_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_34.prefab_name].transform, "story_v_side_new_1106103", "1106103101", "story_v_side_new_1106103.awb")

						arg_416_1:RecordAudio("1106103101", var_419_40)
						arg_416_1:RecordAudio("1106103101", var_419_40)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103101", "story_v_side_new_1106103.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103101", "story_v_side_new_1106103.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_41 = math.max(var_419_32, arg_416_1.talkMaxDuration)

			if var_419_31 <= arg_416_1.time_ and arg_416_1.time_ < var_419_31 + var_419_41 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_31) / var_419_41

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_31 + var_419_41 and arg_416_1.time_ < var_419_31 + var_419_41 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_416_1:InitPlayNodeList()
	end,
	Play1106103102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1106103102
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1106103103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["106101ui_story"].transform
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 then
				arg_420_1.var_.moveOldPos106101ui_story = var_423_0.localPosition
			end

			local var_423_2 = 0.001

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2
				local var_423_4 = Vector3.New(0, 100, 0)

				var_423_0.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos106101ui_story, var_423_4, var_423_3)

				local var_423_5 = manager.ui.mainCamera.transform.position - var_423_0.position

				var_423_0.forward = Vector3.New(var_423_5.x, var_423_5.y, var_423_5.z)

				local var_423_6 = var_423_0.localEulerAngles

				var_423_6.z = 0
				var_423_6.x = 0
				var_423_0.localEulerAngles = var_423_6
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 then
				var_423_0.localPosition = Vector3.New(0, 100, 0)

				local var_423_7 = manager.ui.mainCamera.transform.position - var_423_0.position

				var_423_0.forward = Vector3.New(var_423_7.x, var_423_7.y, var_423_7.z)

				local var_423_8 = var_423_0.localEulerAngles

				var_423_8.z = 0
				var_423_8.x = 0
				var_423_0.localEulerAngles = var_423_8
			end

			local var_423_9 = arg_420_1.actors_["106101ui_story"]
			local var_423_10 = 0

			if var_423_10 < arg_420_1.time_ and arg_420_1.time_ <= var_423_10 + arg_423_0 and not isNil(var_423_9) and arg_420_1.var_.characterEffect106101ui_story == nil then
				arg_420_1.var_.characterEffect106101ui_story = var_423_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_11 = 0.200000002980232

			if var_423_10 <= arg_420_1.time_ and arg_420_1.time_ < var_423_10 + var_423_11 and not isNil(var_423_9) then
				local var_423_12 = (arg_420_1.time_ - var_423_10) / var_423_11

				if arg_420_1.var_.characterEffect106101ui_story and not isNil(var_423_9) then
					local var_423_13 = Mathf.Lerp(0, 0.5, var_423_12)

					arg_420_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_420_1.var_.characterEffect106101ui_story.fillRatio = var_423_13
				end
			end

			if arg_420_1.time_ >= var_423_10 + var_423_11 and arg_420_1.time_ < var_423_10 + var_423_11 + arg_423_0 and not isNil(var_423_9) and arg_420_1.var_.characterEffect106101ui_story then
				local var_423_14 = 0.5

				arg_420_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_420_1.var_.characterEffect106101ui_story.fillRatio = var_423_14
			end

			local var_423_15 = 0
			local var_423_16 = 1.1

			if var_423_15 < arg_420_1.time_ and arg_420_1.time_ <= var_423_15 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_17 = arg_420_1:GetWordFromCfg(1106103102)
				local var_423_18 = arg_420_1:FormatText(var_423_17.content)

				arg_420_1.text_.text = var_423_18

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_19 = 44
				local var_423_20 = utf8.len(var_423_18)
				local var_423_21 = var_423_19 <= 0 and var_423_16 or var_423_16 * (var_423_20 / var_423_19)

				if var_423_21 > 0 and var_423_16 < var_423_21 then
					arg_420_1.talkMaxDuration = var_423_21

					if var_423_21 + var_423_15 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_21 + var_423_15
					end
				end

				arg_420_1.text_.text = var_423_18
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_22 = math.max(var_423_16, arg_420_1.talkMaxDuration)

			if var_423_15 <= arg_420_1.time_ and arg_420_1.time_ < var_423_15 + var_423_22 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_15) / var_423_22

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_15 + var_423_22 and arg_420_1.time_ < var_423_15 + var_423_22 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play1106103103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1106103103
		arg_424_1.duration_ = 6.17

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1106103104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0
			local var_427_1 = 0.65

			if var_427_0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_2 = arg_424_1:FormatText(StoryNameCfg[1357].name)

				arg_424_1.leftNameTxt_.text = var_427_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_3 = arg_424_1:GetWordFromCfg(1106103103)
				local var_427_4 = arg_424_1:FormatText(var_427_3.content)

				arg_424_1.text_.text = var_427_4

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_5 = 26
				local var_427_6 = utf8.len(var_427_4)
				local var_427_7 = var_427_5 <= 0 and var_427_1 or var_427_1 * (var_427_6 / var_427_5)

				if var_427_7 > 0 and var_427_1 < var_427_7 then
					arg_424_1.talkMaxDuration = var_427_7

					if var_427_7 + var_427_0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_7 + var_427_0
					end
				end

				arg_424_1.text_.text = var_427_4
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103103", "story_v_side_new_1106103.awb") ~= 0 then
					local var_427_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103103", "story_v_side_new_1106103.awb") / 1000

					if var_427_8 + var_427_0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_8 + var_427_0
					end

					if var_427_3.prefab_name ~= "" and arg_424_1.actors_[var_427_3.prefab_name] ~= nil then
						local var_427_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_3.prefab_name].transform, "story_v_side_new_1106103", "1106103103", "story_v_side_new_1106103.awb")

						arg_424_1:RecordAudio("1106103103", var_427_9)
						arg_424_1:RecordAudio("1106103103", var_427_9)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103103", "story_v_side_new_1106103.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103103", "story_v_side_new_1106103.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_10 = math.max(var_427_1, arg_424_1.talkMaxDuration)

			if var_427_0 <= arg_424_1.time_ and arg_424_1.time_ < var_427_0 + var_427_10 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_0) / var_427_10

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_0 + var_427_10 and arg_424_1.time_ < var_427_0 + var_427_10 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play1106103104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1106103104
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1106103105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0.0666666666666667
			local var_431_1 = 1

			if var_431_0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_0 + arg_431_0 then
				local var_431_2 = "play"
				local var_431_3 = "effect"

				arg_428_1:AudioAction(var_431_2, var_431_3, "se_story_side_1061", "se_story_side_1061_door", "")
			end

			local var_431_4 = 0
			local var_431_5 = 0.875

			if var_431_4 < arg_428_1.time_ and arg_428_1.time_ <= var_431_4 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_6 = arg_428_1:GetWordFromCfg(1106103104)
				local var_431_7 = arg_428_1:FormatText(var_431_6.content)

				arg_428_1.text_.text = var_431_7

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_8 = 35
				local var_431_9 = utf8.len(var_431_7)
				local var_431_10 = var_431_8 <= 0 and var_431_5 or var_431_5 * (var_431_9 / var_431_8)

				if var_431_10 > 0 and var_431_5 < var_431_10 then
					arg_428_1.talkMaxDuration = var_431_10

					if var_431_10 + var_431_4 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_10 + var_431_4
					end
				end

				arg_428_1.text_.text = var_431_7
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_11 = math.max(var_431_5, arg_428_1.talkMaxDuration)

			if var_431_4 <= arg_428_1.time_ and arg_428_1.time_ < var_431_4 + var_431_11 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_4) / var_431_11

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_4 + var_431_11 and arg_428_1.time_ < var_431_4 + var_431_11 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play1106103105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1106103105
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1106103106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 0.3

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_2 = arg_432_1:FormatText(StoryNameCfg[7].name)

				arg_432_1.leftNameTxt_.text = var_435_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_3 = arg_432_1:GetWordFromCfg(1106103105)
				local var_435_4 = arg_432_1:FormatText(var_435_3.content)

				arg_432_1.text_.text = var_435_4

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_5 = 12
				local var_435_6 = utf8.len(var_435_4)
				local var_435_7 = var_435_5 <= 0 and var_435_1 or var_435_1 * (var_435_6 / var_435_5)

				if var_435_7 > 0 and var_435_1 < var_435_7 then
					arg_432_1.talkMaxDuration = var_435_7

					if var_435_7 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_7 + var_435_0
					end
				end

				arg_432_1.text_.text = var_435_4
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_8 = math.max(var_435_1, arg_432_1.talkMaxDuration)

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_8 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_0) / var_435_8

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_0 + var_435_8 and arg_432_1.time_ < var_435_0 + var_435_8 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1106103106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1106103106
		arg_436_1.duration_ = 2.83

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1106103107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0
			local var_439_1 = 0.4

			if var_439_0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_2 = arg_436_1:FormatText(StoryNameCfg[1358].name)

				arg_436_1.leftNameTxt_.text = var_439_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, true)
				arg_436_1.iconController_:SetSelectedState("hero")

				arg_436_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1095")

				arg_436_1.callingController_:SetSelectedState("normal")

				arg_436_1.keyicon_.color = Color.New(1, 1, 1)
				arg_436_1.icon_.color = Color.New(1, 1, 1)

				local var_439_3 = arg_436_1:GetWordFromCfg(1106103106)
				local var_439_4 = arg_436_1:FormatText(var_439_3.content)

				arg_436_1.text_.text = var_439_4

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_5 = 16
				local var_439_6 = utf8.len(var_439_4)
				local var_439_7 = var_439_5 <= 0 and var_439_1 or var_439_1 * (var_439_6 / var_439_5)

				if var_439_7 > 0 and var_439_1 < var_439_7 then
					arg_436_1.talkMaxDuration = var_439_7

					if var_439_7 + var_439_0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_7 + var_439_0
					end
				end

				arg_436_1.text_.text = var_439_4
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103106", "story_v_side_new_1106103.awb") ~= 0 then
					local var_439_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103106", "story_v_side_new_1106103.awb") / 1000

					if var_439_8 + var_439_0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_8 + var_439_0
					end

					if var_439_3.prefab_name ~= "" and arg_436_1.actors_[var_439_3.prefab_name] ~= nil then
						local var_439_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_3.prefab_name].transform, "story_v_side_new_1106103", "1106103106", "story_v_side_new_1106103.awb")

						arg_436_1:RecordAudio("1106103106", var_439_9)
						arg_436_1:RecordAudio("1106103106", var_439_9)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103106", "story_v_side_new_1106103.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103106", "story_v_side_new_1106103.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_10 = math.max(var_439_1, arg_436_1.talkMaxDuration)

			if var_439_0 <= arg_436_1.time_ and arg_436_1.time_ < var_439_0 + var_439_10 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_0) / var_439_10

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_0 + var_439_10 and arg_436_1.time_ < var_439_0 + var_439_10 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1106103107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1106103107
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1106103108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["106101ui_story"].transform
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.var_.moveOldPos106101ui_story = var_443_0.localPosition

				local var_443_2 = "106101ui_story"

				arg_440_1:ShowWeapon(arg_440_1.var_[var_443_2 .. "Animator"].transform, false)
			end

			local var_443_3 = 0.001

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_3 then
				local var_443_4 = (arg_440_1.time_ - var_443_1) / var_443_3
				local var_443_5 = Vector3.New(0, 100, 0)

				var_443_0.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos106101ui_story, var_443_5, var_443_4)

				local var_443_6 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_6.x, var_443_6.y, var_443_6.z)

				local var_443_7 = var_443_0.localEulerAngles

				var_443_7.z = 0
				var_443_7.x = 0
				var_443_0.localEulerAngles = var_443_7
			end

			if arg_440_1.time_ >= var_443_1 + var_443_3 and arg_440_1.time_ < var_443_1 + var_443_3 + arg_443_0 then
				var_443_0.localPosition = Vector3.New(0, 100, 0)

				local var_443_8 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_8.x, var_443_8.y, var_443_8.z)

				local var_443_9 = var_443_0.localEulerAngles

				var_443_9.z = 0
				var_443_9.x = 0
				var_443_0.localEulerAngles = var_443_9
			end

			local var_443_10 = 0
			local var_443_11 = 0.7

			if var_443_10 < arg_440_1.time_ and arg_440_1.time_ <= var_443_10 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, false)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_12 = arg_440_1:GetWordFromCfg(1106103107)
				local var_443_13 = arg_440_1:FormatText(var_443_12.content)

				arg_440_1.text_.text = var_443_13

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_14 = 28
				local var_443_15 = utf8.len(var_443_13)
				local var_443_16 = var_443_14 <= 0 and var_443_11 or var_443_11 * (var_443_15 / var_443_14)

				if var_443_16 > 0 and var_443_11 < var_443_16 then
					arg_440_1.talkMaxDuration = var_443_16

					if var_443_16 + var_443_10 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_16 + var_443_10
					end
				end

				arg_440_1.text_.text = var_443_13
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_17 = math.max(var_443_11, arg_440_1.talkMaxDuration)

			if var_443_10 <= arg_440_1.time_ and arg_440_1.time_ < var_443_10 + var_443_17 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_10) / var_443_17

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_10 + var_443_17 and arg_440_1.time_ < var_443_10 + var_443_17 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play1106103108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1106103108
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1106103109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0
			local var_447_1 = 1.55

			if var_447_0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, false)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_2 = arg_444_1:GetWordFromCfg(1106103108)
				local var_447_3 = arg_444_1:FormatText(var_447_2.content)

				arg_444_1.text_.text = var_447_3

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_4 = 62
				local var_447_5 = utf8.len(var_447_3)
				local var_447_6 = var_447_4 <= 0 and var_447_1 or var_447_1 * (var_447_5 / var_447_4)

				if var_447_6 > 0 and var_447_1 < var_447_6 then
					arg_444_1.talkMaxDuration = var_447_6

					if var_447_6 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_6 + var_447_0
					end
				end

				arg_444_1.text_.text = var_447_3
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_7 = math.max(var_447_1, arg_444_1.talkMaxDuration)

			if var_447_0 <= arg_444_1.time_ and arg_444_1.time_ < var_447_0 + var_447_7 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_0) / var_447_7

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_0 + var_447_7 and arg_444_1.time_ < var_447_0 + var_447_7 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play1106103109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1106103109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1106103110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0
			local var_451_1 = 1.125

			if var_451_0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, false)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_2 = arg_448_1:GetWordFromCfg(1106103109)
				local var_451_3 = arg_448_1:FormatText(var_451_2.content)

				arg_448_1.text_.text = var_451_3

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_4 = 45
				local var_451_5 = utf8.len(var_451_3)
				local var_451_6 = var_451_4 <= 0 and var_451_1 or var_451_1 * (var_451_5 / var_451_4)

				if var_451_6 > 0 and var_451_1 < var_451_6 then
					arg_448_1.talkMaxDuration = var_451_6

					if var_451_6 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_6 + var_451_0
					end
				end

				arg_448_1.text_.text = var_451_3
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_7 = math.max(var_451_1, arg_448_1.talkMaxDuration)

			if var_451_0 <= arg_448_1.time_ and arg_448_1.time_ < var_451_0 + var_451_7 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_0) / var_451_7

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_0 + var_451_7 and arg_448_1.time_ < var_451_0 + var_451_7 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play1106103110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1106103110
		arg_452_1.duration_ = 3.47

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1106103111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["106101ui_story"]
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.characterEffect106101ui_story == nil then
				arg_452_1.var_.characterEffect106101ui_story = var_455_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_2 = 0.200000002980232

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 and not isNil(var_455_0) then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2

				if arg_452_1.var_.characterEffect106101ui_story and not isNil(var_455_0) then
					arg_452_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.characterEffect106101ui_story then
				arg_452_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			local var_455_4 = arg_452_1.actors_["106101ui_story"].transform
			local var_455_5 = 0

			if var_455_5 < arg_452_1.time_ and arg_452_1.time_ <= var_455_5 + arg_455_0 then
				arg_452_1.var_.moveOldPos106101ui_story = var_455_4.localPosition

				local var_455_6 = "106101ui_story"

				arg_452_1:ShowWeapon(arg_452_1.var_[var_455_6 .. "Animator"].transform, false)
			end

			local var_455_7 = 0.001

			if var_455_5 <= arg_452_1.time_ and arg_452_1.time_ < var_455_5 + var_455_7 then
				local var_455_8 = (arg_452_1.time_ - var_455_5) / var_455_7
				local var_455_9 = Vector3.New(0, -1.18, -6.15)

				var_455_4.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos106101ui_story, var_455_9, var_455_8)

				local var_455_10 = manager.ui.mainCamera.transform.position - var_455_4.position

				var_455_4.forward = Vector3.New(var_455_10.x, var_455_10.y, var_455_10.z)

				local var_455_11 = var_455_4.localEulerAngles

				var_455_11.z = 0
				var_455_11.x = 0
				var_455_4.localEulerAngles = var_455_11
			end

			if arg_452_1.time_ >= var_455_5 + var_455_7 and arg_452_1.time_ < var_455_5 + var_455_7 + arg_455_0 then
				var_455_4.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_455_12 = manager.ui.mainCamera.transform.position - var_455_4.position

				var_455_4.forward = Vector3.New(var_455_12.x, var_455_12.y, var_455_12.z)

				local var_455_13 = var_455_4.localEulerAngles

				var_455_13.z = 0
				var_455_13.x = 0
				var_455_4.localEulerAngles = var_455_13
			end

			local var_455_14 = arg_452_1.actors_["106101ui_story"]
			local var_455_15 = 0

			if var_455_15 < arg_452_1.time_ and arg_452_1.time_ <= var_455_15 + arg_455_0 and not isNil(var_455_14) and arg_452_1.var_.characterEffect106101ui_story == nil then
				arg_452_1.var_.characterEffect106101ui_story = var_455_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_16 = 0.200000002980232

			if var_455_15 <= arg_452_1.time_ and arg_452_1.time_ < var_455_15 + var_455_16 and not isNil(var_455_14) then
				local var_455_17 = (arg_452_1.time_ - var_455_15) / var_455_16

				if arg_452_1.var_.characterEffect106101ui_story and not isNil(var_455_14) then
					arg_452_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_452_1.time_ >= var_455_15 + var_455_16 and arg_452_1.time_ < var_455_15 + var_455_16 + arg_455_0 and not isNil(var_455_14) and arg_452_1.var_.characterEffect106101ui_story then
				arg_452_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			local var_455_18 = 0

			if var_455_18 < arg_452_1.time_ and arg_452_1.time_ <= var_455_18 + arg_455_0 then
				arg_452_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action494")
			end

			local var_455_19 = 0

			if var_455_19 < arg_452_1.time_ and arg_452_1.time_ <= var_455_19 + arg_455_0 then
				arg_452_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva", "EmotionTimelineAnimator")
			end

			local var_455_20 = 0
			local var_455_21 = 0.325

			if var_455_20 < arg_452_1.time_ and arg_452_1.time_ <= var_455_20 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_22 = arg_452_1:FormatText(StoryNameCfg[612].name)

				arg_452_1.leftNameTxt_.text = var_455_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_23 = arg_452_1:GetWordFromCfg(1106103110)
				local var_455_24 = arg_452_1:FormatText(var_455_23.content)

				arg_452_1.text_.text = var_455_24

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_25 = 13
				local var_455_26 = utf8.len(var_455_24)
				local var_455_27 = var_455_25 <= 0 and var_455_21 or var_455_21 * (var_455_26 / var_455_25)

				if var_455_27 > 0 and var_455_21 < var_455_27 then
					arg_452_1.talkMaxDuration = var_455_27

					if var_455_27 + var_455_20 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_27 + var_455_20
					end
				end

				arg_452_1.text_.text = var_455_24
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103110", "story_v_side_new_1106103.awb") ~= 0 then
					local var_455_28 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103110", "story_v_side_new_1106103.awb") / 1000

					if var_455_28 + var_455_20 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_28 + var_455_20
					end

					if var_455_23.prefab_name ~= "" and arg_452_1.actors_[var_455_23.prefab_name] ~= nil then
						local var_455_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_23.prefab_name].transform, "story_v_side_new_1106103", "1106103110", "story_v_side_new_1106103.awb")

						arg_452_1:RecordAudio("1106103110", var_455_29)
						arg_452_1:RecordAudio("1106103110", var_455_29)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103110", "story_v_side_new_1106103.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103110", "story_v_side_new_1106103.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_30 = math.max(var_455_21, arg_452_1.talkMaxDuration)

			if var_455_20 <= arg_452_1.time_ and arg_452_1.time_ < var_455_20 + var_455_30 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_20) / var_455_30

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_20 + var_455_30 and arg_452_1.time_ < var_455_20 + var_455_30 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play1106103111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1106103111
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1106103112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["106101ui_story"]
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.characterEffect106101ui_story == nil then
				arg_456_1.var_.characterEffect106101ui_story = var_459_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_2 = 0.200000002980232

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 and not isNil(var_459_0) then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2

				if arg_456_1.var_.characterEffect106101ui_story and not isNil(var_459_0) then
					local var_459_4 = Mathf.Lerp(0, 0.5, var_459_3)

					arg_456_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_456_1.var_.characterEffect106101ui_story.fillRatio = var_459_4
				end
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.characterEffect106101ui_story then
				local var_459_5 = 0.5

				arg_456_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_456_1.var_.characterEffect106101ui_story.fillRatio = var_459_5
			end

			local var_459_6 = 0
			local var_459_7 = 1.15

			if var_459_6 < arg_456_1.time_ and arg_456_1.time_ <= var_459_6 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_8 = arg_456_1:GetWordFromCfg(1106103111)
				local var_459_9 = arg_456_1:FormatText(var_459_8.content)

				arg_456_1.text_.text = var_459_9

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_10 = 46
				local var_459_11 = utf8.len(var_459_9)
				local var_459_12 = var_459_10 <= 0 and var_459_7 or var_459_7 * (var_459_11 / var_459_10)

				if var_459_12 > 0 and var_459_7 < var_459_12 then
					arg_456_1.talkMaxDuration = var_459_12

					if var_459_12 + var_459_6 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_12 + var_459_6
					end
				end

				arg_456_1.text_.text = var_459_9
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_13 = math.max(var_459_7, arg_456_1.talkMaxDuration)

			if var_459_6 <= arg_456_1.time_ and arg_456_1.time_ < var_459_6 + var_459_13 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_6) / var_459_13

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_6 + var_459_13 and arg_456_1.time_ < var_459_6 + var_459_13 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1106103112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1106103112
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1106103113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["106101ui_story"].transform
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 then
				arg_460_1.var_.moveOldPos106101ui_story = var_463_0.localPosition

				local var_463_2 = "106101ui_story"

				arg_460_1:ShowWeapon(arg_460_1.var_[var_463_2 .. "Animator"].transform, false)
			end

			local var_463_3 = 0.001

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_3 then
				local var_463_4 = (arg_460_1.time_ - var_463_1) / var_463_3
				local var_463_5 = Vector3.New(0, 100, 0)

				var_463_0.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos106101ui_story, var_463_5, var_463_4)

				local var_463_6 = manager.ui.mainCamera.transform.position - var_463_0.position

				var_463_0.forward = Vector3.New(var_463_6.x, var_463_6.y, var_463_6.z)

				local var_463_7 = var_463_0.localEulerAngles

				var_463_7.z = 0
				var_463_7.x = 0
				var_463_0.localEulerAngles = var_463_7
			end

			if arg_460_1.time_ >= var_463_1 + var_463_3 and arg_460_1.time_ < var_463_1 + var_463_3 + arg_463_0 then
				var_463_0.localPosition = Vector3.New(0, 100, 0)

				local var_463_8 = manager.ui.mainCamera.transform.position - var_463_0.position

				var_463_0.forward = Vector3.New(var_463_8.x, var_463_8.y, var_463_8.z)

				local var_463_9 = var_463_0.localEulerAngles

				var_463_9.z = 0
				var_463_9.x = 0
				var_463_0.localEulerAngles = var_463_9
			end

			local var_463_10 = 0
			local var_463_11 = 0.475

			if var_463_10 < arg_460_1.time_ and arg_460_1.time_ <= var_463_10 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, false)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_12 = arg_460_1:GetWordFromCfg(1106103112)
				local var_463_13 = arg_460_1:FormatText(var_463_12.content)

				arg_460_1.text_.text = var_463_13

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_14 = 19
				local var_463_15 = utf8.len(var_463_13)
				local var_463_16 = var_463_14 <= 0 and var_463_11 or var_463_11 * (var_463_15 / var_463_14)

				if var_463_16 > 0 and var_463_11 < var_463_16 then
					arg_460_1.talkMaxDuration = var_463_16

					if var_463_16 + var_463_10 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_16 + var_463_10
					end
				end

				arg_460_1.text_.text = var_463_13
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_17 = math.max(var_463_11, arg_460_1.talkMaxDuration)

			if var_463_10 <= arg_460_1.time_ and arg_460_1.time_ < var_463_10 + var_463_17 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_10) / var_463_17

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_10 + var_463_17 and arg_460_1.time_ < var_463_10 + var_463_17 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play1106103113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1106103113
		arg_464_1.duration_ = 6.52

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play1106103114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 5.51846216336447
			local var_467_1 = 1

			if var_467_0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_0 + arg_467_0 then
				local var_467_2 = "play"
				local var_467_3 = "effect"

				arg_464_1:AudioAction(var_467_2, var_467_3, "se_story_side_1061", "se_story_side_1061_footstep01", "")
			end

			local var_467_4 = 0
			local var_467_5 = 1.45

			if var_467_4 < arg_464_1.time_ and arg_464_1.time_ <= var_467_4 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, false)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_6 = arg_464_1:GetWordFromCfg(1106103113)
				local var_467_7 = arg_464_1:FormatText(var_467_6.content)

				arg_464_1.text_.text = var_467_7

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_8 = 58
				local var_467_9 = utf8.len(var_467_7)
				local var_467_10 = var_467_8 <= 0 and var_467_5 or var_467_5 * (var_467_9 / var_467_8)

				if var_467_10 > 0 and var_467_5 < var_467_10 then
					arg_464_1.talkMaxDuration = var_467_10

					if var_467_10 + var_467_4 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_10 + var_467_4
					end
				end

				arg_464_1.text_.text = var_467_7
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_11 = math.max(var_467_5, arg_464_1.talkMaxDuration)

			if var_467_4 <= arg_464_1.time_ and arg_464_1.time_ < var_467_4 + var_467_11 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_4) / var_467_11

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_4 + var_467_11 and arg_464_1.time_ < var_467_4 + var_467_11 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play1106103114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 1106103114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play1106103115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0
			local var_471_1 = 0.2

			if var_471_0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_2 = arg_468_1:FormatText(StoryNameCfg[7].name)

				arg_468_1.leftNameTxt_.text = var_471_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, true)
				arg_468_1.iconController_:SetSelectedState("hero")

				arg_468_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_468_1.callingController_:SetSelectedState("normal")

				arg_468_1.keyicon_.color = Color.New(1, 1, 1)
				arg_468_1.icon_.color = Color.New(1, 1, 1)

				local var_471_3 = arg_468_1:GetWordFromCfg(1106103114)
				local var_471_4 = arg_468_1:FormatText(var_471_3.content)

				arg_468_1.text_.text = var_471_4

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_5 = 8
				local var_471_6 = utf8.len(var_471_4)
				local var_471_7 = var_471_5 <= 0 and var_471_1 or var_471_1 * (var_471_6 / var_471_5)

				if var_471_7 > 0 and var_471_1 < var_471_7 then
					arg_468_1.talkMaxDuration = var_471_7

					if var_471_7 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_7 + var_471_0
					end
				end

				arg_468_1.text_.text = var_471_4
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_8 = math.max(var_471_1, arg_468_1.talkMaxDuration)

			if var_471_0 <= arg_468_1.time_ and arg_468_1.time_ < var_471_0 + var_471_8 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_0) / var_471_8

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_0 + var_471_8 and arg_468_1.time_ < var_471_0 + var_471_8 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play1106103115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1106103115
		arg_472_1.duration_ = 3.7

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play1106103116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["106101ui_story"].transform
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 then
				arg_472_1.var_.moveOldPos106101ui_story = var_475_0.localPosition
			end

			local var_475_2 = 0.001

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2
				local var_475_4 = Vector3.New(0, -1.18, -6.15)

				var_475_0.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos106101ui_story, var_475_4, var_475_3)

				local var_475_5 = manager.ui.mainCamera.transform.position - var_475_0.position

				var_475_0.forward = Vector3.New(var_475_5.x, var_475_5.y, var_475_5.z)

				local var_475_6 = var_475_0.localEulerAngles

				var_475_6.z = 0
				var_475_6.x = 0
				var_475_0.localEulerAngles = var_475_6
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 then
				var_475_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_475_7 = manager.ui.mainCamera.transform.position - var_475_0.position

				var_475_0.forward = Vector3.New(var_475_7.x, var_475_7.y, var_475_7.z)

				local var_475_8 = var_475_0.localEulerAngles

				var_475_8.z = 0
				var_475_8.x = 0
				var_475_0.localEulerAngles = var_475_8
			end

			local var_475_9 = arg_472_1.actors_["106101ui_story"]
			local var_475_10 = 0

			if var_475_10 < arg_472_1.time_ and arg_472_1.time_ <= var_475_10 + arg_475_0 and not isNil(var_475_9) and arg_472_1.var_.characterEffect106101ui_story == nil then
				arg_472_1.var_.characterEffect106101ui_story = var_475_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_11 = 0.200000002980232

			if var_475_10 <= arg_472_1.time_ and arg_472_1.time_ < var_475_10 + var_475_11 and not isNil(var_475_9) then
				local var_475_12 = (arg_472_1.time_ - var_475_10) / var_475_11

				if arg_472_1.var_.characterEffect106101ui_story and not isNil(var_475_9) then
					arg_472_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= var_475_10 + var_475_11 and arg_472_1.time_ < var_475_10 + var_475_11 + arg_475_0 and not isNil(var_475_9) and arg_472_1.var_.characterEffect106101ui_story then
				arg_472_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			local var_475_13 = 0

			if var_475_13 < arg_472_1.time_ and arg_472_1.time_ <= var_475_13 + arg_475_0 then
				arg_472_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action447")
			end

			local var_475_14 = 0

			if var_475_14 < arg_472_1.time_ and arg_472_1.time_ <= var_475_14 + arg_475_0 then
				arg_472_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_475_15 = 0
			local var_475_16 = 0.3

			if var_475_15 < arg_472_1.time_ and arg_472_1.time_ <= var_475_15 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_17 = arg_472_1:FormatText(StoryNameCfg[612].name)

				arg_472_1.leftNameTxt_.text = var_475_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_18 = arg_472_1:GetWordFromCfg(1106103115)
				local var_475_19 = arg_472_1:FormatText(var_475_18.content)

				arg_472_1.text_.text = var_475_19

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_20 = 12
				local var_475_21 = utf8.len(var_475_19)
				local var_475_22 = var_475_20 <= 0 and var_475_16 or var_475_16 * (var_475_21 / var_475_20)

				if var_475_22 > 0 and var_475_16 < var_475_22 then
					arg_472_1.talkMaxDuration = var_475_22

					if var_475_22 + var_475_15 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_22 + var_475_15
					end
				end

				arg_472_1.text_.text = var_475_19
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103115", "story_v_side_new_1106103.awb") ~= 0 then
					local var_475_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103115", "story_v_side_new_1106103.awb") / 1000

					if var_475_23 + var_475_15 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_23 + var_475_15
					end

					if var_475_18.prefab_name ~= "" and arg_472_1.actors_[var_475_18.prefab_name] ~= nil then
						local var_475_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_18.prefab_name].transform, "story_v_side_new_1106103", "1106103115", "story_v_side_new_1106103.awb")

						arg_472_1:RecordAudio("1106103115", var_475_24)
						arg_472_1:RecordAudio("1106103115", var_475_24)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103115", "story_v_side_new_1106103.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103115", "story_v_side_new_1106103.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_25 = math.max(var_475_16, arg_472_1.talkMaxDuration)

			if var_475_15 <= arg_472_1.time_ and arg_472_1.time_ < var_475_15 + var_475_25 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_15) / var_475_25

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_15 + var_475_25 and arg_472_1.time_ < var_475_15 + var_475_25 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_472_1:InitPlayNodeList()
	end,
	Play1106103116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1106103116
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1106103117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["106101ui_story"]
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect106101ui_story == nil then
				arg_476_1.var_.characterEffect106101ui_story = var_479_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_2 = 0.200000002980232

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_2 and not isNil(var_479_0) then
				local var_479_3 = (arg_476_1.time_ - var_479_1) / var_479_2

				if arg_476_1.var_.characterEffect106101ui_story and not isNil(var_479_0) then
					local var_479_4 = Mathf.Lerp(0, 0.5, var_479_3)

					arg_476_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_476_1.var_.characterEffect106101ui_story.fillRatio = var_479_4
				end
			end

			if arg_476_1.time_ >= var_479_1 + var_479_2 and arg_476_1.time_ < var_479_1 + var_479_2 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect106101ui_story then
				local var_479_5 = 0.5

				arg_476_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_476_1.var_.characterEffect106101ui_story.fillRatio = var_479_5
			end

			local var_479_6 = 0
			local var_479_7 = 0.55

			if var_479_6 < arg_476_1.time_ and arg_476_1.time_ <= var_479_6 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_8 = arg_476_1:FormatText(StoryNameCfg[7].name)

				arg_476_1.leftNameTxt_.text = var_479_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_9 = arg_476_1:GetWordFromCfg(1106103116)
				local var_479_10 = arg_476_1:FormatText(var_479_9.content)

				arg_476_1.text_.text = var_479_10

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_11 = 22
				local var_479_12 = utf8.len(var_479_10)
				local var_479_13 = var_479_11 <= 0 and var_479_7 or var_479_7 * (var_479_12 / var_479_11)

				if var_479_13 > 0 and var_479_7 < var_479_13 then
					arg_476_1.talkMaxDuration = var_479_13

					if var_479_13 + var_479_6 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_13 + var_479_6
					end
				end

				arg_476_1.text_.text = var_479_10
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_14 = math.max(var_479_7, arg_476_1.talkMaxDuration)

			if var_479_6 <= arg_476_1.time_ and arg_476_1.time_ < var_479_6 + var_479_14 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_6) / var_479_14

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_6 + var_479_14 and arg_476_1.time_ < var_479_6 + var_479_14 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play1106103117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 1106103117
		arg_480_1.duration_ = 4.07

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play1106103118(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = arg_480_1.actors_["106101ui_story"].transform
			local var_483_1 = 0

			if var_483_1 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 then
				arg_480_1.var_.moveOldPos106101ui_story = var_483_0.localPosition
			end

			local var_483_2 = 0.001

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_2 then
				local var_483_3 = (arg_480_1.time_ - var_483_1) / var_483_2
				local var_483_4 = Vector3.New(0, -1.18, -6.15)

				var_483_0.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos106101ui_story, var_483_4, var_483_3)

				local var_483_5 = manager.ui.mainCamera.transform.position - var_483_0.position

				var_483_0.forward = Vector3.New(var_483_5.x, var_483_5.y, var_483_5.z)

				local var_483_6 = var_483_0.localEulerAngles

				var_483_6.z = 0
				var_483_6.x = 0
				var_483_0.localEulerAngles = var_483_6
			end

			if arg_480_1.time_ >= var_483_1 + var_483_2 and arg_480_1.time_ < var_483_1 + var_483_2 + arg_483_0 then
				var_483_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_483_7 = manager.ui.mainCamera.transform.position - var_483_0.position

				var_483_0.forward = Vector3.New(var_483_7.x, var_483_7.y, var_483_7.z)

				local var_483_8 = var_483_0.localEulerAngles

				var_483_8.z = 0
				var_483_8.x = 0
				var_483_0.localEulerAngles = var_483_8
			end

			local var_483_9 = arg_480_1.actors_["106101ui_story"]
			local var_483_10 = 0

			if var_483_10 < arg_480_1.time_ and arg_480_1.time_ <= var_483_10 + arg_483_0 and not isNil(var_483_9) and arg_480_1.var_.characterEffect106101ui_story == nil then
				arg_480_1.var_.characterEffect106101ui_story = var_483_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_11 = 0.200000002980232

			if var_483_10 <= arg_480_1.time_ and arg_480_1.time_ < var_483_10 + var_483_11 and not isNil(var_483_9) then
				local var_483_12 = (arg_480_1.time_ - var_483_10) / var_483_11

				if arg_480_1.var_.characterEffect106101ui_story and not isNil(var_483_9) then
					arg_480_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_480_1.time_ >= var_483_10 + var_483_11 and arg_480_1.time_ < var_483_10 + var_483_11 + arg_483_0 and not isNil(var_483_9) and arg_480_1.var_.characterEffect106101ui_story then
				arg_480_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			local var_483_13 = 0

			if var_483_13 < arg_480_1.time_ and arg_480_1.time_ <= var_483_13 + arg_483_0 then
				arg_480_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action472")
			end

			local var_483_14 = 0

			if var_483_14 < arg_480_1.time_ and arg_480_1.time_ <= var_483_14 + arg_483_0 then
				arg_480_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_483_15 = 0
			local var_483_16 = 0.5

			if var_483_15 < arg_480_1.time_ and arg_480_1.time_ <= var_483_15 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_17 = arg_480_1:FormatText(StoryNameCfg[612].name)

				arg_480_1.leftNameTxt_.text = var_483_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_18 = arg_480_1:GetWordFromCfg(1106103117)
				local var_483_19 = arg_480_1:FormatText(var_483_18.content)

				arg_480_1.text_.text = var_483_19

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_20 = 20
				local var_483_21 = utf8.len(var_483_19)
				local var_483_22 = var_483_20 <= 0 and var_483_16 or var_483_16 * (var_483_21 / var_483_20)

				if var_483_22 > 0 and var_483_16 < var_483_22 then
					arg_480_1.talkMaxDuration = var_483_22

					if var_483_22 + var_483_15 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_22 + var_483_15
					end
				end

				arg_480_1.text_.text = var_483_19
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103117", "story_v_side_new_1106103.awb") ~= 0 then
					local var_483_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103117", "story_v_side_new_1106103.awb") / 1000

					if var_483_23 + var_483_15 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_23 + var_483_15
					end

					if var_483_18.prefab_name ~= "" and arg_480_1.actors_[var_483_18.prefab_name] ~= nil then
						local var_483_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_18.prefab_name].transform, "story_v_side_new_1106103", "1106103117", "story_v_side_new_1106103.awb")

						arg_480_1:RecordAudio("1106103117", var_483_24)
						arg_480_1:RecordAudio("1106103117", var_483_24)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103117", "story_v_side_new_1106103.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103117", "story_v_side_new_1106103.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_25 = math.max(var_483_16, arg_480_1.talkMaxDuration)

			if var_483_15 <= arg_480_1.time_ and arg_480_1.time_ < var_483_15 + var_483_25 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_15) / var_483_25

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_15 + var_483_25 and arg_480_1.time_ < var_483_15 + var_483_25 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_480_1:InitPlayNodeList()
	end,
	Play1106103118 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 1106103118
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play1106103119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = arg_484_1.actors_["106101ui_story"]
			local var_487_1 = 0

			if var_487_1 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.characterEffect106101ui_story == nil then
				arg_484_1.var_.characterEffect106101ui_story = var_487_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_2 = 0.200000002980232

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_2 and not isNil(var_487_0) then
				local var_487_3 = (arg_484_1.time_ - var_487_1) / var_487_2

				if arg_484_1.var_.characterEffect106101ui_story and not isNil(var_487_0) then
					local var_487_4 = Mathf.Lerp(0, 0.5, var_487_3)

					arg_484_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_484_1.var_.characterEffect106101ui_story.fillRatio = var_487_4
				end
			end

			if arg_484_1.time_ >= var_487_1 + var_487_2 and arg_484_1.time_ < var_487_1 + var_487_2 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.characterEffect106101ui_story then
				local var_487_5 = 0.5

				arg_484_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_484_1.var_.characterEffect106101ui_story.fillRatio = var_487_5
			end

			local var_487_6 = 0
			local var_487_7 = 0.725

			if var_487_6 < arg_484_1.time_ and arg_484_1.time_ <= var_487_6 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_8 = arg_484_1:FormatText(StoryNameCfg[7].name)

				arg_484_1.leftNameTxt_.text = var_487_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_9 = arg_484_1:GetWordFromCfg(1106103118)
				local var_487_10 = arg_484_1:FormatText(var_487_9.content)

				arg_484_1.text_.text = var_487_10

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_11 = 29
				local var_487_12 = utf8.len(var_487_10)
				local var_487_13 = var_487_11 <= 0 and var_487_7 or var_487_7 * (var_487_12 / var_487_11)

				if var_487_13 > 0 and var_487_7 < var_487_13 then
					arg_484_1.talkMaxDuration = var_487_13

					if var_487_13 + var_487_6 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_13 + var_487_6
					end
				end

				arg_484_1.text_.text = var_487_10
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_14 = math.max(var_487_7, arg_484_1.talkMaxDuration)

			if var_487_6 <= arg_484_1.time_ and arg_484_1.time_ < var_487_6 + var_487_14 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_6) / var_487_14

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_6 + var_487_14 and arg_484_1.time_ < var_487_6 + var_487_14 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play1106103119 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 1106103119
		arg_488_1.duration_ = 5.5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play1106103120(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["106101ui_story"].transform
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 then
				arg_488_1.var_.moveOldPos106101ui_story = var_491_0.localPosition
			end

			local var_491_2 = 0.001

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2
				local var_491_4 = Vector3.New(0, -1.18, -6.15)

				var_491_0.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos106101ui_story, var_491_4, var_491_3)

				local var_491_5 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_5.x, var_491_5.y, var_491_5.z)

				local var_491_6 = var_491_0.localEulerAngles

				var_491_6.z = 0
				var_491_6.x = 0
				var_491_0.localEulerAngles = var_491_6
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 then
				var_491_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_491_7 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_7.x, var_491_7.y, var_491_7.z)

				local var_491_8 = var_491_0.localEulerAngles

				var_491_8.z = 0
				var_491_8.x = 0
				var_491_0.localEulerAngles = var_491_8
			end

			local var_491_9 = arg_488_1.actors_["106101ui_story"]
			local var_491_10 = 0

			if var_491_10 < arg_488_1.time_ and arg_488_1.time_ <= var_491_10 + arg_491_0 and not isNil(var_491_9) and arg_488_1.var_.characterEffect106101ui_story == nil then
				arg_488_1.var_.characterEffect106101ui_story = var_491_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_11 = 0.200000002980232

			if var_491_10 <= arg_488_1.time_ and arg_488_1.time_ < var_491_10 + var_491_11 and not isNil(var_491_9) then
				local var_491_12 = (arg_488_1.time_ - var_491_10) / var_491_11

				if arg_488_1.var_.characterEffect106101ui_story and not isNil(var_491_9) then
					arg_488_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_488_1.time_ >= var_491_10 + var_491_11 and arg_488_1.time_ < var_491_10 + var_491_11 + arg_491_0 and not isNil(var_491_9) and arg_488_1.var_.characterEffect106101ui_story then
				arg_488_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			local var_491_13 = 0

			if var_491_13 < arg_488_1.time_ and arg_488_1.time_ <= var_491_13 + arg_491_0 then
				arg_488_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action426")
			end

			local var_491_14 = 0

			if var_491_14 < arg_488_1.time_ and arg_488_1.time_ <= var_491_14 + arg_491_0 then
				arg_488_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_491_15 = 0
			local var_491_16 = 0.55

			if var_491_15 < arg_488_1.time_ and arg_488_1.time_ <= var_491_15 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_17 = arg_488_1:FormatText(StoryNameCfg[612].name)

				arg_488_1.leftNameTxt_.text = var_491_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_18 = arg_488_1:GetWordFromCfg(1106103119)
				local var_491_19 = arg_488_1:FormatText(var_491_18.content)

				arg_488_1.text_.text = var_491_19

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_20 = 22
				local var_491_21 = utf8.len(var_491_19)
				local var_491_22 = var_491_20 <= 0 and var_491_16 or var_491_16 * (var_491_21 / var_491_20)

				if var_491_22 > 0 and var_491_16 < var_491_22 then
					arg_488_1.talkMaxDuration = var_491_22

					if var_491_22 + var_491_15 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_22 + var_491_15
					end
				end

				arg_488_1.text_.text = var_491_19
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103119", "story_v_side_new_1106103.awb") ~= 0 then
					local var_491_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103119", "story_v_side_new_1106103.awb") / 1000

					if var_491_23 + var_491_15 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_23 + var_491_15
					end

					if var_491_18.prefab_name ~= "" and arg_488_1.actors_[var_491_18.prefab_name] ~= nil then
						local var_491_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_18.prefab_name].transform, "story_v_side_new_1106103", "1106103119", "story_v_side_new_1106103.awb")

						arg_488_1:RecordAudio("1106103119", var_491_24)
						arg_488_1:RecordAudio("1106103119", var_491_24)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103119", "story_v_side_new_1106103.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103119", "story_v_side_new_1106103.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_25 = math.max(var_491_16, arg_488_1.talkMaxDuration)

			if var_491_15 <= arg_488_1.time_ and arg_488_1.time_ < var_491_15 + var_491_25 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_15) / var_491_25

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_15 + var_491_25 and arg_488_1.time_ < var_491_15 + var_491_25 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play1106103120 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 1106103120
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play1106103121(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = arg_492_1.actors_["106101ui_story"].transform
			local var_495_1 = 0

			if var_495_1 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 then
				arg_492_1.var_.moveOldPos106101ui_story = var_495_0.localPosition
			end

			local var_495_2 = 0.001

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_2 then
				local var_495_3 = (arg_492_1.time_ - var_495_1) / var_495_2
				local var_495_4 = Vector3.New(0, 100, 0)

				var_495_0.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos106101ui_story, var_495_4, var_495_3)

				local var_495_5 = manager.ui.mainCamera.transform.position - var_495_0.position

				var_495_0.forward = Vector3.New(var_495_5.x, var_495_5.y, var_495_5.z)

				local var_495_6 = var_495_0.localEulerAngles

				var_495_6.z = 0
				var_495_6.x = 0
				var_495_0.localEulerAngles = var_495_6
			end

			if arg_492_1.time_ >= var_495_1 + var_495_2 and arg_492_1.time_ < var_495_1 + var_495_2 + arg_495_0 then
				var_495_0.localPosition = Vector3.New(0, 100, 0)

				local var_495_7 = manager.ui.mainCamera.transform.position - var_495_0.position

				var_495_0.forward = Vector3.New(var_495_7.x, var_495_7.y, var_495_7.z)

				local var_495_8 = var_495_0.localEulerAngles

				var_495_8.z = 0
				var_495_8.x = 0
				var_495_0.localEulerAngles = var_495_8
			end

			local var_495_9 = arg_492_1.actors_["106101ui_story"]
			local var_495_10 = 0

			if var_495_10 < arg_492_1.time_ and arg_492_1.time_ <= var_495_10 + arg_495_0 and not isNil(var_495_9) and arg_492_1.var_.characterEffect106101ui_story == nil then
				arg_492_1.var_.characterEffect106101ui_story = var_495_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_11 = 0.200000002980232

			if var_495_10 <= arg_492_1.time_ and arg_492_1.time_ < var_495_10 + var_495_11 and not isNil(var_495_9) then
				local var_495_12 = (arg_492_1.time_ - var_495_10) / var_495_11

				if arg_492_1.var_.characterEffect106101ui_story and not isNil(var_495_9) then
					local var_495_13 = Mathf.Lerp(0, 0.5, var_495_12)

					arg_492_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_492_1.var_.characterEffect106101ui_story.fillRatio = var_495_13
				end
			end

			if arg_492_1.time_ >= var_495_10 + var_495_11 and arg_492_1.time_ < var_495_10 + var_495_11 + arg_495_0 and not isNil(var_495_9) and arg_492_1.var_.characterEffect106101ui_story then
				local var_495_14 = 0.5

				arg_492_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_492_1.var_.characterEffect106101ui_story.fillRatio = var_495_14
			end

			local var_495_15 = 0
			local var_495_16 = 0.775

			if var_495_15 < arg_492_1.time_ and arg_492_1.time_ <= var_495_15 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, false)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_17 = arg_492_1:GetWordFromCfg(1106103120)
				local var_495_18 = arg_492_1:FormatText(var_495_17.content)

				arg_492_1.text_.text = var_495_18

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_19 = 31
				local var_495_20 = utf8.len(var_495_18)
				local var_495_21 = var_495_19 <= 0 and var_495_16 or var_495_16 * (var_495_20 / var_495_19)

				if var_495_21 > 0 and var_495_16 < var_495_21 then
					arg_492_1.talkMaxDuration = var_495_21

					if var_495_21 + var_495_15 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_21 + var_495_15
					end
				end

				arg_492_1.text_.text = var_495_18
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_22 = math.max(var_495_16, arg_492_1.talkMaxDuration)

			if var_495_15 <= arg_492_1.time_ and arg_492_1.time_ < var_495_15 + var_495_22 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_15) / var_495_22

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_15 + var_495_22 and arg_492_1.time_ < var_495_15 + var_495_22 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play1106103121 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 1106103121
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play1106103122(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0
			local var_499_1 = 0.375

			if var_499_0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_2 = arg_496_1:FormatText(StoryNameCfg[7].name)

				arg_496_1.leftNameTxt_.text = var_499_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_3 = arg_496_1:GetWordFromCfg(1106103121)
				local var_499_4 = arg_496_1:FormatText(var_499_3.content)

				arg_496_1.text_.text = var_499_4

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_5 = 15
				local var_499_6 = utf8.len(var_499_4)
				local var_499_7 = var_499_5 <= 0 and var_499_1 or var_499_1 * (var_499_6 / var_499_5)

				if var_499_7 > 0 and var_499_1 < var_499_7 then
					arg_496_1.talkMaxDuration = var_499_7

					if var_499_7 + var_499_0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_7 + var_499_0
					end
				end

				arg_496_1.text_.text = var_499_4
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_8 = math.max(var_499_1, arg_496_1.talkMaxDuration)

			if var_499_0 <= arg_496_1.time_ and arg_496_1.time_ < var_499_0 + var_499_8 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_0) / var_499_8

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_0 + var_499_8 and arg_496_1.time_ < var_499_0 + var_499_8 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play1106103122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1106103122
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1106103123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 0.3

			if var_503_0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_2 = arg_500_1:FormatText(StoryNameCfg[7].name)

				arg_500_1.leftNameTxt_.text = var_503_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, true)
				arg_500_1.iconController_:SetSelectedState("hero")

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_3 = arg_500_1:GetWordFromCfg(1106103122)
				local var_503_4 = arg_500_1:FormatText(var_503_3.content)

				arg_500_1.text_.text = var_503_4

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_5 = 12
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
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_8 = math.max(var_503_1, arg_500_1.talkMaxDuration)

			if var_503_0 <= arg_500_1.time_ and arg_500_1.time_ < var_503_0 + var_503_8 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_0) / var_503_8

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_0 + var_503_8 and arg_500_1.time_ < var_503_0 + var_503_8 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play1106103123 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 1106103123
		arg_504_1.duration_ = 3.63

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play1106103124(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = arg_504_1.actors_["106101ui_story"].transform
			local var_507_1 = 0

			if var_507_1 < arg_504_1.time_ and arg_504_1.time_ <= var_507_1 + arg_507_0 then
				arg_504_1.var_.moveOldPos106101ui_story = var_507_0.localPosition
			end

			local var_507_2 = 0.001

			if var_507_1 <= arg_504_1.time_ and arg_504_1.time_ < var_507_1 + var_507_2 then
				local var_507_3 = (arg_504_1.time_ - var_507_1) / var_507_2
				local var_507_4 = Vector3.New(0, -1.18, -6.15)

				var_507_0.localPosition = Vector3.Lerp(arg_504_1.var_.moveOldPos106101ui_story, var_507_4, var_507_3)

				local var_507_5 = manager.ui.mainCamera.transform.position - var_507_0.position

				var_507_0.forward = Vector3.New(var_507_5.x, var_507_5.y, var_507_5.z)

				local var_507_6 = var_507_0.localEulerAngles

				var_507_6.z = 0
				var_507_6.x = 0
				var_507_0.localEulerAngles = var_507_6
			end

			if arg_504_1.time_ >= var_507_1 + var_507_2 and arg_504_1.time_ < var_507_1 + var_507_2 + arg_507_0 then
				var_507_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_507_7 = manager.ui.mainCamera.transform.position - var_507_0.position

				var_507_0.forward = Vector3.New(var_507_7.x, var_507_7.y, var_507_7.z)

				local var_507_8 = var_507_0.localEulerAngles

				var_507_8.z = 0
				var_507_8.x = 0
				var_507_0.localEulerAngles = var_507_8
			end

			local var_507_9 = arg_504_1.actors_["106101ui_story"]
			local var_507_10 = 0

			if var_507_10 < arg_504_1.time_ and arg_504_1.time_ <= var_507_10 + arg_507_0 and not isNil(var_507_9) and arg_504_1.var_.characterEffect106101ui_story == nil then
				arg_504_1.var_.characterEffect106101ui_story = var_507_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_11 = 0.200000002980232

			if var_507_10 <= arg_504_1.time_ and arg_504_1.time_ < var_507_10 + var_507_11 and not isNil(var_507_9) then
				local var_507_12 = (arg_504_1.time_ - var_507_10) / var_507_11

				if arg_504_1.var_.characterEffect106101ui_story and not isNil(var_507_9) then
					arg_504_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_504_1.time_ >= var_507_10 + var_507_11 and arg_504_1.time_ < var_507_10 + var_507_11 + arg_507_0 and not isNil(var_507_9) and arg_504_1.var_.characterEffect106101ui_story then
				arg_504_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			local var_507_13 = 0

			if var_507_13 < arg_504_1.time_ and arg_504_1.time_ <= var_507_13 + arg_507_0 then
				arg_504_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action6_2")
			end

			local var_507_14 = 0

			if var_507_14 < arg_504_1.time_ and arg_504_1.time_ <= var_507_14 + arg_507_0 then
				arg_504_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_507_15 = 0
			local var_507_16 = 0.45

			if var_507_15 < arg_504_1.time_ and arg_504_1.time_ <= var_507_15 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_17 = arg_504_1:FormatText(StoryNameCfg[612].name)

				arg_504_1.leftNameTxt_.text = var_507_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_18 = arg_504_1:GetWordFromCfg(1106103123)
				local var_507_19 = arg_504_1:FormatText(var_507_18.content)

				arg_504_1.text_.text = var_507_19

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_20 = 18
				local var_507_21 = utf8.len(var_507_19)
				local var_507_22 = var_507_20 <= 0 and var_507_16 or var_507_16 * (var_507_21 / var_507_20)

				if var_507_22 > 0 and var_507_16 < var_507_22 then
					arg_504_1.talkMaxDuration = var_507_22

					if var_507_22 + var_507_15 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_22 + var_507_15
					end
				end

				arg_504_1.text_.text = var_507_19
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103123", "story_v_side_new_1106103.awb") ~= 0 then
					local var_507_23 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103123", "story_v_side_new_1106103.awb") / 1000

					if var_507_23 + var_507_15 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_23 + var_507_15
					end

					if var_507_18.prefab_name ~= "" and arg_504_1.actors_[var_507_18.prefab_name] ~= nil then
						local var_507_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_18.prefab_name].transform, "story_v_side_new_1106103", "1106103123", "story_v_side_new_1106103.awb")

						arg_504_1:RecordAudio("1106103123", var_507_24)
						arg_504_1:RecordAudio("1106103123", var_507_24)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103123", "story_v_side_new_1106103.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103123", "story_v_side_new_1106103.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_25 = math.max(var_507_16, arg_504_1.talkMaxDuration)

			if var_507_15 <= arg_504_1.time_ and arg_504_1.time_ < var_507_15 + var_507_25 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_15) / var_507_25

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_15 + var_507_25 and arg_504_1.time_ < var_507_15 + var_507_25 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_504_1:InitPlayNodeList()
	end,
	Play1106103124 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 1106103124
		arg_508_1.duration_ = 2

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play1106103125(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0

			if var_511_0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_0 + arg_511_0 then
				arg_508_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_1")
			end

			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 then
				arg_508_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva", "EmotionTimelineAnimator")
			end

			local var_511_2 = 0
			local var_511_3 = 0.175

			if var_511_2 < arg_508_1.time_ and arg_508_1.time_ <= var_511_2 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_4 = arg_508_1:FormatText(StoryNameCfg[612].name)

				arg_508_1.leftNameTxt_.text = var_511_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_5 = arg_508_1:GetWordFromCfg(1106103124)
				local var_511_6 = arg_508_1:FormatText(var_511_5.content)

				arg_508_1.text_.text = var_511_6

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_7 = 7
				local var_511_8 = utf8.len(var_511_6)
				local var_511_9 = var_511_7 <= 0 and var_511_3 or var_511_3 * (var_511_8 / var_511_7)

				if var_511_9 > 0 and var_511_3 < var_511_9 then
					arg_508_1.talkMaxDuration = var_511_9

					if var_511_9 + var_511_2 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_9 + var_511_2
					end
				end

				arg_508_1.text_.text = var_511_6
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103124", "story_v_side_new_1106103.awb") ~= 0 then
					local var_511_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103124", "story_v_side_new_1106103.awb") / 1000

					if var_511_10 + var_511_2 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_10 + var_511_2
					end

					if var_511_5.prefab_name ~= "" and arg_508_1.actors_[var_511_5.prefab_name] ~= nil then
						local var_511_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_5.prefab_name].transform, "story_v_side_new_1106103", "1106103124", "story_v_side_new_1106103.awb")

						arg_508_1:RecordAudio("1106103124", var_511_11)
						arg_508_1:RecordAudio("1106103124", var_511_11)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103124", "story_v_side_new_1106103.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103124", "story_v_side_new_1106103.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_12 = math.max(var_511_3, arg_508_1.talkMaxDuration)

			if var_511_2 <= arg_508_1.time_ and arg_508_1.time_ < var_511_2 + var_511_12 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_2) / var_511_12

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_2 + var_511_12 and arg_508_1.time_ < var_511_2 + var_511_12 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play1106103125 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 1106103125
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
			arg_512_1.auto_ = false
		end

		function arg_512_1.playNext_(arg_514_0)
			arg_512_1.onStoryFinished_()
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = arg_512_1.actors_["106101ui_story"].transform
			local var_515_1 = 0

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 then
				arg_512_1.var_.moveOldPos106101ui_story = var_515_0.localPosition
			end

			local var_515_2 = 0.001

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_2 then
				local var_515_3 = (arg_512_1.time_ - var_515_1) / var_515_2
				local var_515_4 = Vector3.New(0, 100, 0)

				var_515_0.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos106101ui_story, var_515_4, var_515_3)

				local var_515_5 = manager.ui.mainCamera.transform.position - var_515_0.position

				var_515_0.forward = Vector3.New(var_515_5.x, var_515_5.y, var_515_5.z)

				local var_515_6 = var_515_0.localEulerAngles

				var_515_6.z = 0
				var_515_6.x = 0
				var_515_0.localEulerAngles = var_515_6
			end

			if arg_512_1.time_ >= var_515_1 + var_515_2 and arg_512_1.time_ < var_515_1 + var_515_2 + arg_515_0 then
				var_515_0.localPosition = Vector3.New(0, 100, 0)

				local var_515_7 = manager.ui.mainCamera.transform.position - var_515_0.position

				var_515_0.forward = Vector3.New(var_515_7.x, var_515_7.y, var_515_7.z)

				local var_515_8 = var_515_0.localEulerAngles

				var_515_8.z = 0
				var_515_8.x = 0
				var_515_0.localEulerAngles = var_515_8
			end

			local var_515_9 = arg_512_1.actors_["106101ui_story"]
			local var_515_10 = 0

			if var_515_10 < arg_512_1.time_ and arg_512_1.time_ <= var_515_10 + arg_515_0 and not isNil(var_515_9) and arg_512_1.var_.characterEffect106101ui_story == nil then
				arg_512_1.var_.characterEffect106101ui_story = var_515_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_11 = 0.200000002980232

			if var_515_10 <= arg_512_1.time_ and arg_512_1.time_ < var_515_10 + var_515_11 and not isNil(var_515_9) then
				local var_515_12 = (arg_512_1.time_ - var_515_10) / var_515_11

				if arg_512_1.var_.characterEffect106101ui_story and not isNil(var_515_9) then
					local var_515_13 = Mathf.Lerp(0, 0.5, var_515_12)

					arg_512_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_512_1.var_.characterEffect106101ui_story.fillRatio = var_515_13
				end
			end

			if arg_512_1.time_ >= var_515_10 + var_515_11 and arg_512_1.time_ < var_515_10 + var_515_11 + arg_515_0 and not isNil(var_515_9) and arg_512_1.var_.characterEffect106101ui_story then
				local var_515_14 = 0.5

				arg_512_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_512_1.var_.characterEffect106101ui_story.fillRatio = var_515_14
			end

			local var_515_15 = 0
			local var_515_16 = 0.725

			if var_515_15 < arg_512_1.time_ and arg_512_1.time_ <= var_515_15 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, false)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_17 = arg_512_1:GetWordFromCfg(1106103125)
				local var_515_18 = arg_512_1:FormatText(var_515_17.content)

				arg_512_1.text_.text = var_515_18

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_19 = 29
				local var_515_20 = utf8.len(var_515_18)
				local var_515_21 = var_515_19 <= 0 and var_515_16 or var_515_16 * (var_515_20 / var_515_19)

				if var_515_21 > 0 and var_515_16 < var_515_21 then
					arg_512_1.talkMaxDuration = var_515_21

					if var_515_21 + var_515_15 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_21 + var_515_15
					end
				end

				arg_512_1.text_.text = var_515_18
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_22 = math.max(var_515_16, arg_512_1.talkMaxDuration)

			if var_515_15 <= arg_512_1.time_ and arg_512_1.time_ < var_515_15 + var_515_22 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_15) / var_515_22

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_15 + var_515_22 and arg_512_1.time_ < var_515_15 + var_515_22 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_512_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST29",
		"TextureConfig/Background/ST47"
	},
	voices = {
		"story_v_side_new_1106103.awb"
	}
}
