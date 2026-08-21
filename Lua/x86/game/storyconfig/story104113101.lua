return {
	Play411311001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411311001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411311002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I11o"

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
				local var_4_5 = arg_1_1.bgs_.I11o

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
					if iter_4_0 ~= "I11o" then
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
			local var_4_23 = 0.4

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

			local var_4_28 = 0.666666666666667
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure")

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
			local var_4_35 = 0.925

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

				local var_4_37 = arg_1_1:GetWordFromCfg(411311001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 37
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
	Play411311002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411311002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play411311003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.15

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[36].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(411311002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 6
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_8 and arg_9_1.time_ < var_12_0 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play411311003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411311003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play411311004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.775

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

				local var_16_2 = arg_13_1:GetWordFromCfg(411311003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 31
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
	Play411311004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411311004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play411311005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "10066ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_17_1.stage_.transform)

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

			local var_20_5 = arg_17_1.actors_["10066ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos10066ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0, -0.99, -5.83)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10066ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["10066ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect10066ui_story == nil then
				arg_17_1.var_.characterEffect10066ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect10066ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect10066ui_story then
				arg_17_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_20_20 = 0
			local var_20_21 = 0.675

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_22 = arg_17_1:FormatText(StoryNameCfg[640].name)

				arg_17_1.leftNameTxt_.text = var_20_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_23 = arg_17_1:GetWordFromCfg(411311004)
				local var_20_24 = arg_17_1:FormatText(var_20_23.content)

				arg_17_1.text_.text = var_20_24

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_25 = 27
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
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_28 = math.max(var_20_21, arg_17_1.talkMaxDuration)

			if var_20_20 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_28 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_20) / var_20_28

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_20 + var_20_28 and arg_17_1.time_ < var_20_20 + var_20_28 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play411311005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411311005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play411311006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "10058ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_21_1.stage_.transform)

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

			local var_24_5 = arg_21_1.actors_["10058ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos10058ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(0.7, -0.98, -6.1)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10058ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = arg_21_1.actors_["10058ui_story"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect10058ui_story == nil then
				arg_21_1.var_.characterEffect10058ui_story = var_24_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_16 = 0.200000002980232

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.characterEffect10058ui_story and not isNil(var_24_14) then
					arg_21_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect10058ui_story then
				arg_21_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_24_18 = 0

			if var_24_18 < arg_21_1.time_ and arg_21_1.time_ <= var_24_18 + arg_24_0 then
				arg_21_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_20 = arg_21_1.actors_["10066ui_story"]
			local var_24_21 = 0

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 and not isNil(var_24_20) and arg_21_1.var_.characterEffect10066ui_story == nil then
				arg_21_1.var_.characterEffect10066ui_story = var_24_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_22 = 0.200000002980232

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 and not isNil(var_24_20) then
				local var_24_23 = (arg_21_1.time_ - var_24_21) / var_24_22

				if arg_21_1.var_.characterEffect10066ui_story and not isNil(var_24_20) then
					local var_24_24 = Mathf.Lerp(0, 0.5, var_24_23)

					arg_21_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10066ui_story.fillRatio = var_24_24
				end
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 and not isNil(var_24_20) and arg_21_1.var_.characterEffect10066ui_story then
				local var_24_25 = 0.5

				arg_21_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10066ui_story.fillRatio = var_24_25
			end

			local var_24_26 = arg_21_1.actors_["10066ui_story"].transform
			local var_24_27 = 0

			if var_24_27 < arg_21_1.time_ and arg_21_1.time_ <= var_24_27 + arg_24_0 then
				arg_21_1.var_.moveOldPos10066ui_story = var_24_26.localPosition
			end

			local var_24_28 = 0.001

			if var_24_27 <= arg_21_1.time_ and arg_21_1.time_ < var_24_27 + var_24_28 then
				local var_24_29 = (arg_21_1.time_ - var_24_27) / var_24_28
				local var_24_30 = Vector3.New(-0.7, -0.99, -5.83)

				var_24_26.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10066ui_story, var_24_30, var_24_29)

				local var_24_31 = manager.ui.mainCamera.transform.position - var_24_26.position

				var_24_26.forward = Vector3.New(var_24_31.x, var_24_31.y, var_24_31.z)

				local var_24_32 = var_24_26.localEulerAngles

				var_24_32.z = 0
				var_24_32.x = 0
				var_24_26.localEulerAngles = var_24_32
			end

			if arg_21_1.time_ >= var_24_27 + var_24_28 and arg_21_1.time_ < var_24_27 + var_24_28 + arg_24_0 then
				var_24_26.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_24_33 = manager.ui.mainCamera.transform.position - var_24_26.position

				var_24_26.forward = Vector3.New(var_24_33.x, var_24_33.y, var_24_33.z)

				local var_24_34 = var_24_26.localEulerAngles

				var_24_34.z = 0
				var_24_34.x = 0
				var_24_26.localEulerAngles = var_24_34
			end

			local var_24_35 = 0
			local var_24_36 = 0.25

			if var_24_35 < arg_21_1.time_ and arg_21_1.time_ <= var_24_35 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_37 = arg_21_1:FormatText(StoryNameCfg[471].name)

				arg_21_1.leftNameTxt_.text = var_24_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_38 = arg_21_1:GetWordFromCfg(411311005)
				local var_24_39 = arg_21_1:FormatText(var_24_38.content)

				arg_21_1.text_.text = var_24_39

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_40 = 10
				local var_24_41 = utf8.len(var_24_39)
				local var_24_42 = var_24_40 <= 0 and var_24_36 or var_24_36 * (var_24_41 / var_24_40)

				if var_24_42 > 0 and var_24_36 < var_24_42 then
					arg_21_1.talkMaxDuration = var_24_42

					if var_24_42 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_42 + var_24_35
					end
				end

				arg_21_1.text_.text = var_24_39
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_43 = math.max(var_24_36, arg_21_1.talkMaxDuration)

			if var_24_35 <= arg_21_1.time_ and arg_21_1.time_ < var_24_35 + var_24_43 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_35) / var_24_43

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_35 + var_24_43 and arg_21_1.time_ < var_24_35 + var_24_43 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play411311006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411311006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play411311007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10066ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10066ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10066ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["10066ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect10066ui_story == nil then
				arg_25_1.var_.characterEffect10066ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect10066ui_story and not isNil(var_28_9) then
					arg_25_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect10066ui_story then
				arg_25_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_28_15 = arg_25_1.actors_["10058ui_story"]
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.characterEffect10058ui_story == nil then
				arg_25_1.var_.characterEffect10058ui_story = var_28_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_17 = 0.200000002980232

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 and not isNil(var_28_15) then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17

				if arg_25_1.var_.characterEffect10058ui_story and not isNil(var_28_15) then
					local var_28_19 = Mathf.Lerp(0, 0.5, var_28_18)

					arg_25_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10058ui_story.fillRatio = var_28_19
				end
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.characterEffect10058ui_story then
				local var_28_20 = 0.5

				arg_25_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10058ui_story.fillRatio = var_28_20
			end

			local var_28_21 = 0
			local var_28_22 = 0.925

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_23 = arg_25_1:FormatText(StoryNameCfg[640].name)

				arg_25_1.leftNameTxt_.text = var_28_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_24 = arg_25_1:GetWordFromCfg(411311006)
				local var_28_25 = arg_25_1:FormatText(var_28_24.content)

				arg_25_1.text_.text = var_28_25

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_26 = 37
				local var_28_27 = utf8.len(var_28_25)
				local var_28_28 = var_28_26 <= 0 and var_28_22 or var_28_22 * (var_28_27 / var_28_26)

				if var_28_28 > 0 and var_28_22 < var_28_28 then
					arg_25_1.talkMaxDuration = var_28_28

					if var_28_28 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_21
					end
				end

				arg_25_1.text_.text = var_28_25
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_29 = math.max(var_28_22, arg_25_1.talkMaxDuration)

			if var_28_21 <= arg_25_1.time_ and arg_25_1.time_ < var_28_21 + var_28_29 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_21) / var_28_29

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_21 + var_28_29 and arg_25_1.time_ < var_28_21 + var_28_29 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play411311007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411311007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play411311008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10058ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos10058ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0.7, -0.98, -6.1)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10058ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["10058ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect10058ui_story == nil then
				arg_29_1.var_.characterEffect10058ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect10058ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect10058ui_story then
				arg_29_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_32_13 = 0

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_32_14 = arg_29_1.actors_["10066ui_story"]
			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect10066ui_story == nil then
				arg_29_1.var_.characterEffect10066ui_story = var_32_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_16 = 0.200000002980232

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 and not isNil(var_32_14) then
				local var_32_17 = (arg_29_1.time_ - var_32_15) / var_32_16

				if arg_29_1.var_.characterEffect10066ui_story and not isNil(var_32_14) then
					local var_32_18 = Mathf.Lerp(0, 0.5, var_32_17)

					arg_29_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10066ui_story.fillRatio = var_32_18
				end
			end

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect10066ui_story then
				local var_32_19 = 0.5

				arg_29_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10066ui_story.fillRatio = var_32_19
			end

			local var_32_20 = 0

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				arg_29_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_32_21 = 0
			local var_32_22 = 0.35

			if var_32_21 < arg_29_1.time_ and arg_29_1.time_ <= var_32_21 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_23 = arg_29_1:FormatText(StoryNameCfg[471].name)

				arg_29_1.leftNameTxt_.text = var_32_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_24 = arg_29_1:GetWordFromCfg(411311007)
				local var_32_25 = arg_29_1:FormatText(var_32_24.content)

				arg_29_1.text_.text = var_32_25

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_26 = 14
				local var_32_27 = utf8.len(var_32_25)
				local var_32_28 = var_32_26 <= 0 and var_32_22 or var_32_22 * (var_32_27 / var_32_26)

				if var_32_28 > 0 and var_32_22 < var_32_28 then
					arg_29_1.talkMaxDuration = var_32_28

					if var_32_28 + var_32_21 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_28 + var_32_21
					end
				end

				arg_29_1.text_.text = var_32_25
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_29 = math.max(var_32_22, arg_29_1.talkMaxDuration)

			if var_32_21 <= arg_29_1.time_ and arg_29_1.time_ < var_32_21 + var_32_29 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_21) / var_32_29

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_21 + var_32_29 and arg_29_1.time_ < var_32_21 + var_32_29 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play411311008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411311008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play411311009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10066ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10066ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10066ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["10066ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect10066ui_story == nil then
				arg_33_1.var_.characterEffect10066ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect10066ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect10066ui_story then
				arg_33_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_36_15 = arg_33_1.actors_["10058ui_story"]
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.characterEffect10058ui_story == nil then
				arg_33_1.var_.characterEffect10058ui_story = var_36_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_17 = 0.200000002980232

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 and not isNil(var_36_15) then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17

				if arg_33_1.var_.characterEffect10058ui_story and not isNil(var_36_15) then
					local var_36_19 = Mathf.Lerp(0, 0.5, var_36_18)

					arg_33_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10058ui_story.fillRatio = var_36_19
				end
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.characterEffect10058ui_story then
				local var_36_20 = 0.5

				arg_33_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10058ui_story.fillRatio = var_36_20
			end

			local var_36_21 = 0
			local var_36_22 = 0.15

			if var_36_21 < arg_33_1.time_ and arg_33_1.time_ <= var_36_21 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_23 = arg_33_1:FormatText(StoryNameCfg[640].name)

				arg_33_1.leftNameTxt_.text = var_36_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_24 = arg_33_1:GetWordFromCfg(411311008)
				local var_36_25 = arg_33_1:FormatText(var_36_24.content)

				arg_33_1.text_.text = var_36_25

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_26 = 6
				local var_36_27 = utf8.len(var_36_25)
				local var_36_28 = var_36_26 <= 0 and var_36_22 or var_36_22 * (var_36_27 / var_36_26)

				if var_36_28 > 0 and var_36_22 < var_36_28 then
					arg_33_1.talkMaxDuration = var_36_28

					if var_36_28 + var_36_21 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_28 + var_36_21
					end
				end

				arg_33_1.text_.text = var_36_25
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_29 = math.max(var_36_22, arg_33_1.talkMaxDuration)

			if var_36_21 <= arg_33_1.time_ and arg_33_1.time_ < var_36_21 + var_36_29 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_21) / var_36_29

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_21 + var_36_29 and arg_33_1.time_ < var_36_21 + var_36_29 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play411311009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 411311009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play411311010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10066ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10066ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, 100, 0)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10066ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, 100, 0)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["10066ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect10066ui_story == nil then
				arg_37_1.var_.characterEffect10066ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect10066ui_story and not isNil(var_40_9) then
					local var_40_13 = Mathf.Lerp(0, 0.5, var_40_12)

					arg_37_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10066ui_story.fillRatio = var_40_13
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect10066ui_story then
				local var_40_14 = 0.5

				arg_37_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10066ui_story.fillRatio = var_40_14
			end

			local var_40_15 = arg_37_1.actors_["10058ui_story"].transform
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.var_.moveOldPos10058ui_story = var_40_15.localPosition
			end

			local var_40_17 = 0.001

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17
				local var_40_19 = Vector3.New(0, 100, 0)

				var_40_15.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10058ui_story, var_40_19, var_40_18)

				local var_40_20 = manager.ui.mainCamera.transform.position - var_40_15.position

				var_40_15.forward = Vector3.New(var_40_20.x, var_40_20.y, var_40_20.z)

				local var_40_21 = var_40_15.localEulerAngles

				var_40_21.z = 0
				var_40_21.x = 0
				var_40_15.localEulerAngles = var_40_21
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 then
				var_40_15.localPosition = Vector3.New(0, 100, 0)

				local var_40_22 = manager.ui.mainCamera.transform.position - var_40_15.position

				var_40_15.forward = Vector3.New(var_40_22.x, var_40_22.y, var_40_22.z)

				local var_40_23 = var_40_15.localEulerAngles

				var_40_23.z = 0
				var_40_23.x = 0
				var_40_15.localEulerAngles = var_40_23
			end

			local var_40_24 = arg_37_1.actors_["10058ui_story"]
			local var_40_25 = 0

			if var_40_25 < arg_37_1.time_ and arg_37_1.time_ <= var_40_25 + arg_40_0 and not isNil(var_40_24) and arg_37_1.var_.characterEffect10058ui_story == nil then
				arg_37_1.var_.characterEffect10058ui_story = var_40_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_26 = 0.200000002980232

			if var_40_25 <= arg_37_1.time_ and arg_37_1.time_ < var_40_25 + var_40_26 and not isNil(var_40_24) then
				local var_40_27 = (arg_37_1.time_ - var_40_25) / var_40_26

				if arg_37_1.var_.characterEffect10058ui_story and not isNil(var_40_24) then
					local var_40_28 = Mathf.Lerp(0, 0.5, var_40_27)

					arg_37_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10058ui_story.fillRatio = var_40_28
				end
			end

			if arg_37_1.time_ >= var_40_25 + var_40_26 and arg_37_1.time_ < var_40_25 + var_40_26 + arg_40_0 and not isNil(var_40_24) and arg_37_1.var_.characterEffect10058ui_story then
				local var_40_29 = 0.5

				arg_37_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10058ui_story.fillRatio = var_40_29
			end

			local var_40_30 = 0
			local var_40_31 = 0.725

			if var_40_30 < arg_37_1.time_ and arg_37_1.time_ <= var_40_30 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_32 = arg_37_1:GetWordFromCfg(411311009)
				local var_40_33 = arg_37_1:FormatText(var_40_32.content)

				arg_37_1.text_.text = var_40_33

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_34 = 29
				local var_40_35 = utf8.len(var_40_33)
				local var_40_36 = var_40_34 <= 0 and var_40_31 or var_40_31 * (var_40_35 / var_40_34)

				if var_40_36 > 0 and var_40_31 < var_40_36 then
					arg_37_1.talkMaxDuration = var_40_36

					if var_40_36 + var_40_30 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_36 + var_40_30
					end
				end

				arg_37_1.text_.text = var_40_33
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_37 = math.max(var_40_31, arg_37_1.talkMaxDuration)

			if var_40_30 <= arg_37_1.time_ and arg_37_1.time_ < var_40_30 + var_40_37 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_30) / var_40_37

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_30 + var_40_37 and arg_37_1.time_ < var_40_30 + var_40_37 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play411311010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 411311010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play411311011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10058ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10058ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(0.7, -0.98, -6.1)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10058ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["10058ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect10058ui_story == nil then
				arg_41_1.var_.characterEffect10058ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect10058ui_story and not isNil(var_44_9) then
					arg_41_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect10058ui_story then
				arg_41_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_44_14 = arg_41_1.actors_["10066ui_story"].transform
			local var_44_15 = 0

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.var_.moveOldPos10066ui_story = var_44_14.localPosition
			end

			local var_44_16 = 0.001

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_16 then
				local var_44_17 = (arg_41_1.time_ - var_44_15) / var_44_16
				local var_44_18 = Vector3.New(-0.7, -0.99, -5.83)

				var_44_14.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10066ui_story, var_44_18, var_44_17)

				local var_44_19 = manager.ui.mainCamera.transform.position - var_44_14.position

				var_44_14.forward = Vector3.New(var_44_19.x, var_44_19.y, var_44_19.z)

				local var_44_20 = var_44_14.localEulerAngles

				var_44_20.z = 0
				var_44_20.x = 0
				var_44_14.localEulerAngles = var_44_20
			end

			if arg_41_1.time_ >= var_44_15 + var_44_16 and arg_41_1.time_ < var_44_15 + var_44_16 + arg_44_0 then
				var_44_14.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_44_21 = manager.ui.mainCamera.transform.position - var_44_14.position

				var_44_14.forward = Vector3.New(var_44_21.x, var_44_21.y, var_44_21.z)

				local var_44_22 = var_44_14.localEulerAngles

				var_44_22.z = 0
				var_44_22.x = 0
				var_44_14.localEulerAngles = var_44_22
			end

			local var_44_23 = arg_41_1.actors_["10066ui_story"]
			local var_44_24 = 0

			if var_44_24 < arg_41_1.time_ and arg_41_1.time_ <= var_44_24 + arg_44_0 and not isNil(var_44_23) and arg_41_1.var_.characterEffect10066ui_story == nil then
				arg_41_1.var_.characterEffect10066ui_story = var_44_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_25 = 0.200000002980232

			if var_44_24 <= arg_41_1.time_ and arg_41_1.time_ < var_44_24 + var_44_25 and not isNil(var_44_23) then
				local var_44_26 = (arg_41_1.time_ - var_44_24) / var_44_25

				if arg_41_1.var_.characterEffect10066ui_story and not isNil(var_44_23) then
					local var_44_27 = Mathf.Lerp(0, 0.5, var_44_26)

					arg_41_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10066ui_story.fillRatio = var_44_27
				end
			end

			if arg_41_1.time_ >= var_44_24 + var_44_25 and arg_41_1.time_ < var_44_24 + var_44_25 + arg_44_0 and not isNil(var_44_23) and arg_41_1.var_.characterEffect10066ui_story then
				local var_44_28 = 0.5

				arg_41_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10066ui_story.fillRatio = var_44_28
			end

			local var_44_29 = 0
			local var_44_30 = 0.375

			if var_44_29 < arg_41_1.time_ and arg_41_1.time_ <= var_44_29 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_31 = arg_41_1:FormatText(StoryNameCfg[471].name)

				arg_41_1.leftNameTxt_.text = var_44_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_32 = arg_41_1:GetWordFromCfg(411311010)
				local var_44_33 = arg_41_1:FormatText(var_44_32.content)

				arg_41_1.text_.text = var_44_33

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_34 = 15
				local var_44_35 = utf8.len(var_44_33)
				local var_44_36 = var_44_34 <= 0 and var_44_30 or var_44_30 * (var_44_35 / var_44_34)

				if var_44_36 > 0 and var_44_30 < var_44_36 then
					arg_41_1.talkMaxDuration = var_44_36

					if var_44_36 + var_44_29 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_36 + var_44_29
					end
				end

				arg_41_1.text_.text = var_44_33
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_37 = math.max(var_44_30, arg_41_1.talkMaxDuration)

			if var_44_29 <= arg_41_1.time_ and arg_41_1.time_ < var_44_29 + var_44_37 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_29) / var_44_37

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_29 + var_44_37 and arg_41_1.time_ < var_44_29 + var_44_37 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play411311011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 411311011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play411311012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10066ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10066ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10066ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["10066ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect10066ui_story == nil then
				arg_45_1.var_.characterEffect10066ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect10066ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect10066ui_story then
				arg_45_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_14 = arg_45_1.actors_["10058ui_story"]
			local var_48_15 = 0

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 and not isNil(var_48_14) and arg_45_1.var_.characterEffect10058ui_story == nil then
				arg_45_1.var_.characterEffect10058ui_story = var_48_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_16 = 0.200000002980232

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_16 and not isNil(var_48_14) then
				local var_48_17 = (arg_45_1.time_ - var_48_15) / var_48_16

				if arg_45_1.var_.characterEffect10058ui_story and not isNil(var_48_14) then
					local var_48_18 = Mathf.Lerp(0, 0.5, var_48_17)

					arg_45_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10058ui_story.fillRatio = var_48_18
				end
			end

			if arg_45_1.time_ >= var_48_15 + var_48_16 and arg_45_1.time_ < var_48_15 + var_48_16 + arg_48_0 and not isNil(var_48_14) and arg_45_1.var_.characterEffect10058ui_story then
				local var_48_19 = 0.5

				arg_45_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10058ui_story.fillRatio = var_48_19
			end

			local var_48_20 = 0
			local var_48_21 = 0.5

			if var_48_20 < arg_45_1.time_ and arg_45_1.time_ <= var_48_20 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_22 = arg_45_1:FormatText(StoryNameCfg[640].name)

				arg_45_1.leftNameTxt_.text = var_48_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_23 = arg_45_1:GetWordFromCfg(411311011)
				local var_48_24 = arg_45_1:FormatText(var_48_23.content)

				arg_45_1.text_.text = var_48_24

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_25 = 20
				local var_48_26 = utf8.len(var_48_24)
				local var_48_27 = var_48_25 <= 0 and var_48_21 or var_48_21 * (var_48_26 / var_48_25)

				if var_48_27 > 0 and var_48_21 < var_48_27 then
					arg_45_1.talkMaxDuration = var_48_27

					if var_48_27 + var_48_20 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_27 + var_48_20
					end
				end

				arg_45_1.text_.text = var_48_24
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_28 = math.max(var_48_21, arg_45_1.talkMaxDuration)

			if var_48_20 <= arg_45_1.time_ and arg_45_1.time_ < var_48_20 + var_48_28 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_20) / var_48_28

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_20 + var_48_28 and arg_45_1.time_ < var_48_20 + var_48_28 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play411311012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 411311012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play411311013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10066ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10066ui_story == nil then
				arg_49_1.var_.characterEffect10066ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect10066ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10066ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10066ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10066ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.825

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(411311012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 33
				local var_52_11 = utf8.len(var_52_9)
				local var_52_12 = var_52_10 <= 0 and var_52_7 or var_52_7 * (var_52_11 / var_52_10)

				if var_52_12 > 0 and var_52_7 < var_52_12 then
					arg_49_1.talkMaxDuration = var_52_12

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_13 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_13 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_13

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_13 and arg_49_1.time_ < var_52_6 + var_52_13 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play411311013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 411311013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play411311014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action446")
			end

			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_56_2 = arg_53_1.actors_["10066ui_story"]
			local var_56_3 = 0

			if var_56_3 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect10066ui_story == nil then
				arg_53_1.var_.characterEffect10066ui_story = var_56_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_4 = 0.200000002980232

			if var_56_3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_3 + var_56_4 and not isNil(var_56_2) then
				local var_56_5 = (arg_53_1.time_ - var_56_3) / var_56_4

				if arg_53_1.var_.characterEffect10066ui_story and not isNil(var_56_2) then
					arg_53_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_3 + var_56_4 and arg_53_1.time_ < var_56_3 + var_56_4 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect10066ui_story then
				arg_53_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_56_6 = 0
			local var_56_7 = 0.525

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[640].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_9 = arg_53_1:GetWordFromCfg(411311013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 21
				local var_56_12 = utf8.len(var_56_10)
				local var_56_13 = var_56_11 <= 0 and var_56_7 or var_56_7 * (var_56_12 / var_56_11)

				if var_56_13 > 0 and var_56_7 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play411311014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 411311014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play411311015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.7

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[640].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(411311014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 28
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play411311015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 411311015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play411311016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10058ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos10058ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0.7, -0.98, -6.1)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10058ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["10058ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect10058ui_story == nil then
				arg_61_1.var_.characterEffect10058ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect10058ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect10058ui_story then
				arg_61_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_64_13 = arg_61_1.actors_["10066ui_story"]
			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 and not isNil(var_64_13) and arg_61_1.var_.characterEffect10066ui_story == nil then
				arg_61_1.var_.characterEffect10066ui_story = var_64_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_15 = 0.200000002980232

			if var_64_14 <= arg_61_1.time_ and arg_61_1.time_ < var_64_14 + var_64_15 and not isNil(var_64_13) then
				local var_64_16 = (arg_61_1.time_ - var_64_14) / var_64_15

				if arg_61_1.var_.characterEffect10066ui_story and not isNil(var_64_13) then
					local var_64_17 = Mathf.Lerp(0, 0.5, var_64_16)

					arg_61_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10066ui_story.fillRatio = var_64_17
				end
			end

			if arg_61_1.time_ >= var_64_14 + var_64_15 and arg_61_1.time_ < var_64_14 + var_64_15 + arg_64_0 and not isNil(var_64_13) and arg_61_1.var_.characterEffect10066ui_story then
				local var_64_18 = 0.5

				arg_61_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10066ui_story.fillRatio = var_64_18
			end

			local var_64_19 = 0
			local var_64_20 = 0.1

			if var_64_19 < arg_61_1.time_ and arg_61_1.time_ <= var_64_19 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_21 = arg_61_1:FormatText(StoryNameCfg[471].name)

				arg_61_1.leftNameTxt_.text = var_64_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_22 = arg_61_1:GetWordFromCfg(411311015)
				local var_64_23 = arg_61_1:FormatText(var_64_22.content)

				arg_61_1.text_.text = var_64_23

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_24 = 4
				local var_64_25 = utf8.len(var_64_23)
				local var_64_26 = var_64_24 <= 0 and var_64_20 or var_64_20 * (var_64_25 / var_64_24)

				if var_64_26 > 0 and var_64_20 < var_64_26 then
					arg_61_1.talkMaxDuration = var_64_26

					if var_64_26 + var_64_19 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_26 + var_64_19
					end
				end

				arg_61_1.text_.text = var_64_23
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_27 = math.max(var_64_20, arg_61_1.talkMaxDuration)

			if var_64_19 <= arg_61_1.time_ and arg_61_1.time_ < var_64_19 + var_64_27 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_19) / var_64_27

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_19 + var_64_27 and arg_61_1.time_ < var_64_19 + var_64_27 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play411311016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 411311016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play411311017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10058ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10058ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0.7, -0.98, -6.1)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10058ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["10058ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect10058ui_story == nil then
				arg_65_1.var_.characterEffect10058ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect10058ui_story and not isNil(var_68_9) then
					local var_68_13 = Mathf.Lerp(0, 0.5, var_68_12)

					arg_65_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10058ui_story.fillRatio = var_68_13
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect10058ui_story then
				local var_68_14 = 0.5

				arg_65_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10058ui_story.fillRatio = var_68_14
			end

			local var_68_15 = arg_65_1.actors_["10066ui_story"]
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.characterEffect10066ui_story == nil then
				arg_65_1.var_.characterEffect10066ui_story = var_68_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_17 = 0.200000002980232

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 and not isNil(var_68_15) then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17

				if arg_65_1.var_.characterEffect10066ui_story and not isNil(var_68_15) then
					arg_65_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.characterEffect10066ui_story then
				arg_65_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_68_19 = 0
			local var_68_20 = 0.575

			if var_68_19 < arg_65_1.time_ and arg_65_1.time_ <= var_68_19 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_21 = arg_65_1:FormatText(StoryNameCfg[640].name)

				arg_65_1.leftNameTxt_.text = var_68_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_22 = arg_65_1:GetWordFromCfg(411311016)
				local var_68_23 = arg_65_1:FormatText(var_68_22.content)

				arg_65_1.text_.text = var_68_23

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_24 = 23
				local var_68_25 = utf8.len(var_68_23)
				local var_68_26 = var_68_24 <= 0 and var_68_20 or var_68_20 * (var_68_25 / var_68_24)

				if var_68_26 > 0 and var_68_20 < var_68_26 then
					arg_65_1.talkMaxDuration = var_68_26

					if var_68_26 + var_68_19 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_26 + var_68_19
					end
				end

				arg_65_1.text_.text = var_68_23
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_27 = math.max(var_68_20, arg_65_1.talkMaxDuration)

			if var_68_19 <= arg_65_1.time_ and arg_65_1.time_ < var_68_19 + var_68_27 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_19) / var_68_27

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_19 + var_68_27 and arg_65_1.time_ < var_68_19 + var_68_27 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play411311017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 411311017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play411311018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10058ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10058ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0.7, -0.98, -6.1)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10058ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["10058ui_story"]
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect10058ui_story == nil then
				arg_69_1.var_.characterEffect10058ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 and not isNil(var_72_9) then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11

				if arg_69_1.var_.characterEffect10058ui_story and not isNil(var_72_9) then
					arg_69_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect10058ui_story then
				arg_69_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_72_13 = 0

			if var_72_13 < arg_69_1.time_ and arg_69_1.time_ <= var_72_13 + arg_72_0 then
				arg_69_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_72_14 = 0

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				arg_69_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_72_15 = arg_69_1.actors_["10066ui_story"]
			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.characterEffect10066ui_story == nil then
				arg_69_1.var_.characterEffect10066ui_story = var_72_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_17 = 0.200000002980232

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_17 and not isNil(var_72_15) then
				local var_72_18 = (arg_69_1.time_ - var_72_16) / var_72_17

				if arg_69_1.var_.characterEffect10066ui_story and not isNil(var_72_15) then
					local var_72_19 = Mathf.Lerp(0, 0.5, var_72_18)

					arg_69_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10066ui_story.fillRatio = var_72_19
				end
			end

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.characterEffect10066ui_story then
				local var_72_20 = 0.5

				arg_69_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10066ui_story.fillRatio = var_72_20
			end

			local var_72_21 = 0
			local var_72_22 = 0.2

			if var_72_21 < arg_69_1.time_ and arg_69_1.time_ <= var_72_21 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_23 = arg_69_1:FormatText(StoryNameCfg[471].name)

				arg_69_1.leftNameTxt_.text = var_72_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_24 = arg_69_1:GetWordFromCfg(411311017)
				local var_72_25 = arg_69_1:FormatText(var_72_24.content)

				arg_69_1.text_.text = var_72_25

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_26 = 8
				local var_72_27 = utf8.len(var_72_25)
				local var_72_28 = var_72_26 <= 0 and var_72_22 or var_72_22 * (var_72_27 / var_72_26)

				if var_72_28 > 0 and var_72_22 < var_72_28 then
					arg_69_1.talkMaxDuration = var_72_28

					if var_72_28 + var_72_21 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_28 + var_72_21
					end
				end

				arg_69_1.text_.text = var_72_25
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_29 = math.max(var_72_22, arg_69_1.talkMaxDuration)

			if var_72_21 <= arg_69_1.time_ and arg_69_1.time_ < var_72_21 + var_72_29 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_21) / var_72_29

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_21 + var_72_29 and arg_69_1.time_ < var_72_21 + var_72_29 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play411311018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 411311018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play411311019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10058ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10058ui_story == nil then
				arg_73_1.var_.characterEffect10058ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect10058ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10058ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10058ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10058ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_76_7 = 0
			local var_76_8 = 1.2

			if var_76_7 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_9 = arg_73_1:GetWordFromCfg(411311018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 48
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_8 or var_76_8 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_8 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_7 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_7
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_8, arg_73_1.talkMaxDuration)

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_7) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_7 + var_76_14 and arg_73_1.time_ < var_76_7 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play411311019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 411311019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play411311020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10066ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10066ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10066ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["10066ui_story"]
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect10066ui_story == nil then
				arg_77_1.var_.characterEffect10066ui_story = var_80_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 and not isNil(var_80_9) then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11

				if arg_77_1.var_.characterEffect10066ui_story and not isNil(var_80_9) then
					arg_77_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect10066ui_story then
				arg_77_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_80_13 = 0

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_80_14 = 0

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_80_15 = 0
			local var_80_16 = 0.5

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_17 = arg_77_1:FormatText(StoryNameCfg[640].name)

				arg_77_1.leftNameTxt_.text = var_80_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_18 = arg_77_1:GetWordFromCfg(411311019)
				local var_80_19 = arg_77_1:FormatText(var_80_18.content)

				arg_77_1.text_.text = var_80_19

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_20 = 20
				local var_80_21 = utf8.len(var_80_19)
				local var_80_22 = var_80_20 <= 0 and var_80_16 or var_80_16 * (var_80_21 / var_80_20)

				if var_80_22 > 0 and var_80_16 < var_80_22 then
					arg_77_1.talkMaxDuration = var_80_22

					if var_80_22 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_22 + var_80_15
					end
				end

				arg_77_1.text_.text = var_80_19
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_23 = math.max(var_80_16, arg_77_1.talkMaxDuration)

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_23 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_15) / var_80_23

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_15 + var_80_23 and arg_77_1.time_ < var_80_15 + var_80_23 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play411311020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 411311020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play411311021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10058ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10058ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0.7, -0.98, -6.1)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10058ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["10058ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect10058ui_story == nil then
				arg_81_1.var_.characterEffect10058ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect10058ui_story and not isNil(var_84_9) then
					arg_81_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect10058ui_story then
				arg_81_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_84_14 = arg_81_1.actors_["10066ui_story"]
			local var_84_15 = 0

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.characterEffect10066ui_story == nil then
				arg_81_1.var_.characterEffect10066ui_story = var_84_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_16 = 0.200000002980232

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_16 and not isNil(var_84_14) then
				local var_84_17 = (arg_81_1.time_ - var_84_15) / var_84_16

				if arg_81_1.var_.characterEffect10066ui_story and not isNil(var_84_14) then
					local var_84_18 = Mathf.Lerp(0, 0.5, var_84_17)

					arg_81_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10066ui_story.fillRatio = var_84_18
				end
			end

			if arg_81_1.time_ >= var_84_15 + var_84_16 and arg_81_1.time_ < var_84_15 + var_84_16 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.characterEffect10066ui_story then
				local var_84_19 = 0.5

				arg_81_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10066ui_story.fillRatio = var_84_19
			end

			local var_84_20 = 0

			if var_84_20 < arg_81_1.time_ and arg_81_1.time_ <= var_84_20 + arg_84_0 then
				arg_81_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_1")
			end

			local var_84_21 = arg_81_1.actors_["10066ui_story"].transform
			local var_84_22 = 0

			if var_84_22 < arg_81_1.time_ and arg_81_1.time_ <= var_84_22 + arg_84_0 then
				arg_81_1.var_.moveOldPos10066ui_story = var_84_21.localPosition
			end

			local var_84_23 = 0.001

			if var_84_22 <= arg_81_1.time_ and arg_81_1.time_ < var_84_22 + var_84_23 then
				local var_84_24 = (arg_81_1.time_ - var_84_22) / var_84_23
				local var_84_25 = Vector3.New(-0.7, -0.99, -5.83)

				var_84_21.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10066ui_story, var_84_25, var_84_24)

				local var_84_26 = manager.ui.mainCamera.transform.position - var_84_21.position

				var_84_21.forward = Vector3.New(var_84_26.x, var_84_26.y, var_84_26.z)

				local var_84_27 = var_84_21.localEulerAngles

				var_84_27.z = 0
				var_84_27.x = 0
				var_84_21.localEulerAngles = var_84_27
			end

			if arg_81_1.time_ >= var_84_22 + var_84_23 and arg_81_1.time_ < var_84_22 + var_84_23 + arg_84_0 then
				var_84_21.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_84_28 = manager.ui.mainCamera.transform.position - var_84_21.position

				var_84_21.forward = Vector3.New(var_84_28.x, var_84_28.y, var_84_28.z)

				local var_84_29 = var_84_21.localEulerAngles

				var_84_29.z = 0
				var_84_29.x = 0
				var_84_21.localEulerAngles = var_84_29
			end

			local var_84_30 = 0
			local var_84_31 = 0.3

			if var_84_30 < arg_81_1.time_ and arg_81_1.time_ <= var_84_30 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_32 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_32:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_33 = arg_81_1:FormatText(StoryNameCfg[471].name)

				arg_81_1.leftNameTxt_.text = var_84_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_34 = arg_81_1:GetWordFromCfg(411311020)
				local var_84_35 = arg_81_1:FormatText(var_84_34.content)

				arg_81_1.text_.text = var_84_35

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_36 = 12
				local var_84_37 = utf8.len(var_84_35)
				local var_84_38 = var_84_36 <= 0 and var_84_31 or var_84_31 * (var_84_37 / var_84_36)

				if var_84_38 > 0 and var_84_31 < var_84_38 then
					arg_81_1.talkMaxDuration = var_84_38
					var_84_30 = var_84_30 + 0.3

					if var_84_38 + var_84_30 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_38 + var_84_30
					end
				end

				arg_81_1.text_.text = var_84_35
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_39 = var_84_30 + 0.3
			local var_84_40 = math.max(var_84_31, arg_81_1.talkMaxDuration)

			if var_84_39 <= arg_81_1.time_ and arg_81_1.time_ < var_84_39 + var_84_40 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_39) / var_84_40

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_39 + var_84_40 and arg_81_1.time_ < var_84_39 + var_84_40 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play411311021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 411311021
		arg_87_1.duration_ = 7.53

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play411311022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = "ST02"

			if arg_87_1.bgs_[var_90_0] == nil then
				local var_90_1 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_90_0)
				var_90_1.name = var_90_0
				var_90_1.transform.parent = arg_87_1.stage_.transform
				var_90_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_[var_90_0] = var_90_1
			end

			local var_90_2 = 1.025

			if var_90_2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				local var_90_3 = manager.ui.mainCamera.transform.localPosition
				local var_90_4 = Vector3.New(0, 0, 10) + Vector3.New(var_90_3.x, var_90_3.y, 0)
				local var_90_5 = arg_87_1.bgs_.ST02

				var_90_5.transform.localPosition = var_90_4
				var_90_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_6 = var_90_5:GetComponent("SpriteRenderer")

				if var_90_6 and var_90_6.sprite then
					local var_90_7 = (var_90_5.transform.localPosition - var_90_3).z
					local var_90_8 = manager.ui.mainCameraCom_
					local var_90_9 = 2 * var_90_7 * Mathf.Tan(var_90_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_90_10 = var_90_9 * var_90_8.aspect
					local var_90_11 = var_90_6.sprite.bounds.size.x
					local var_90_12 = var_90_6.sprite.bounds.size.y
					local var_90_13 = var_90_10 / var_90_11
					local var_90_14 = var_90_9 / var_90_12
					local var_90_15 = var_90_14 < var_90_13 and var_90_13 or var_90_14

					var_90_5.transform.localScale = Vector3.New(var_90_15, var_90_15, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "ST02" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_16 = 0

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_17 = 1.025

			if var_90_16 <= arg_87_1.time_ and arg_87_1.time_ < var_90_16 + var_90_17 then
				local var_90_18 = (arg_87_1.time_ - var_90_16) / var_90_17
				local var_90_19 = Color.New(0, 0, 0)

				var_90_19.a = Mathf.Lerp(0, 1, var_90_18)
				arg_87_1.mask_.color = var_90_19
			end

			if arg_87_1.time_ >= var_90_16 + var_90_17 and arg_87_1.time_ < var_90_16 + var_90_17 + arg_90_0 then
				local var_90_20 = Color.New(0, 0, 0)

				var_90_20.a = 1
				arg_87_1.mask_.color = var_90_20
			end

			local var_90_21 = 1.025

			if var_90_21 < arg_87_1.time_ and arg_87_1.time_ <= var_90_21 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_22 = 2

			if var_90_21 <= arg_87_1.time_ and arg_87_1.time_ < var_90_21 + var_90_22 then
				local var_90_23 = (arg_87_1.time_ - var_90_21) / var_90_22
				local var_90_24 = Color.New(0, 0, 0)

				var_90_24.a = Mathf.Lerp(1, 0, var_90_23)
				arg_87_1.mask_.color = var_90_24
			end

			if arg_87_1.time_ >= var_90_21 + var_90_22 and arg_87_1.time_ < var_90_21 + var_90_22 + arg_90_0 then
				local var_90_25 = Color.New(0, 0, 0)
				local var_90_26 = 0

				arg_87_1.mask_.enabled = false
				var_90_25.a = var_90_26
				arg_87_1.mask_.color = var_90_25
			end

			local var_90_27 = arg_87_1.actors_["10058ui_story"].transform
			local var_90_28 = 1

			if var_90_28 < arg_87_1.time_ and arg_87_1.time_ <= var_90_28 + arg_90_0 then
				arg_87_1.var_.moveOldPos10058ui_story = var_90_27.localPosition
			end

			local var_90_29 = 0.001

			if var_90_28 <= arg_87_1.time_ and arg_87_1.time_ < var_90_28 + var_90_29 then
				local var_90_30 = (arg_87_1.time_ - var_90_28) / var_90_29
				local var_90_31 = Vector3.New(0, 100, 0)

				var_90_27.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10058ui_story, var_90_31, var_90_30)

				local var_90_32 = manager.ui.mainCamera.transform.position - var_90_27.position

				var_90_27.forward = Vector3.New(var_90_32.x, var_90_32.y, var_90_32.z)

				local var_90_33 = var_90_27.localEulerAngles

				var_90_33.z = 0
				var_90_33.x = 0
				var_90_27.localEulerAngles = var_90_33
			end

			if arg_87_1.time_ >= var_90_28 + var_90_29 and arg_87_1.time_ < var_90_28 + var_90_29 + arg_90_0 then
				var_90_27.localPosition = Vector3.New(0, 100, 0)

				local var_90_34 = manager.ui.mainCamera.transform.position - var_90_27.position

				var_90_27.forward = Vector3.New(var_90_34.x, var_90_34.y, var_90_34.z)

				local var_90_35 = var_90_27.localEulerAngles

				var_90_35.z = 0
				var_90_35.x = 0
				var_90_27.localEulerAngles = var_90_35
			end

			local var_90_36 = arg_87_1.actors_["10058ui_story"]
			local var_90_37 = 1

			if var_90_37 < arg_87_1.time_ and arg_87_1.time_ <= var_90_37 + arg_90_0 and not isNil(var_90_36) and arg_87_1.var_.characterEffect10058ui_story == nil then
				arg_87_1.var_.characterEffect10058ui_story = var_90_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_38 = 0.200000002980232

			if var_90_37 <= arg_87_1.time_ and arg_87_1.time_ < var_90_37 + var_90_38 and not isNil(var_90_36) then
				local var_90_39 = (arg_87_1.time_ - var_90_37) / var_90_38

				if arg_87_1.var_.characterEffect10058ui_story and not isNil(var_90_36) then
					local var_90_40 = Mathf.Lerp(0, 0.5, var_90_39)

					arg_87_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10058ui_story.fillRatio = var_90_40
				end
			end

			if arg_87_1.time_ >= var_90_37 + var_90_38 and arg_87_1.time_ < var_90_37 + var_90_38 + arg_90_0 and not isNil(var_90_36) and arg_87_1.var_.characterEffect10058ui_story then
				local var_90_41 = 0.5

				arg_87_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10058ui_story.fillRatio = var_90_41
			end

			local var_90_42 = arg_87_1.actors_["10066ui_story"].transform
			local var_90_43 = 1

			if var_90_43 < arg_87_1.time_ and arg_87_1.time_ <= var_90_43 + arg_90_0 then
				arg_87_1.var_.moveOldPos10066ui_story = var_90_42.localPosition
			end

			local var_90_44 = 0.001

			if var_90_43 <= arg_87_1.time_ and arg_87_1.time_ < var_90_43 + var_90_44 then
				local var_90_45 = (arg_87_1.time_ - var_90_43) / var_90_44
				local var_90_46 = Vector3.New(0, 100, 0)

				var_90_42.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10066ui_story, var_90_46, var_90_45)

				local var_90_47 = manager.ui.mainCamera.transform.position - var_90_42.position

				var_90_42.forward = Vector3.New(var_90_47.x, var_90_47.y, var_90_47.z)

				local var_90_48 = var_90_42.localEulerAngles

				var_90_48.z = 0
				var_90_48.x = 0
				var_90_42.localEulerAngles = var_90_48
			end

			if arg_87_1.time_ >= var_90_43 + var_90_44 and arg_87_1.time_ < var_90_43 + var_90_44 + arg_90_0 then
				var_90_42.localPosition = Vector3.New(0, 100, 0)

				local var_90_49 = manager.ui.mainCamera.transform.position - var_90_42.position

				var_90_42.forward = Vector3.New(var_90_49.x, var_90_49.y, var_90_49.z)

				local var_90_50 = var_90_42.localEulerAngles

				var_90_50.z = 0
				var_90_50.x = 0
				var_90_42.localEulerAngles = var_90_50
			end

			local var_90_51 = arg_87_1.actors_["10066ui_story"]
			local var_90_52 = 1

			if var_90_52 < arg_87_1.time_ and arg_87_1.time_ <= var_90_52 + arg_90_0 and not isNil(var_90_51) and arg_87_1.var_.characterEffect10066ui_story == nil then
				arg_87_1.var_.characterEffect10066ui_story = var_90_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_53 = 0.200000002980232

			if var_90_52 <= arg_87_1.time_ and arg_87_1.time_ < var_90_52 + var_90_53 and not isNil(var_90_51) then
				local var_90_54 = (arg_87_1.time_ - var_90_52) / var_90_53

				if arg_87_1.var_.characterEffect10066ui_story and not isNil(var_90_51) then
					local var_90_55 = Mathf.Lerp(0, 0.5, var_90_54)

					arg_87_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10066ui_story.fillRatio = var_90_55
				end
			end

			if arg_87_1.time_ >= var_90_52 + var_90_53 and arg_87_1.time_ < var_90_52 + var_90_53 + arg_90_0 and not isNil(var_90_51) and arg_87_1.var_.characterEffect10066ui_story then
				local var_90_56 = 0.5

				arg_87_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10066ui_story.fillRatio = var_90_56
			end

			local var_90_57 = 0.833333333333333
			local var_90_58 = 1

			if var_90_57 < arg_87_1.time_ and arg_87_1.time_ <= var_90_57 + arg_90_0 then
				local var_90_59 = "play"
				local var_90_60 = "effect"

				arg_87_1:AudioAction(var_90_59, var_90_60, "se_story_221_00", "se_story_221_00_canteen_loop", "")
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_61 = 2.53333333333333
			local var_90_62 = 1.025

			if var_90_61 < arg_87_1.time_ and arg_87_1.time_ <= var_90_61 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_63 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_63:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_64 = arg_87_1:GetWordFromCfg(411311021)
				local var_90_65 = arg_87_1:FormatText(var_90_64.content)

				arg_87_1.text_.text = var_90_65

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_66 = 41
				local var_90_67 = utf8.len(var_90_65)
				local var_90_68 = var_90_66 <= 0 and var_90_62 or var_90_62 * (var_90_67 / var_90_66)

				if var_90_68 > 0 and var_90_62 < var_90_68 then
					arg_87_1.talkMaxDuration = var_90_68
					var_90_61 = var_90_61 + 0.3

					if var_90_68 + var_90_61 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_68 + var_90_61
					end
				end

				arg_87_1.text_.text = var_90_65
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_69 = var_90_61 + 0.3
			local var_90_70 = math.max(var_90_62, arg_87_1.talkMaxDuration)

			if var_90_69 <= arg_87_1.time_ and arg_87_1.time_ < var_90_69 + var_90_70 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_69) / var_90_70

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_69 + var_90_70 and arg_87_1.time_ < var_90_69 + var_90_70 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play411311022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 411311022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play411311023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.2

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(411311022)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 48
				local var_96_5 = utf8.len(var_96_3)
				local var_96_6 = var_96_4 <= 0 and var_96_1 or var_96_1 * (var_96_5 / var_96_4)

				if var_96_6 > 0 and var_96_1 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_7 and arg_93_1.time_ < var_96_0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play411311023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 411311023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play411311024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10066ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10066ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, -0.99, -5.83)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10066ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["10066ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10066ui_story == nil then
				arg_97_1.var_.characterEffect10066ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect10066ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10066ui_story then
				arg_97_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_100_15 = 0
			local var_100_16 = 0.725

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[640].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(411311023)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 29
				local var_100_21 = utf8.len(var_100_19)
				local var_100_22 = var_100_20 <= 0 and var_100_16 or var_100_16 * (var_100_21 / var_100_20)

				if var_100_22 > 0 and var_100_16 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_19
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_23 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_23 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_23

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_23 and arg_97_1.time_ < var_100_15 + var_100_23 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play411311024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 411311024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play411311025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10066ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10066ui_story == nil then
				arg_101_1.var_.characterEffect10066ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect10066ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10066ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10066ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10066ui_story.fillRatio = var_104_5
			end

			local var_104_6 = 0
			local var_104_7 = 0.65

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:GetWordFromCfg(411311024)
				local var_104_9 = arg_101_1:FormatText(var_104_8.content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_10 = 26
				local var_104_11 = utf8.len(var_104_9)
				local var_104_12 = var_104_10 <= 0 and var_104_7 or var_104_7 * (var_104_11 / var_104_10)

				if var_104_12 > 0 and var_104_7 < var_104_12 then
					arg_101_1.talkMaxDuration = var_104_12

					if var_104_12 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_13 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_13 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_13

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_13 and arg_101_1.time_ < var_104_6 + var_104_13 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play411311025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 411311025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play411311026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10066ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10066ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0, -0.99, -5.83)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10066ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = arg_105_1.actors_["10066ui_story"]
			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect10066ui_story == nil then
				arg_105_1.var_.characterEffect10066ui_story = var_108_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_11 = 0.200000002980232

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 and not isNil(var_108_9) then
				local var_108_12 = (arg_105_1.time_ - var_108_10) / var_108_11

				if arg_105_1.var_.characterEffect10066ui_story and not isNil(var_108_9) then
					arg_105_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect10066ui_story then
				arg_105_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_108_13 = 0

			if var_108_13 < arg_105_1.time_ and arg_105_1.time_ <= var_108_13 + arg_108_0 then
				arg_105_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_108_14 = 0
			local var_108_15 = 0.625

			if var_108_14 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_16 = arg_105_1:FormatText(StoryNameCfg[640].name)

				arg_105_1.leftNameTxt_.text = var_108_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_17 = arg_105_1:GetWordFromCfg(411311025)
				local var_108_18 = arg_105_1:FormatText(var_108_17.content)

				arg_105_1.text_.text = var_108_18

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_19 = 25
				local var_108_20 = utf8.len(var_108_18)
				local var_108_21 = var_108_19 <= 0 and var_108_15 or var_108_15 * (var_108_20 / var_108_19)

				if var_108_21 > 0 and var_108_15 < var_108_21 then
					arg_105_1.talkMaxDuration = var_108_21

					if var_108_21 + var_108_14 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_21 + var_108_14
					end
				end

				arg_105_1.text_.text = var_108_18
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_22 = math.max(var_108_15, arg_105_1.talkMaxDuration)

			if var_108_14 <= arg_105_1.time_ and arg_105_1.time_ < var_108_14 + var_108_22 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_14) / var_108_22

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_14 + var_108_22 and arg_105_1.time_ < var_108_14 + var_108_22 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play411311026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 411311026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play411311027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10058ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10058ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0.7, -0.98, -6.1)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10058ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["10058ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect10058ui_story == nil then
				arg_109_1.var_.characterEffect10058ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect10058ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect10058ui_story then
				arg_109_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_112_14 = arg_109_1.actors_["10066ui_story"]
			local var_112_15 = 0

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 and not isNil(var_112_14) and arg_109_1.var_.characterEffect10066ui_story == nil then
				arg_109_1.var_.characterEffect10066ui_story = var_112_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_16 = 0.200000002980232

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_16 and not isNil(var_112_14) then
				local var_112_17 = (arg_109_1.time_ - var_112_15) / var_112_16

				if arg_109_1.var_.characterEffect10066ui_story and not isNil(var_112_14) then
					local var_112_18 = Mathf.Lerp(0, 0.5, var_112_17)

					arg_109_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10066ui_story.fillRatio = var_112_18
				end
			end

			if arg_109_1.time_ >= var_112_15 + var_112_16 and arg_109_1.time_ < var_112_15 + var_112_16 + arg_112_0 and not isNil(var_112_14) and arg_109_1.var_.characterEffect10066ui_story then
				local var_112_19 = 0.5

				arg_109_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10066ui_story.fillRatio = var_112_19
			end

			local var_112_20 = 0

			if var_112_20 < arg_109_1.time_ and arg_109_1.time_ <= var_112_20 + arg_112_0 then
				arg_109_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_112_21 = arg_109_1.actors_["10066ui_story"].transform
			local var_112_22 = 0

			if var_112_22 < arg_109_1.time_ and arg_109_1.time_ <= var_112_22 + arg_112_0 then
				arg_109_1.var_.moveOldPos10066ui_story = var_112_21.localPosition
			end

			local var_112_23 = 0.001

			if var_112_22 <= arg_109_1.time_ and arg_109_1.time_ < var_112_22 + var_112_23 then
				local var_112_24 = (arg_109_1.time_ - var_112_22) / var_112_23
				local var_112_25 = Vector3.New(-0.7, -0.99, -5.83)

				var_112_21.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10066ui_story, var_112_25, var_112_24)

				local var_112_26 = manager.ui.mainCamera.transform.position - var_112_21.position

				var_112_21.forward = Vector3.New(var_112_26.x, var_112_26.y, var_112_26.z)

				local var_112_27 = var_112_21.localEulerAngles

				var_112_27.z = 0
				var_112_27.x = 0
				var_112_21.localEulerAngles = var_112_27
			end

			if arg_109_1.time_ >= var_112_22 + var_112_23 and arg_109_1.time_ < var_112_22 + var_112_23 + arg_112_0 then
				var_112_21.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_112_28 = manager.ui.mainCamera.transform.position - var_112_21.position

				var_112_21.forward = Vector3.New(var_112_28.x, var_112_28.y, var_112_28.z)

				local var_112_29 = var_112_21.localEulerAngles

				var_112_29.z = 0
				var_112_29.x = 0
				var_112_21.localEulerAngles = var_112_29
			end

			local var_112_30 = 0
			local var_112_31 = 0.3

			if var_112_30 < arg_109_1.time_ and arg_109_1.time_ <= var_112_30 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_32 = arg_109_1:FormatText(StoryNameCfg[471].name)

				arg_109_1.leftNameTxt_.text = var_112_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_33 = arg_109_1:GetWordFromCfg(411311026)
				local var_112_34 = arg_109_1:FormatText(var_112_33.content)

				arg_109_1.text_.text = var_112_34

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_35 = 12
				local var_112_36 = utf8.len(var_112_34)
				local var_112_37 = var_112_35 <= 0 and var_112_31 or var_112_31 * (var_112_36 / var_112_35)

				if var_112_37 > 0 and var_112_31 < var_112_37 then
					arg_109_1.talkMaxDuration = var_112_37

					if var_112_37 + var_112_30 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_37 + var_112_30
					end
				end

				arg_109_1.text_.text = var_112_34
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_38 = math.max(var_112_31, arg_109_1.talkMaxDuration)

			if var_112_30 <= arg_109_1.time_ and arg_109_1.time_ < var_112_30 + var_112_38 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_30) / var_112_38

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_30 + var_112_38 and arg_109_1.time_ < var_112_30 + var_112_38 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play411311027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 411311027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play411311028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10066ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10066ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10066ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["10066ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect10066ui_story == nil then
				arg_113_1.var_.characterEffect10066ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect10066ui_story and not isNil(var_116_9) then
					arg_113_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect10066ui_story then
				arg_113_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_116_13 = 0

			if var_116_13 < arg_113_1.time_ and arg_113_1.time_ <= var_116_13 + arg_116_0 then
				arg_113_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_116_14 = 0

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_116_15 = arg_113_1.actors_["10058ui_story"]
			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.characterEffect10058ui_story == nil then
				arg_113_1.var_.characterEffect10058ui_story = var_116_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_17 = 0.200000002980232

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 and not isNil(var_116_15) then
				local var_116_18 = (arg_113_1.time_ - var_116_16) / var_116_17

				if arg_113_1.var_.characterEffect10058ui_story and not isNil(var_116_15) then
					local var_116_19 = Mathf.Lerp(0, 0.5, var_116_18)

					arg_113_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10058ui_story.fillRatio = var_116_19
				end
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.characterEffect10058ui_story then
				local var_116_20 = 0.5

				arg_113_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10058ui_story.fillRatio = var_116_20
			end

			local var_116_21 = 0
			local var_116_22 = 0.275

			if var_116_21 < arg_113_1.time_ and arg_113_1.time_ <= var_116_21 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_23 = arg_113_1:FormatText(StoryNameCfg[640].name)

				arg_113_1.leftNameTxt_.text = var_116_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_24 = arg_113_1:GetWordFromCfg(411311027)
				local var_116_25 = arg_113_1:FormatText(var_116_24.content)

				arg_113_1.text_.text = var_116_25

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_26 = 11
				local var_116_27 = utf8.len(var_116_25)
				local var_116_28 = var_116_26 <= 0 and var_116_22 or var_116_22 * (var_116_27 / var_116_26)

				if var_116_28 > 0 and var_116_22 < var_116_28 then
					arg_113_1.talkMaxDuration = var_116_28

					if var_116_28 + var_116_21 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_28 + var_116_21
					end
				end

				arg_113_1.text_.text = var_116_25
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_29 = math.max(var_116_22, arg_113_1.talkMaxDuration)

			if var_116_21 <= arg_113_1.time_ and arg_113_1.time_ < var_116_21 + var_116_29 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_21) / var_116_29

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_21 + var_116_29 and arg_113_1.time_ < var_116_21 + var_116_29 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play411311028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 411311028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play411311029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10066ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect10066ui_story == nil then
				arg_117_1.var_.characterEffect10066ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect10066ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10066ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect10066ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10066ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.8

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(411311028)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 32
				local var_120_11 = utf8.len(var_120_9)
				local var_120_12 = var_120_10 <= 0 and var_120_7 or var_120_7 * (var_120_11 / var_120_10)

				if var_120_12 > 0 and var_120_7 < var_120_12 then
					arg_117_1.talkMaxDuration = var_120_12

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_13 and arg_117_1.time_ < var_120_6 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play411311029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 411311029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play411311030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10066ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10066ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10066ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["10066ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10066ui_story == nil then
				arg_121_1.var_.characterEffect10066ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect10066ui_story and not isNil(var_124_9) then
					arg_121_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10066ui_story then
				arg_121_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_124_13 = 0

			if var_124_13 < arg_121_1.time_ and arg_121_1.time_ <= var_124_13 + arg_124_0 then
				arg_121_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 then
				arg_121_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_124_15 = 0
			local var_124_16 = 1.15

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_17 = arg_121_1:FormatText(StoryNameCfg[640].name)

				arg_121_1.leftNameTxt_.text = var_124_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_18 = arg_121_1:GetWordFromCfg(411311029)
				local var_124_19 = arg_121_1:FormatText(var_124_18.content)

				arg_121_1.text_.text = var_124_19

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_20 = 46
				local var_124_21 = utf8.len(var_124_19)
				local var_124_22 = var_124_20 <= 0 and var_124_16 or var_124_16 * (var_124_21 / var_124_20)

				if var_124_22 > 0 and var_124_16 < var_124_22 then
					arg_121_1.talkMaxDuration = var_124_22

					if var_124_22 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_15
					end
				end

				arg_121_1.text_.text = var_124_19
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_23 = math.max(var_124_16, arg_121_1.talkMaxDuration)

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_23 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_15) / var_124_23

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_15 + var_124_23 and arg_121_1.time_ < var_124_15 + var_124_23 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play411311030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 411311030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play411311031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10058ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos10058ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0.7, -0.98, -6.1)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10058ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["10058ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect10058ui_story == nil then
				arg_125_1.var_.characterEffect10058ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect10058ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect10058ui_story then
				arg_125_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_128_13 = arg_125_1.actors_["10066ui_story"]
			local var_128_14 = 0

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 and not isNil(var_128_13) and arg_125_1.var_.characterEffect10066ui_story == nil then
				arg_125_1.var_.characterEffect10066ui_story = var_128_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_15 = 0.200000002980232

			if var_128_14 <= arg_125_1.time_ and arg_125_1.time_ < var_128_14 + var_128_15 and not isNil(var_128_13) then
				local var_128_16 = (arg_125_1.time_ - var_128_14) / var_128_15

				if arg_125_1.var_.characterEffect10066ui_story and not isNil(var_128_13) then
					local var_128_17 = Mathf.Lerp(0, 0.5, var_128_16)

					arg_125_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10066ui_story.fillRatio = var_128_17
				end
			end

			if arg_125_1.time_ >= var_128_14 + var_128_15 and arg_125_1.time_ < var_128_14 + var_128_15 + arg_128_0 and not isNil(var_128_13) and arg_125_1.var_.characterEffect10066ui_story then
				local var_128_18 = 0.5

				arg_125_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10066ui_story.fillRatio = var_128_18
			end

			local var_128_19 = 0
			local var_128_20 = 0.4

			if var_128_19 < arg_125_1.time_ and arg_125_1.time_ <= var_128_19 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_21 = arg_125_1:FormatText(StoryNameCfg[471].name)

				arg_125_1.leftNameTxt_.text = var_128_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_22 = arg_125_1:GetWordFromCfg(411311030)
				local var_128_23 = arg_125_1:FormatText(var_128_22.content)

				arg_125_1.text_.text = var_128_23

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_24 = 16
				local var_128_25 = utf8.len(var_128_23)
				local var_128_26 = var_128_24 <= 0 and var_128_20 or var_128_20 * (var_128_25 / var_128_24)

				if var_128_26 > 0 and var_128_20 < var_128_26 then
					arg_125_1.talkMaxDuration = var_128_26

					if var_128_26 + var_128_19 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_26 + var_128_19
					end
				end

				arg_125_1.text_.text = var_128_23
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_27 = math.max(var_128_20, arg_125_1.talkMaxDuration)

			if var_128_19 <= arg_125_1.time_ and arg_125_1.time_ < var_128_19 + var_128_27 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_19) / var_128_27

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_19 + var_128_27 and arg_125_1.time_ < var_128_19 + var_128_27 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play411311031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 411311031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play411311032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10066ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos10066ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10066ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = arg_129_1.actors_["10066ui_story"]
			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect10066ui_story == nil then
				arg_129_1.var_.characterEffect10066ui_story = var_132_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_11 = 0.200000002980232

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_11 and not isNil(var_132_9) then
				local var_132_12 = (arg_129_1.time_ - var_132_10) / var_132_11

				if arg_129_1.var_.characterEffect10066ui_story and not isNil(var_132_9) then
					arg_129_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_10 + var_132_11 and arg_129_1.time_ < var_132_10 + var_132_11 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect10066ui_story then
				arg_129_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_132_13 = arg_129_1.actors_["10058ui_story"]
			local var_132_14 = 0

			if var_132_14 < arg_129_1.time_ and arg_129_1.time_ <= var_132_14 + arg_132_0 and not isNil(var_132_13) and arg_129_1.var_.characterEffect10058ui_story == nil then
				arg_129_1.var_.characterEffect10058ui_story = var_132_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_15 = 0.200000002980232

			if var_132_14 <= arg_129_1.time_ and arg_129_1.time_ < var_132_14 + var_132_15 and not isNil(var_132_13) then
				local var_132_16 = (arg_129_1.time_ - var_132_14) / var_132_15

				if arg_129_1.var_.characterEffect10058ui_story and not isNil(var_132_13) then
					local var_132_17 = Mathf.Lerp(0, 0.5, var_132_16)

					arg_129_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10058ui_story.fillRatio = var_132_17
				end
			end

			if arg_129_1.time_ >= var_132_14 + var_132_15 and arg_129_1.time_ < var_132_14 + var_132_15 + arg_132_0 and not isNil(var_132_13) and arg_129_1.var_.characterEffect10058ui_story then
				local var_132_18 = 0.5

				arg_129_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10058ui_story.fillRatio = var_132_18
			end

			local var_132_19 = 0
			local var_132_20 = 1.525

			if var_132_19 < arg_129_1.time_ and arg_129_1.time_ <= var_132_19 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_21 = arg_129_1:FormatText(StoryNameCfg[640].name)

				arg_129_1.leftNameTxt_.text = var_132_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_22 = arg_129_1:GetWordFromCfg(411311031)
				local var_132_23 = arg_129_1:FormatText(var_132_22.content)

				arg_129_1.text_.text = var_132_23

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_24 = 61
				local var_132_25 = utf8.len(var_132_23)
				local var_132_26 = var_132_24 <= 0 and var_132_20 or var_132_20 * (var_132_25 / var_132_24)

				if var_132_26 > 0 and var_132_20 < var_132_26 then
					arg_129_1.talkMaxDuration = var_132_26

					if var_132_26 + var_132_19 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_26 + var_132_19
					end
				end

				arg_129_1.text_.text = var_132_23
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_27 = math.max(var_132_20, arg_129_1.talkMaxDuration)

			if var_132_19 <= arg_129_1.time_ and arg_129_1.time_ < var_132_19 + var_132_27 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_19) / var_132_27

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_19 + var_132_27 and arg_129_1.time_ < var_132_19 + var_132_27 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play411311032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 411311032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play411311033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10066ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10066ui_story == nil then
				arg_133_1.var_.characterEffect10066ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect10066ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10066ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10066ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10066ui_story.fillRatio = var_136_5
			end

			local var_136_6 = 0
			local var_136_7 = 1.475

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(411311032)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_10 = 59
				local var_136_11 = utf8.len(var_136_9)
				local var_136_12 = var_136_10 <= 0 and var_136_7 or var_136_7 * (var_136_11 / var_136_10)

				if var_136_12 > 0 and var_136_7 < var_136_12 then
					arg_133_1.talkMaxDuration = var_136_12

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_13 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_13 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_13

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_13 and arg_133_1.time_ < var_136_6 + var_136_13 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play411311033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 411311033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play411311034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10058ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10058ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0.7, -0.98, -6.1)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10058ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = arg_137_1.actors_["10058ui_story"]
			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect10058ui_story == nil then
				arg_137_1.var_.characterEffect10058ui_story = var_140_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_11 = 0.200000002980232

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_11 and not isNil(var_140_9) then
				local var_140_12 = (arg_137_1.time_ - var_140_10) / var_140_11

				if arg_137_1.var_.characterEffect10058ui_story and not isNil(var_140_9) then
					arg_137_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_10 + var_140_11 and arg_137_1.time_ < var_140_10 + var_140_11 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect10058ui_story then
				arg_137_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_140_13 = 0

			if var_140_13 < arg_137_1.time_ and arg_137_1.time_ <= var_140_13 + arg_140_0 then
				arg_137_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_140_14 = 0

			if var_140_14 < arg_137_1.time_ and arg_137_1.time_ <= var_140_14 + arg_140_0 then
				arg_137_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_140_15 = 0
			local var_140_16 = 0.15

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_17 = arg_137_1:FormatText(StoryNameCfg[471].name)

				arg_137_1.leftNameTxt_.text = var_140_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_18 = arg_137_1:GetWordFromCfg(411311033)
				local var_140_19 = arg_137_1:FormatText(var_140_18.content)

				arg_137_1.text_.text = var_140_19

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_20 = 6
				local var_140_21 = utf8.len(var_140_19)
				local var_140_22 = var_140_20 <= 0 and var_140_16 or var_140_16 * (var_140_21 / var_140_20)

				if var_140_22 > 0 and var_140_16 < var_140_22 then
					arg_137_1.talkMaxDuration = var_140_22

					if var_140_22 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_22 + var_140_15
					end
				end

				arg_137_1.text_.text = var_140_19
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_23 = math.max(var_140_16, arg_137_1.talkMaxDuration)

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_23 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_15) / var_140_23

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_15 + var_140_23 and arg_137_1.time_ < var_140_15 + var_140_23 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play411311034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 411311034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play411311035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10066ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos10066ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10066ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["10066ui_story"]
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect10066ui_story == nil then
				arg_141_1.var_.characterEffect10066ui_story = var_144_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_11 = 0.200000002980232

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 and not isNil(var_144_9) then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11

				if arg_141_1.var_.characterEffect10066ui_story and not isNil(var_144_9) then
					arg_141_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect10066ui_story then
				arg_141_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_144_13 = 0

			if var_144_13 < arg_141_1.time_ and arg_141_1.time_ <= var_144_13 + arg_144_0 then
				arg_141_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_144_14 = arg_141_1.actors_["10058ui_story"]
			local var_144_15 = 0

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 and not isNil(var_144_14) and arg_141_1.var_.characterEffect10058ui_story == nil then
				arg_141_1.var_.characterEffect10058ui_story = var_144_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_16 = 0.200000002980232

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_16 and not isNil(var_144_14) then
				local var_144_17 = (arg_141_1.time_ - var_144_15) / var_144_16

				if arg_141_1.var_.characterEffect10058ui_story and not isNil(var_144_14) then
					local var_144_18 = Mathf.Lerp(0, 0.5, var_144_17)

					arg_141_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10058ui_story.fillRatio = var_144_18
				end
			end

			if arg_141_1.time_ >= var_144_15 + var_144_16 and arg_141_1.time_ < var_144_15 + var_144_16 + arg_144_0 and not isNil(var_144_14) and arg_141_1.var_.characterEffect10058ui_story then
				local var_144_19 = 0.5

				arg_141_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10058ui_story.fillRatio = var_144_19
			end

			local var_144_20 = 0
			local var_144_21 = 0.35

			if var_144_20 < arg_141_1.time_ and arg_141_1.time_ <= var_144_20 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_22 = arg_141_1:FormatText(StoryNameCfg[640].name)

				arg_141_1.leftNameTxt_.text = var_144_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_23 = arg_141_1:GetWordFromCfg(411311034)
				local var_144_24 = arg_141_1:FormatText(var_144_23.content)

				arg_141_1.text_.text = var_144_24

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_25 = 14
				local var_144_26 = utf8.len(var_144_24)
				local var_144_27 = var_144_25 <= 0 and var_144_21 or var_144_21 * (var_144_26 / var_144_25)

				if var_144_27 > 0 and var_144_21 < var_144_27 then
					arg_141_1.talkMaxDuration = var_144_27

					if var_144_27 + var_144_20 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_27 + var_144_20
					end
				end

				arg_141_1.text_.text = var_144_24
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_28 = math.max(var_144_21, arg_141_1.talkMaxDuration)

			if var_144_20 <= arg_141_1.time_ and arg_141_1.time_ < var_144_20 + var_144_28 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_20) / var_144_28

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_20 + var_144_28 and arg_141_1.time_ < var_144_20 + var_144_28 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play411311035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 411311035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play411311036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action436")
			end

			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_148_2 = 0
			local var_148_3 = 0.8

			if var_148_2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_4 = arg_145_1:FormatText(StoryNameCfg[640].name)

				arg_145_1.leftNameTxt_.text = var_148_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_5 = arg_145_1:GetWordFromCfg(411311035)
				local var_148_6 = arg_145_1:FormatText(var_148_5.content)

				arg_145_1.text_.text = var_148_6

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 32
				local var_148_8 = utf8.len(var_148_6)
				local var_148_9 = var_148_7 <= 0 and var_148_3 or var_148_3 * (var_148_8 / var_148_7)

				if var_148_9 > 0 and var_148_3 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_2
					end
				end

				arg_145_1.text_.text = var_148_6
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_3, arg_145_1.talkMaxDuration)

			if var_148_2 <= arg_145_1.time_ and arg_145_1.time_ < var_148_2 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_2) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_2 + var_148_10 and arg_145_1.time_ < var_148_2 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play411311036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 411311036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play411311037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10058ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos10058ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(0.7, -0.98, -6.1)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10058ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["10058ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect10058ui_story == nil then
				arg_149_1.var_.characterEffect10058ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect10058ui_story and not isNil(var_152_9) then
					arg_149_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect10058ui_story then
				arg_149_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_152_13 = 0

			if var_152_13 < arg_149_1.time_ and arg_149_1.time_ <= var_152_13 + arg_152_0 then
				arg_149_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_152_14 = arg_149_1.actors_["10066ui_story"]
			local var_152_15 = 0

			if var_152_15 < arg_149_1.time_ and arg_149_1.time_ <= var_152_15 + arg_152_0 and not isNil(var_152_14) and arg_149_1.var_.characterEffect10066ui_story == nil then
				arg_149_1.var_.characterEffect10066ui_story = var_152_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_16 = 0.200000002980232

			if var_152_15 <= arg_149_1.time_ and arg_149_1.time_ < var_152_15 + var_152_16 and not isNil(var_152_14) then
				local var_152_17 = (arg_149_1.time_ - var_152_15) / var_152_16

				if arg_149_1.var_.characterEffect10066ui_story and not isNil(var_152_14) then
					local var_152_18 = Mathf.Lerp(0, 0.5, var_152_17)

					arg_149_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10066ui_story.fillRatio = var_152_18
				end
			end

			if arg_149_1.time_ >= var_152_15 + var_152_16 and arg_149_1.time_ < var_152_15 + var_152_16 + arg_152_0 and not isNil(var_152_14) and arg_149_1.var_.characterEffect10066ui_story then
				local var_152_19 = 0.5

				arg_149_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10066ui_story.fillRatio = var_152_19
			end

			local var_152_20 = 0

			if var_152_20 < arg_149_1.time_ and arg_149_1.time_ <= var_152_20 + arg_152_0 then
				arg_149_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_152_21 = 0
			local var_152_22 = 0.325

			if var_152_21 < arg_149_1.time_ and arg_149_1.time_ <= var_152_21 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_23 = arg_149_1:FormatText(StoryNameCfg[471].name)

				arg_149_1.leftNameTxt_.text = var_152_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_24 = arg_149_1:GetWordFromCfg(411311036)
				local var_152_25 = arg_149_1:FormatText(var_152_24.content)

				arg_149_1.text_.text = var_152_25

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_26 = 13
				local var_152_27 = utf8.len(var_152_25)
				local var_152_28 = var_152_26 <= 0 and var_152_22 or var_152_22 * (var_152_27 / var_152_26)

				if var_152_28 > 0 and var_152_22 < var_152_28 then
					arg_149_1.talkMaxDuration = var_152_28

					if var_152_28 + var_152_21 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_28 + var_152_21
					end
				end

				arg_149_1.text_.text = var_152_25
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_29 = math.max(var_152_22, arg_149_1.talkMaxDuration)

			if var_152_21 <= arg_149_1.time_ and arg_149_1.time_ < var_152_21 + var_152_29 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_21) / var_152_29

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_21 + var_152_29 and arg_149_1.time_ < var_152_21 + var_152_29 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411311037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 411311037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play411311038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10066ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos10066ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10066ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = arg_153_1.actors_["10066ui_story"]
			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect10066ui_story == nil then
				arg_153_1.var_.characterEffect10066ui_story = var_156_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_11 = 0.200000002980232

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_11 and not isNil(var_156_9) then
				local var_156_12 = (arg_153_1.time_ - var_156_10) / var_156_11

				if arg_153_1.var_.characterEffect10066ui_story and not isNil(var_156_9) then
					arg_153_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_10 + var_156_11 and arg_153_1.time_ < var_156_10 + var_156_11 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect10066ui_story then
				arg_153_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_156_13 = 0

			if var_156_13 < arg_153_1.time_ and arg_153_1.time_ <= var_156_13 + arg_156_0 then
				arg_153_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action467")
			end

			local var_156_14 = 0

			if var_156_14 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				arg_153_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_156_15 = arg_153_1.actors_["10058ui_story"]
			local var_156_16 = 0

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 and not isNil(var_156_15) and arg_153_1.var_.characterEffect10058ui_story == nil then
				arg_153_1.var_.characterEffect10058ui_story = var_156_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_17 = 0.200000002980232

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_17 and not isNil(var_156_15) then
				local var_156_18 = (arg_153_1.time_ - var_156_16) / var_156_17

				if arg_153_1.var_.characterEffect10058ui_story and not isNil(var_156_15) then
					local var_156_19 = Mathf.Lerp(0, 0.5, var_156_18)

					arg_153_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10058ui_story.fillRatio = var_156_19
				end
			end

			if arg_153_1.time_ >= var_156_16 + var_156_17 and arg_153_1.time_ < var_156_16 + var_156_17 + arg_156_0 and not isNil(var_156_15) and arg_153_1.var_.characterEffect10058ui_story then
				local var_156_20 = 0.5

				arg_153_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10058ui_story.fillRatio = var_156_20
			end

			local var_156_21 = 0
			local var_156_22 = 0.575

			if var_156_21 < arg_153_1.time_ and arg_153_1.time_ <= var_156_21 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_23 = arg_153_1:FormatText(StoryNameCfg[640].name)

				arg_153_1.leftNameTxt_.text = var_156_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_24 = arg_153_1:GetWordFromCfg(411311037)
				local var_156_25 = arg_153_1:FormatText(var_156_24.content)

				arg_153_1.text_.text = var_156_25

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_26 = 23
				local var_156_27 = utf8.len(var_156_25)
				local var_156_28 = var_156_26 <= 0 and var_156_22 or var_156_22 * (var_156_27 / var_156_26)

				if var_156_28 > 0 and var_156_22 < var_156_28 then
					arg_153_1.talkMaxDuration = var_156_28

					if var_156_28 + var_156_21 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_28 + var_156_21
					end
				end

				arg_153_1.text_.text = var_156_25
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_29 = math.max(var_156_22, arg_153_1.talkMaxDuration)

			if var_156_21 <= arg_153_1.time_ and arg_153_1.time_ < var_156_21 + var_156_29 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_21) / var_156_29

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_21 + var_156_29 and arg_153_1.time_ < var_156_21 + var_156_29 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play411311038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 411311038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play411311039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10058ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10058ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0.7, -0.98, -6.1)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10058ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["10058ui_story"]
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect10058ui_story == nil then
				arg_157_1.var_.characterEffect10058ui_story = var_160_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_11 = 0.200000002980232

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 and not isNil(var_160_9) then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11

				if arg_157_1.var_.characterEffect10058ui_story and not isNil(var_160_9) then
					arg_157_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect10058ui_story then
				arg_157_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_160_13 = arg_157_1.actors_["10066ui_story"]
			local var_160_14 = 0

			if var_160_14 < arg_157_1.time_ and arg_157_1.time_ <= var_160_14 + arg_160_0 and not isNil(var_160_13) and arg_157_1.var_.characterEffect10066ui_story == nil then
				arg_157_1.var_.characterEffect10066ui_story = var_160_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_15 = 0.200000002980232

			if var_160_14 <= arg_157_1.time_ and arg_157_1.time_ < var_160_14 + var_160_15 and not isNil(var_160_13) then
				local var_160_16 = (arg_157_1.time_ - var_160_14) / var_160_15

				if arg_157_1.var_.characterEffect10066ui_story and not isNil(var_160_13) then
					local var_160_17 = Mathf.Lerp(0, 0.5, var_160_16)

					arg_157_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10066ui_story.fillRatio = var_160_17
				end
			end

			if arg_157_1.time_ >= var_160_14 + var_160_15 and arg_157_1.time_ < var_160_14 + var_160_15 + arg_160_0 and not isNil(var_160_13) and arg_157_1.var_.characterEffect10066ui_story then
				local var_160_18 = 0.5

				arg_157_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10066ui_story.fillRatio = var_160_18
			end

			local var_160_19 = 0
			local var_160_20 = 0.225

			if var_160_19 < arg_157_1.time_ and arg_157_1.time_ <= var_160_19 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_21 = arg_157_1:FormatText(StoryNameCfg[471].name)

				arg_157_1.leftNameTxt_.text = var_160_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_22 = arg_157_1:GetWordFromCfg(411311038)
				local var_160_23 = arg_157_1:FormatText(var_160_22.content)

				arg_157_1.text_.text = var_160_23

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_24 = 9
				local var_160_25 = utf8.len(var_160_23)
				local var_160_26 = var_160_24 <= 0 and var_160_20 or var_160_20 * (var_160_25 / var_160_24)

				if var_160_26 > 0 and var_160_20 < var_160_26 then
					arg_157_1.talkMaxDuration = var_160_26

					if var_160_26 + var_160_19 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_26 + var_160_19
					end
				end

				arg_157_1.text_.text = var_160_23
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_27 = math.max(var_160_20, arg_157_1.talkMaxDuration)

			if var_160_19 <= arg_157_1.time_ and arg_157_1.time_ < var_160_19 + var_160_27 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_19) / var_160_27

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_19 + var_160_27 and arg_157_1.time_ < var_160_19 + var_160_27 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play411311039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 411311039
		arg_161_1.duration_ = 8.73

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play411311040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = "ST74"

			if arg_161_1.bgs_[var_164_0] == nil then
				local var_164_1 = Object.Instantiate(arg_161_1.paintGo_)

				var_164_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_164_0)
				var_164_1.name = var_164_0
				var_164_1.transform.parent = arg_161_1.stage_.transform
				var_164_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.bgs_[var_164_0] = var_164_1
			end

			local var_164_2 = 2

			if var_164_2 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 then
				local var_164_3 = manager.ui.mainCamera.transform.localPosition
				local var_164_4 = Vector3.New(0, 0, 10) + Vector3.New(var_164_3.x, var_164_3.y, 0)
				local var_164_5 = arg_161_1.bgs_.ST74

				var_164_5.transform.localPosition = var_164_4
				var_164_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_164_6 = var_164_5:GetComponent("SpriteRenderer")

				if var_164_6 and var_164_6.sprite then
					local var_164_7 = (var_164_5.transform.localPosition - var_164_3).z
					local var_164_8 = manager.ui.mainCameraCom_
					local var_164_9 = 2 * var_164_7 * Mathf.Tan(var_164_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_164_10 = var_164_9 * var_164_8.aspect
					local var_164_11 = var_164_6.sprite.bounds.size.x
					local var_164_12 = var_164_6.sprite.bounds.size.y
					local var_164_13 = var_164_10 / var_164_11
					local var_164_14 = var_164_9 / var_164_12
					local var_164_15 = var_164_14 < var_164_13 and var_164_13 or var_164_14

					var_164_5.transform.localScale = Vector3.New(var_164_15, var_164_15, 0)
				end

				for iter_164_0, iter_164_1 in pairs(arg_161_1.bgs_) do
					if iter_164_0 ~= "ST74" then
						iter_164_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_164_16 = 0

			if var_164_16 < arg_161_1.time_ and arg_161_1.time_ <= var_164_16 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_17 = 2

			if var_164_16 <= arg_161_1.time_ and arg_161_1.time_ < var_164_16 + var_164_17 then
				local var_164_18 = (arg_161_1.time_ - var_164_16) / var_164_17
				local var_164_19 = Color.New(0, 0, 0)

				var_164_19.a = Mathf.Lerp(0, 1, var_164_18)
				arg_161_1.mask_.color = var_164_19
			end

			if arg_161_1.time_ >= var_164_16 + var_164_17 and arg_161_1.time_ < var_164_16 + var_164_17 + arg_164_0 then
				local var_164_20 = Color.New(0, 0, 0)

				var_164_20.a = 1
				arg_161_1.mask_.color = var_164_20
			end

			local var_164_21 = 2

			if var_164_21 < arg_161_1.time_ and arg_161_1.time_ <= var_164_21 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_22 = 2

			if var_164_21 <= arg_161_1.time_ and arg_161_1.time_ < var_164_21 + var_164_22 then
				local var_164_23 = (arg_161_1.time_ - var_164_21) / var_164_22
				local var_164_24 = Color.New(0, 0, 0)

				var_164_24.a = Mathf.Lerp(1, 0, var_164_23)
				arg_161_1.mask_.color = var_164_24
			end

			if arg_161_1.time_ >= var_164_21 + var_164_22 and arg_161_1.time_ < var_164_21 + var_164_22 + arg_164_0 then
				local var_164_25 = Color.New(0, 0, 0)
				local var_164_26 = 0

				arg_161_1.mask_.enabled = false
				var_164_25.a = var_164_26
				arg_161_1.mask_.color = var_164_25
			end

			local var_164_27 = arg_161_1.actors_["10058ui_story"].transform
			local var_164_28 = 2

			if var_164_28 < arg_161_1.time_ and arg_161_1.time_ <= var_164_28 + arg_164_0 then
				arg_161_1.var_.moveOldPos10058ui_story = var_164_27.localPosition
			end

			local var_164_29 = 0.001

			if var_164_28 <= arg_161_1.time_ and arg_161_1.time_ < var_164_28 + var_164_29 then
				local var_164_30 = (arg_161_1.time_ - var_164_28) / var_164_29
				local var_164_31 = Vector3.New(0, 100, 0)

				var_164_27.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10058ui_story, var_164_31, var_164_30)

				local var_164_32 = manager.ui.mainCamera.transform.position - var_164_27.position

				var_164_27.forward = Vector3.New(var_164_32.x, var_164_32.y, var_164_32.z)

				local var_164_33 = var_164_27.localEulerAngles

				var_164_33.z = 0
				var_164_33.x = 0
				var_164_27.localEulerAngles = var_164_33
			end

			if arg_161_1.time_ >= var_164_28 + var_164_29 and arg_161_1.time_ < var_164_28 + var_164_29 + arg_164_0 then
				var_164_27.localPosition = Vector3.New(0, 100, 0)

				local var_164_34 = manager.ui.mainCamera.transform.position - var_164_27.position

				var_164_27.forward = Vector3.New(var_164_34.x, var_164_34.y, var_164_34.z)

				local var_164_35 = var_164_27.localEulerAngles

				var_164_35.z = 0
				var_164_35.x = 0
				var_164_27.localEulerAngles = var_164_35
			end

			local var_164_36 = arg_161_1.actors_["10058ui_story"]
			local var_164_37 = 2

			if var_164_37 < arg_161_1.time_ and arg_161_1.time_ <= var_164_37 + arg_164_0 and not isNil(var_164_36) and arg_161_1.var_.characterEffect10058ui_story == nil then
				arg_161_1.var_.characterEffect10058ui_story = var_164_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_38 = 0.200000002980232

			if var_164_37 <= arg_161_1.time_ and arg_161_1.time_ < var_164_37 + var_164_38 and not isNil(var_164_36) then
				local var_164_39 = (arg_161_1.time_ - var_164_37) / var_164_38

				if arg_161_1.var_.characterEffect10058ui_story and not isNil(var_164_36) then
					local var_164_40 = Mathf.Lerp(0, 0.5, var_164_39)

					arg_161_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10058ui_story.fillRatio = var_164_40
				end
			end

			if arg_161_1.time_ >= var_164_37 + var_164_38 and arg_161_1.time_ < var_164_37 + var_164_38 + arg_164_0 and not isNil(var_164_36) and arg_161_1.var_.characterEffect10058ui_story then
				local var_164_41 = 0.5

				arg_161_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10058ui_story.fillRatio = var_164_41
			end

			local var_164_42 = arg_161_1.actors_["10066ui_story"].transform
			local var_164_43 = 2

			if var_164_43 < arg_161_1.time_ and arg_161_1.time_ <= var_164_43 + arg_164_0 then
				arg_161_1.var_.moveOldPos10066ui_story = var_164_42.localPosition
			end

			local var_164_44 = 0.001

			if var_164_43 <= arg_161_1.time_ and arg_161_1.time_ < var_164_43 + var_164_44 then
				local var_164_45 = (arg_161_1.time_ - var_164_43) / var_164_44
				local var_164_46 = Vector3.New(0, 100, 0)

				var_164_42.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10066ui_story, var_164_46, var_164_45)

				local var_164_47 = manager.ui.mainCamera.transform.position - var_164_42.position

				var_164_42.forward = Vector3.New(var_164_47.x, var_164_47.y, var_164_47.z)

				local var_164_48 = var_164_42.localEulerAngles

				var_164_48.z = 0
				var_164_48.x = 0
				var_164_42.localEulerAngles = var_164_48
			end

			if arg_161_1.time_ >= var_164_43 + var_164_44 and arg_161_1.time_ < var_164_43 + var_164_44 + arg_164_0 then
				var_164_42.localPosition = Vector3.New(0, 100, 0)

				local var_164_49 = manager.ui.mainCamera.transform.position - var_164_42.position

				var_164_42.forward = Vector3.New(var_164_49.x, var_164_49.y, var_164_49.z)

				local var_164_50 = var_164_42.localEulerAngles

				var_164_50.z = 0
				var_164_50.x = 0
				var_164_42.localEulerAngles = var_164_50
			end

			local var_164_51 = arg_161_1.actors_["10066ui_story"]
			local var_164_52 = 2

			if var_164_52 < arg_161_1.time_ and arg_161_1.time_ <= var_164_52 + arg_164_0 and not isNil(var_164_51) and arg_161_1.var_.characterEffect10066ui_story == nil then
				arg_161_1.var_.characterEffect10066ui_story = var_164_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_53 = 0.200000002980232

			if var_164_52 <= arg_161_1.time_ and arg_161_1.time_ < var_164_52 + var_164_53 and not isNil(var_164_51) then
				local var_164_54 = (arg_161_1.time_ - var_164_52) / var_164_53

				if arg_161_1.var_.characterEffect10066ui_story and not isNil(var_164_51) then
					local var_164_55 = Mathf.Lerp(0, 0.5, var_164_54)

					arg_161_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10066ui_story.fillRatio = var_164_55
				end
			end

			if arg_161_1.time_ >= var_164_52 + var_164_53 and arg_161_1.time_ < var_164_52 + var_164_53 + arg_164_0 and not isNil(var_164_51) and arg_161_1.var_.characterEffect10066ui_story then
				local var_164_56 = 0.5

				arg_161_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10066ui_story.fillRatio = var_164_56
			end

			local var_164_57 = 0
			local var_164_58 = 0.4

			if var_164_57 < arg_161_1.time_ and arg_161_1.time_ <= var_164_57 + arg_164_0 then
				local var_164_59 = "stop"
				local var_164_60 = "effect"

				arg_161_1:AudioAction(var_164_59, var_164_60, "se_story_221_00", "se_story_221_00_canteen_loop", "")
			end

			if arg_161_1.frameCnt_ <= 1 then
				arg_161_1.dialog_:SetActive(false)
			end

			local var_164_61 = 3.73333333333333
			local var_164_62 = 1.175

			if var_164_61 < arg_161_1.time_ and arg_161_1.time_ <= var_164_61 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0

				arg_161_1.dialog_:SetActive(true)

				arg_161_1.dialogCg_.alpha = 0

				local var_164_63 = LeanTween.value(arg_161_1.dialog_, 0, 1, 0.3)

				var_164_63:setOnUpdate(LuaHelper.FloatAction(function(arg_165_0)
					arg_161_1.dialogCg_.alpha = arg_165_0
				end))
				var_164_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_161_1.dialog_)
					var_164_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_161_1.duration_ = arg_161_1.duration_ + 0.3

				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_64 = arg_161_1:GetWordFromCfg(411311039)
				local var_164_65 = arg_161_1:FormatText(var_164_64.content)

				arg_161_1.text_.text = var_164_65

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_66 = 47
				local var_164_67 = utf8.len(var_164_65)
				local var_164_68 = var_164_66 <= 0 and var_164_62 or var_164_62 * (var_164_67 / var_164_66)

				if var_164_68 > 0 and var_164_62 < var_164_68 then
					arg_161_1.talkMaxDuration = var_164_68
					var_164_61 = var_164_61 + 0.3

					if var_164_68 + var_164_61 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_68 + var_164_61
					end
				end

				arg_161_1.text_.text = var_164_65
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_69 = var_164_61 + 0.3
			local var_164_70 = math.max(var_164_62, arg_161_1.talkMaxDuration)

			if var_164_69 <= arg_161_1.time_ and arg_161_1.time_ < var_164_69 + var_164_70 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_69) / var_164_70

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_69 + var_164_70 and arg_161_1.time_ < var_164_69 + var_164_70 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play411311040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 411311040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play411311041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10066ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos10066ui_story = var_170_0.localPosition
			end

			local var_170_2 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2
				local var_170_4 = Vector3.New(0, -0.99, -5.83)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10066ui_story, var_170_4, var_170_3)

				local var_170_5 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_5.x, var_170_5.y, var_170_5.z)

				local var_170_6 = var_170_0.localEulerAngles

				var_170_6.z = 0
				var_170_6.x = 0
				var_170_0.localEulerAngles = var_170_6
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_170_7 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_7.x, var_170_7.y, var_170_7.z)

				local var_170_8 = var_170_0.localEulerAngles

				var_170_8.z = 0
				var_170_8.x = 0
				var_170_0.localEulerAngles = var_170_8
			end

			local var_170_9 = arg_167_1.actors_["10066ui_story"]
			local var_170_10 = 0

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 and not isNil(var_170_9) and arg_167_1.var_.characterEffect10066ui_story == nil then
				arg_167_1.var_.characterEffect10066ui_story = var_170_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_11 = 0.200000002980232

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_11 and not isNil(var_170_9) then
				local var_170_12 = (arg_167_1.time_ - var_170_10) / var_170_11

				if arg_167_1.var_.characterEffect10066ui_story and not isNil(var_170_9) then
					arg_167_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_10 + var_170_11 and arg_167_1.time_ < var_170_10 + var_170_11 + arg_170_0 and not isNil(var_170_9) and arg_167_1.var_.characterEffect10066ui_story then
				arg_167_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_170_13 = 0

			if var_170_13 < arg_167_1.time_ and arg_167_1.time_ <= var_170_13 + arg_170_0 then
				arg_167_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_2")
			end

			local var_170_14 = 0

			if var_170_14 < arg_167_1.time_ and arg_167_1.time_ <= var_170_14 + arg_170_0 then
				arg_167_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_170_15 = 0
			local var_170_16 = 0.375

			if var_170_15 < arg_167_1.time_ and arg_167_1.time_ <= var_170_15 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_17 = arg_167_1:FormatText(StoryNameCfg[640].name)

				arg_167_1.leftNameTxt_.text = var_170_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_18 = arg_167_1:GetWordFromCfg(411311040)
				local var_170_19 = arg_167_1:FormatText(var_170_18.content)

				arg_167_1.text_.text = var_170_19

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_20 = 15
				local var_170_21 = utf8.len(var_170_19)
				local var_170_22 = var_170_20 <= 0 and var_170_16 or var_170_16 * (var_170_21 / var_170_20)

				if var_170_22 > 0 and var_170_16 < var_170_22 then
					arg_167_1.talkMaxDuration = var_170_22

					if var_170_22 + var_170_15 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_22 + var_170_15
					end
				end

				arg_167_1.text_.text = var_170_19
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_23 = math.max(var_170_16, arg_167_1.talkMaxDuration)

			if var_170_15 <= arg_167_1.time_ and arg_167_1.time_ < var_170_15 + var_170_23 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_15) / var_170_23

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_15 + var_170_23 and arg_167_1.time_ < var_170_15 + var_170_23 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play411311041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 411311041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play411311042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10058ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10058ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0.7, -0.98, -6.1)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10058ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["10058ui_story"]
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10058ui_story == nil then
				arg_171_1.var_.characterEffect10058ui_story = var_174_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_11 = 0.200000002980232

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 and not isNil(var_174_9) then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11

				if arg_171_1.var_.characterEffect10058ui_story and not isNil(var_174_9) then
					arg_171_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10058ui_story then
				arg_171_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_174_13 = 0

			if var_174_13 < arg_171_1.time_ and arg_171_1.time_ <= var_174_13 + arg_174_0 then
				arg_171_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_174_14 = arg_171_1.actors_["10066ui_story"]
			local var_174_15 = 0

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 and not isNil(var_174_14) and arg_171_1.var_.characterEffect10066ui_story == nil then
				arg_171_1.var_.characterEffect10066ui_story = var_174_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_16 = 0.200000002980232

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_16 and not isNil(var_174_14) then
				local var_174_17 = (arg_171_1.time_ - var_174_15) / var_174_16

				if arg_171_1.var_.characterEffect10066ui_story and not isNil(var_174_14) then
					local var_174_18 = Mathf.Lerp(0, 0.5, var_174_17)

					arg_171_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10066ui_story.fillRatio = var_174_18
				end
			end

			if arg_171_1.time_ >= var_174_15 + var_174_16 and arg_171_1.time_ < var_174_15 + var_174_16 + arg_174_0 and not isNil(var_174_14) and arg_171_1.var_.characterEffect10066ui_story then
				local var_174_19 = 0.5

				arg_171_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10066ui_story.fillRatio = var_174_19
			end

			local var_174_20 = 0

			if var_174_20 < arg_171_1.time_ and arg_171_1.time_ <= var_174_20 + arg_174_0 then
				arg_171_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_174_21 = arg_171_1.actors_["10066ui_story"].transform
			local var_174_22 = 0

			if var_174_22 < arg_171_1.time_ and arg_171_1.time_ <= var_174_22 + arg_174_0 then
				arg_171_1.var_.moveOldPos10066ui_story = var_174_21.localPosition
			end

			local var_174_23 = 0.001

			if var_174_22 <= arg_171_1.time_ and arg_171_1.time_ < var_174_22 + var_174_23 then
				local var_174_24 = (arg_171_1.time_ - var_174_22) / var_174_23
				local var_174_25 = Vector3.New(-0.7, -0.99, -5.83)

				var_174_21.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10066ui_story, var_174_25, var_174_24)

				local var_174_26 = manager.ui.mainCamera.transform.position - var_174_21.position

				var_174_21.forward = Vector3.New(var_174_26.x, var_174_26.y, var_174_26.z)

				local var_174_27 = var_174_21.localEulerAngles

				var_174_27.z = 0
				var_174_27.x = 0
				var_174_21.localEulerAngles = var_174_27
			end

			if arg_171_1.time_ >= var_174_22 + var_174_23 and arg_171_1.time_ < var_174_22 + var_174_23 + arg_174_0 then
				var_174_21.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_174_28 = manager.ui.mainCamera.transform.position - var_174_21.position

				var_174_21.forward = Vector3.New(var_174_28.x, var_174_28.y, var_174_28.z)

				local var_174_29 = var_174_21.localEulerAngles

				var_174_29.z = 0
				var_174_29.x = 0
				var_174_21.localEulerAngles = var_174_29
			end

			local var_174_30 = 0
			local var_174_31 = 0.4

			if var_174_30 < arg_171_1.time_ and arg_171_1.time_ <= var_174_30 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_32 = arg_171_1:FormatText(StoryNameCfg[471].name)

				arg_171_1.leftNameTxt_.text = var_174_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_33 = arg_171_1:GetWordFromCfg(411311041)
				local var_174_34 = arg_171_1:FormatText(var_174_33.content)

				arg_171_1.text_.text = var_174_34

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_35 = 16
				local var_174_36 = utf8.len(var_174_34)
				local var_174_37 = var_174_35 <= 0 and var_174_31 or var_174_31 * (var_174_36 / var_174_35)

				if var_174_37 > 0 and var_174_31 < var_174_37 then
					arg_171_1.talkMaxDuration = var_174_37

					if var_174_37 + var_174_30 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_37 + var_174_30
					end
				end

				arg_171_1.text_.text = var_174_34
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_38 = math.max(var_174_31, arg_171_1.talkMaxDuration)

			if var_174_30 <= arg_171_1.time_ and arg_171_1.time_ < var_174_30 + var_174_38 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_30) / var_174_38

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_30 + var_174_38 and arg_171_1.time_ < var_174_30 + var_174_38 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play411311042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 411311042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play411311043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10066ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos10066ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10066ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["10066ui_story"]
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect10066ui_story == nil then
				arg_175_1.var_.characterEffect10066ui_story = var_178_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_11 = 0.200000002980232

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 and not isNil(var_178_9) then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11

				if arg_175_1.var_.characterEffect10066ui_story and not isNil(var_178_9) then
					arg_175_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect10066ui_story then
				arg_175_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_178_13 = 0

			if var_178_13 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			local var_178_14 = 0

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 then
				arg_175_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_178_15 = arg_175_1.actors_["10058ui_story"]
			local var_178_16 = 0

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 and not isNil(var_178_15) and arg_175_1.var_.characterEffect10058ui_story == nil then
				arg_175_1.var_.characterEffect10058ui_story = var_178_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_17 = 0.200000002980232

			if var_178_16 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_17 and not isNil(var_178_15) then
				local var_178_18 = (arg_175_1.time_ - var_178_16) / var_178_17

				if arg_175_1.var_.characterEffect10058ui_story and not isNil(var_178_15) then
					local var_178_19 = Mathf.Lerp(0, 0.5, var_178_18)

					arg_175_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10058ui_story.fillRatio = var_178_19
				end
			end

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 and not isNil(var_178_15) and arg_175_1.var_.characterEffect10058ui_story then
				local var_178_20 = 0.5

				arg_175_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10058ui_story.fillRatio = var_178_20
			end

			local var_178_21 = 0
			local var_178_22 = 0.5

			if var_178_21 < arg_175_1.time_ and arg_175_1.time_ <= var_178_21 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_23 = arg_175_1:FormatText(StoryNameCfg[640].name)

				arg_175_1.leftNameTxt_.text = var_178_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_24 = arg_175_1:GetWordFromCfg(411311042)
				local var_178_25 = arg_175_1:FormatText(var_178_24.content)

				arg_175_1.text_.text = var_178_25

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_26 = 20
				local var_178_27 = utf8.len(var_178_25)
				local var_178_28 = var_178_26 <= 0 and var_178_22 or var_178_22 * (var_178_27 / var_178_26)

				if var_178_28 > 0 and var_178_22 < var_178_28 then
					arg_175_1.talkMaxDuration = var_178_28

					if var_178_28 + var_178_21 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_28 + var_178_21
					end
				end

				arg_175_1.text_.text = var_178_25
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_29 = math.max(var_178_22, arg_175_1.talkMaxDuration)

			if var_178_21 <= arg_175_1.time_ and arg_175_1.time_ < var_178_21 + var_178_29 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_21) / var_178_29

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_21 + var_178_29 and arg_175_1.time_ < var_178_21 + var_178_29 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play411311043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 411311043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play411311044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10066ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect10066ui_story == nil then
				arg_179_1.var_.characterEffect10066ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect10066ui_story and not isNil(var_182_0) then
					local var_182_4 = Mathf.Lerp(0, 0.5, var_182_3)

					arg_179_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10066ui_story.fillRatio = var_182_4
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect10066ui_story then
				local var_182_5 = 0.5

				arg_179_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10066ui_story.fillRatio = var_182_5
			end

			local var_182_6 = 0
			local var_182_7 = 0.55

			if var_182_6 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_8 = arg_179_1:GetWordFromCfg(411311043)
				local var_182_9 = arg_179_1:FormatText(var_182_8.content)

				arg_179_1.text_.text = var_182_9

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_10 = 22
				local var_182_11 = utf8.len(var_182_9)
				local var_182_12 = var_182_10 <= 0 and var_182_7 or var_182_7 * (var_182_11 / var_182_10)

				if var_182_12 > 0 and var_182_7 < var_182_12 then
					arg_179_1.talkMaxDuration = var_182_12

					if var_182_12 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_12 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_9
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_13 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_13 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_13

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_13 and arg_179_1.time_ < var_182_6 + var_182_13 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play411311044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 411311044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play411311045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10066ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos10066ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10066ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["10066ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect10066ui_story == nil then
				arg_183_1.var_.characterEffect10066ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 and not isNil(var_186_9) then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect10066ui_story and not isNil(var_186_9) then
					arg_183_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect10066ui_story then
				arg_183_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_186_13 = 0

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				arg_183_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			local var_186_14 = 0

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_186_15 = 0
			local var_186_16 = 0.275

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[640].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:GetWordFromCfg(411311044)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 11
				local var_186_21 = utf8.len(var_186_19)
				local var_186_22 = var_186_20 <= 0 and var_186_16 or var_186_16 * (var_186_21 / var_186_20)

				if var_186_22 > 0 and var_186_16 < var_186_22 then
					arg_183_1.talkMaxDuration = var_186_22

					if var_186_22 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_19
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_23 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_23 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_23

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_23 and arg_183_1.time_ < var_186_15 + var_186_23 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play411311045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 411311045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play411311046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10066ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos10066ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(0, 100, 0)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10066ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(0, 100, 0)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = arg_187_1.actors_["10066ui_story"]
			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect10066ui_story == nil then
				arg_187_1.var_.characterEffect10066ui_story = var_190_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_11 = 0.200000002980232

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_11 and not isNil(var_190_9) then
				local var_190_12 = (arg_187_1.time_ - var_190_10) / var_190_11

				if arg_187_1.var_.characterEffect10066ui_story and not isNil(var_190_9) then
					local var_190_13 = Mathf.Lerp(0, 0.5, var_190_12)

					arg_187_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10066ui_story.fillRatio = var_190_13
				end
			end

			if arg_187_1.time_ >= var_190_10 + var_190_11 and arg_187_1.time_ < var_190_10 + var_190_11 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect10066ui_story then
				local var_190_14 = 0.5

				arg_187_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10066ui_story.fillRatio = var_190_14
			end

			local var_190_15 = arg_187_1.actors_["10058ui_story"].transform
			local var_190_16 = 0

			if var_190_16 < arg_187_1.time_ and arg_187_1.time_ <= var_190_16 + arg_190_0 then
				arg_187_1.var_.moveOldPos10058ui_story = var_190_15.localPosition
			end

			local var_190_17 = 0.001

			if var_190_16 <= arg_187_1.time_ and arg_187_1.time_ < var_190_16 + var_190_17 then
				local var_190_18 = (arg_187_1.time_ - var_190_16) / var_190_17
				local var_190_19 = Vector3.New(0, 100, 0)

				var_190_15.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10058ui_story, var_190_19, var_190_18)

				local var_190_20 = manager.ui.mainCamera.transform.position - var_190_15.position

				var_190_15.forward = Vector3.New(var_190_20.x, var_190_20.y, var_190_20.z)

				local var_190_21 = var_190_15.localEulerAngles

				var_190_21.z = 0
				var_190_21.x = 0
				var_190_15.localEulerAngles = var_190_21
			end

			if arg_187_1.time_ >= var_190_16 + var_190_17 and arg_187_1.time_ < var_190_16 + var_190_17 + arg_190_0 then
				var_190_15.localPosition = Vector3.New(0, 100, 0)

				local var_190_22 = manager.ui.mainCamera.transform.position - var_190_15.position

				var_190_15.forward = Vector3.New(var_190_22.x, var_190_22.y, var_190_22.z)

				local var_190_23 = var_190_15.localEulerAngles

				var_190_23.z = 0
				var_190_23.x = 0
				var_190_15.localEulerAngles = var_190_23
			end

			local var_190_24 = arg_187_1.actors_["10058ui_story"]
			local var_190_25 = 0

			if var_190_25 < arg_187_1.time_ and arg_187_1.time_ <= var_190_25 + arg_190_0 and not isNil(var_190_24) and arg_187_1.var_.characterEffect10058ui_story == nil then
				arg_187_1.var_.characterEffect10058ui_story = var_190_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_26 = 0.200000002980232

			if var_190_25 <= arg_187_1.time_ and arg_187_1.time_ < var_190_25 + var_190_26 and not isNil(var_190_24) then
				local var_190_27 = (arg_187_1.time_ - var_190_25) / var_190_26

				if arg_187_1.var_.characterEffect10058ui_story and not isNil(var_190_24) then
					local var_190_28 = Mathf.Lerp(0, 0.5, var_190_27)

					arg_187_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10058ui_story.fillRatio = var_190_28
				end
			end

			if arg_187_1.time_ >= var_190_25 + var_190_26 and arg_187_1.time_ < var_190_25 + var_190_26 + arg_190_0 and not isNil(var_190_24) and arg_187_1.var_.characterEffect10058ui_story then
				local var_190_29 = 0.5

				arg_187_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10058ui_story.fillRatio = var_190_29
			end

			local var_190_30 = 0
			local var_190_31 = 1.55

			if var_190_30 < arg_187_1.time_ and arg_187_1.time_ <= var_190_30 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_32 = arg_187_1:GetWordFromCfg(411311045)
				local var_190_33 = arg_187_1:FormatText(var_190_32.content)

				arg_187_1.text_.text = var_190_33

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_34 = 62
				local var_190_35 = utf8.len(var_190_33)
				local var_190_36 = var_190_34 <= 0 and var_190_31 or var_190_31 * (var_190_35 / var_190_34)

				if var_190_36 > 0 and var_190_31 < var_190_36 then
					arg_187_1.talkMaxDuration = var_190_36

					if var_190_36 + var_190_30 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_36 + var_190_30
					end
				end

				arg_187_1.text_.text = var_190_33
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_37 = math.max(var_190_31, arg_187_1.talkMaxDuration)

			if var_190_30 <= arg_187_1.time_ and arg_187_1.time_ < var_190_30 + var_190_37 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_30) / var_190_37

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_30 + var_190_37 and arg_187_1.time_ < var_190_30 + var_190_37 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play411311046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 411311046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play411311047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 1.275

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:GetWordFromCfg(411311046)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 51
				local var_194_5 = utf8.len(var_194_3)
				local var_194_6 = var_194_4 <= 0 and var_194_1 or var_194_1 * (var_194_5 / var_194_4)

				if var_194_6 > 0 and var_194_1 < var_194_6 then
					arg_191_1.talkMaxDuration = var_194_6

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_7 and arg_191_1.time_ < var_194_0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play411311047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 411311047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play411311048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10058ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos10058ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0, -0.98, -6.1)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10058ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = arg_195_1.actors_["10058ui_story"]
			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect10058ui_story == nil then
				arg_195_1.var_.characterEffect10058ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_11 and not isNil(var_198_9) then
				local var_198_12 = (arg_195_1.time_ - var_198_10) / var_198_11

				if arg_195_1.var_.characterEffect10058ui_story and not isNil(var_198_9) then
					arg_195_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_10 + var_198_11 and arg_195_1.time_ < var_198_10 + var_198_11 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect10058ui_story then
				arg_195_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_198_13 = 0

			if var_198_13 < arg_195_1.time_ and arg_195_1.time_ <= var_198_13 + arg_198_0 then
				arg_195_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_198_14 = 0

			if var_198_14 < arg_195_1.time_ and arg_195_1.time_ <= var_198_14 + arg_198_0 then
				arg_195_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_198_15 = 0
			local var_198_16 = 0.225

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_17 = arg_195_1:FormatText(StoryNameCfg[471].name)

				arg_195_1.leftNameTxt_.text = var_198_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_18 = arg_195_1:GetWordFromCfg(411311047)
				local var_198_19 = arg_195_1:FormatText(var_198_18.content)

				arg_195_1.text_.text = var_198_19

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_20 = 9
				local var_198_21 = utf8.len(var_198_19)
				local var_198_22 = var_198_20 <= 0 and var_198_16 or var_198_16 * (var_198_21 / var_198_20)

				if var_198_22 > 0 and var_198_16 < var_198_22 then
					arg_195_1.talkMaxDuration = var_198_22

					if var_198_22 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_22 + var_198_15
					end
				end

				arg_195_1.text_.text = var_198_19
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_23 = math.max(var_198_16, arg_195_1.talkMaxDuration)

			if var_198_15 <= arg_195_1.time_ and arg_195_1.time_ < var_198_15 + var_198_23 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_15) / var_198_23

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_15 + var_198_23 and arg_195_1.time_ < var_198_15 + var_198_23 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411311048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 411311048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play411311049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10066ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos10066ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10066ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["10066ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect10066ui_story == nil then
				arg_199_1.var_.characterEffect10066ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.200000002980232

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect10066ui_story and not isNil(var_202_9) then
					arg_199_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect10066ui_story then
				arg_199_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action443")
			end

			local var_202_14 = 0

			if var_202_14 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 then
				arg_199_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_202_15 = arg_199_1.actors_["10058ui_story"]
			local var_202_16 = 0

			if var_202_16 < arg_199_1.time_ and arg_199_1.time_ <= var_202_16 + arg_202_0 and not isNil(var_202_15) and arg_199_1.var_.characterEffect10058ui_story == nil then
				arg_199_1.var_.characterEffect10058ui_story = var_202_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_17 = 0.200000002980232

			if var_202_16 <= arg_199_1.time_ and arg_199_1.time_ < var_202_16 + var_202_17 and not isNil(var_202_15) then
				local var_202_18 = (arg_199_1.time_ - var_202_16) / var_202_17

				if arg_199_1.var_.characterEffect10058ui_story and not isNil(var_202_15) then
					local var_202_19 = Mathf.Lerp(0, 0.5, var_202_18)

					arg_199_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_199_1.var_.characterEffect10058ui_story.fillRatio = var_202_19
				end
			end

			if arg_199_1.time_ >= var_202_16 + var_202_17 and arg_199_1.time_ < var_202_16 + var_202_17 + arg_202_0 and not isNil(var_202_15) and arg_199_1.var_.characterEffect10058ui_story then
				local var_202_20 = 0.5

				arg_199_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_199_1.var_.characterEffect10058ui_story.fillRatio = var_202_20
			end

			local var_202_21 = arg_199_1.actors_["10058ui_story"].transform
			local var_202_22 = 0

			if var_202_22 < arg_199_1.time_ and arg_199_1.time_ <= var_202_22 + arg_202_0 then
				arg_199_1.var_.moveOldPos10058ui_story = var_202_21.localPosition
			end

			local var_202_23 = 0.001

			if var_202_22 <= arg_199_1.time_ and arg_199_1.time_ < var_202_22 + var_202_23 then
				local var_202_24 = (arg_199_1.time_ - var_202_22) / var_202_23
				local var_202_25 = Vector3.New(0.7, -0.98, -6.1)

				var_202_21.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10058ui_story, var_202_25, var_202_24)

				local var_202_26 = manager.ui.mainCamera.transform.position - var_202_21.position

				var_202_21.forward = Vector3.New(var_202_26.x, var_202_26.y, var_202_26.z)

				local var_202_27 = var_202_21.localEulerAngles

				var_202_27.z = 0
				var_202_27.x = 0
				var_202_21.localEulerAngles = var_202_27
			end

			if arg_199_1.time_ >= var_202_22 + var_202_23 and arg_199_1.time_ < var_202_22 + var_202_23 + arg_202_0 then
				var_202_21.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_202_28 = manager.ui.mainCamera.transform.position - var_202_21.position

				var_202_21.forward = Vector3.New(var_202_28.x, var_202_28.y, var_202_28.z)

				local var_202_29 = var_202_21.localEulerAngles

				var_202_29.z = 0
				var_202_29.x = 0
				var_202_21.localEulerAngles = var_202_29
			end

			local var_202_30 = 0
			local var_202_31 = 0.125

			if var_202_30 < arg_199_1.time_ and arg_199_1.time_ <= var_202_30 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_32 = arg_199_1:FormatText(StoryNameCfg[640].name)

				arg_199_1.leftNameTxt_.text = var_202_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_33 = arg_199_1:GetWordFromCfg(411311048)
				local var_202_34 = arg_199_1:FormatText(var_202_33.content)

				arg_199_1.text_.text = var_202_34

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_35 = 5
				local var_202_36 = utf8.len(var_202_34)
				local var_202_37 = var_202_35 <= 0 and var_202_31 or var_202_31 * (var_202_36 / var_202_35)

				if var_202_37 > 0 and var_202_31 < var_202_37 then
					arg_199_1.talkMaxDuration = var_202_37

					if var_202_37 + var_202_30 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_37 + var_202_30
					end
				end

				arg_199_1.text_.text = var_202_34
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_38 = math.max(var_202_31, arg_199_1.talkMaxDuration)

			if var_202_30 <= arg_199_1.time_ and arg_199_1.time_ < var_202_30 + var_202_38 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_30) / var_202_38

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_30 + var_202_38 and arg_199_1.time_ < var_202_30 + var_202_38 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play411311049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 411311049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play411311050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10058ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos10058ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(0.7, -0.98, -6.1)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10058ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["10058ui_story"]
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect10058ui_story == nil then
				arg_203_1.var_.characterEffect10058ui_story = var_206_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 and not isNil(var_206_9) then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11

				if arg_203_1.var_.characterEffect10058ui_story and not isNil(var_206_9) then
					arg_203_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect10058ui_story then
				arg_203_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_206_13 = 0

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_206_14 = arg_203_1.actors_["10066ui_story"]
			local var_206_15 = 0

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 and not isNil(var_206_14) and arg_203_1.var_.characterEffect10066ui_story == nil then
				arg_203_1.var_.characterEffect10066ui_story = var_206_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_16 = 0.200000002980232

			if var_206_15 <= arg_203_1.time_ and arg_203_1.time_ < var_206_15 + var_206_16 and not isNil(var_206_14) then
				local var_206_17 = (arg_203_1.time_ - var_206_15) / var_206_16

				if arg_203_1.var_.characterEffect10066ui_story and not isNil(var_206_14) then
					local var_206_18 = Mathf.Lerp(0, 0.5, var_206_17)

					arg_203_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10066ui_story.fillRatio = var_206_18
				end
			end

			if arg_203_1.time_ >= var_206_15 + var_206_16 and arg_203_1.time_ < var_206_15 + var_206_16 + arg_206_0 and not isNil(var_206_14) and arg_203_1.var_.characterEffect10066ui_story then
				local var_206_19 = 0.5

				arg_203_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10066ui_story.fillRatio = var_206_19
			end

			local var_206_20 = 0
			local var_206_21 = 0.175

			if var_206_20 < arg_203_1.time_ and arg_203_1.time_ <= var_206_20 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_22 = arg_203_1:FormatText(StoryNameCfg[471].name)

				arg_203_1.leftNameTxt_.text = var_206_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_23 = arg_203_1:GetWordFromCfg(411311049)
				local var_206_24 = arg_203_1:FormatText(var_206_23.content)

				arg_203_1.text_.text = var_206_24

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_25 = 7
				local var_206_26 = utf8.len(var_206_24)
				local var_206_27 = var_206_25 <= 0 and var_206_21 or var_206_21 * (var_206_26 / var_206_25)

				if var_206_27 > 0 and var_206_21 < var_206_27 then
					arg_203_1.talkMaxDuration = var_206_27

					if var_206_27 + var_206_20 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_27 + var_206_20
					end
				end

				arg_203_1.text_.text = var_206_24
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_28 = math.max(var_206_21, arg_203_1.talkMaxDuration)

			if var_206_20 <= arg_203_1.time_ and arg_203_1.time_ < var_206_20 + var_206_28 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_20) / var_206_28

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_20 + var_206_28 and arg_203_1.time_ < var_206_20 + var_206_28 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411311050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 411311050
		arg_207_1.duration_ = 7

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
			arg_207_1.auto_ = false
		end

		function arg_207_1.playNext_(arg_209_0)
			arg_207_1.onStoryFinished_()
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10066ui_story"].transform
			local var_210_1 = 2.02499999701977

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos10066ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0, 100, 0)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10066ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, 100, 0)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["10066ui_story"]
			local var_210_10 = 2.02499999701977

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect10066ui_story == nil then
				arg_207_1.var_.characterEffect10066ui_story = var_210_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_11 = 0.200000002980232

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 and not isNil(var_210_9) then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11

				if arg_207_1.var_.characterEffect10066ui_story and not isNil(var_210_9) then
					local var_210_13 = Mathf.Lerp(0, 0.5, var_210_12)

					arg_207_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10066ui_story.fillRatio = var_210_13
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect10066ui_story then
				local var_210_14 = 0.5

				arg_207_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10066ui_story.fillRatio = var_210_14
			end

			local var_210_15 = arg_207_1.actors_["10058ui_story"].transform
			local var_210_16 = 2.02499999701977

			if var_210_16 < arg_207_1.time_ and arg_207_1.time_ <= var_210_16 + arg_210_0 then
				arg_207_1.var_.moveOldPos10058ui_story = var_210_15.localPosition
			end

			local var_210_17 = 0.001

			if var_210_16 <= arg_207_1.time_ and arg_207_1.time_ < var_210_16 + var_210_17 then
				local var_210_18 = (arg_207_1.time_ - var_210_16) / var_210_17
				local var_210_19 = Vector3.New(0, 100, 0)

				var_210_15.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10058ui_story, var_210_19, var_210_18)

				local var_210_20 = manager.ui.mainCamera.transform.position - var_210_15.position

				var_210_15.forward = Vector3.New(var_210_20.x, var_210_20.y, var_210_20.z)

				local var_210_21 = var_210_15.localEulerAngles

				var_210_21.z = 0
				var_210_21.x = 0
				var_210_15.localEulerAngles = var_210_21
			end

			if arg_207_1.time_ >= var_210_16 + var_210_17 and arg_207_1.time_ < var_210_16 + var_210_17 + arg_210_0 then
				var_210_15.localPosition = Vector3.New(0, 100, 0)

				local var_210_22 = manager.ui.mainCamera.transform.position - var_210_15.position

				var_210_15.forward = Vector3.New(var_210_22.x, var_210_22.y, var_210_22.z)

				local var_210_23 = var_210_15.localEulerAngles

				var_210_23.z = 0
				var_210_23.x = 0
				var_210_15.localEulerAngles = var_210_23
			end

			local var_210_24 = arg_207_1.actors_["10058ui_story"]
			local var_210_25 = 2.02499999701977

			if var_210_25 < arg_207_1.time_ and arg_207_1.time_ <= var_210_25 + arg_210_0 and not isNil(var_210_24) and arg_207_1.var_.characterEffect10058ui_story == nil then
				arg_207_1.var_.characterEffect10058ui_story = var_210_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_26 = 0.200000002980232

			if var_210_25 <= arg_207_1.time_ and arg_207_1.time_ < var_210_25 + var_210_26 and not isNil(var_210_24) then
				local var_210_27 = (arg_207_1.time_ - var_210_25) / var_210_26

				if arg_207_1.var_.characterEffect10058ui_story and not isNil(var_210_24) then
					local var_210_28 = Mathf.Lerp(0, 0.5, var_210_27)

					arg_207_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10058ui_story.fillRatio = var_210_28
				end
			end

			if arg_207_1.time_ >= var_210_25 + var_210_26 and arg_207_1.time_ < var_210_25 + var_210_26 + arg_210_0 and not isNil(var_210_24) and arg_207_1.var_.characterEffect10058ui_story then
				local var_210_29 = 0.5

				arg_207_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10058ui_story.fillRatio = var_210_29
			end

			local var_210_30 = 0

			if var_210_30 < arg_207_1.time_ and arg_207_1.time_ <= var_210_30 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_31 = 2

			if var_210_30 <= arg_207_1.time_ and arg_207_1.time_ < var_210_30 + var_210_31 then
				local var_210_32 = (arg_207_1.time_ - var_210_30) / var_210_31
				local var_210_33 = Color.New(1, 1, 1)

				var_210_33.a = Mathf.Lerp(0, 1, var_210_32)
				arg_207_1.mask_.color = var_210_33
			end

			if arg_207_1.time_ >= var_210_30 + var_210_31 and arg_207_1.time_ < var_210_30 + var_210_31 + arg_210_0 then
				local var_210_34 = Color.New(1, 1, 1)

				var_210_34.a = 1
				arg_207_1.mask_.color = var_210_34
			end

			local var_210_35 = 2

			if var_210_35 < arg_207_1.time_ and arg_207_1.time_ <= var_210_35 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_36 = 2

			if var_210_35 <= arg_207_1.time_ and arg_207_1.time_ < var_210_35 + var_210_36 then
				local var_210_37 = (arg_207_1.time_ - var_210_35) / var_210_36
				local var_210_38 = Color.New(1, 1, 1)

				var_210_38.a = Mathf.Lerp(1, 0, var_210_37)
				arg_207_1.mask_.color = var_210_38
			end

			if arg_207_1.time_ >= var_210_35 + var_210_36 and arg_207_1.time_ < var_210_35 + var_210_36 + arg_210_0 then
				local var_210_39 = Color.New(1, 1, 1)
				local var_210_40 = 0

				arg_207_1.mask_.enabled = false
				var_210_39.a = var_210_40
				arg_207_1.mask_.color = var_210_39
			end

			local var_210_41 = 2
			local var_210_42 = 0.225

			if var_210_41 < arg_207_1.time_ and arg_207_1.time_ <= var_210_41 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_43 = arg_207_1:GetWordFromCfg(411311050)
				local var_210_44 = arg_207_1:FormatText(var_210_43.content)

				arg_207_1.text_.text = var_210_44

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_45 = 9
				local var_210_46 = utf8.len(var_210_44)
				local var_210_47 = var_210_45 <= 0 and var_210_42 or var_210_42 * (var_210_46 / var_210_45)

				if var_210_47 > 0 and var_210_42 < var_210_47 then
					arg_207_1.talkMaxDuration = var_210_47

					if var_210_47 + var_210_41 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_47 + var_210_41
					end
				end

				arg_207_1.text_.text = var_210_44
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_48 = math.max(var_210_42, arg_207_1.talkMaxDuration)

			if var_210_41 <= arg_207_1.time_ and arg_207_1.time_ < var_210_41 + var_210_48 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_41) / var_210_48

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_41 + var_210_48 and arg_207_1.time_ < var_210_41 + var_210_48 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.02499999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.02499999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/ST74"
	},
	voices = {}
}
