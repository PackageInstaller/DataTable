return {
	Play1104906001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104906001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104906002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST06"

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
				local var_4_5 = arg_1_1.bgs_.ST06

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
					if iter_4_0 ~= "ST06" then
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

			local var_4_24 = 0
			local var_4_25 = 0.2

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.4
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quietre.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 0.125
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 2
			local var_4_41 = 0.675

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_43 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_44 = arg_1_1:GetWordFromCfg(1104906001)
				local var_4_45 = arg_1_1:FormatText(var_4_44.content)

				arg_1_1.text_.text = var_4_45

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_46 = 27
				local var_4_47 = utf8.len(var_4_45)
				local var_4_48 = var_4_46 <= 0 and var_4_41 or var_4_41 * (var_4_47 / var_4_46)

				if var_4_48 > 0 and var_4_41 < var_4_48 then
					arg_1_1.talkMaxDuration = var_4_48
					var_4_40 = var_4_40 + 0.3

					if var_4_48 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_48 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_45
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_49 = var_4_40 + 0.3
			local var_4_50 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_50 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_49) / var_4_50

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_49 + var_4_50 and arg_1_1.time_ < var_4_49 + var_4_50 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1104906002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1104906002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1104906003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(1104906002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 40
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
	Play1104906003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1104906003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1104906004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.7

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

				local var_16_2 = arg_13_1:GetWordFromCfg(1104906003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 28
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
	Play1104906004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1104906004
		arg_17_1.duration_ = 2.23

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1104906005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1049ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1049ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_17_1.stage_.transform)

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

			local var_20_5 = arg_17_1.actors_["1049ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1049ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0, -1.2, -6)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1049ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -1.2, -6)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["1049ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1049ui_story == nil then
				arg_17_1.var_.characterEffect1049ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect1049ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1049ui_story then
				arg_17_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_20_20 = 0
			local var_20_21 = 0.225

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_22 = arg_17_1:FormatText(StoryNameCfg[551].name)

				arg_17_1.leftNameTxt_.text = var_20_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_23 = arg_17_1:GetWordFromCfg(1104906004)
				local var_20_24 = arg_17_1:FormatText(var_20_23.content)

				arg_17_1.text_.text = var_20_24

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_25 = 9
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906004", "story_v_side_new_1104906.awb") ~= 0 then
					local var_20_28 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906004", "story_v_side_new_1104906.awb") / 1000

					if var_20_28 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_20
					end

					if var_20_23.prefab_name ~= "" and arg_17_1.actors_[var_20_23.prefab_name] ~= nil then
						local var_20_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_23.prefab_name].transform, "story_v_side_new_1104906", "1104906004", "story_v_side_new_1104906.awb")

						arg_17_1:RecordAudio("1104906004", var_20_29)
						arg_17_1:RecordAudio("1104906004", var_20_29)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906004", "story_v_side_new_1104906.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906004", "story_v_side_new_1104906.awb")
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
				actorName = "1049ui_story",
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
	Play1104906005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1104906005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1104906006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1049ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1049ui_story == nil then
				arg_21_1.var_.characterEffect1049ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1049ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1049ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1049ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1049ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.4

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_9 = arg_21_1:GetWordFromCfg(1104906005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 16
				local var_24_12 = utf8.len(var_24_10)
				local var_24_13 = var_24_11 <= 0 and var_24_7 or var_24_7 * (var_24_12 / var_24_11)

				if var_24_13 > 0 and var_24_7 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1104906006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1104906006
		arg_25_1.duration_ = 2.37

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1104906007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1049ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1049ui_story == nil then
				arg_25_1.var_.characterEffect1049ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1049ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1049ui_story then
				arg_25_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_28_6 = 0
			local var_28_7 = 0.275

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[551].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:GetWordFromCfg(1104906006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 11
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_7 or var_28_7 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_7 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906006", "story_v_side_new_1104906.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906006", "story_v_side_new_1104906.awb") / 1000

					if var_28_14 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_6
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_side_new_1104906", "1104906006", "story_v_side_new_1104906.awb")

						arg_25_1:RecordAudio("1104906006", var_28_15)
						arg_25_1:RecordAudio("1104906006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906006", "story_v_side_new_1104906.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906006", "story_v_side_new_1104906.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_16 and arg_25_1.time_ < var_28_6 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1104906007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1104906007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1104906008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1049ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1049ui_story == nil then
				arg_29_1.var_.characterEffect1049ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1049ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1049ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1049ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1049ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0
			local var_32_7 = 0.4

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_9 = arg_29_1:GetWordFromCfg(1104906007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 16
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_7 or var_32_7 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_7 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_14 and arg_29_1.time_ < var_32_6 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1104906008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1104906008
		arg_33_1.duration_ = 2.9

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1104906009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1049ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1049ui_story == nil then
				arg_33_1.var_.characterEffect1049ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1049ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1049ui_story then
				arg_33_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story104901/story1049actionlink/1049action426")
			end

			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_36_6 = 0
			local var_36_7 = 0.2

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[551].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_9 = arg_33_1:GetWordFromCfg(1104906008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 8
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906008", "story_v_side_new_1104906.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906008", "story_v_side_new_1104906.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_side_new_1104906", "1104906008", "story_v_side_new_1104906.awb")

						arg_33_1:RecordAudio("1104906008", var_36_15)
						arg_33_1:RecordAudio("1104906008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906008", "story_v_side_new_1104906.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906008", "story_v_side_new_1104906.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_16 and arg_33_1.time_ < var_36_6 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1104906009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1104906009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1104906010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1049ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1049ui_story == nil then
				arg_37_1.var_.characterEffect1049ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1049ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1049ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1049ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1049ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 0.15

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_9 = arg_37_1:GetWordFromCfg(1104906009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 6
				local var_40_12 = utf8.len(var_40_10)
				local var_40_13 = var_40_11 <= 0 and var_40_7 or var_40_7 * (var_40_12 / var_40_11)

				if var_40_13 > 0 and var_40_7 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1104906010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1104906010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1104906011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.05

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(1104906010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 42
				local var_44_5 = utf8.len(var_44_3)
				local var_44_6 = var_44_4 <= 0 and var_44_1 or var_44_1 * (var_44_5 / var_44_4)

				if var_44_6 > 0 and var_44_1 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_7 and arg_41_1.time_ < var_44_0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1104906011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1104906011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1104906012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.125

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(1104906011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 45
				local var_48_5 = utf8.len(var_48_3)
				local var_48_6 = var_48_4 <= 0 and var_48_1 or var_48_1 * (var_48_5 / var_48_4)

				if var_48_6 > 0 and var_48_1 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_7 and arg_45_1.time_ < var_48_0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1104906012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1104906012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1104906013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.25

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[7].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(1104906012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 10
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_8 and arg_49_1.time_ < var_52_0 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1104906013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1104906013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1104906014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.7

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(1104906013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 28
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_8 and arg_53_1.time_ < var_56_0 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1104906014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1104906014
		arg_57_1.duration_ = 10.5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1104906015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1049ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1049ui_story == nil then
				arg_57_1.var_.characterEffect1049ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1049ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1049ui_story then
				arg_57_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_60_4 = 0

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049actionlink/1049action464")
			end

			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_60_6 = 0
			local var_60_7 = 1

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[551].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_9 = arg_57_1:GetWordFromCfg(1104906014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 40
				local var_60_12 = utf8.len(var_60_10)
				local var_60_13 = var_60_11 <= 0 and var_60_7 or var_60_7 * (var_60_12 / var_60_11)

				if var_60_13 > 0 and var_60_7 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_10
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906014", "story_v_side_new_1104906.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906014", "story_v_side_new_1104906.awb") / 1000

					if var_60_14 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_6
					end

					if var_60_9.prefab_name ~= "" and arg_57_1.actors_[var_60_9.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_9.prefab_name].transform, "story_v_side_new_1104906", "1104906014", "story_v_side_new_1104906.awb")

						arg_57_1:RecordAudio("1104906014", var_60_15)
						arg_57_1:RecordAudio("1104906014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906014", "story_v_side_new_1104906.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906014", "story_v_side_new_1104906.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_16 and arg_57_1.time_ < var_60_6 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1104906015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1104906015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1104906016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1049ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1049ui_story == nil then
				arg_61_1.var_.characterEffect1049ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1049ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1049ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1049ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1049ui_story.fillRatio = var_64_5
			end

			local var_64_6 = 0
			local var_64_7 = 0.275

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[7].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_9 = arg_61_1:GetWordFromCfg(1104906015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 11
				local var_64_12 = utf8.len(var_64_10)
				local var_64_13 = var_64_11 <= 0 and var_64_7 or var_64_7 * (var_64_12 / var_64_11)

				if var_64_13 > 0 and var_64_7 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_14 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_14 and arg_61_1.time_ < var_64_6 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1104906016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1104906016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1104906017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 1.35

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(1104906016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 54
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1104906017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1104906017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1104906018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.075

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[7].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(1104906017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 43
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1104906018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1104906018
		arg_73_1.duration_ = 2

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1104906019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1049ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1049ui_story == nil then
				arg_73_1.var_.characterEffect1049ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1049ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1049ui_story then
				arg_73_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_76_4 = 0

			if var_76_4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action4_2")
			end

			local var_76_5 = 0

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_76_6 = 0
			local var_76_7 = 0.125

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[551].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_9 = arg_73_1:GetWordFromCfg(1104906018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 5
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_7 or var_76_7 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_7 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906018", "story_v_side_new_1104906.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906018", "story_v_side_new_1104906.awb") / 1000

					if var_76_14 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_6
					end

					if var_76_9.prefab_name ~= "" and arg_73_1.actors_[var_76_9.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_9.prefab_name].transform, "story_v_side_new_1104906", "1104906018", "story_v_side_new_1104906.awb")

						arg_73_1:RecordAudio("1104906018", var_76_15)
						arg_73_1:RecordAudio("1104906018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906018", "story_v_side_new_1104906.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906018", "story_v_side_new_1104906.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_16 and arg_73_1.time_ < var_76_6 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1104906019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1104906019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1104906020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1049ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1049ui_story == nil then
				arg_77_1.var_.characterEffect1049ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1049ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1049ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1049ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1049ui_story.fillRatio = var_80_5
			end

			local var_80_6 = 0
			local var_80_7 = 0.225

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_8 = arg_77_1:FormatText(StoryNameCfg[7].name)

				arg_77_1.leftNameTxt_.text = var_80_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_9 = arg_77_1:GetWordFromCfg(1104906019)
				local var_80_10 = arg_77_1:FormatText(var_80_9.content)

				arg_77_1.text_.text = var_80_10

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 9
				local var_80_12 = utf8.len(var_80_10)
				local var_80_13 = var_80_11 <= 0 and var_80_7 or var_80_7 * (var_80_12 / var_80_11)

				if var_80_13 > 0 and var_80_7 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_10
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_14 and arg_77_1.time_ < var_80_6 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1104906020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1104906020
		arg_81_1.duration_ = 4.9

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1104906021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1049ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1049ui_story == nil then
				arg_81_1.var_.characterEffect1049ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1049ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1049ui_story then
				arg_81_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_84_4 = 0

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_84_6 = 0
			local var_84_7 = 0.4

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_8 = arg_81_1:FormatText(StoryNameCfg[551].name)

				arg_81_1.leftNameTxt_.text = var_84_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_9 = arg_81_1:GetWordFromCfg(1104906020)
				local var_84_10 = arg_81_1:FormatText(var_84_9.content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 16
				local var_84_12 = utf8.len(var_84_10)
				local var_84_13 = var_84_11 <= 0 and var_84_7 or var_84_7 * (var_84_12 / var_84_11)

				if var_84_13 > 0 and var_84_7 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906020", "story_v_side_new_1104906.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906020", "story_v_side_new_1104906.awb") / 1000

					if var_84_14 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_6
					end

					if var_84_9.prefab_name ~= "" and arg_81_1.actors_[var_84_9.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_9.prefab_name].transform, "story_v_side_new_1104906", "1104906020", "story_v_side_new_1104906.awb")

						arg_81_1:RecordAudio("1104906020", var_84_15)
						arg_81_1:RecordAudio("1104906020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906020", "story_v_side_new_1104906.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906020", "story_v_side_new_1104906.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_16 and arg_81_1.time_ < var_84_6 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1104906021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1104906021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1104906022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1049ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1049ui_story == nil then
				arg_85_1.var_.characterEffect1049ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1049ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1049ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1049ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1049ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.65

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(1104906021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 26
				local var_88_12 = utf8.len(var_88_10)
				local var_88_13 = var_88_11 <= 0 and var_88_7 or var_88_7 * (var_88_12 / var_88_11)

				if var_88_13 > 0 and var_88_7 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_10
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1104906022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1104906022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1104906023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1049ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1049ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, 100, 0)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1049ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, 100, 0)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = 0
			local var_92_10 = 0.725

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_11 = arg_89_1:GetWordFromCfg(1104906022)
				local var_92_12 = arg_89_1:FormatText(var_92_11.content)

				arg_89_1.text_.text = var_92_12

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 29
				local var_92_14 = utf8.len(var_92_12)
				local var_92_15 = var_92_13 <= 0 and var_92_10 or var_92_10 * (var_92_14 / var_92_13)

				if var_92_15 > 0 and var_92_10 < var_92_15 then
					arg_89_1.talkMaxDuration = var_92_15

					if var_92_15 + var_92_9 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_15 + var_92_9
					end
				end

				arg_89_1.text_.text = var_92_12
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_10, arg_89_1.talkMaxDuration)

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_9) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_9 + var_92_16 and arg_89_1.time_ < var_92_9 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play1104906023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1104906023
		arg_93_1.duration_ = 4.83

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1104906024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1049ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1049ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, -1.2, -6)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1049ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1049ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1049ui_story == nil then
				arg_93_1.var_.characterEffect1049ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect1049ui_story and not isNil(var_96_9) then
					arg_93_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1049ui_story then
				arg_93_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_96_13 = 0

			if var_96_13 < arg_93_1.time_ and arg_93_1.time_ <= var_96_13 + arg_96_0 then
				arg_93_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_96_14 = 0

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_15 = 0
			local var_96_16 = 0.5

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[551].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(1104906023)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 20
				local var_96_21 = utf8.len(var_96_19)
				local var_96_22 = var_96_20 <= 0 and var_96_16 or var_96_16 * (var_96_21 / var_96_20)

				if var_96_22 > 0 and var_96_16 < var_96_22 then
					arg_93_1.talkMaxDuration = var_96_22

					if var_96_22 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906023", "story_v_side_new_1104906.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906023", "story_v_side_new_1104906.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_side_new_1104906", "1104906023", "story_v_side_new_1104906.awb")

						arg_93_1:RecordAudio("1104906023", var_96_24)
						arg_93_1:RecordAudio("1104906023", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906023", "story_v_side_new_1104906.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906023", "story_v_side_new_1104906.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_25 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_25 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_25

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_25 and arg_93_1.time_ < var_96_15 + var_96_25 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play1104906024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1104906024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1104906025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1049ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1049ui_story == nil then
				arg_97_1.var_.characterEffect1049ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1049ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1049ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1049ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1049ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 0.15

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_9 = arg_97_1:GetWordFromCfg(1104906024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 6
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_7 or var_100_7 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_7 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1104906025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1104906025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1104906026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1049ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1049ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, 100, 0)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1049ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, 100, 0)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = 0
			local var_104_10 = 1.4

			if var_104_9 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_11 = arg_101_1:GetWordFromCfg(1104906025)
				local var_104_12 = arg_101_1:FormatText(var_104_11.content)

				arg_101_1.text_.text = var_104_12

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 56
				local var_104_14 = utf8.len(var_104_12)
				local var_104_15 = var_104_13 <= 0 and var_104_10 or var_104_10 * (var_104_14 / var_104_13)

				if var_104_15 > 0 and var_104_10 < var_104_15 then
					arg_101_1.talkMaxDuration = var_104_15

					if var_104_15 + var_104_9 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_15 + var_104_9
					end
				end

				arg_101_1.text_.text = var_104_12
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_10, arg_101_1.talkMaxDuration)

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_9) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_9 + var_104_16 and arg_101_1.time_ < var_104_9 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play1104906026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1104906026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1104906027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.333333333333333
			local var_108_1 = 0.2

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				local var_108_2 = "play"
				local var_108_3 = "music"

				arg_105_1:AudioAction(var_108_2, var_108_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_108_4 = ""
				local var_108_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_108_5 ~= "" then
					if arg_105_1.bgmTxt_.text ~= var_108_5 and arg_105_1.bgmTxt_.text ~= "" then
						if arg_105_1.bgmTxt2_.text ~= "" then
							arg_105_1.bgmTxt_.text = arg_105_1.bgmTxt2_.text
						end

						arg_105_1.bgmTxt2_.text = var_108_5

						arg_105_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_105_1.bgmTxt_.text = var_108_5
						arg_105_1.bgmTxt2_.text = var_108_5
					end

					if arg_105_1.bgmTimer then
						arg_105_1.bgmTimer:Stop()

						arg_105_1.bgmTimer = nil
					end

					if arg_105_1.settingData.show_music_name == 1 then
						arg_105_1.musicController:SetSelectedState("show")
						arg_105_1.musicAnimator_:Play("open", 0, 0)

						if arg_105_1.settingData.music_time ~= 0 then
							arg_105_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_105_1.settingData.music_time), function()
								if arg_105_1 == nil or isNil(arg_105_1.bgmTxt_) then
									return
								end

								arg_105_1.musicController:SetSelectedState("hide")
								arg_105_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_108_6 = 0.125
			local var_108_7 = 1

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				local var_108_8 = "play"
				local var_108_9 = "effect"

				arg_105_1:AudioAction(var_108_8, var_108_9, "se_story_side_1080", "se_story_1080_knock", "")
			end

			local var_108_10 = 0
			local var_108_11 = 1.3

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_12 = arg_105_1:GetWordFromCfg(1104906026)
				local var_108_13 = arg_105_1:FormatText(var_108_12.content)

				arg_105_1.text_.text = var_108_13

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_14 = 52
				local var_108_15 = utf8.len(var_108_13)
				local var_108_16 = var_108_14 <= 0 and var_108_11 or var_108_11 * (var_108_15 / var_108_14)

				if var_108_16 > 0 and var_108_11 < var_108_16 then
					arg_105_1.talkMaxDuration = var_108_16

					if var_108_16 + var_108_10 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_16 + var_108_10
					end
				end

				arg_105_1.text_.text = var_108_13
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_17 = math.max(var_108_11, arg_105_1.talkMaxDuration)

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_17 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_10) / var_108_17

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_10 + var_108_17 and arg_105_1.time_ < var_108_10 + var_108_17 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1104906027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1104906027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1104906028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.525

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

				local var_113_2 = arg_110_1:GetWordFromCfg(1104906027)
				local var_113_3 = arg_110_1:FormatText(var_113_2.content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 21
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
	Play1104906028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1104906028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play1104906029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 0.075

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[7].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:GetWordFromCfg(1104906028)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 3
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_8 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_8 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_8

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_8 and arg_114_1.time_ < var_117_0 + var_117_8 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play1104906029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1104906029
		arg_118_1.duration_ = 5.3

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1104906030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1049ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos1049ui_story = var_121_0.localPosition
			end

			local var_121_2 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2
				local var_121_4 = Vector3.New(0, -1.2, -6)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1049ui_story, var_121_4, var_121_3)

				local var_121_5 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_5.x, var_121_5.y, var_121_5.z)

				local var_121_6 = var_121_0.localEulerAngles

				var_121_6.z = 0
				var_121_6.x = 0
				var_121_0.localEulerAngles = var_121_6
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_121_7 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_7.x, var_121_7.y, var_121_7.z)

				local var_121_8 = var_121_0.localEulerAngles

				var_121_8.z = 0
				var_121_8.x = 0
				var_121_0.localEulerAngles = var_121_8
			end

			local var_121_9 = arg_118_1.actors_["1049ui_story"]
			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect1049ui_story == nil then
				arg_118_1.var_.characterEffect1049ui_story = var_121_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_11 = 0.200000002980232

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_11 and not isNil(var_121_9) then
				local var_121_12 = (arg_118_1.time_ - var_121_10) / var_121_11

				if arg_118_1.var_.characterEffect1049ui_story and not isNil(var_121_9) then
					arg_118_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_10 + var_121_11 and arg_118_1.time_ < var_121_10 + var_121_11 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect1049ui_story then
				arg_118_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_121_13 = 0

			if var_121_13 < arg_118_1.time_ and arg_118_1.time_ <= var_121_13 + arg_121_0 then
				arg_118_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			local var_121_14 = 0

			if var_121_14 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 then
				arg_118_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_121_15 = 0
			local var_121_16 = 0.4

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_17 = arg_118_1:FormatText(StoryNameCfg[551].name)

				arg_118_1.leftNameTxt_.text = var_121_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_18 = arg_118_1:GetWordFromCfg(1104906029)
				local var_121_19 = arg_118_1:FormatText(var_121_18.content)

				arg_118_1.text_.text = var_121_19

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_20 = 16
				local var_121_21 = utf8.len(var_121_19)
				local var_121_22 = var_121_20 <= 0 and var_121_16 or var_121_16 * (var_121_21 / var_121_20)

				if var_121_22 > 0 and var_121_16 < var_121_22 then
					arg_118_1.talkMaxDuration = var_121_22

					if var_121_22 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_22 + var_121_15
					end
				end

				arg_118_1.text_.text = var_121_19
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906029", "story_v_side_new_1104906.awb") ~= 0 then
					local var_121_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906029", "story_v_side_new_1104906.awb") / 1000

					if var_121_23 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_23 + var_121_15
					end

					if var_121_18.prefab_name ~= "" and arg_118_1.actors_[var_121_18.prefab_name] ~= nil then
						local var_121_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_18.prefab_name].transform, "story_v_side_new_1104906", "1104906029", "story_v_side_new_1104906.awb")

						arg_118_1:RecordAudio("1104906029", var_121_24)
						arg_118_1:RecordAudio("1104906029", var_121_24)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906029", "story_v_side_new_1104906.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906029", "story_v_side_new_1104906.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_25 = math.max(var_121_16, arg_118_1.talkMaxDuration)

			if var_121_15 <= arg_118_1.time_ and arg_118_1.time_ < var_121_15 + var_121_25 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_15) / var_121_25

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_15 + var_121_25 and arg_118_1.time_ < var_121_15 + var_121_25 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play1104906030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1104906030
		arg_122_1.duration_ = 9

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1104906031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = "ST58"

			if arg_122_1.bgs_[var_125_0] == nil then
				local var_125_1 = Object.Instantiate(arg_122_1.paintGo_)

				var_125_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_125_0)
				var_125_1.name = var_125_0
				var_125_1.transform.parent = arg_122_1.stage_.transform
				var_125_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_122_1.bgs_[var_125_0] = var_125_1
			end

			local var_125_2 = 2

			if var_125_2 < arg_122_1.time_ and arg_122_1.time_ <= var_125_2 + arg_125_0 then
				local var_125_3 = manager.ui.mainCamera.transform.localPosition
				local var_125_4 = Vector3.New(0, 0, 10) + Vector3.New(var_125_3.x, var_125_3.y, 0)
				local var_125_5 = arg_122_1.bgs_.ST58

				var_125_5.transform.localPosition = var_125_4
				var_125_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_125_6 = var_125_5:GetComponent("SpriteRenderer")

				if var_125_6 and var_125_6.sprite then
					local var_125_7 = (var_125_5.transform.localPosition - var_125_3).z
					local var_125_8 = manager.ui.mainCameraCom_
					local var_125_9 = 2 * var_125_7 * Mathf.Tan(var_125_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_125_10 = var_125_9 * var_125_8.aspect
					local var_125_11 = var_125_6.sprite.bounds.size.x
					local var_125_12 = var_125_6.sprite.bounds.size.y
					local var_125_13 = var_125_10 / var_125_11
					local var_125_14 = var_125_9 / var_125_12
					local var_125_15 = var_125_14 < var_125_13 and var_125_13 or var_125_14

					var_125_5.transform.localScale = Vector3.New(var_125_15, var_125_15, 0)
				end

				for iter_125_0, iter_125_1 in pairs(arg_122_1.bgs_) do
					if iter_125_0 ~= "ST58" then
						iter_125_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_125_16 = 4

			if var_125_16 < arg_122_1.time_ and arg_122_1.time_ <= var_125_16 + arg_125_0 then
				arg_122_1.allBtn_.enabled = false
			end

			local var_125_17 = 0.3

			if arg_122_1.time_ >= var_125_16 + var_125_17 and arg_122_1.time_ < var_125_16 + var_125_17 + arg_125_0 then
				arg_122_1.allBtn_.enabled = true
			end

			local var_125_18 = 0

			if var_125_18 < arg_122_1.time_ and arg_122_1.time_ <= var_125_18 + arg_125_0 then
				arg_122_1.mask_.enabled = true
				arg_122_1.mask_.raycastTarget = true

				arg_122_1:SetGaussion(false)
			end

			local var_125_19 = 2

			if var_125_18 <= arg_122_1.time_ and arg_122_1.time_ < var_125_18 + var_125_19 then
				local var_125_20 = (arg_122_1.time_ - var_125_18) / var_125_19
				local var_125_21 = Color.New(0, 0, 0)

				var_125_21.a = Mathf.Lerp(0, 1, var_125_20)
				arg_122_1.mask_.color = var_125_21
			end

			if arg_122_1.time_ >= var_125_18 + var_125_19 and arg_122_1.time_ < var_125_18 + var_125_19 + arg_125_0 then
				local var_125_22 = Color.New(0, 0, 0)

				var_125_22.a = 1
				arg_122_1.mask_.color = var_125_22
			end

			local var_125_23 = 2

			if var_125_23 < arg_122_1.time_ and arg_122_1.time_ <= var_125_23 + arg_125_0 then
				arg_122_1.mask_.enabled = true
				arg_122_1.mask_.raycastTarget = true

				arg_122_1:SetGaussion(false)
			end

			local var_125_24 = 2

			if var_125_23 <= arg_122_1.time_ and arg_122_1.time_ < var_125_23 + var_125_24 then
				local var_125_25 = (arg_122_1.time_ - var_125_23) / var_125_24
				local var_125_26 = Color.New(0, 0, 0)

				var_125_26.a = Mathf.Lerp(1, 0, var_125_25)
				arg_122_1.mask_.color = var_125_26
			end

			if arg_122_1.time_ >= var_125_23 + var_125_24 and arg_122_1.time_ < var_125_23 + var_125_24 + arg_125_0 then
				local var_125_27 = Color.New(0, 0, 0)
				local var_125_28 = 0

				arg_122_1.mask_.enabled = false
				var_125_27.a = var_125_28
				arg_122_1.mask_.color = var_125_27
			end

			local var_125_29 = arg_122_1.actors_["1049ui_story"].transform
			local var_125_30 = 1.96599999815226

			if var_125_30 < arg_122_1.time_ and arg_122_1.time_ <= var_125_30 + arg_125_0 then
				arg_122_1.var_.moveOldPos1049ui_story = var_125_29.localPosition
			end

			local var_125_31 = 0.001

			if var_125_30 <= arg_122_1.time_ and arg_122_1.time_ < var_125_30 + var_125_31 then
				local var_125_32 = (arg_122_1.time_ - var_125_30) / var_125_31
				local var_125_33 = Vector3.New(0, 100, 0)

				var_125_29.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1049ui_story, var_125_33, var_125_32)

				local var_125_34 = manager.ui.mainCamera.transform.position - var_125_29.position

				var_125_29.forward = Vector3.New(var_125_34.x, var_125_34.y, var_125_34.z)

				local var_125_35 = var_125_29.localEulerAngles

				var_125_35.z = 0
				var_125_35.x = 0
				var_125_29.localEulerAngles = var_125_35
			end

			if arg_122_1.time_ >= var_125_30 + var_125_31 and arg_122_1.time_ < var_125_30 + var_125_31 + arg_125_0 then
				var_125_29.localPosition = Vector3.New(0, 100, 0)

				local var_125_36 = manager.ui.mainCamera.transform.position - var_125_29.position

				var_125_29.forward = Vector3.New(var_125_36.x, var_125_36.y, var_125_36.z)

				local var_125_37 = var_125_29.localEulerAngles

				var_125_37.z = 0
				var_125_37.x = 0
				var_125_29.localEulerAngles = var_125_37
			end

			local var_125_38 = arg_122_1.actors_["1049ui_story"]
			local var_125_39 = 1.96599999815226

			if var_125_39 < arg_122_1.time_ and arg_122_1.time_ <= var_125_39 + arg_125_0 and not isNil(var_125_38) and arg_122_1.var_.characterEffect1049ui_story == nil then
				arg_122_1.var_.characterEffect1049ui_story = var_125_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_40 = 0.034000001847744

			if var_125_39 <= arg_122_1.time_ and arg_122_1.time_ < var_125_39 + var_125_40 and not isNil(var_125_38) then
				local var_125_41 = (arg_122_1.time_ - var_125_39) / var_125_40

				if arg_122_1.var_.characterEffect1049ui_story and not isNil(var_125_38) then
					local var_125_42 = Mathf.Lerp(0, 0.5, var_125_41)

					arg_122_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1049ui_story.fillRatio = var_125_42
				end
			end

			if arg_122_1.time_ >= var_125_39 + var_125_40 and arg_122_1.time_ < var_125_39 + var_125_40 + arg_125_0 and not isNil(var_125_38) and arg_122_1.var_.characterEffect1049ui_story then
				local var_125_43 = 0.5

				arg_122_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1049ui_story.fillRatio = var_125_43
			end

			local var_125_44 = 0.266666666666667
			local var_125_45 = 1

			if var_125_44 < arg_122_1.time_ and arg_122_1.time_ <= var_125_44 + arg_125_0 then
				local var_125_46 = "stop"
				local var_125_47 = "effect"

				arg_122_1:AudioAction(var_125_46, var_125_47, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_125_48 = 1.63333333333333
			local var_125_49 = 1

			if var_125_48 < arg_122_1.time_ and arg_122_1.time_ <= var_125_48 + arg_125_0 then
				local var_125_50 = "play"
				local var_125_51 = "effect"

				arg_122_1:AudioAction(var_125_50, var_125_51, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_125_52 = 0
			local var_125_53 = 0.2

			if var_125_52 < arg_122_1.time_ and arg_122_1.time_ <= var_125_52 + arg_125_0 then
				local var_125_54 = "play"
				local var_125_55 = "music"

				arg_122_1:AudioAction(var_125_54, var_125_55, "ui_battle", "ui_battle_stopbgm", "")

				local var_125_56 = ""
				local var_125_57 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_125_57 ~= "" then
					if arg_122_1.bgmTxt_.text ~= var_125_57 and arg_122_1.bgmTxt_.text ~= "" then
						if arg_122_1.bgmTxt2_.text ~= "" then
							arg_122_1.bgmTxt_.text = arg_122_1.bgmTxt2_.text
						end

						arg_122_1.bgmTxt2_.text = var_125_57

						arg_122_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_122_1.bgmTxt_.text = var_125_57
						arg_122_1.bgmTxt2_.text = var_125_57
					end

					if arg_122_1.bgmTimer then
						arg_122_1.bgmTimer:Stop()

						arg_122_1.bgmTimer = nil
					end

					if arg_122_1.settingData.show_music_name == 1 then
						arg_122_1.musicController:SetSelectedState("show")
						arg_122_1.musicAnimator_:Play("open", 0, 0)

						if arg_122_1.settingData.music_time ~= 0 then
							arg_122_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_122_1.settingData.music_time), function()
								if arg_122_1 == nil or isNil(arg_122_1.bgmTxt_) then
									return
								end

								arg_122_1.musicController:SetSelectedState("hide")
								arg_122_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_125_58 = 0.4
			local var_125_59 = 1

			if var_125_58 < arg_122_1.time_ and arg_122_1.time_ <= var_125_58 + arg_125_0 then
				local var_125_60 = "play"
				local var_125_61 = "music"

				arg_122_1:AudioAction(var_125_60, var_125_61, "bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet.awb")

				local var_125_62 = ""
				local var_125_63 = manager.audio:GetAudioName("bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet")

				if var_125_63 ~= "" then
					if arg_122_1.bgmTxt_.text ~= var_125_63 and arg_122_1.bgmTxt_.text ~= "" then
						if arg_122_1.bgmTxt2_.text ~= "" then
							arg_122_1.bgmTxt_.text = arg_122_1.bgmTxt2_.text
						end

						arg_122_1.bgmTxt2_.text = var_125_63

						arg_122_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_122_1.bgmTxt_.text = var_125_63
						arg_122_1.bgmTxt2_.text = var_125_63
					end

					if arg_122_1.bgmTimer then
						arg_122_1.bgmTimer:Stop()

						arg_122_1.bgmTimer = nil
					end

					if arg_122_1.settingData.show_music_name == 1 then
						arg_122_1.musicController:SetSelectedState("show")
						arg_122_1.musicAnimator_:Play("open", 0, 0)

						if arg_122_1.settingData.music_time ~= 0 then
							arg_122_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_122_1.settingData.music_time), function()
								if arg_122_1 == nil or isNil(arg_122_1.bgmTxt_) then
									return
								end

								arg_122_1.musicController:SetSelectedState("hide")
								arg_122_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_122_1.frameCnt_ <= 1 then
				arg_122_1.dialog_:SetActive(false)
			end

			local var_125_64 = 4
			local var_125_65 = 0.175

			if var_125_64 < arg_122_1.time_ and arg_122_1.time_ <= var_125_64 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_66 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_66:setOnUpdate(LuaHelper.FloatAction(function(arg_128_0)
					arg_122_1.dialogCg_.alpha = arg_128_0
				end))
				var_125_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_67 = arg_122_1:FormatText(StoryNameCfg[7].name)

				arg_122_1.leftNameTxt_.text = var_125_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_68 = arg_122_1:GetWordFromCfg(1104906030)
				local var_125_69 = arg_122_1:FormatText(var_125_68.content)

				arg_122_1.text_.text = var_125_69

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_70 = 7
				local var_125_71 = utf8.len(var_125_69)
				local var_125_72 = var_125_70 <= 0 and var_125_65 or var_125_65 * (var_125_71 / var_125_70)

				if var_125_72 > 0 and var_125_65 < var_125_72 then
					arg_122_1.talkMaxDuration = var_125_72
					var_125_64 = var_125_64 + 0.3

					if var_125_72 + var_125_64 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_72 + var_125_64
					end
				end

				arg_122_1.text_.text = var_125_69
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_73 = var_125_64 + 0.3
			local var_125_74 = math.max(var_125_65, arg_122_1.talkMaxDuration)

			if var_125_73 <= arg_122_1.time_ and arg_122_1.time_ < var_125_73 + var_125_74 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_73) / var_125_74

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_73 + var_125_74 and arg_122_1.time_ < var_125_73 + var_125_74 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play1104906031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 1104906031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play1104906032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.5

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

				local var_133_2 = arg_130_1:GetWordFromCfg(1104906031)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 20
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
	Play1104906032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1104906032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1104906033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 1

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_2 = arg_134_1:GetWordFromCfg(1104906032)
				local var_137_3 = arg_134_1:FormatText(var_137_2.content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 40
				local var_137_5 = utf8.len(var_137_3)
				local var_137_6 = var_137_4 <= 0 and var_137_1 or var_137_1 * (var_137_5 / var_137_4)

				if var_137_6 > 0 and var_137_1 < var_137_6 then
					arg_134_1.talkMaxDuration = var_137_6

					if var_137_6 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_7 and arg_134_1.time_ < var_137_0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play1104906033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1104906033
		arg_138_1.duration_ = 8.2

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1104906034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 1.025

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_2 = arg_138_1:FormatText(StoryNameCfg[1201].name)

				arg_138_1.leftNameTxt_.text = var_141_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:GetWordFromCfg(1104906033)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 41
				local var_141_6 = utf8.len(var_141_4)
				local var_141_7 = var_141_5 <= 0 and var_141_1 or var_141_1 * (var_141_6 / var_141_5)

				if var_141_7 > 0 and var_141_1 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906033", "story_v_side_new_1104906.awb") ~= 0 then
					local var_141_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906033", "story_v_side_new_1104906.awb") / 1000

					if var_141_8 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_0
					end

					if var_141_3.prefab_name ~= "" and arg_138_1.actors_[var_141_3.prefab_name] ~= nil then
						local var_141_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_3.prefab_name].transform, "story_v_side_new_1104906", "1104906033", "story_v_side_new_1104906.awb")

						arg_138_1:RecordAudio("1104906033", var_141_9)
						arg_138_1:RecordAudio("1104906033", var_141_9)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906033", "story_v_side_new_1104906.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906033", "story_v_side_new_1104906.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_10 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_10 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_10

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_10 and arg_138_1.time_ < var_141_0 + var_141_10 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play1104906034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1104906034
		arg_142_1.duration_ = 8.9

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1104906035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 1.15

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[1201].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(1104906034)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906034", "story_v_side_new_1104906.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906034", "story_v_side_new_1104906.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_side_new_1104906", "1104906034", "story_v_side_new_1104906.awb")

						arg_142_1:RecordAudio("1104906034", var_145_9)
						arg_142_1:RecordAudio("1104906034", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906034", "story_v_side_new_1104906.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906034", "story_v_side_new_1104906.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_10 and arg_142_1.time_ < var_145_0 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play1104906035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1104906035
		arg_146_1.duration_ = 9.4

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1104906036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 1.125

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[1201].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_3 = arg_146_1:GetWordFromCfg(1104906035)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 45
				local var_149_6 = utf8.len(var_149_4)
				local var_149_7 = var_149_5 <= 0 and var_149_1 or var_149_1 * (var_149_6 / var_149_5)

				if var_149_7 > 0 and var_149_1 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906035", "story_v_side_new_1104906.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906035", "story_v_side_new_1104906.awb") / 1000

					if var_149_8 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_0
					end

					if var_149_3.prefab_name ~= "" and arg_146_1.actors_[var_149_3.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_3.prefab_name].transform, "story_v_side_new_1104906", "1104906035", "story_v_side_new_1104906.awb")

						arg_146_1:RecordAudio("1104906035", var_149_9)
						arg_146_1:RecordAudio("1104906035", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906035", "story_v_side_new_1104906.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906035", "story_v_side_new_1104906.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_10 and arg_146_1.time_ < var_149_0 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play1104906036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1104906036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play1104906037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.625

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_2 = arg_150_1:GetWordFromCfg(1104906036)
				local var_153_3 = arg_150_1:FormatText(var_153_2.content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 25
				local var_153_5 = utf8.len(var_153_3)
				local var_153_6 = var_153_4 <= 0 and var_153_1 or var_153_1 * (var_153_5 / var_153_4)

				if var_153_6 > 0 and var_153_1 < var_153_6 then
					arg_150_1.talkMaxDuration = var_153_6

					if var_153_6 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_6 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_7 and arg_150_1.time_ < var_153_0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play1104906037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1104906037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play1104906038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 0.225

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_2 = arg_154_1:FormatText(StoryNameCfg[7].name)

				arg_154_1.leftNameTxt_.text = var_157_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_3 = arg_154_1:GetWordFromCfg(1104906037)
				local var_157_4 = arg_154_1:FormatText(var_157_3.content)

				arg_154_1.text_.text = var_157_4

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 9
				local var_157_6 = utf8.len(var_157_4)
				local var_157_7 = var_157_5 <= 0 and var_157_1 or var_157_1 * (var_157_6 / var_157_5)

				if var_157_7 > 0 and var_157_1 < var_157_7 then
					arg_154_1.talkMaxDuration = var_157_7

					if var_157_7 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_7 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_4
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_8 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_8 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_8

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_8 and arg_154_1.time_ < var_157_0 + var_157_8 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play1104906038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1104906038
		arg_158_1.duration_ = 2.97

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1104906039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.075

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_2 = arg_158_1:FormatText(StoryNameCfg[1201].name)

				arg_158_1.leftNameTxt_.text = var_161_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_3 = arg_158_1:GetWordFromCfg(1104906038)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 3
				local var_161_6 = utf8.len(var_161_4)
				local var_161_7 = var_161_5 <= 0 and var_161_1 or var_161_1 * (var_161_6 / var_161_5)

				if var_161_7 > 0 and var_161_1 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906038", "story_v_side_new_1104906.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906038", "story_v_side_new_1104906.awb") / 1000

					if var_161_8 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_0
					end

					if var_161_3.prefab_name ~= "" and arg_158_1.actors_[var_161_3.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_3.prefab_name].transform, "story_v_side_new_1104906", "1104906038", "story_v_side_new_1104906.awb")

						arg_158_1:RecordAudio("1104906038", var_161_9)
						arg_158_1:RecordAudio("1104906038", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906038", "story_v_side_new_1104906.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906038", "story_v_side_new_1104906.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_10 and arg_158_1.time_ < var_161_0 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play1104906039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1104906039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1104906040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 1.075

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_2 = arg_162_1:GetWordFromCfg(1104906039)
				local var_165_3 = arg_162_1:FormatText(var_165_2.content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 43
				local var_165_5 = utf8.len(var_165_3)
				local var_165_6 = var_165_4 <= 0 and var_165_1 or var_165_1 * (var_165_5 / var_165_4)

				if var_165_6 > 0 and var_165_1 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_7 and arg_162_1.time_ < var_165_0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play1104906040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1104906040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play1104906041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 0.9

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_2 = arg_166_1:GetWordFromCfg(1104906040)
				local var_169_3 = arg_166_1:FormatText(var_169_2.content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_4 = 36
				local var_169_5 = utf8.len(var_169_3)
				local var_169_6 = var_169_4 <= 0 and var_169_1 or var_169_1 * (var_169_5 / var_169_4)

				if var_169_6 > 0 and var_169_1 < var_169_6 then
					arg_166_1.talkMaxDuration = var_169_6

					if var_169_6 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_6 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_7 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_7 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_7

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_7 and arg_166_1.time_ < var_169_0 + var_169_7 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play1104906041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 1104906041
		arg_170_1.duration_ = 4.4

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play1104906042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1049ui_story"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos1049ui_story = var_173_0.localPosition
			end

			local var_173_2 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2
				local var_173_4 = Vector3.New(0, -1.2, -6)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1049ui_story, var_173_4, var_173_3)

				local var_173_5 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_5.x, var_173_5.y, var_173_5.z)

				local var_173_6 = var_173_0.localEulerAngles

				var_173_6.z = 0
				var_173_6.x = 0
				var_173_0.localEulerAngles = var_173_6
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_173_7 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_7.x, var_173_7.y, var_173_7.z)

				local var_173_8 = var_173_0.localEulerAngles

				var_173_8.z = 0
				var_173_8.x = 0
				var_173_0.localEulerAngles = var_173_8
			end

			local var_173_9 = arg_170_1.actors_["1049ui_story"]
			local var_173_10 = 0

			if var_173_10 < arg_170_1.time_ and arg_170_1.time_ <= var_173_10 + arg_173_0 and not isNil(var_173_9) and arg_170_1.var_.characterEffect1049ui_story == nil then
				arg_170_1.var_.characterEffect1049ui_story = var_173_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_11 = 0.200000002980232

			if var_173_10 <= arg_170_1.time_ and arg_170_1.time_ < var_173_10 + var_173_11 and not isNil(var_173_9) then
				local var_173_12 = (arg_170_1.time_ - var_173_10) / var_173_11

				if arg_170_1.var_.characterEffect1049ui_story and not isNil(var_173_9) then
					arg_170_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_10 + var_173_11 and arg_170_1.time_ < var_173_10 + var_173_11 + arg_173_0 and not isNil(var_173_9) and arg_170_1.var_.characterEffect1049ui_story then
				arg_170_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_173_13 = 0

			if var_173_13 < arg_170_1.time_ and arg_170_1.time_ <= var_173_13 + arg_173_0 then
				arg_170_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_173_14 = 0

			if var_173_14 < arg_170_1.time_ and arg_170_1.time_ <= var_173_14 + arg_173_0 then
				arg_170_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_173_15 = 0
			local var_173_16 = 0.45

			if var_173_15 < arg_170_1.time_ and arg_170_1.time_ <= var_173_15 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_17 = arg_170_1:FormatText(StoryNameCfg[551].name)

				arg_170_1.leftNameTxt_.text = var_173_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_18 = arg_170_1:GetWordFromCfg(1104906041)
				local var_173_19 = arg_170_1:FormatText(var_173_18.content)

				arg_170_1.text_.text = var_173_19

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_20 = 18
				local var_173_21 = utf8.len(var_173_19)
				local var_173_22 = var_173_20 <= 0 and var_173_16 or var_173_16 * (var_173_21 / var_173_20)

				if var_173_22 > 0 and var_173_16 < var_173_22 then
					arg_170_1.talkMaxDuration = var_173_22

					if var_173_22 + var_173_15 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_22 + var_173_15
					end
				end

				arg_170_1.text_.text = var_173_19
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906041", "story_v_side_new_1104906.awb") ~= 0 then
					local var_173_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906041", "story_v_side_new_1104906.awb") / 1000

					if var_173_23 + var_173_15 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_23 + var_173_15
					end

					if var_173_18.prefab_name ~= "" and arg_170_1.actors_[var_173_18.prefab_name] ~= nil then
						local var_173_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_18.prefab_name].transform, "story_v_side_new_1104906", "1104906041", "story_v_side_new_1104906.awb")

						arg_170_1:RecordAudio("1104906041", var_173_24)
						arg_170_1:RecordAudio("1104906041", var_173_24)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906041", "story_v_side_new_1104906.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906041", "story_v_side_new_1104906.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_25 = math.max(var_173_16, arg_170_1.talkMaxDuration)

			if var_173_15 <= arg_170_1.time_ and arg_170_1.time_ < var_173_15 + var_173_25 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_15) / var_173_25

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_15 + var_173_25 and arg_170_1.time_ < var_173_15 + var_173_25 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play1104906042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1104906042
		arg_174_1.duration_ = 4.77

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play1104906043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_177_2 = 0
			local var_177_3 = 0.475

			if var_177_2 < arg_174_1.time_ and arg_174_1.time_ <= var_177_2 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_4 = arg_174_1:FormatText(StoryNameCfg[551].name)

				arg_174_1.leftNameTxt_.text = var_177_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_5 = arg_174_1:GetWordFromCfg(1104906042)
				local var_177_6 = arg_174_1:FormatText(var_177_5.content)

				arg_174_1.text_.text = var_177_6

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_7 = 19
				local var_177_8 = utf8.len(var_177_6)
				local var_177_9 = var_177_7 <= 0 and var_177_3 or var_177_3 * (var_177_8 / var_177_7)

				if var_177_9 > 0 and var_177_3 < var_177_9 then
					arg_174_1.talkMaxDuration = var_177_9

					if var_177_9 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_9 + var_177_2
					end
				end

				arg_174_1.text_.text = var_177_6
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906042", "story_v_side_new_1104906.awb") ~= 0 then
					local var_177_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906042", "story_v_side_new_1104906.awb") / 1000

					if var_177_10 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_10 + var_177_2
					end

					if var_177_5.prefab_name ~= "" and arg_174_1.actors_[var_177_5.prefab_name] ~= nil then
						local var_177_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_5.prefab_name].transform, "story_v_side_new_1104906", "1104906042", "story_v_side_new_1104906.awb")

						arg_174_1:RecordAudio("1104906042", var_177_11)
						arg_174_1:RecordAudio("1104906042", var_177_11)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906042", "story_v_side_new_1104906.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906042", "story_v_side_new_1104906.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_12 = math.max(var_177_3, arg_174_1.talkMaxDuration)

			if var_177_2 <= arg_174_1.time_ and arg_174_1.time_ < var_177_2 + var_177_12 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_2) / var_177_12

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_2 + var_177_12 and arg_174_1.time_ < var_177_2 + var_177_12 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play1104906043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1104906043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play1104906044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1049ui_story"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1049ui_story == nil then
				arg_178_1.var_.characterEffect1049ui_story = var_181_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.characterEffect1049ui_story and not isNil(var_181_0) then
					local var_181_4 = Mathf.Lerp(0, 0.5, var_181_3)

					arg_178_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1049ui_story.fillRatio = var_181_4
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1049ui_story then
				local var_181_5 = 0.5

				arg_178_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1049ui_story.fillRatio = var_181_5
			end

			local var_181_6 = 0
			local var_181_7 = 1.275

			if var_181_6 < arg_178_1.time_ and arg_178_1.time_ <= var_181_6 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_8 = arg_178_1:FormatText(StoryNameCfg[7].name)

				arg_178_1.leftNameTxt_.text = var_181_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_9 = arg_178_1:GetWordFromCfg(1104906043)
				local var_181_10 = arg_178_1:FormatText(var_181_9.content)

				arg_178_1.text_.text = var_181_10

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_11 = 51
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
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_14 = math.max(var_181_7, arg_178_1.talkMaxDuration)

			if var_181_6 <= arg_178_1.time_ and arg_178_1.time_ < var_181_6 + var_181_14 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_6) / var_181_14

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_6 + var_181_14 and arg_178_1.time_ < var_181_6 + var_181_14 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play1104906044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1104906044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1104906045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 0.65

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_2 = arg_182_1:FormatText(StoryNameCfg[7].name)

				arg_182_1.leftNameTxt_.text = var_185_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_3 = arg_182_1:GetWordFromCfg(1104906044)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 26
				local var_185_6 = utf8.len(var_185_4)
				local var_185_7 = var_185_5 <= 0 and var_185_1 or var_185_1 * (var_185_6 / var_185_5)

				if var_185_7 > 0 and var_185_1 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_8 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_8 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_8

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_8 and arg_182_1.time_ < var_185_0 + var_185_8 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play1104906045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1104906045
		arg_186_1.duration_ = 5.07

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1104906046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1049ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1049ui_story == nil then
				arg_186_1.var_.characterEffect1049ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect1049ui_story and not isNil(var_189_0) then
					arg_186_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1049ui_story then
				arg_186_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_189_4 = 0

			if var_189_4 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			local var_189_5 = 0

			if var_189_5 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_189_6 = 0
			local var_189_7 = 0.575

			if var_189_6 < arg_186_1.time_ and arg_186_1.time_ <= var_189_6 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_8 = arg_186_1:FormatText(StoryNameCfg[551].name)

				arg_186_1.leftNameTxt_.text = var_189_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_9 = arg_186_1:GetWordFromCfg(1104906045)
				local var_189_10 = arg_186_1:FormatText(var_189_9.content)

				arg_186_1.text_.text = var_189_10

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_11 = 23
				local var_189_12 = utf8.len(var_189_10)
				local var_189_13 = var_189_11 <= 0 and var_189_7 or var_189_7 * (var_189_12 / var_189_11)

				if var_189_13 > 0 and var_189_7 < var_189_13 then
					arg_186_1.talkMaxDuration = var_189_13

					if var_189_13 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_13 + var_189_6
					end
				end

				arg_186_1.text_.text = var_189_10
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906045", "story_v_side_new_1104906.awb") ~= 0 then
					local var_189_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906045", "story_v_side_new_1104906.awb") / 1000

					if var_189_14 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_14 + var_189_6
					end

					if var_189_9.prefab_name ~= "" and arg_186_1.actors_[var_189_9.prefab_name] ~= nil then
						local var_189_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_9.prefab_name].transform, "story_v_side_new_1104906", "1104906045", "story_v_side_new_1104906.awb")

						arg_186_1:RecordAudio("1104906045", var_189_15)
						arg_186_1:RecordAudio("1104906045", var_189_15)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906045", "story_v_side_new_1104906.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906045", "story_v_side_new_1104906.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_16 = math.max(var_189_7, arg_186_1.talkMaxDuration)

			if var_189_6 <= arg_186_1.time_ and arg_186_1.time_ < var_189_6 + var_189_16 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_6) / var_189_16

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_6 + var_189_16 and arg_186_1.time_ < var_189_6 + var_189_16 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play1104906046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1104906046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1104906047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1049ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1049ui_story == nil then
				arg_190_1.var_.characterEffect1049ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1049ui_story and not isNil(var_193_0) then
					local var_193_4 = Mathf.Lerp(0, 0.5, var_193_3)

					arg_190_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1049ui_story.fillRatio = var_193_4
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1049ui_story then
				local var_193_5 = 0.5

				arg_190_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1049ui_story.fillRatio = var_193_5
			end

			local var_193_6 = 0
			local var_193_7 = 0.125

			if var_193_6 < arg_190_1.time_ and arg_190_1.time_ <= var_193_6 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_8 = arg_190_1:FormatText(StoryNameCfg[7].name)

				arg_190_1.leftNameTxt_.text = var_193_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_9 = arg_190_1:GetWordFromCfg(1104906046)
				local var_193_10 = arg_190_1:FormatText(var_193_9.content)

				arg_190_1.text_.text = var_193_10

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_11 = 5
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
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_14 = math.max(var_193_7, arg_190_1.talkMaxDuration)

			if var_193_6 <= arg_190_1.time_ and arg_190_1.time_ < var_193_6 + var_193_14 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_6) / var_193_14

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_6 + var_193_14 and arg_190_1.time_ < var_193_6 + var_193_14 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play1104906047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1104906047
		arg_194_1.duration_ = 12.2

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1104906048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1049ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1049ui_story == nil then
				arg_194_1.var_.characterEffect1049ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.200000002980232

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect1049ui_story and not isNil(var_197_0) then
					arg_194_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1049ui_story then
				arg_194_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_197_4 = 0

			if var_197_4 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_197_5 = 0

			if var_197_5 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 then
				arg_194_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_197_6 = 0
			local var_197_7 = 1.15

			if var_197_6 < arg_194_1.time_ and arg_194_1.time_ <= var_197_6 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_8 = arg_194_1:FormatText(StoryNameCfg[551].name)

				arg_194_1.leftNameTxt_.text = var_197_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_9 = arg_194_1:GetWordFromCfg(1104906047)
				local var_197_10 = arg_194_1:FormatText(var_197_9.content)

				arg_194_1.text_.text = var_197_10

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_11 = 46
				local var_197_12 = utf8.len(var_197_10)
				local var_197_13 = var_197_11 <= 0 and var_197_7 or var_197_7 * (var_197_12 / var_197_11)

				if var_197_13 > 0 and var_197_7 < var_197_13 then
					arg_194_1.talkMaxDuration = var_197_13

					if var_197_13 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_13 + var_197_6
					end
				end

				arg_194_1.text_.text = var_197_10
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906047", "story_v_side_new_1104906.awb") ~= 0 then
					local var_197_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906047", "story_v_side_new_1104906.awb") / 1000

					if var_197_14 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_14 + var_197_6
					end

					if var_197_9.prefab_name ~= "" and arg_194_1.actors_[var_197_9.prefab_name] ~= nil then
						local var_197_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_9.prefab_name].transform, "story_v_side_new_1104906", "1104906047", "story_v_side_new_1104906.awb")

						arg_194_1:RecordAudio("1104906047", var_197_15)
						arg_194_1:RecordAudio("1104906047", var_197_15)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906047", "story_v_side_new_1104906.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906047", "story_v_side_new_1104906.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_16 = math.max(var_197_7, arg_194_1.talkMaxDuration)

			if var_197_6 <= arg_194_1.time_ and arg_194_1.time_ < var_197_6 + var_197_16 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_6) / var_197_16

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_6 + var_197_16 and arg_194_1.time_ < var_197_6 + var_197_16 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play1104906048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1104906048
		arg_198_1.duration_ = 8

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1104906049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_201_2 = 0
			local var_201_3 = 0.6

			if var_201_2 < arg_198_1.time_ and arg_198_1.time_ <= var_201_2 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_4 = arg_198_1:FormatText(StoryNameCfg[551].name)

				arg_198_1.leftNameTxt_.text = var_201_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_5 = arg_198_1:GetWordFromCfg(1104906048)
				local var_201_6 = arg_198_1:FormatText(var_201_5.content)

				arg_198_1.text_.text = var_201_6

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_7 = 24
				local var_201_8 = utf8.len(var_201_6)
				local var_201_9 = var_201_7 <= 0 and var_201_3 or var_201_3 * (var_201_8 / var_201_7)

				if var_201_9 > 0 and var_201_3 < var_201_9 then
					arg_198_1.talkMaxDuration = var_201_9

					if var_201_9 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_2
					end
				end

				arg_198_1.text_.text = var_201_6
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906048", "story_v_side_new_1104906.awb") ~= 0 then
					local var_201_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906048", "story_v_side_new_1104906.awb") / 1000

					if var_201_10 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_2
					end

					if var_201_5.prefab_name ~= "" and arg_198_1.actors_[var_201_5.prefab_name] ~= nil then
						local var_201_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_5.prefab_name].transform, "story_v_side_new_1104906", "1104906048", "story_v_side_new_1104906.awb")

						arg_198_1:RecordAudio("1104906048", var_201_11)
						arg_198_1:RecordAudio("1104906048", var_201_11)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906048", "story_v_side_new_1104906.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906048", "story_v_side_new_1104906.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_12 = math.max(var_201_3, arg_198_1.talkMaxDuration)

			if var_201_2 <= arg_198_1.time_ and arg_198_1.time_ < var_201_2 + var_201_12 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_2) / var_201_12

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_2 + var_201_12 and arg_198_1.time_ < var_201_2 + var_201_12 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play1104906049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1104906049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1104906050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1049ui_story"].transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.moveOldPos1049ui_story = var_205_0.localPosition
			end

			local var_205_2 = 0.001

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2
				local var_205_4 = Vector3.New(0, 100, 0)

				var_205_0.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1049ui_story, var_205_4, var_205_3)

				local var_205_5 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_5.x, var_205_5.y, var_205_5.z)

				local var_205_6 = var_205_0.localEulerAngles

				var_205_6.z = 0
				var_205_6.x = 0
				var_205_0.localEulerAngles = var_205_6
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 then
				var_205_0.localPosition = Vector3.New(0, 100, 0)

				local var_205_7 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_7.x, var_205_7.y, var_205_7.z)

				local var_205_8 = var_205_0.localEulerAngles

				var_205_8.z = 0
				var_205_8.x = 0
				var_205_0.localEulerAngles = var_205_8
			end

			local var_205_9 = arg_202_1.actors_["1049ui_story"]
			local var_205_10 = 0

			if var_205_10 < arg_202_1.time_ and arg_202_1.time_ <= var_205_10 + arg_205_0 and not isNil(var_205_9) and arg_202_1.var_.characterEffect1049ui_story == nil then
				arg_202_1.var_.characterEffect1049ui_story = var_205_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_11 = 0.200000002980232

			if var_205_10 <= arg_202_1.time_ and arg_202_1.time_ < var_205_10 + var_205_11 and not isNil(var_205_9) then
				local var_205_12 = (arg_202_1.time_ - var_205_10) / var_205_11

				if arg_202_1.var_.characterEffect1049ui_story and not isNil(var_205_9) then
					local var_205_13 = Mathf.Lerp(0, 0.5, var_205_12)

					arg_202_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1049ui_story.fillRatio = var_205_13
				end
			end

			if arg_202_1.time_ >= var_205_10 + var_205_11 and arg_202_1.time_ < var_205_10 + var_205_11 + arg_205_0 and not isNil(var_205_9) and arg_202_1.var_.characterEffect1049ui_story then
				local var_205_14 = 0.5

				arg_202_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1049ui_story.fillRatio = var_205_14
			end

			local var_205_15 = 0
			local var_205_16 = 1.05

			if var_205_15 < arg_202_1.time_ and arg_202_1.time_ <= var_205_15 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_17 = arg_202_1:GetWordFromCfg(1104906049)
				local var_205_18 = arg_202_1:FormatText(var_205_17.content)

				arg_202_1.text_.text = var_205_18

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_19 = 42
				local var_205_20 = utf8.len(var_205_18)
				local var_205_21 = var_205_19 <= 0 and var_205_16 or var_205_16 * (var_205_20 / var_205_19)

				if var_205_21 > 0 and var_205_16 < var_205_21 then
					arg_202_1.talkMaxDuration = var_205_21

					if var_205_21 + var_205_15 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_21 + var_205_15
					end
				end

				arg_202_1.text_.text = var_205_18
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_22 = math.max(var_205_16, arg_202_1.talkMaxDuration)

			if var_205_15 <= arg_202_1.time_ and arg_202_1.time_ < var_205_15 + var_205_22 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_15) / var_205_22

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_15 + var_205_22 and arg_202_1.time_ < var_205_15 + var_205_22 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play1104906050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1104906050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1104906051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0
			local var_209_1 = 0.55

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

				local var_209_2 = arg_206_1:GetWordFromCfg(1104906050)
				local var_209_3 = arg_206_1:FormatText(var_209_2.content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 22
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
	Play1104906051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1104906051
		arg_210_1.duration_ = 1

		SetActive(arg_210_1.tipsGo_, true)

		arg_210_1.tipsText_.text = StoryTipsCfg[104901].name

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"

			SetActive(arg_210_1.choicesGo_, true)

			for iter_211_0, iter_211_1 in ipairs(arg_210_1.choices_) do
				local var_211_0 = iter_211_0 <= 2

				SetActive(iter_211_1.go, var_211_0)
			end

			arg_210_1.choices_[1].txt.text = arg_210_1:FormatText(StoryChoiceCfg[1185].name)
			arg_210_1.choices_[2].txt.text = arg_210_1:FormatText(StoryChoiceCfg[1186].name)
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				PlayerAction.UseStoryTrigger(1049013, 210490106, 1104906051, 1)
				arg_210_0:Play1104906052(arg_210_1)
			end

			if arg_212_0 == 2 then
				arg_210_0:Play1104906053(arg_210_1)
			end

			arg_210_1:RecordChoiceLog(1104906051, 1185, 1186)
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.allBtn_.enabled = false
			end

			local var_213_1 = 0.6

			if arg_210_1.time_ >= var_213_0 + var_213_1 and arg_210_1.time_ < var_213_0 + var_213_1 + arg_213_0 then
				arg_210_1.allBtn_.enabled = true
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play1104906052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1104906052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1104906054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.975

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[7].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:GetWordFromCfg(1104906052)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 39
				local var_217_6 = utf8.len(var_217_4)
				local var_217_7 = var_217_5 <= 0 and var_217_1 or var_217_1 * (var_217_6 / var_217_5)

				if var_217_7 > 0 and var_217_1 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_8 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_8 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_8

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_8 and arg_214_1.time_ < var_217_0 + var_217_8 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1104906054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1104906054
		arg_218_1.duration_ = 9.07

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1104906055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1049ui_story"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1049ui_story == nil then
				arg_218_1.var_.characterEffect1049ui_story = var_221_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.characterEffect1049ui_story and not isNil(var_221_0) then
					arg_218_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1049ui_story then
				arg_218_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_221_4 = 0

			if var_221_4 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_221_5 = 0

			if var_221_5 < arg_218_1.time_ and arg_218_1.time_ <= var_221_5 + arg_221_0 then
				arg_218_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_221_6 = arg_218_1.actors_["1049ui_story"].transform
			local var_221_7 = 0

			if var_221_7 < arg_218_1.time_ and arg_218_1.time_ <= var_221_7 + arg_221_0 then
				arg_218_1.var_.moveOldPos1049ui_story = var_221_6.localPosition
			end

			local var_221_8 = 0.001

			if var_221_7 <= arg_218_1.time_ and arg_218_1.time_ < var_221_7 + var_221_8 then
				local var_221_9 = (arg_218_1.time_ - var_221_7) / var_221_8
				local var_221_10 = Vector3.New(0, -1.2, -6)

				var_221_6.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1049ui_story, var_221_10, var_221_9)

				local var_221_11 = manager.ui.mainCamera.transform.position - var_221_6.position

				var_221_6.forward = Vector3.New(var_221_11.x, var_221_11.y, var_221_11.z)

				local var_221_12 = var_221_6.localEulerAngles

				var_221_12.z = 0
				var_221_12.x = 0
				var_221_6.localEulerAngles = var_221_12
			end

			if arg_218_1.time_ >= var_221_7 + var_221_8 and arg_218_1.time_ < var_221_7 + var_221_8 + arg_221_0 then
				var_221_6.localPosition = Vector3.New(0, -1.2, -6)

				local var_221_13 = manager.ui.mainCamera.transform.position - var_221_6.position

				var_221_6.forward = Vector3.New(var_221_13.x, var_221_13.y, var_221_13.z)

				local var_221_14 = var_221_6.localEulerAngles

				var_221_14.z = 0
				var_221_14.x = 0
				var_221_6.localEulerAngles = var_221_14
			end

			local var_221_15 = 0
			local var_221_16 = 0.55

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_17 = arg_218_1:FormatText(StoryNameCfg[551].name)

				arg_218_1.leftNameTxt_.text = var_221_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_18 = arg_218_1:GetWordFromCfg(1104906054)
				local var_221_19 = arg_218_1:FormatText(var_221_18.content)

				arg_218_1.text_.text = var_221_19

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_20 = 22
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906054", "story_v_side_new_1104906.awb") ~= 0 then
					local var_221_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906054", "story_v_side_new_1104906.awb") / 1000

					if var_221_23 + var_221_15 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_23 + var_221_15
					end

					if var_221_18.prefab_name ~= "" and arg_218_1.actors_[var_221_18.prefab_name] ~= nil then
						local var_221_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_18.prefab_name].transform, "story_v_side_new_1104906", "1104906054", "story_v_side_new_1104906.awb")

						arg_218_1:RecordAudio("1104906054", var_221_24)
						arg_218_1:RecordAudio("1104906054", var_221_24)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906054", "story_v_side_new_1104906.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906054", "story_v_side_new_1104906.awb")
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
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play1104906055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1104906055
		arg_222_1.duration_ = 9

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1104906056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 2

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				local var_225_1 = manager.ui.mainCamera.transform.localPosition
				local var_225_2 = Vector3.New(0, 0, 10) + Vector3.New(var_225_1.x, var_225_1.y, 0)
				local var_225_3 = arg_222_1.bgs_.ST58

				var_225_3.transform.localPosition = var_225_2
				var_225_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_225_4 = var_225_3:GetComponent("SpriteRenderer")

				if var_225_4 and var_225_4.sprite then
					local var_225_5 = (var_225_3.transform.localPosition - var_225_1).z
					local var_225_6 = manager.ui.mainCameraCom_
					local var_225_7 = 2 * var_225_5 * Mathf.Tan(var_225_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_225_8 = var_225_7 * var_225_6.aspect
					local var_225_9 = var_225_4.sprite.bounds.size.x
					local var_225_10 = var_225_4.sprite.bounds.size.y
					local var_225_11 = var_225_8 / var_225_9
					local var_225_12 = var_225_7 / var_225_10
					local var_225_13 = var_225_12 < var_225_11 and var_225_11 or var_225_12

					var_225_3.transform.localScale = Vector3.New(var_225_13, var_225_13, 0)
				end

				for iter_225_0, iter_225_1 in pairs(arg_222_1.bgs_) do
					if iter_225_0 ~= "ST58" then
						iter_225_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_225_14 = 4

			if var_225_14 < arg_222_1.time_ and arg_222_1.time_ <= var_225_14 + arg_225_0 then
				arg_222_1.allBtn_.enabled = false
			end

			local var_225_15 = 0.3

			if arg_222_1.time_ >= var_225_14 + var_225_15 and arg_222_1.time_ < var_225_14 + var_225_15 + arg_225_0 then
				arg_222_1.allBtn_.enabled = true
			end

			local var_225_16 = 0

			if var_225_16 < arg_222_1.time_ and arg_222_1.time_ <= var_225_16 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_17 = 2

			if var_225_16 <= arg_222_1.time_ and arg_222_1.time_ < var_225_16 + var_225_17 then
				local var_225_18 = (arg_222_1.time_ - var_225_16) / var_225_17
				local var_225_19 = Color.New(0, 0, 0)

				var_225_19.a = Mathf.Lerp(0, 1, var_225_18)
				arg_222_1.mask_.color = var_225_19
			end

			if arg_222_1.time_ >= var_225_16 + var_225_17 and arg_222_1.time_ < var_225_16 + var_225_17 + arg_225_0 then
				local var_225_20 = Color.New(0, 0, 0)

				var_225_20.a = 1
				arg_222_1.mask_.color = var_225_20
			end

			local var_225_21 = 2

			if var_225_21 < arg_222_1.time_ and arg_222_1.time_ <= var_225_21 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_22 = 2

			if var_225_21 <= arg_222_1.time_ and arg_222_1.time_ < var_225_21 + var_225_22 then
				local var_225_23 = (arg_222_1.time_ - var_225_21) / var_225_22
				local var_225_24 = Color.New(0, 0, 0)

				var_225_24.a = Mathf.Lerp(1, 0, var_225_23)
				arg_222_1.mask_.color = var_225_24
			end

			if arg_222_1.time_ >= var_225_21 + var_225_22 and arg_222_1.time_ < var_225_21 + var_225_22 + arg_225_0 then
				local var_225_25 = Color.New(0, 0, 0)
				local var_225_26 = 0

				arg_222_1.mask_.enabled = false
				var_225_25.a = var_225_26
				arg_222_1.mask_.color = var_225_25
			end

			local var_225_27 = arg_222_1.actors_["1049ui_story"].transform
			local var_225_28 = 1.96599999815226

			if var_225_28 < arg_222_1.time_ and arg_222_1.time_ <= var_225_28 + arg_225_0 then
				arg_222_1.var_.moveOldPos1049ui_story = var_225_27.localPosition
			end

			local var_225_29 = 0.001

			if var_225_28 <= arg_222_1.time_ and arg_222_1.time_ < var_225_28 + var_225_29 then
				local var_225_30 = (arg_222_1.time_ - var_225_28) / var_225_29
				local var_225_31 = Vector3.New(0, 100, 0)

				var_225_27.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1049ui_story, var_225_31, var_225_30)

				local var_225_32 = manager.ui.mainCamera.transform.position - var_225_27.position

				var_225_27.forward = Vector3.New(var_225_32.x, var_225_32.y, var_225_32.z)

				local var_225_33 = var_225_27.localEulerAngles

				var_225_33.z = 0
				var_225_33.x = 0
				var_225_27.localEulerAngles = var_225_33
			end

			if arg_222_1.time_ >= var_225_28 + var_225_29 and arg_222_1.time_ < var_225_28 + var_225_29 + arg_225_0 then
				var_225_27.localPosition = Vector3.New(0, 100, 0)

				local var_225_34 = manager.ui.mainCamera.transform.position - var_225_27.position

				var_225_27.forward = Vector3.New(var_225_34.x, var_225_34.y, var_225_34.z)

				local var_225_35 = var_225_27.localEulerAngles

				var_225_35.z = 0
				var_225_35.x = 0
				var_225_27.localEulerAngles = var_225_35
			end

			local var_225_36 = arg_222_1.actors_["1049ui_story"]
			local var_225_37 = 1.96599999815226

			if var_225_37 < arg_222_1.time_ and arg_222_1.time_ <= var_225_37 + arg_225_0 and not isNil(var_225_36) and arg_222_1.var_.characterEffect1049ui_story == nil then
				arg_222_1.var_.characterEffect1049ui_story = var_225_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_38 = 0.034000001847744

			if var_225_37 <= arg_222_1.time_ and arg_222_1.time_ < var_225_37 + var_225_38 and not isNil(var_225_36) then
				local var_225_39 = (arg_222_1.time_ - var_225_37) / var_225_38

				if arg_222_1.var_.characterEffect1049ui_story and not isNil(var_225_36) then
					local var_225_40 = Mathf.Lerp(0, 0.5, var_225_39)

					arg_222_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1049ui_story.fillRatio = var_225_40
				end
			end

			if arg_222_1.time_ >= var_225_37 + var_225_38 and arg_222_1.time_ < var_225_37 + var_225_38 + arg_225_0 and not isNil(var_225_36) and arg_222_1.var_.characterEffect1049ui_story then
				local var_225_41 = 0.5

				arg_222_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1049ui_story.fillRatio = var_225_41
			end

			if arg_222_1.frameCnt_ <= 1 then
				arg_222_1.dialog_:SetActive(false)
			end

			local var_225_42 = 4
			local var_225_43 = 0.575

			if var_225_42 < arg_222_1.time_ and arg_222_1.time_ <= var_225_42 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0

				arg_222_1.dialog_:SetActive(true)

				arg_222_1.dialogCg_.alpha = 0

				local var_225_44 = LeanTween.value(arg_222_1.dialog_, 0, 1, 0.3)

				var_225_44:setOnUpdate(LuaHelper.FloatAction(function(arg_226_0)
					arg_222_1.dialogCg_.alpha = arg_226_0
				end))
				var_225_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_222_1.dialog_)
					var_225_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_222_1.duration_ = arg_222_1.duration_ + 0.3

				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_45 = arg_222_1:GetWordFromCfg(1104906055)
				local var_225_46 = arg_222_1:FormatText(var_225_45.content)

				arg_222_1.text_.text = var_225_46

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_47 = 23
				local var_225_48 = utf8.len(var_225_46)
				local var_225_49 = var_225_47 <= 0 and var_225_43 or var_225_43 * (var_225_48 / var_225_47)

				if var_225_49 > 0 and var_225_43 < var_225_49 then
					arg_222_1.talkMaxDuration = var_225_49
					var_225_42 = var_225_42 + 0.3

					if var_225_49 + var_225_42 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_49 + var_225_42
					end
				end

				arg_222_1.text_.text = var_225_46
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_50 = var_225_42 + 0.3
			local var_225_51 = math.max(var_225_43, arg_222_1.talkMaxDuration)

			if var_225_50 <= arg_222_1.time_ and arg_222_1.time_ < var_225_50 + var_225_51 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_50) / var_225_51

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_50 + var_225_51 and arg_222_1.time_ < var_225_50 + var_225_51 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play1104906056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1104906056
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play1104906057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0
			local var_231_1 = 1.1

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_2 = arg_228_1:GetWordFromCfg(1104906056)
				local var_231_3 = arg_228_1:FormatText(var_231_2.content)

				arg_228_1.text_.text = var_231_3

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_4 = 44
				local var_231_5 = utf8.len(var_231_3)
				local var_231_6 = var_231_4 <= 0 and var_231_1 or var_231_1 * (var_231_5 / var_231_4)

				if var_231_6 > 0 and var_231_1 < var_231_6 then
					arg_228_1.talkMaxDuration = var_231_6

					if var_231_6 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_6 + var_231_0
					end
				end

				arg_228_1.text_.text = var_231_3
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_7 = math.max(var_231_1, arg_228_1.talkMaxDuration)

			if var_231_0 <= arg_228_1.time_ and arg_228_1.time_ < var_231_0 + var_231_7 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_0) / var_231_7

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_0 + var_231_7 and arg_228_1.time_ < var_231_0 + var_231_7 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play1104906057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1104906057
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1104906058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0
			local var_235_1 = 1.425

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

				local var_235_3 = arg_232_1:GetWordFromCfg(1104906057)
				local var_235_4 = arg_232_1:FormatText(var_235_3.content)

				arg_232_1.text_.text = var_235_4

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_5 = 57
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
	Play1104906058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 1104906058
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play1104906059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 0.1

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_2 = arg_236_1:FormatText(StoryNameCfg[7].name)

				arg_236_1.leftNameTxt_.text = var_239_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_3 = arg_236_1:GetWordFromCfg(1104906058)
				local var_239_4 = arg_236_1:FormatText(var_239_3.content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 4
				local var_239_6 = utf8.len(var_239_4)
				local var_239_7 = var_239_5 <= 0 and var_239_1 or var_239_1 * (var_239_6 / var_239_5)

				if var_239_7 > 0 and var_239_1 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_8 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_8 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_8

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_8 and arg_236_1.time_ < var_239_0 + var_239_8 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play1104906059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 1104906059
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play1104906060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 0.15

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_2 = arg_240_1:GetWordFromCfg(1104906059)
				local var_243_3 = arg_240_1:FormatText(var_243_2.content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 6
				local var_243_5 = utf8.len(var_243_3)
				local var_243_6 = var_243_4 <= 0 and var_243_1 or var_243_1 * (var_243_5 / var_243_4)

				if var_243_6 > 0 and var_243_1 < var_243_6 then
					arg_240_1.talkMaxDuration = var_243_6

					if var_243_6 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_7 and arg_240_1.time_ < var_243_0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play1104906060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 1104906060
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play1104906061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 0.1

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_2 = arg_244_1:FormatText(StoryNameCfg[7].name)

				arg_244_1.leftNameTxt_.text = var_247_2

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

				local var_247_3 = arg_244_1:GetWordFromCfg(1104906060)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 4
				local var_247_6 = utf8.len(var_247_4)
				local var_247_7 = var_247_5 <= 0 and var_247_1 or var_247_1 * (var_247_6 / var_247_5)

				if var_247_7 > 0 and var_247_1 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_8 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_8 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_8

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_8 and arg_244_1.time_ < var_247_0 + var_247_8 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play1104906061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 1104906061
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play1104906062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.15

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_2 = arg_248_1:GetWordFromCfg(1104906061)
				local var_251_3 = arg_248_1:FormatText(var_251_2.content)

				arg_248_1.text_.text = var_251_3

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 6
				local var_251_5 = utf8.len(var_251_3)
				local var_251_6 = var_251_4 <= 0 and var_251_1 or var_251_1 * (var_251_5 / var_251_4)

				if var_251_6 > 0 and var_251_1 < var_251_6 then
					arg_248_1.talkMaxDuration = var_251_6

					if var_251_6 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_6 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_3
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_7 and arg_248_1.time_ < var_251_0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play1104906062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 1104906062
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play1104906063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0
			local var_255_1 = 0.625

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_2 = arg_252_1:FormatText(StoryNameCfg[7].name)

				arg_252_1.leftNameTxt_.text = var_255_2

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

				local var_255_3 = arg_252_1:GetWordFromCfg(1104906062)
				local var_255_4 = arg_252_1:FormatText(var_255_3.content)

				arg_252_1.text_.text = var_255_4

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 25
				local var_255_6 = utf8.len(var_255_4)
				local var_255_7 = var_255_5 <= 0 and var_255_1 or var_255_1 * (var_255_6 / var_255_5)

				if var_255_7 > 0 and var_255_1 < var_255_7 then
					arg_252_1.talkMaxDuration = var_255_7

					if var_255_7 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_0
					end
				end

				arg_252_1.text_.text = var_255_4
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_8 = math.max(var_255_1, arg_252_1.talkMaxDuration)

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_8 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_0) / var_255_8

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_0 + var_255_8 and arg_252_1.time_ < var_255_0 + var_255_8 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play1104906063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1104906063
		arg_256_1.duration_ = 7.17

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play1104906064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = "STblack"

			if arg_256_1.bgs_[var_259_0] == nil then
				local var_259_1 = Object.Instantiate(arg_256_1.paintGo_)

				var_259_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_259_0)
				var_259_1.name = var_259_0
				var_259_1.transform.parent = arg_256_1.stage_.transform
				var_259_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_256_1.bgs_[var_259_0] = var_259_1
			end

			local var_259_2 = 3

			if var_259_2 < arg_256_1.time_ and arg_256_1.time_ <= var_259_2 + arg_259_0 then
				local var_259_3 = manager.ui.mainCamera.transform.localPosition
				local var_259_4 = Vector3.New(0, 0, 10) + Vector3.New(var_259_3.x, var_259_3.y, 0)
				local var_259_5 = arg_256_1.bgs_.STblack

				var_259_5.transform.localPosition = var_259_4
				var_259_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_259_6 = var_259_5:GetComponent("SpriteRenderer")

				if var_259_6 and var_259_6.sprite then
					local var_259_7 = (var_259_5.transform.localPosition - var_259_3).z
					local var_259_8 = manager.ui.mainCameraCom_
					local var_259_9 = 2 * var_259_7 * Mathf.Tan(var_259_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_259_10 = var_259_9 * var_259_8.aspect
					local var_259_11 = var_259_6.sprite.bounds.size.x
					local var_259_12 = var_259_6.sprite.bounds.size.y
					local var_259_13 = var_259_10 / var_259_11
					local var_259_14 = var_259_9 / var_259_12
					local var_259_15 = var_259_14 < var_259_13 and var_259_13 or var_259_14

					var_259_5.transform.localScale = Vector3.New(var_259_15, var_259_15, 0)
				end

				for iter_259_0, iter_259_1 in pairs(arg_256_1.bgs_) do
					if iter_259_0 ~= "STblack" then
						iter_259_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_259_16 = 5.999999999999

			if var_259_16 < arg_256_1.time_ and arg_256_1.time_ <= var_259_16 + arg_259_0 then
				arg_256_1.allBtn_.enabled = false
			end

			local var_259_17 = 0.3

			if arg_256_1.time_ >= var_259_16 + var_259_17 and arg_256_1.time_ < var_259_16 + var_259_17 + arg_259_0 then
				arg_256_1.allBtn_.enabled = true
			end

			local var_259_18 = 0

			if var_259_18 < arg_256_1.time_ and arg_256_1.time_ <= var_259_18 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_19 = 3

			if var_259_18 <= arg_256_1.time_ and arg_256_1.time_ < var_259_18 + var_259_19 then
				local var_259_20 = (arg_256_1.time_ - var_259_18) / var_259_19
				local var_259_21 = Color.New(0, 0, 0)

				var_259_21.a = Mathf.Lerp(0, 1, var_259_20)
				arg_256_1.mask_.color = var_259_21
			end

			if arg_256_1.time_ >= var_259_18 + var_259_19 and arg_256_1.time_ < var_259_18 + var_259_19 + arg_259_0 then
				local var_259_22 = Color.New(0, 0, 0)

				var_259_22.a = 1
				arg_256_1.mask_.color = var_259_22
			end

			local var_259_23 = 3

			if var_259_23 < arg_256_1.time_ and arg_256_1.time_ <= var_259_23 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_24 = 3

			if var_259_23 <= arg_256_1.time_ and arg_256_1.time_ < var_259_23 + var_259_24 then
				local var_259_25 = (arg_256_1.time_ - var_259_23) / var_259_24
				local var_259_26 = Color.New(0, 0, 0)

				var_259_26.a = Mathf.Lerp(1, 0, var_259_25)
				arg_256_1.mask_.color = var_259_26
			end

			if arg_256_1.time_ >= var_259_23 + var_259_24 and arg_256_1.time_ < var_259_23 + var_259_24 + arg_259_0 then
				local var_259_27 = Color.New(0, 0, 0)
				local var_259_28 = 0

				arg_256_1.mask_.enabled = false
				var_259_27.a = var_259_28
				arg_256_1.mask_.color = var_259_27
			end

			local var_259_29 = arg_256_1.actors_["1049ui_story"]
			local var_259_30 = 2.98333333333333

			if var_259_30 < arg_256_1.time_ and arg_256_1.time_ <= var_259_30 + arg_259_0 and not isNil(var_259_29) and arg_256_1.var_.characterEffect1049ui_story == nil then
				arg_256_1.var_.characterEffect1049ui_story = var_259_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_31 = 0.0166666666666666

			if var_259_30 <= arg_256_1.time_ and arg_256_1.time_ < var_259_30 + var_259_31 and not isNil(var_259_29) then
				local var_259_32 = (arg_256_1.time_ - var_259_30) / var_259_31

				if arg_256_1.var_.characterEffect1049ui_story and not isNil(var_259_29) then
					arg_256_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_30 + var_259_31 and arg_256_1.time_ < var_259_30 + var_259_31 + arg_259_0 and not isNil(var_259_29) and arg_256_1.var_.characterEffect1049ui_story then
				arg_256_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_259_33 = 1.1
			local var_259_34 = 0.2

			if var_259_33 < arg_256_1.time_ and arg_256_1.time_ <= var_259_33 + arg_259_0 then
				local var_259_35 = "play"
				local var_259_36 = "music"

				arg_256_1:AudioAction(var_259_35, var_259_36, "ui_battle", "ui_battle_stopbgm", "")

				local var_259_37 = ""
				local var_259_38 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_259_38 ~= "" then
					if arg_256_1.bgmTxt_.text ~= var_259_38 and arg_256_1.bgmTxt_.text ~= "" then
						if arg_256_1.bgmTxt2_.text ~= "" then
							arg_256_1.bgmTxt_.text = arg_256_1.bgmTxt2_.text
						end

						arg_256_1.bgmTxt2_.text = var_259_38

						arg_256_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_256_1.bgmTxt_.text = var_259_38
						arg_256_1.bgmTxt2_.text = var_259_38
					end

					if arg_256_1.bgmTimer then
						arg_256_1.bgmTimer:Stop()

						arg_256_1.bgmTimer = nil
					end

					if arg_256_1.settingData.show_music_name == 1 then
						arg_256_1.musicController:SetSelectedState("show")
						arg_256_1.musicAnimator_:Play("open", 0, 0)

						if arg_256_1.settingData.music_time ~= 0 then
							arg_256_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_256_1.settingData.music_time), function()
								if arg_256_1 == nil or isNil(arg_256_1.bgmTxt_) then
									return
								end

								arg_256_1.musicController:SetSelectedState("hide")
								arg_256_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_256_1.frameCnt_ <= 1 then
				arg_256_1.dialog_:SetActive(false)
			end

			local var_259_39 = 5.8
			local var_259_40 = 0.125

			if var_259_39 < arg_256_1.time_ and arg_256_1.time_ <= var_259_39 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0

				arg_256_1.dialog_:SetActive(true)

				arg_256_1.dialogCg_.alpha = 0

				local var_259_41 = LeanTween.value(arg_256_1.dialog_, 0, 1, 0.3)

				var_259_41:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_256_1.dialogCg_.alpha = arg_261_0
				end))
				var_259_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_256_1.dialog_)
					var_259_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_256_1.duration_ = arg_256_1.duration_ + 0.3

				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_42 = arg_256_1:FormatText(StoryNameCfg[551].name)

				arg_256_1.leftNameTxt_.text = var_259_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_43 = arg_256_1:GetWordFromCfg(1104906063)
				local var_259_44 = arg_256_1:FormatText(var_259_43.content)

				arg_256_1.text_.text = var_259_44

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_45 = 5
				local var_259_46 = utf8.len(var_259_44)
				local var_259_47 = var_259_45 <= 0 and var_259_40 or var_259_40 * (var_259_46 / var_259_45)

				if var_259_47 > 0 and var_259_40 < var_259_47 then
					arg_256_1.talkMaxDuration = var_259_47
					var_259_39 = var_259_39 + 0.3

					if var_259_47 + var_259_39 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_47 + var_259_39
					end
				end

				arg_256_1.text_.text = var_259_44
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906063", "story_v_side_new_1104906.awb") ~= 0 then
					local var_259_48 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906063", "story_v_side_new_1104906.awb") / 1000

					if var_259_48 + var_259_39 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_48 + var_259_39
					end

					if var_259_43.prefab_name ~= "" and arg_256_1.actors_[var_259_43.prefab_name] ~= nil then
						local var_259_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_43.prefab_name].transform, "story_v_side_new_1104906", "1104906063", "story_v_side_new_1104906.awb")

						arg_256_1:RecordAudio("1104906063", var_259_49)
						arg_256_1:RecordAudio("1104906063", var_259_49)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906063", "story_v_side_new_1104906.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906063", "story_v_side_new_1104906.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_50 = var_259_39 + 0.3
			local var_259_51 = math.max(var_259_40, arg_256_1.talkMaxDuration)

			if var_259_50 <= arg_256_1.time_ and arg_256_1.time_ < var_259_50 + var_259_51 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_50) / var_259_51

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_50 + var_259_51 and arg_256_1.time_ < var_259_50 + var_259_51 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play1104906064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1104906064
		arg_263_1.duration_ = 7

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1104906065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = "K11f"

			if arg_263_1.bgs_[var_266_0] == nil then
				local var_266_1 = Object.Instantiate(arg_263_1.paintGo_)

				var_266_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_266_0)
				var_266_1.name = var_266_0
				var_266_1.transform.parent = arg_263_1.stage_.transform
				var_266_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.bgs_[var_266_0] = var_266_1
			end

			local var_266_2 = 0

			if var_266_2 < arg_263_1.time_ and arg_263_1.time_ <= var_266_2 + arg_266_0 then
				local var_266_3 = manager.ui.mainCamera.transform.localPosition
				local var_266_4 = Vector3.New(0, 0, 10) + Vector3.New(var_266_3.x, var_266_3.y, 0)
				local var_266_5 = arg_263_1.bgs_.K11f

				var_266_5.transform.localPosition = var_266_4
				var_266_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_266_6 = var_266_5:GetComponent("SpriteRenderer")

				if var_266_6 and var_266_6.sprite then
					local var_266_7 = (var_266_5.transform.localPosition - var_266_3).z
					local var_266_8 = manager.ui.mainCameraCom_
					local var_266_9 = 2 * var_266_7 * Mathf.Tan(var_266_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_266_10 = var_266_9 * var_266_8.aspect
					local var_266_11 = var_266_6.sprite.bounds.size.x
					local var_266_12 = var_266_6.sprite.bounds.size.y
					local var_266_13 = var_266_10 / var_266_11
					local var_266_14 = var_266_9 / var_266_12
					local var_266_15 = var_266_14 < var_266_13 and var_266_13 or var_266_14

					var_266_5.transform.localScale = Vector3.New(var_266_15, var_266_15, 0)
				end

				for iter_266_0, iter_266_1 in pairs(arg_263_1.bgs_) do
					if iter_266_0 ~= "K11f" then
						iter_266_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_266_16 = 2

			if var_266_16 < arg_263_1.time_ and arg_263_1.time_ <= var_266_16 + arg_266_0 then
				arg_263_1.allBtn_.enabled = false
			end

			local var_266_17 = 0.3

			if arg_263_1.time_ >= var_266_16 + var_266_17 and arg_263_1.time_ < var_266_16 + var_266_17 + arg_266_0 then
				arg_263_1.allBtn_.enabled = true
			end

			local var_266_18 = 0

			if var_266_18 < arg_263_1.time_ and arg_263_1.time_ <= var_266_18 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_19 = 2

			if var_266_18 <= arg_263_1.time_ and arg_263_1.time_ < var_266_18 + var_266_19 then
				local var_266_20 = (arg_263_1.time_ - var_266_18) / var_266_19
				local var_266_21 = Color.New(0, 0, 0)

				var_266_21.a = Mathf.Lerp(1, 0, var_266_20)
				arg_263_1.mask_.color = var_266_21
			end

			if arg_263_1.time_ >= var_266_18 + var_266_19 and arg_263_1.time_ < var_266_18 + var_266_19 + arg_266_0 then
				local var_266_22 = Color.New(0, 0, 0)
				local var_266_23 = 0

				arg_263_1.mask_.enabled = false
				var_266_22.a = var_266_23
				arg_263_1.mask_.color = var_266_22
			end

			local var_266_24 = 0
			local var_266_25 = 1

			if var_266_24 < arg_263_1.time_ and arg_263_1.time_ <= var_266_24 + arg_266_0 then
				local var_266_26 = "play"
				local var_266_27 = "effect"

				arg_263_1:AudioAction(var_266_26, var_266_27, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_266_28 = 0
			local var_266_29 = 1

			if var_266_28 < arg_263_1.time_ and arg_263_1.time_ <= var_266_28 + arg_266_0 then
				local var_266_30 = "stop"
				local var_266_31 = "effect"

				arg_263_1:AudioAction(var_266_30, var_266_31, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_266_32 = 0
			local var_266_33 = 0.2

			if var_266_32 < arg_263_1.time_ and arg_263_1.time_ <= var_266_32 + arg_266_0 then
				local var_266_34 = "play"
				local var_266_35 = "music"

				arg_263_1:AudioAction(var_266_34, var_266_35, "ui_battle", "ui_battle_stopbgm", "")

				local var_266_36 = ""
				local var_266_37 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_266_37 ~= "" then
					if arg_263_1.bgmTxt_.text ~= var_266_37 and arg_263_1.bgmTxt_.text ~= "" then
						if arg_263_1.bgmTxt2_.text ~= "" then
							arg_263_1.bgmTxt_.text = arg_263_1.bgmTxt2_.text
						end

						arg_263_1.bgmTxt2_.text = var_266_37

						arg_263_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_263_1.bgmTxt_.text = var_266_37
						arg_263_1.bgmTxt2_.text = var_266_37
					end

					if arg_263_1.bgmTimer then
						arg_263_1.bgmTimer:Stop()

						arg_263_1.bgmTimer = nil
					end

					if arg_263_1.settingData.show_music_name == 1 then
						arg_263_1.musicController:SetSelectedState("show")
						arg_263_1.musicAnimator_:Play("open", 0, 0)

						if arg_263_1.settingData.music_time ~= 0 then
							arg_263_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_263_1.settingData.music_time), function()
								if arg_263_1 == nil or isNil(arg_263_1.bgmTxt_) then
									return
								end

								arg_263_1.musicController:SetSelectedState("hide")
								arg_263_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_266_38 = 0.4
			local var_266_39 = 1

			if var_266_38 < arg_263_1.time_ and arg_263_1.time_ <= var_266_38 + arg_266_0 then
				local var_266_40 = "play"
				local var_266_41 = "music"

				arg_263_1:AudioAction(var_266_40, var_266_41, "bgm_side_daily07", "bgm_side_daily07", "bgm_side_daily07.awb")

				local var_266_42 = ""
				local var_266_43 = manager.audio:GetAudioName("bgm_side_daily07", "bgm_side_daily07")

				if var_266_43 ~= "" then
					if arg_263_1.bgmTxt_.text ~= var_266_43 and arg_263_1.bgmTxt_.text ~= "" then
						if arg_263_1.bgmTxt2_.text ~= "" then
							arg_263_1.bgmTxt_.text = arg_263_1.bgmTxt2_.text
						end

						arg_263_1.bgmTxt2_.text = var_266_43

						arg_263_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_263_1.bgmTxt_.text = var_266_43
						arg_263_1.bgmTxt2_.text = var_266_43
					end

					if arg_263_1.bgmTimer then
						arg_263_1.bgmTimer:Stop()

						arg_263_1.bgmTimer = nil
					end

					if arg_263_1.settingData.show_music_name == 1 then
						arg_263_1.musicController:SetSelectedState("show")
						arg_263_1.musicAnimator_:Play("open", 0, 0)

						if arg_263_1.settingData.music_time ~= 0 then
							arg_263_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_263_1.settingData.music_time), function()
								if arg_263_1 == nil or isNil(arg_263_1.bgmTxt_) then
									return
								end

								arg_263_1.musicController:SetSelectedState("hide")
								arg_263_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_44 = 2
			local var_266_45 = 0.225

			if var_266_44 < arg_263_1.time_ and arg_263_1.time_ <= var_266_44 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_46 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_46:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_263_1.dialogCg_.alpha = arg_269_0
				end))
				var_266_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_47 = arg_263_1:FormatText(StoryNameCfg[7].name)

				arg_263_1.leftNameTxt_.text = var_266_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_48 = arg_263_1:GetWordFromCfg(1104906064)
				local var_266_49 = arg_263_1:FormatText(var_266_48.content)

				arg_263_1.text_.text = var_266_49

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_50 = 9
				local var_266_51 = utf8.len(var_266_49)
				local var_266_52 = var_266_50 <= 0 and var_266_45 or var_266_45 * (var_266_51 / var_266_50)

				if var_266_52 > 0 and var_266_45 < var_266_52 then
					arg_263_1.talkMaxDuration = var_266_52
					var_266_44 = var_266_44 + 0.3

					if var_266_52 + var_266_44 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_52 + var_266_44
					end
				end

				arg_263_1.text_.text = var_266_49
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_53 = var_266_44 + 0.3
			local var_266_54 = math.max(var_266_45, arg_263_1.talkMaxDuration)

			if var_266_53 <= arg_263_1.time_ and arg_263_1.time_ < var_266_53 + var_266_54 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_53) / var_266_54

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_53 + var_266_54 and arg_263_1.time_ < var_266_53 + var_266_54 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play1104906065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1104906065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1104906066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 1.3

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_2 = arg_271_1:GetWordFromCfg(1104906065)
				local var_274_3 = arg_271_1:FormatText(var_274_2.content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 52
				local var_274_5 = utf8.len(var_274_3)
				local var_274_6 = var_274_4 <= 0 and var_274_1 or var_274_1 * (var_274_5 / var_274_4)

				if var_274_6 > 0 and var_274_1 < var_274_6 then
					arg_271_1.talkMaxDuration = var_274_6

					if var_274_6 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_6 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_7 and arg_271_1.time_ < var_274_0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1104906066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1104906066
		arg_275_1.duration_ = 3.4

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1104906067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1049ui_story"].transform
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.var_.moveOldPos1049ui_story = var_278_0.localPosition
			end

			local var_278_2 = 0.001

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2
				local var_278_4 = Vector3.New(0, -1.2, -6)

				var_278_0.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1049ui_story, var_278_4, var_278_3)

				local var_278_5 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_5.x, var_278_5.y, var_278_5.z)

				local var_278_6 = var_278_0.localEulerAngles

				var_278_6.z = 0
				var_278_6.x = 0
				var_278_0.localEulerAngles = var_278_6
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 then
				var_278_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_278_7 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_7.x, var_278_7.y, var_278_7.z)

				local var_278_8 = var_278_0.localEulerAngles

				var_278_8.z = 0
				var_278_8.x = 0
				var_278_0.localEulerAngles = var_278_8
			end

			local var_278_9 = arg_275_1.actors_["1049ui_story"]
			local var_278_10 = 0

			if var_278_10 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect1049ui_story == nil then
				arg_275_1.var_.characterEffect1049ui_story = var_278_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_11 = 0.200000002980232

			if var_278_10 <= arg_275_1.time_ and arg_275_1.time_ < var_278_10 + var_278_11 and not isNil(var_278_9) then
				local var_278_12 = (arg_275_1.time_ - var_278_10) / var_278_11

				if arg_275_1.var_.characterEffect1049ui_story and not isNil(var_278_9) then
					arg_275_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_10 + var_278_11 and arg_275_1.time_ < var_278_10 + var_278_11 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect1049ui_story then
				arg_275_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_278_13 = 0

			if var_278_13 < arg_275_1.time_ and arg_275_1.time_ <= var_278_13 + arg_278_0 then
				arg_275_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_278_14 = 0

			if var_278_14 < arg_275_1.time_ and arg_275_1.time_ <= var_278_14 + arg_278_0 then
				arg_275_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_278_15 = 0
			local var_278_16 = 0.325

			if var_278_15 < arg_275_1.time_ and arg_275_1.time_ <= var_278_15 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_17 = arg_275_1:FormatText(StoryNameCfg[551].name)

				arg_275_1.leftNameTxt_.text = var_278_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_18 = arg_275_1:GetWordFromCfg(1104906066)
				local var_278_19 = arg_275_1:FormatText(var_278_18.content)

				arg_275_1.text_.text = var_278_19

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_20 = 13
				local var_278_21 = utf8.len(var_278_19)
				local var_278_22 = var_278_20 <= 0 and var_278_16 or var_278_16 * (var_278_21 / var_278_20)

				if var_278_22 > 0 and var_278_16 < var_278_22 then
					arg_275_1.talkMaxDuration = var_278_22

					if var_278_22 + var_278_15 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_22 + var_278_15
					end
				end

				arg_275_1.text_.text = var_278_19
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906066", "story_v_side_new_1104906.awb") ~= 0 then
					local var_278_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906066", "story_v_side_new_1104906.awb") / 1000

					if var_278_23 + var_278_15 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_23 + var_278_15
					end

					if var_278_18.prefab_name ~= "" and arg_275_1.actors_[var_278_18.prefab_name] ~= nil then
						local var_278_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_18.prefab_name].transform, "story_v_side_new_1104906", "1104906066", "story_v_side_new_1104906.awb")

						arg_275_1:RecordAudio("1104906066", var_278_24)
						arg_275_1:RecordAudio("1104906066", var_278_24)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906066", "story_v_side_new_1104906.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906066", "story_v_side_new_1104906.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_25 = math.max(var_278_16, arg_275_1.talkMaxDuration)

			if var_278_15 <= arg_275_1.time_ and arg_275_1.time_ < var_278_15 + var_278_25 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_15) / var_278_25

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_15 + var_278_25 and arg_275_1.time_ < var_278_15 + var_278_25 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play1104906067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1104906067
		arg_279_1.duration_ = 1

		SetActive(arg_279_1.tipsGo_, true)

		arg_279_1.tipsText_.text = StoryTipsCfg[104901].name

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"

			SetActive(arg_279_1.choicesGo_, true)

			for iter_280_0, iter_280_1 in ipairs(arg_279_1.choices_) do
				local var_280_0 = iter_280_0 <= 2

				SetActive(iter_280_1.go, var_280_0)
			end

			arg_279_1.choices_[1].txt.text = arg_279_1:FormatText(StoryChoiceCfg[1187].name)
			arg_279_1.choices_[2].txt.text = arg_279_1:FormatText(StoryChoiceCfg[1188].name)
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1104906068(arg_279_1)
			end

			if arg_281_0 == 2 then
				PlayerAction.UseStoryTrigger(1049014, 210490106, 1104906067, 2)
				arg_279_0:Play1104906069(arg_279_1)
			end

			arg_279_1:RecordChoiceLog(1104906067, 1187, 1188)
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1049ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1049ui_story == nil then
				arg_279_1.var_.characterEffect1049ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect1049ui_story and not isNil(var_282_0) then
					local var_282_4 = Mathf.Lerp(0, 0.5, var_282_3)

					arg_279_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1049ui_story.fillRatio = var_282_4
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1049ui_story then
				local var_282_5 = 0.5

				arg_279_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1049ui_story.fillRatio = var_282_5
			end

			local var_282_6 = 0

			if var_282_6 < arg_279_1.time_ and arg_279_1.time_ <= var_282_6 + arg_282_0 then
				arg_279_1.allBtn_.enabled = false
			end

			local var_282_7 = 0.6

			if arg_279_1.time_ >= var_282_6 + var_282_7 and arg_279_1.time_ < var_282_6 + var_282_7 + arg_282_0 then
				arg_279_1.allBtn_.enabled = true
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1104906068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1104906068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1104906070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 0.775

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_2 = arg_283_1:FormatText(StoryNameCfg[7].name)

				arg_283_1.leftNameTxt_.text = var_286_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:GetWordFromCfg(1104906068)
				local var_286_4 = arg_283_1:FormatText(var_286_3.content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 31
				local var_286_6 = utf8.len(var_286_4)
				local var_286_7 = var_286_5 <= 0 and var_286_1 or var_286_1 * (var_286_6 / var_286_5)

				if var_286_7 > 0 and var_286_1 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_0
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_8 = math.max(var_286_1, arg_283_1.talkMaxDuration)

			if var_286_0 <= arg_283_1.time_ and arg_283_1.time_ < var_286_0 + var_286_8 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_0) / var_286_8

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_0 + var_286_8 and arg_283_1.time_ < var_286_0 + var_286_8 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1104906070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1104906070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1104906071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0
			local var_290_1 = 0.775

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_2 = arg_287_1:GetWordFromCfg(1104906070)
				local var_290_3 = arg_287_1:FormatText(var_290_2.content)

				arg_287_1.text_.text = var_290_3

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 31
				local var_290_5 = utf8.len(var_290_3)
				local var_290_6 = var_290_4 <= 0 and var_290_1 or var_290_1 * (var_290_5 / var_290_4)

				if var_290_6 > 0 and var_290_1 < var_290_6 then
					arg_287_1.talkMaxDuration = var_290_6

					if var_290_6 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_6 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_3
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_7 and arg_287_1.time_ < var_290_0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1104906071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1104906071
		arg_291_1.duration_ = 3.03

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1104906072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1049ui_story"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1049ui_story == nil then
				arg_291_1.var_.characterEffect1049ui_story = var_294_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.characterEffect1049ui_story and not isNil(var_294_0) then
					arg_291_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1049ui_story then
				arg_291_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_294_4 = 0

			if var_294_4 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			local var_294_5 = 0

			if var_294_5 < arg_291_1.time_ and arg_291_1.time_ <= var_294_5 + arg_294_0 then
				arg_291_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_294_6 = 0
			local var_294_7 = 0.325

			if var_294_6 < arg_291_1.time_ and arg_291_1.time_ <= var_294_6 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_8 = arg_291_1:FormatText(StoryNameCfg[551].name)

				arg_291_1.leftNameTxt_.text = var_294_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_9 = arg_291_1:GetWordFromCfg(1104906071)
				local var_294_10 = arg_291_1:FormatText(var_294_9.content)

				arg_291_1.text_.text = var_294_10

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_11 = 13
				local var_294_12 = utf8.len(var_294_10)
				local var_294_13 = var_294_11 <= 0 and var_294_7 or var_294_7 * (var_294_12 / var_294_11)

				if var_294_13 > 0 and var_294_7 < var_294_13 then
					arg_291_1.talkMaxDuration = var_294_13

					if var_294_13 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_13 + var_294_6
					end
				end

				arg_291_1.text_.text = var_294_10
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906071", "story_v_side_new_1104906.awb") ~= 0 then
					local var_294_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906071", "story_v_side_new_1104906.awb") / 1000

					if var_294_14 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_14 + var_294_6
					end

					if var_294_9.prefab_name ~= "" and arg_291_1.actors_[var_294_9.prefab_name] ~= nil then
						local var_294_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_9.prefab_name].transform, "story_v_side_new_1104906", "1104906071", "story_v_side_new_1104906.awb")

						arg_291_1:RecordAudio("1104906071", var_294_15)
						arg_291_1:RecordAudio("1104906071", var_294_15)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906071", "story_v_side_new_1104906.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906071", "story_v_side_new_1104906.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_16 = math.max(var_294_7, arg_291_1.talkMaxDuration)

			if var_294_6 <= arg_291_1.time_ and arg_291_1.time_ < var_294_6 + var_294_16 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_6) / var_294_16

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_6 + var_294_16 and arg_291_1.time_ < var_294_6 + var_294_16 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1104906072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1104906072
		arg_295_1.duration_ = 3.5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1104906073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_298_2 = 0
			local var_298_3 = 0.3

			if var_298_2 < arg_295_1.time_ and arg_295_1.time_ <= var_298_2 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_4 = arg_295_1:FormatText(StoryNameCfg[551].name)

				arg_295_1.leftNameTxt_.text = var_298_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_5 = arg_295_1:GetWordFromCfg(1104906072)
				local var_298_6 = arg_295_1:FormatText(var_298_5.content)

				arg_295_1.text_.text = var_298_6

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_7 = 12
				local var_298_8 = utf8.len(var_298_6)
				local var_298_9 = var_298_7 <= 0 and var_298_3 or var_298_3 * (var_298_8 / var_298_7)

				if var_298_9 > 0 and var_298_3 < var_298_9 then
					arg_295_1.talkMaxDuration = var_298_9

					if var_298_9 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_2
					end
				end

				arg_295_1.text_.text = var_298_6
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906072", "story_v_side_new_1104906.awb") ~= 0 then
					local var_298_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906072", "story_v_side_new_1104906.awb") / 1000

					if var_298_10 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_2
					end

					if var_298_5.prefab_name ~= "" and arg_295_1.actors_[var_298_5.prefab_name] ~= nil then
						local var_298_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_5.prefab_name].transform, "story_v_side_new_1104906", "1104906072", "story_v_side_new_1104906.awb")

						arg_295_1:RecordAudio("1104906072", var_298_11)
						arg_295_1:RecordAudio("1104906072", var_298_11)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906072", "story_v_side_new_1104906.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906072", "story_v_side_new_1104906.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_12 = math.max(var_298_3, arg_295_1.talkMaxDuration)

			if var_298_2 <= arg_295_1.time_ and arg_295_1.time_ < var_298_2 + var_298_12 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_2) / var_298_12

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_2 + var_298_12 and arg_295_1.time_ < var_298_2 + var_298_12 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1104906073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1104906073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1104906074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1049ui_story"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos1049ui_story = var_302_0.localPosition
			end

			local var_302_2 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2
				local var_302_4 = Vector3.New(0, 100, 0)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1049ui_story, var_302_4, var_302_3)

				local var_302_5 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_5.x, var_302_5.y, var_302_5.z)

				local var_302_6 = var_302_0.localEulerAngles

				var_302_6.z = 0
				var_302_6.x = 0
				var_302_0.localEulerAngles = var_302_6
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(0, 100, 0)

				local var_302_7 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_7.x, var_302_7.y, var_302_7.z)

				local var_302_8 = var_302_0.localEulerAngles

				var_302_8.z = 0
				var_302_8.x = 0
				var_302_0.localEulerAngles = var_302_8
			end

			local var_302_9 = arg_299_1.actors_["1049ui_story"]
			local var_302_10 = 0

			if var_302_10 < arg_299_1.time_ and arg_299_1.time_ <= var_302_10 + arg_302_0 and not isNil(var_302_9) and arg_299_1.var_.characterEffect1049ui_story == nil then
				arg_299_1.var_.characterEffect1049ui_story = var_302_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_11 = 0.200000002980232

			if var_302_10 <= arg_299_1.time_ and arg_299_1.time_ < var_302_10 + var_302_11 and not isNil(var_302_9) then
				local var_302_12 = (arg_299_1.time_ - var_302_10) / var_302_11

				if arg_299_1.var_.characterEffect1049ui_story and not isNil(var_302_9) then
					local var_302_13 = Mathf.Lerp(0, 0.5, var_302_12)

					arg_299_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1049ui_story.fillRatio = var_302_13
				end
			end

			if arg_299_1.time_ >= var_302_10 + var_302_11 and arg_299_1.time_ < var_302_10 + var_302_11 + arg_302_0 and not isNil(var_302_9) and arg_299_1.var_.characterEffect1049ui_story then
				local var_302_14 = 0.5

				arg_299_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1049ui_story.fillRatio = var_302_14
			end

			local var_302_15 = 0
			local var_302_16 = 1.675

			if var_302_15 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_17 = arg_299_1:GetWordFromCfg(1104906073)
				local var_302_18 = arg_299_1:FormatText(var_302_17.content)

				arg_299_1.text_.text = var_302_18

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_19 = 67
				local var_302_20 = utf8.len(var_302_18)
				local var_302_21 = var_302_19 <= 0 and var_302_16 or var_302_16 * (var_302_20 / var_302_19)

				if var_302_21 > 0 and var_302_16 < var_302_21 then
					arg_299_1.talkMaxDuration = var_302_21

					if var_302_21 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_21 + var_302_15
					end
				end

				arg_299_1.text_.text = var_302_18
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_22 = math.max(var_302_16, arg_299_1.talkMaxDuration)

			if var_302_15 <= arg_299_1.time_ and arg_299_1.time_ < var_302_15 + var_302_22 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_15) / var_302_22

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_15 + var_302_22 and arg_299_1.time_ < var_302_15 + var_302_22 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play1104906074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1104906074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1104906075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 0.075

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_2 = arg_303_1:FormatText(StoryNameCfg[7].name)

				arg_303_1.leftNameTxt_.text = var_306_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_3 = arg_303_1:GetWordFromCfg(1104906074)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 3
				local var_306_6 = utf8.len(var_306_4)
				local var_306_7 = var_306_5 <= 0 and var_306_1 or var_306_1 * (var_306_6 / var_306_5)

				if var_306_7 > 0 and var_306_1 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_8 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_8 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_8

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_8 and arg_303_1.time_ < var_306_0 + var_306_8 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1104906075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1104906075
		arg_307_1.duration_ = 4.3

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1104906076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1049ui_story"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1049ui_story == nil then
				arg_307_1.var_.characterEffect1049ui_story = var_310_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.characterEffect1049ui_story and not isNil(var_310_0) then
					arg_307_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1049ui_story then
				arg_307_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_310_4 = 0
			local var_310_5 = 0.425

			if var_310_4 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_6 = arg_307_1:FormatText(StoryNameCfg[551].name)

				arg_307_1.leftNameTxt_.text = var_310_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_7 = arg_307_1:GetWordFromCfg(1104906075)
				local var_310_8 = arg_307_1:FormatText(var_310_7.content)

				arg_307_1.text_.text = var_310_8

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_9 = 17
				local var_310_10 = utf8.len(var_310_8)
				local var_310_11 = var_310_9 <= 0 and var_310_5 or var_310_5 * (var_310_10 / var_310_9)

				if var_310_11 > 0 and var_310_5 < var_310_11 then
					arg_307_1.talkMaxDuration = var_310_11

					if var_310_11 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_11 + var_310_4
					end
				end

				arg_307_1.text_.text = var_310_8
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906075", "story_v_side_new_1104906.awb") ~= 0 then
					local var_310_12 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906075", "story_v_side_new_1104906.awb") / 1000

					if var_310_12 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_12 + var_310_4
					end

					if var_310_7.prefab_name ~= "" and arg_307_1.actors_[var_310_7.prefab_name] ~= nil then
						local var_310_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_7.prefab_name].transform, "story_v_side_new_1104906", "1104906075", "story_v_side_new_1104906.awb")

						arg_307_1:RecordAudio("1104906075", var_310_13)
						arg_307_1:RecordAudio("1104906075", var_310_13)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906075", "story_v_side_new_1104906.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906075", "story_v_side_new_1104906.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_14 = math.max(var_310_5, arg_307_1.talkMaxDuration)

			if var_310_4 <= arg_307_1.time_ and arg_307_1.time_ < var_310_4 + var_310_14 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_4) / var_310_14

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_4 + var_310_14 and arg_307_1.time_ < var_310_4 + var_310_14 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1104906076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1104906076
		arg_311_1.duration_ = 6.77

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1104906077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.375

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_2 = arg_311_1:FormatText(StoryNameCfg[551].name)

				arg_311_1.leftNameTxt_.text = var_314_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:GetWordFromCfg(1104906076)
				local var_314_4 = arg_311_1:FormatText(var_314_3.content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 15
				local var_314_6 = utf8.len(var_314_4)
				local var_314_7 = var_314_5 <= 0 and var_314_1 or var_314_1 * (var_314_6 / var_314_5)

				if var_314_7 > 0 and var_314_1 < var_314_7 then
					arg_311_1.talkMaxDuration = var_314_7

					if var_314_7 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_7 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_4
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906076", "story_v_side_new_1104906.awb") ~= 0 then
					local var_314_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906076", "story_v_side_new_1104906.awb") / 1000

					if var_314_8 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_8 + var_314_0
					end

					if var_314_3.prefab_name ~= "" and arg_311_1.actors_[var_314_3.prefab_name] ~= nil then
						local var_314_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_3.prefab_name].transform, "story_v_side_new_1104906", "1104906076", "story_v_side_new_1104906.awb")

						arg_311_1:RecordAudio("1104906076", var_314_9)
						arg_311_1:RecordAudio("1104906076", var_314_9)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906076", "story_v_side_new_1104906.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906076", "story_v_side_new_1104906.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_10 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_10 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_10

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_10 and arg_311_1.time_ < var_314_0 + var_314_10 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1104906077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1104906077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1104906078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1049ui_story"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1049ui_story == nil then
				arg_315_1.var_.characterEffect1049ui_story = var_318_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.characterEffect1049ui_story and not isNil(var_318_0) then
					local var_318_4 = Mathf.Lerp(0, 0.5, var_318_3)

					arg_315_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1049ui_story.fillRatio = var_318_4
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1049ui_story then
				local var_318_5 = 0.5

				arg_315_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1049ui_story.fillRatio = var_318_5
			end

			local var_318_6 = 0
			local var_318_7 = 0.15

			if var_318_6 < arg_315_1.time_ and arg_315_1.time_ <= var_318_6 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_8 = arg_315_1:FormatText(StoryNameCfg[7].name)

				arg_315_1.leftNameTxt_.text = var_318_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_9 = arg_315_1:GetWordFromCfg(1104906077)
				local var_318_10 = arg_315_1:FormatText(var_318_9.content)

				arg_315_1.text_.text = var_318_10

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_11 = 6
				local var_318_12 = utf8.len(var_318_10)
				local var_318_13 = var_318_11 <= 0 and var_318_7 or var_318_7 * (var_318_12 / var_318_11)

				if var_318_13 > 0 and var_318_7 < var_318_13 then
					arg_315_1.talkMaxDuration = var_318_13

					if var_318_13 + var_318_6 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_13 + var_318_6
					end
				end

				arg_315_1.text_.text = var_318_10
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_14 = math.max(var_318_7, arg_315_1.talkMaxDuration)

			if var_318_6 <= arg_315_1.time_ and arg_315_1.time_ < var_318_6 + var_318_14 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_6) / var_318_14

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_6 + var_318_14 and arg_315_1.time_ < var_318_6 + var_318_14 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1104906078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1104906078
		arg_319_1.duration_ = 6.93

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1104906079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1049ui_story"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1049ui_story == nil then
				arg_319_1.var_.characterEffect1049ui_story = var_322_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.characterEffect1049ui_story and not isNil(var_322_0) then
					arg_319_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1049ui_story then
				arg_319_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_322_4 = 0
			local var_322_5 = 0.5

			if var_322_4 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_6 = arg_319_1:FormatText(StoryNameCfg[551].name)

				arg_319_1.leftNameTxt_.text = var_322_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_7 = arg_319_1:GetWordFromCfg(1104906078)
				local var_322_8 = arg_319_1:FormatText(var_322_7.content)

				arg_319_1.text_.text = var_322_8

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_9 = 20
				local var_322_10 = utf8.len(var_322_8)
				local var_322_11 = var_322_9 <= 0 and var_322_5 or var_322_5 * (var_322_10 / var_322_9)

				if var_322_11 > 0 and var_322_5 < var_322_11 then
					arg_319_1.talkMaxDuration = var_322_11

					if var_322_11 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_11 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_8
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906078", "story_v_side_new_1104906.awb") ~= 0 then
					local var_322_12 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906078", "story_v_side_new_1104906.awb") / 1000

					if var_322_12 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_12 + var_322_4
					end

					if var_322_7.prefab_name ~= "" and arg_319_1.actors_[var_322_7.prefab_name] ~= nil then
						local var_322_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_7.prefab_name].transform, "story_v_side_new_1104906", "1104906078", "story_v_side_new_1104906.awb")

						arg_319_1:RecordAudio("1104906078", var_322_13)
						arg_319_1:RecordAudio("1104906078", var_322_13)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906078", "story_v_side_new_1104906.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906078", "story_v_side_new_1104906.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_14 = math.max(var_322_5, arg_319_1.talkMaxDuration)

			if var_322_4 <= arg_319_1.time_ and arg_319_1.time_ < var_322_4 + var_322_14 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_4) / var_322_14

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_4 + var_322_14 and arg_319_1.time_ < var_322_4 + var_322_14 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1104906079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1104906079
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1104906080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1049ui_story"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1049ui_story == nil then
				arg_323_1.var_.characterEffect1049ui_story = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect1049ui_story and not isNil(var_326_0) then
					local var_326_4 = Mathf.Lerp(0, 0.5, var_326_3)

					arg_323_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1049ui_story.fillRatio = var_326_4
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1049ui_story then
				local var_326_5 = 0.5

				arg_323_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1049ui_story.fillRatio = var_326_5
			end

			local var_326_6 = 0
			local var_326_7 = 0.925

			if var_326_6 < arg_323_1.time_ and arg_323_1.time_ <= var_326_6 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_8 = arg_323_1:GetWordFromCfg(1104906079)
				local var_326_9 = arg_323_1:FormatText(var_326_8.content)

				arg_323_1.text_.text = var_326_9

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_10 = 37
				local var_326_11 = utf8.len(var_326_9)
				local var_326_12 = var_326_10 <= 0 and var_326_7 or var_326_7 * (var_326_11 / var_326_10)

				if var_326_12 > 0 and var_326_7 < var_326_12 then
					arg_323_1.talkMaxDuration = var_326_12

					if var_326_12 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_12 + var_326_6
					end
				end

				arg_323_1.text_.text = var_326_9
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_13 = math.max(var_326_7, arg_323_1.talkMaxDuration)

			if var_326_6 <= arg_323_1.time_ and arg_323_1.time_ < var_326_6 + var_326_13 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_6) / var_326_13

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_6 + var_326_13 and arg_323_1.time_ < var_326_6 + var_326_13 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play1104906080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1104906080
		arg_327_1.duration_ = 9.2

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1104906081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1049ui_story"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1049ui_story == nil then
				arg_327_1.var_.characterEffect1049ui_story = var_330_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.characterEffect1049ui_story and not isNil(var_330_0) then
					arg_327_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1049ui_story then
				arg_327_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_330_4 = 0
			local var_330_5 = 0.6

			if var_330_4 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_6 = arg_327_1:FormatText(StoryNameCfg[551].name)

				arg_327_1.leftNameTxt_.text = var_330_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_7 = arg_327_1:GetWordFromCfg(1104906080)
				local var_330_8 = arg_327_1:FormatText(var_330_7.content)

				arg_327_1.text_.text = var_330_8

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_9 = 24
				local var_330_10 = utf8.len(var_330_8)
				local var_330_11 = var_330_9 <= 0 and var_330_5 or var_330_5 * (var_330_10 / var_330_9)

				if var_330_11 > 0 and var_330_5 < var_330_11 then
					arg_327_1.talkMaxDuration = var_330_11

					if var_330_11 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_11 + var_330_4
					end
				end

				arg_327_1.text_.text = var_330_8
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906080", "story_v_side_new_1104906.awb") ~= 0 then
					local var_330_12 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906080", "story_v_side_new_1104906.awb") / 1000

					if var_330_12 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_12 + var_330_4
					end

					if var_330_7.prefab_name ~= "" and arg_327_1.actors_[var_330_7.prefab_name] ~= nil then
						local var_330_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_7.prefab_name].transform, "story_v_side_new_1104906", "1104906080", "story_v_side_new_1104906.awb")

						arg_327_1:RecordAudio("1104906080", var_330_13)
						arg_327_1:RecordAudio("1104906080", var_330_13)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906080", "story_v_side_new_1104906.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906080", "story_v_side_new_1104906.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_14 = math.max(var_330_5, arg_327_1.talkMaxDuration)

			if var_330_4 <= arg_327_1.time_ and arg_327_1.time_ < var_330_4 + var_330_14 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_4) / var_330_14

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_4 + var_330_14 and arg_327_1.time_ < var_330_4 + var_330_14 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1104906081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1104906081
		arg_331_1.duration_ = 7.03

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1104906082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0
			local var_334_1 = 0.725

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_2 = arg_331_1:FormatText(StoryNameCfg[551].name)

				arg_331_1.leftNameTxt_.text = var_334_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_3 = arg_331_1:GetWordFromCfg(1104906081)
				local var_334_4 = arg_331_1:FormatText(var_334_3.content)

				arg_331_1.text_.text = var_334_4

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 29
				local var_334_6 = utf8.len(var_334_4)
				local var_334_7 = var_334_5 <= 0 and var_334_1 or var_334_1 * (var_334_6 / var_334_5)

				if var_334_7 > 0 and var_334_1 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_4
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906081", "story_v_side_new_1104906.awb") ~= 0 then
					local var_334_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906081", "story_v_side_new_1104906.awb") / 1000

					if var_334_8 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_8 + var_334_0
					end

					if var_334_3.prefab_name ~= "" and arg_331_1.actors_[var_334_3.prefab_name] ~= nil then
						local var_334_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_3.prefab_name].transform, "story_v_side_new_1104906", "1104906081", "story_v_side_new_1104906.awb")

						arg_331_1:RecordAudio("1104906081", var_334_9)
						arg_331_1:RecordAudio("1104906081", var_334_9)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906081", "story_v_side_new_1104906.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906081", "story_v_side_new_1104906.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_10 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_10 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_10

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_10 and arg_331_1.time_ < var_334_0 + var_334_10 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1104906082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1104906082
		arg_335_1.duration_ = 1

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"

			SetActive(arg_335_1.choicesGo_, true)

			for iter_336_0, iter_336_1 in ipairs(arg_335_1.choices_) do
				local var_336_0 = iter_336_0 <= 1

				SetActive(iter_336_1.go, var_336_0)
			end

			arg_335_1.choices_[1].txt.text = arg_335_1:FormatText(StoryChoiceCfg[1189].name)
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1104906083(arg_335_1)
			end

			arg_335_1:RecordChoiceLog(1104906082, 1189)
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1049ui_story"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1049ui_story == nil then
				arg_335_1.var_.characterEffect1049ui_story = var_338_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.200000002980232

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.characterEffect1049ui_story and not isNil(var_338_0) then
					local var_338_4 = Mathf.Lerp(0, 0.5, var_338_3)

					arg_335_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1049ui_story.fillRatio = var_338_4
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1049ui_story then
				local var_338_5 = 0.5

				arg_335_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1049ui_story.fillRatio = var_338_5
			end

			local var_338_6 = 0

			if var_338_6 < arg_335_1.time_ and arg_335_1.time_ <= var_338_6 + arg_338_0 then
				arg_335_1.allBtn_.enabled = false
			end

			local var_338_7 = 0.6

			if arg_335_1.time_ >= var_338_6 + var_338_7 and arg_335_1.time_ < var_338_6 + var_338_7 + arg_338_0 then
				arg_335_1.allBtn_.enabled = true
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play1104906083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1104906083
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1104906084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0
			local var_342_1 = 0.5

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_2 = arg_339_1:FormatText(StoryNameCfg[7].name)

				arg_339_1.leftNameTxt_.text = var_342_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_3 = arg_339_1:GetWordFromCfg(1104906083)
				local var_342_4 = arg_339_1:FormatText(var_342_3.content)

				arg_339_1.text_.text = var_342_4

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 20
				local var_342_6 = utf8.len(var_342_4)
				local var_342_7 = var_342_5 <= 0 and var_342_1 or var_342_1 * (var_342_6 / var_342_5)

				if var_342_7 > 0 and var_342_1 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_0
					end
				end

				arg_339_1.text_.text = var_342_4
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_8 = math.max(var_342_1, arg_339_1.talkMaxDuration)

			if var_342_0 <= arg_339_1.time_ and arg_339_1.time_ < var_342_0 + var_342_8 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_0) / var_342_8

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_0 + var_342_8 and arg_339_1.time_ < var_342_0 + var_342_8 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1104906084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1104906084
		arg_343_1.duration_ = 1.77

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1104906085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1049ui_story"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect1049ui_story == nil then
				arg_343_1.var_.characterEffect1049ui_story = var_346_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.200000002980232

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.characterEffect1049ui_story and not isNil(var_346_0) then
					arg_343_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect1049ui_story then
				arg_343_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_346_4 = 0
			local var_346_5 = 0.225

			if var_346_4 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_6 = arg_343_1:FormatText(StoryNameCfg[551].name)

				arg_343_1.leftNameTxt_.text = var_346_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_7 = arg_343_1:GetWordFromCfg(1104906084)
				local var_346_8 = arg_343_1:FormatText(var_346_7.content)

				arg_343_1.text_.text = var_346_8

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_9 = 9
				local var_346_10 = utf8.len(var_346_8)
				local var_346_11 = var_346_9 <= 0 and var_346_5 or var_346_5 * (var_346_10 / var_346_9)

				if var_346_11 > 0 and var_346_5 < var_346_11 then
					arg_343_1.talkMaxDuration = var_346_11

					if var_346_11 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_11 + var_346_4
					end
				end

				arg_343_1.text_.text = var_346_8
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906084", "story_v_side_new_1104906.awb") ~= 0 then
					local var_346_12 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906084", "story_v_side_new_1104906.awb") / 1000

					if var_346_12 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_12 + var_346_4
					end

					if var_346_7.prefab_name ~= "" and arg_343_1.actors_[var_346_7.prefab_name] ~= nil then
						local var_346_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_7.prefab_name].transform, "story_v_side_new_1104906", "1104906084", "story_v_side_new_1104906.awb")

						arg_343_1:RecordAudio("1104906084", var_346_13)
						arg_343_1:RecordAudio("1104906084", var_346_13)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906084", "story_v_side_new_1104906.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906084", "story_v_side_new_1104906.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_14 = math.max(var_346_5, arg_343_1.talkMaxDuration)

			if var_346_4 <= arg_343_1.time_ and arg_343_1.time_ < var_346_4 + var_346_14 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_4) / var_346_14

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_4 + var_346_14 and arg_343_1.time_ < var_346_4 + var_346_14 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1104906085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1104906085
		arg_347_1.duration_ = 9.3

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1104906086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0
			local var_350_1 = 0.725

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_2 = arg_347_1:FormatText(StoryNameCfg[551].name)

				arg_347_1.leftNameTxt_.text = var_350_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_3 = arg_347_1:GetWordFromCfg(1104906085)
				local var_350_4 = arg_347_1:FormatText(var_350_3.content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 29
				local var_350_6 = utf8.len(var_350_4)
				local var_350_7 = var_350_5 <= 0 and var_350_1 or var_350_1 * (var_350_6 / var_350_5)

				if var_350_7 > 0 and var_350_1 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_0
					end
				end

				arg_347_1.text_.text = var_350_4
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906085", "story_v_side_new_1104906.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906085", "story_v_side_new_1104906.awb") / 1000

					if var_350_8 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_0
					end

					if var_350_3.prefab_name ~= "" and arg_347_1.actors_[var_350_3.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_3.prefab_name].transform, "story_v_side_new_1104906", "1104906085", "story_v_side_new_1104906.awb")

						arg_347_1:RecordAudio("1104906085", var_350_9)
						arg_347_1:RecordAudio("1104906085", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906085", "story_v_side_new_1104906.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906085", "story_v_side_new_1104906.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_1, arg_347_1.talkMaxDuration)

			if var_350_0 <= arg_347_1.time_ and arg_347_1.time_ < var_350_0 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_0) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_0 + var_350_10 and arg_347_1.time_ < var_350_0 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1104906086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1104906086
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1104906087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1049ui_story"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1049ui_story == nil then
				arg_351_1.var_.characterEffect1049ui_story = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.characterEffect1049ui_story and not isNil(var_354_0) then
					local var_354_4 = Mathf.Lerp(0, 0.5, var_354_3)

					arg_351_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1049ui_story.fillRatio = var_354_4
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1049ui_story then
				local var_354_5 = 0.5

				arg_351_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1049ui_story.fillRatio = var_354_5
			end

			local var_354_6 = 0
			local var_354_7 = 0.25

			if var_354_6 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_8 = arg_351_1:FormatText(StoryNameCfg[7].name)

				arg_351_1.leftNameTxt_.text = var_354_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_9 = arg_351_1:GetWordFromCfg(1104906086)
				local var_354_10 = arg_351_1:FormatText(var_354_9.content)

				arg_351_1.text_.text = var_354_10

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_11 = 10
				local var_354_12 = utf8.len(var_354_10)
				local var_354_13 = var_354_11 <= 0 and var_354_7 or var_354_7 * (var_354_12 / var_354_11)

				if var_354_13 > 0 and var_354_7 < var_354_13 then
					arg_351_1.talkMaxDuration = var_354_13

					if var_354_13 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_13 + var_354_6
					end
				end

				arg_351_1.text_.text = var_354_10
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_14 = math.max(var_354_7, arg_351_1.talkMaxDuration)

			if var_354_6 <= arg_351_1.time_ and arg_351_1.time_ < var_354_6 + var_354_14 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_6) / var_354_14

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_6 + var_354_14 and arg_351_1.time_ < var_354_6 + var_354_14 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1104906087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1104906087
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1104906088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0
			local var_358_1 = 0.25

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_2 = arg_355_1:FormatText(StoryNameCfg[7].name)

				arg_355_1.leftNameTxt_.text = var_358_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_3 = arg_355_1:GetWordFromCfg(1104906087)
				local var_358_4 = arg_355_1:FormatText(var_358_3.content)

				arg_355_1.text_.text = var_358_4

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 10
				local var_358_6 = utf8.len(var_358_4)
				local var_358_7 = var_358_5 <= 0 and var_358_1 or var_358_1 * (var_358_6 / var_358_5)

				if var_358_7 > 0 and var_358_1 < var_358_7 then
					arg_355_1.talkMaxDuration = var_358_7

					if var_358_7 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_7 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_4
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_8 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_8 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_8

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_8 and arg_355_1.time_ < var_358_0 + var_358_8 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1104906088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1104906088
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1104906089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0
			local var_362_1 = 1.075

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_2 = arg_359_1:GetWordFromCfg(1104906088)
				local var_362_3 = arg_359_1:FormatText(var_362_2.content)

				arg_359_1.text_.text = var_362_3

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 43
				local var_362_5 = utf8.len(var_362_3)
				local var_362_6 = var_362_4 <= 0 and var_362_1 or var_362_1 * (var_362_5 / var_362_4)

				if var_362_6 > 0 and var_362_1 < var_362_6 then
					arg_359_1.talkMaxDuration = var_362_6

					if var_362_6 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_6 + var_362_0
					end
				end

				arg_359_1.text_.text = var_362_3
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_7 = math.max(var_362_1, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_7 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_0) / var_362_7

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_7 and arg_359_1.time_ < var_362_0 + var_362_7 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1104906089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1104906089
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1104906090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 1.025

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_2 = arg_363_1:FormatText(StoryNameCfg[7].name)

				arg_363_1.leftNameTxt_.text = var_366_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:GetWordFromCfg(1104906089)
				local var_366_4 = arg_363_1:FormatText(var_366_3.content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 41
				local var_366_6 = utf8.len(var_366_4)
				local var_366_7 = var_366_5 <= 0 and var_366_1 or var_366_1 * (var_366_6 / var_366_5)

				if var_366_7 > 0 and var_366_1 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_8 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_8 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_8

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_8 and arg_363_1.time_ < var_366_0 + var_366_8 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1104906090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1104906090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1104906091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 0.625

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_2 = arg_367_1:FormatText(StoryNameCfg[7].name)

				arg_367_1.leftNameTxt_.text = var_370_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:GetWordFromCfg(1104906090)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 25
				local var_370_6 = utf8.len(var_370_4)
				local var_370_7 = var_370_5 <= 0 and var_370_1 or var_370_1 * (var_370_6 / var_370_5)

				if var_370_7 > 0 and var_370_1 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_4
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_8 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_8 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_8

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_8 and arg_367_1.time_ < var_370_0 + var_370_8 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1104906091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1104906091
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1104906092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0
			local var_374_1 = 0.525

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_2 = arg_371_1:FormatText(StoryNameCfg[7].name)

				arg_371_1.leftNameTxt_.text = var_374_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_3 = arg_371_1:GetWordFromCfg(1104906091)
				local var_374_4 = arg_371_1:FormatText(var_374_3.content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 26
				local var_374_6 = utf8.len(var_374_4)
				local var_374_7 = var_374_5 <= 0 and var_374_1 or var_374_1 * (var_374_6 / var_374_5)

				if var_374_7 > 0 and var_374_1 < var_374_7 then
					arg_371_1.talkMaxDuration = var_374_7

					if var_374_7 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_0
					end
				end

				arg_371_1.text_.text = var_374_4
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_8 = math.max(var_374_1, arg_371_1.talkMaxDuration)

			if var_374_0 <= arg_371_1.time_ and arg_371_1.time_ < var_374_0 + var_374_8 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_0) / var_374_8

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_0 + var_374_8 and arg_371_1.time_ < var_374_0 + var_374_8 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1104906092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1104906092
		arg_375_1.duration_ = 4.77

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1104906093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1049ui_story"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos1049ui_story = var_378_0.localPosition
			end

			local var_378_2 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2
				local var_378_4 = Vector3.New(0, -1.2, -6)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1049ui_story, var_378_4, var_378_3)

				local var_378_5 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_5.x, var_378_5.y, var_378_5.z)

				local var_378_6 = var_378_0.localEulerAngles

				var_378_6.z = 0
				var_378_6.x = 0
				var_378_0.localEulerAngles = var_378_6
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_378_7 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_7.x, var_378_7.y, var_378_7.z)

				local var_378_8 = var_378_0.localEulerAngles

				var_378_8.z = 0
				var_378_8.x = 0
				var_378_0.localEulerAngles = var_378_8
			end

			local var_378_9 = arg_375_1.actors_["1049ui_story"]
			local var_378_10 = 0

			if var_378_10 < arg_375_1.time_ and arg_375_1.time_ <= var_378_10 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect1049ui_story == nil then
				arg_375_1.var_.characterEffect1049ui_story = var_378_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_11 = 0.200000002980232

			if var_378_10 <= arg_375_1.time_ and arg_375_1.time_ < var_378_10 + var_378_11 and not isNil(var_378_9) then
				local var_378_12 = (arg_375_1.time_ - var_378_10) / var_378_11

				if arg_375_1.var_.characterEffect1049ui_story and not isNil(var_378_9) then
					arg_375_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= var_378_10 + var_378_11 and arg_375_1.time_ < var_378_10 + var_378_11 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect1049ui_story then
				arg_375_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_378_13 = 0

			if var_378_13 < arg_375_1.time_ and arg_375_1.time_ <= var_378_13 + arg_378_0 then
				arg_375_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_378_14 = 0

			if var_378_14 < arg_375_1.time_ and arg_375_1.time_ <= var_378_14 + arg_378_0 then
				arg_375_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_378_15 = 0
			local var_378_16 = 0.35

			if var_378_15 < arg_375_1.time_ and arg_375_1.time_ <= var_378_15 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_17 = arg_375_1:FormatText(StoryNameCfg[551].name)

				arg_375_1.leftNameTxt_.text = var_378_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_18 = arg_375_1:GetWordFromCfg(1104906092)
				local var_378_19 = arg_375_1:FormatText(var_378_18.content)

				arg_375_1.text_.text = var_378_19

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_20 = 14
				local var_378_21 = utf8.len(var_378_19)
				local var_378_22 = var_378_20 <= 0 and var_378_16 or var_378_16 * (var_378_21 / var_378_20)

				if var_378_22 > 0 and var_378_16 < var_378_22 then
					arg_375_1.talkMaxDuration = var_378_22

					if var_378_22 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_22 + var_378_15
					end
				end

				arg_375_1.text_.text = var_378_19
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906092", "story_v_side_new_1104906.awb") ~= 0 then
					local var_378_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906092", "story_v_side_new_1104906.awb") / 1000

					if var_378_23 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_23 + var_378_15
					end

					if var_378_18.prefab_name ~= "" and arg_375_1.actors_[var_378_18.prefab_name] ~= nil then
						local var_378_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_18.prefab_name].transform, "story_v_side_new_1104906", "1104906092", "story_v_side_new_1104906.awb")

						arg_375_1:RecordAudio("1104906092", var_378_24)
						arg_375_1:RecordAudio("1104906092", var_378_24)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906092", "story_v_side_new_1104906.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906092", "story_v_side_new_1104906.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_25 = math.max(var_378_16, arg_375_1.talkMaxDuration)

			if var_378_15 <= arg_375_1.time_ and arg_375_1.time_ < var_378_15 + var_378_25 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_15) / var_378_25

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_15 + var_378_25 and arg_375_1.time_ < var_378_15 + var_378_25 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play1104906093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1104906093
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1104906094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1049ui_story"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1049ui_story == nil then
				arg_379_1.var_.characterEffect1049ui_story = var_382_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.characterEffect1049ui_story and not isNil(var_382_0) then
					local var_382_4 = Mathf.Lerp(0, 0.5, var_382_3)

					arg_379_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1049ui_story.fillRatio = var_382_4
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1049ui_story then
				local var_382_5 = 0.5

				arg_379_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1049ui_story.fillRatio = var_382_5
			end

			local var_382_6 = 0
			local var_382_7 = 0.925

			if var_382_6 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_8 = arg_379_1:GetWordFromCfg(1104906093)
				local var_382_9 = arg_379_1:FormatText(var_382_8.content)

				arg_379_1.text_.text = var_382_9

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_10 = 37
				local var_382_11 = utf8.len(var_382_9)
				local var_382_12 = var_382_10 <= 0 and var_382_7 or var_382_7 * (var_382_11 / var_382_10)

				if var_382_12 > 0 and var_382_7 < var_382_12 then
					arg_379_1.talkMaxDuration = var_382_12

					if var_382_12 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_12 + var_382_6
					end
				end

				arg_379_1.text_.text = var_382_9
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_13 = math.max(var_382_7, arg_379_1.talkMaxDuration)

			if var_382_6 <= arg_379_1.time_ and arg_379_1.time_ < var_382_6 + var_382_13 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_6) / var_382_13

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_6 + var_382_13 and arg_379_1.time_ < var_382_6 + var_382_13 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1104906094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1104906094
		arg_383_1.duration_ = 2.37

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1104906095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1049ui_story"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1049ui_story == nil then
				arg_383_1.var_.characterEffect1049ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.characterEffect1049ui_story and not isNil(var_386_0) then
					arg_383_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1049ui_story then
				arg_383_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_386_4 = 0

			if var_386_4 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_386_5 = 0

			if var_386_5 < arg_383_1.time_ and arg_383_1.time_ <= var_386_5 + arg_386_0 then
				arg_383_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_386_6 = 0
			local var_386_7 = 0.2

			if var_386_6 < arg_383_1.time_ and arg_383_1.time_ <= var_386_6 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_8 = arg_383_1:FormatText(StoryNameCfg[551].name)

				arg_383_1.leftNameTxt_.text = var_386_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_9 = arg_383_1:GetWordFromCfg(1104906094)
				local var_386_10 = arg_383_1:FormatText(var_386_9.content)

				arg_383_1.text_.text = var_386_10

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_11 = 8
				local var_386_12 = utf8.len(var_386_10)
				local var_386_13 = var_386_11 <= 0 and var_386_7 or var_386_7 * (var_386_12 / var_386_11)

				if var_386_13 > 0 and var_386_7 < var_386_13 then
					arg_383_1.talkMaxDuration = var_386_13

					if var_386_13 + var_386_6 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_13 + var_386_6
					end
				end

				arg_383_1.text_.text = var_386_10
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906094", "story_v_side_new_1104906.awb") ~= 0 then
					local var_386_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906094", "story_v_side_new_1104906.awb") / 1000

					if var_386_14 + var_386_6 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_14 + var_386_6
					end

					if var_386_9.prefab_name ~= "" and arg_383_1.actors_[var_386_9.prefab_name] ~= nil then
						local var_386_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_9.prefab_name].transform, "story_v_side_new_1104906", "1104906094", "story_v_side_new_1104906.awb")

						arg_383_1:RecordAudio("1104906094", var_386_15)
						arg_383_1:RecordAudio("1104906094", var_386_15)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906094", "story_v_side_new_1104906.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906094", "story_v_side_new_1104906.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_16 = math.max(var_386_7, arg_383_1.talkMaxDuration)

			if var_386_6 <= arg_383_1.time_ and arg_383_1.time_ < var_386_6 + var_386_16 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_6) / var_386_16

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_6 + var_386_16 and arg_383_1.time_ < var_386_6 + var_386_16 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1104906095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1104906095
		arg_387_1.duration_ = 2.57

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1104906096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_390_2 = 0
			local var_390_3 = 0.375

			if var_390_2 < arg_387_1.time_ and arg_387_1.time_ <= var_390_2 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_4 = arg_387_1:FormatText(StoryNameCfg[551].name)

				arg_387_1.leftNameTxt_.text = var_390_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_5 = arg_387_1:GetWordFromCfg(1104906095)
				local var_390_6 = arg_387_1:FormatText(var_390_5.content)

				arg_387_1.text_.text = var_390_6

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_7 = 15
				local var_390_8 = utf8.len(var_390_6)
				local var_390_9 = var_390_7 <= 0 and var_390_3 or var_390_3 * (var_390_8 / var_390_7)

				if var_390_9 > 0 and var_390_3 < var_390_9 then
					arg_387_1.talkMaxDuration = var_390_9

					if var_390_9 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_9 + var_390_2
					end
				end

				arg_387_1.text_.text = var_390_6
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906095", "story_v_side_new_1104906.awb") ~= 0 then
					local var_390_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906095", "story_v_side_new_1104906.awb") / 1000

					if var_390_10 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_10 + var_390_2
					end

					if var_390_5.prefab_name ~= "" and arg_387_1.actors_[var_390_5.prefab_name] ~= nil then
						local var_390_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_5.prefab_name].transform, "story_v_side_new_1104906", "1104906095", "story_v_side_new_1104906.awb")

						arg_387_1:RecordAudio("1104906095", var_390_11)
						arg_387_1:RecordAudio("1104906095", var_390_11)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906095", "story_v_side_new_1104906.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906095", "story_v_side_new_1104906.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_12 = math.max(var_390_3, arg_387_1.talkMaxDuration)

			if var_390_2 <= arg_387_1.time_ and arg_387_1.time_ < var_390_2 + var_390_12 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_2) / var_390_12

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_2 + var_390_12 and arg_387_1.time_ < var_390_2 + var_390_12 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1104906096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1104906096
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1104906097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1049ui_story"]
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1049ui_story == nil then
				arg_391_1.var_.characterEffect1049ui_story = var_394_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.200000002980232

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 and not isNil(var_394_0) then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2

				if arg_391_1.var_.characterEffect1049ui_story and not isNil(var_394_0) then
					local var_394_4 = Mathf.Lerp(0, 0.5, var_394_3)

					arg_391_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1049ui_story.fillRatio = var_394_4
				end
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1049ui_story then
				local var_394_5 = 0.5

				arg_391_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1049ui_story.fillRatio = var_394_5
			end

			local var_394_6 = 0
			local var_394_7 = 0.125

			if var_394_6 < arg_391_1.time_ and arg_391_1.time_ <= var_394_6 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_8 = arg_391_1:FormatText(StoryNameCfg[7].name)

				arg_391_1.leftNameTxt_.text = var_394_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_9 = arg_391_1:GetWordFromCfg(1104906096)
				local var_394_10 = arg_391_1:FormatText(var_394_9.content)

				arg_391_1.text_.text = var_394_10

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_11 = 5
				local var_394_12 = utf8.len(var_394_10)
				local var_394_13 = var_394_11 <= 0 and var_394_7 or var_394_7 * (var_394_12 / var_394_11)

				if var_394_13 > 0 and var_394_7 < var_394_13 then
					arg_391_1.talkMaxDuration = var_394_13

					if var_394_13 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_13 + var_394_6
					end
				end

				arg_391_1.text_.text = var_394_10
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_14 = math.max(var_394_7, arg_391_1.talkMaxDuration)

			if var_394_6 <= arg_391_1.time_ and arg_391_1.time_ < var_394_6 + var_394_14 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_6) / var_394_14

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_6 + var_394_14 and arg_391_1.time_ < var_394_6 + var_394_14 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1104906097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1104906097
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1104906098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0
			local var_398_1 = 0.55

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_2 = arg_395_1:FormatText(StoryNameCfg[7].name)

				arg_395_1.leftNameTxt_.text = var_398_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_3 = arg_395_1:GetWordFromCfg(1104906097)
				local var_398_4 = arg_395_1:FormatText(var_398_3.content)

				arg_395_1.text_.text = var_398_4

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_5 = 22
				local var_398_6 = utf8.len(var_398_4)
				local var_398_7 = var_398_5 <= 0 and var_398_1 or var_398_1 * (var_398_6 / var_398_5)

				if var_398_7 > 0 and var_398_1 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_0
					end
				end

				arg_395_1.text_.text = var_398_4
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_8 = math.max(var_398_1, arg_395_1.talkMaxDuration)

			if var_398_0 <= arg_395_1.time_ and arg_395_1.time_ < var_398_0 + var_398_8 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_0) / var_398_8

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_0 + var_398_8 and arg_395_1.time_ < var_398_0 + var_398_8 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1104906098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1104906098
		arg_399_1.duration_ = 4.2

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1104906099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1049ui_story"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1049ui_story == nil then
				arg_399_1.var_.characterEffect1049ui_story = var_402_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.200000002980232

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.characterEffect1049ui_story and not isNil(var_402_0) then
					arg_399_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1049ui_story then
				arg_399_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_402_4 = 0

			if var_402_4 < arg_399_1.time_ and arg_399_1.time_ <= var_402_4 + arg_402_0 then
				arg_399_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_402_5 = 0

			if var_402_5 < arg_399_1.time_ and arg_399_1.time_ <= var_402_5 + arg_402_0 then
				arg_399_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_402_6 = 0
			local var_402_7 = 0.375

			if var_402_6 < arg_399_1.time_ and arg_399_1.time_ <= var_402_6 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_8 = arg_399_1:FormatText(StoryNameCfg[551].name)

				arg_399_1.leftNameTxt_.text = var_402_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_9 = arg_399_1:GetWordFromCfg(1104906098)
				local var_402_10 = arg_399_1:FormatText(var_402_9.content)

				arg_399_1.text_.text = var_402_10

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_11 = 15
				local var_402_12 = utf8.len(var_402_10)
				local var_402_13 = var_402_11 <= 0 and var_402_7 or var_402_7 * (var_402_12 / var_402_11)

				if var_402_13 > 0 and var_402_7 < var_402_13 then
					arg_399_1.talkMaxDuration = var_402_13

					if var_402_13 + var_402_6 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_13 + var_402_6
					end
				end

				arg_399_1.text_.text = var_402_10
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906098", "story_v_side_new_1104906.awb") ~= 0 then
					local var_402_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906098", "story_v_side_new_1104906.awb") / 1000

					if var_402_14 + var_402_6 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_14 + var_402_6
					end

					if var_402_9.prefab_name ~= "" and arg_399_1.actors_[var_402_9.prefab_name] ~= nil then
						local var_402_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_9.prefab_name].transform, "story_v_side_new_1104906", "1104906098", "story_v_side_new_1104906.awb")

						arg_399_1:RecordAudio("1104906098", var_402_15)
						arg_399_1:RecordAudio("1104906098", var_402_15)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906098", "story_v_side_new_1104906.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906098", "story_v_side_new_1104906.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_16 = math.max(var_402_7, arg_399_1.talkMaxDuration)

			if var_402_6 <= arg_399_1.time_ and arg_399_1.time_ < var_402_6 + var_402_16 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_6) / var_402_16

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_6 + var_402_16 and arg_399_1.time_ < var_402_6 + var_402_16 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1104906099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1104906099
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1104906100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["1049ui_story"]
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect1049ui_story == nil then
				arg_403_1.var_.characterEffect1049ui_story = var_406_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 and not isNil(var_406_0) then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2

				if arg_403_1.var_.characterEffect1049ui_story and not isNil(var_406_0) then
					local var_406_4 = Mathf.Lerp(0, 0.5, var_406_3)

					arg_403_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1049ui_story.fillRatio = var_406_4
				end
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect1049ui_story then
				local var_406_5 = 0.5

				arg_403_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1049ui_story.fillRatio = var_406_5
			end

			local var_406_6 = 0
			local var_406_7 = 0.325

			if var_406_6 < arg_403_1.time_ and arg_403_1.time_ <= var_406_6 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_8 = arg_403_1:FormatText(StoryNameCfg[7].name)

				arg_403_1.leftNameTxt_.text = var_406_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_9 = arg_403_1:GetWordFromCfg(1104906099)
				local var_406_10 = arg_403_1:FormatText(var_406_9.content)

				arg_403_1.text_.text = var_406_10

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_11 = 13
				local var_406_12 = utf8.len(var_406_10)
				local var_406_13 = var_406_11 <= 0 and var_406_7 or var_406_7 * (var_406_12 / var_406_11)

				if var_406_13 > 0 and var_406_7 < var_406_13 then
					arg_403_1.talkMaxDuration = var_406_13

					if var_406_13 + var_406_6 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_13 + var_406_6
					end
				end

				arg_403_1.text_.text = var_406_10
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_14 = math.max(var_406_7, arg_403_1.talkMaxDuration)

			if var_406_6 <= arg_403_1.time_ and arg_403_1.time_ < var_406_6 + var_406_14 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_6) / var_406_14

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_6 + var_406_14 and arg_403_1.time_ < var_406_6 + var_406_14 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1104906100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1104906100
		arg_407_1.duration_ = 4.47

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1104906101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1049ui_story"]
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1049ui_story == nil then
				arg_407_1.var_.characterEffect1049ui_story = var_410_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.200000002980232

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 and not isNil(var_410_0) then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2

				if arg_407_1.var_.characterEffect1049ui_story and not isNil(var_410_0) then
					arg_407_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1049ui_story then
				arg_407_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_410_4 = 0

			if var_410_4 < arg_407_1.time_ and arg_407_1.time_ <= var_410_4 + arg_410_0 then
				arg_407_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action6_1")
			end

			local var_410_5 = 0

			if var_410_5 < arg_407_1.time_ and arg_407_1.time_ <= var_410_5 + arg_410_0 then
				arg_407_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_410_6 = 0
			local var_410_7 = 0.375

			if var_410_6 < arg_407_1.time_ and arg_407_1.time_ <= var_410_6 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_8 = arg_407_1:FormatText(StoryNameCfg[551].name)

				arg_407_1.leftNameTxt_.text = var_410_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_9 = arg_407_1:GetWordFromCfg(1104906100)
				local var_410_10 = arg_407_1:FormatText(var_410_9.content)

				arg_407_1.text_.text = var_410_10

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_11 = 15
				local var_410_12 = utf8.len(var_410_10)
				local var_410_13 = var_410_11 <= 0 and var_410_7 or var_410_7 * (var_410_12 / var_410_11)

				if var_410_13 > 0 and var_410_7 < var_410_13 then
					arg_407_1.talkMaxDuration = var_410_13

					if var_410_13 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_13 + var_410_6
					end
				end

				arg_407_1.text_.text = var_410_10
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906100", "story_v_side_new_1104906.awb") ~= 0 then
					local var_410_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906100", "story_v_side_new_1104906.awb") / 1000

					if var_410_14 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_14 + var_410_6
					end

					if var_410_9.prefab_name ~= "" and arg_407_1.actors_[var_410_9.prefab_name] ~= nil then
						local var_410_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_9.prefab_name].transform, "story_v_side_new_1104906", "1104906100", "story_v_side_new_1104906.awb")

						arg_407_1:RecordAudio("1104906100", var_410_15)
						arg_407_1:RecordAudio("1104906100", var_410_15)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906100", "story_v_side_new_1104906.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906100", "story_v_side_new_1104906.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_16 = math.max(var_410_7, arg_407_1.talkMaxDuration)

			if var_410_6 <= arg_407_1.time_ and arg_407_1.time_ < var_410_6 + var_410_16 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_6) / var_410_16

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_6 + var_410_16 and arg_407_1.time_ < var_410_6 + var_410_16 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1104906101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1104906101
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1104906102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1049ui_story"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1049ui_story == nil then
				arg_411_1.var_.characterEffect1049ui_story = var_414_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.200000002980232

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 and not isNil(var_414_0) then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2

				if arg_411_1.var_.characterEffect1049ui_story and not isNil(var_414_0) then
					local var_414_4 = Mathf.Lerp(0, 0.5, var_414_3)

					arg_411_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1049ui_story.fillRatio = var_414_4
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1049ui_story then
				local var_414_5 = 0.5

				arg_411_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1049ui_story.fillRatio = var_414_5
			end

			local var_414_6 = 0
			local var_414_7 = 0.075

			if var_414_6 < arg_411_1.time_ and arg_411_1.time_ <= var_414_6 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_8 = arg_411_1:FormatText(StoryNameCfg[7].name)

				arg_411_1.leftNameTxt_.text = var_414_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_9 = arg_411_1:GetWordFromCfg(1104906101)
				local var_414_10 = arg_411_1:FormatText(var_414_9.content)

				arg_411_1.text_.text = var_414_10

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_11 = 3
				local var_414_12 = utf8.len(var_414_10)
				local var_414_13 = var_414_11 <= 0 and var_414_7 or var_414_7 * (var_414_12 / var_414_11)

				if var_414_13 > 0 and var_414_7 < var_414_13 then
					arg_411_1.talkMaxDuration = var_414_13

					if var_414_13 + var_414_6 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_13 + var_414_6
					end
				end

				arg_411_1.text_.text = var_414_10
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_14 = math.max(var_414_7, arg_411_1.talkMaxDuration)

			if var_414_6 <= arg_411_1.time_ and arg_411_1.time_ < var_414_6 + var_414_14 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_6) / var_414_14

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_6 + var_414_14 and arg_411_1.time_ < var_414_6 + var_414_14 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1104906102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1104906102
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1104906103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["1049ui_story"].transform
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.var_.moveOldPos1049ui_story = var_418_0.localPosition
			end

			local var_418_2 = 0.001

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2
				local var_418_4 = Vector3.New(0, 100, 0)

				var_418_0.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1049ui_story, var_418_4, var_418_3)

				local var_418_5 = manager.ui.mainCamera.transform.position - var_418_0.position

				var_418_0.forward = Vector3.New(var_418_5.x, var_418_5.y, var_418_5.z)

				local var_418_6 = var_418_0.localEulerAngles

				var_418_6.z = 0
				var_418_6.x = 0
				var_418_0.localEulerAngles = var_418_6
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 then
				var_418_0.localPosition = Vector3.New(0, 100, 0)

				local var_418_7 = manager.ui.mainCamera.transform.position - var_418_0.position

				var_418_0.forward = Vector3.New(var_418_7.x, var_418_7.y, var_418_7.z)

				local var_418_8 = var_418_0.localEulerAngles

				var_418_8.z = 0
				var_418_8.x = 0
				var_418_0.localEulerAngles = var_418_8
			end

			local var_418_9 = 0.533333333333333
			local var_418_10 = 1

			if var_418_9 < arg_415_1.time_ and arg_415_1.time_ <= var_418_9 + arg_418_0 then
				local var_418_11 = "play"
				local var_418_12 = "effect"

				arg_415_1:AudioAction(var_418_11, var_418_12, "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_418_13 = 0
			local var_418_14 = 0.7

			if var_418_13 < arg_415_1.time_ and arg_415_1.time_ <= var_418_13 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_15 = arg_415_1:GetWordFromCfg(1104906102)
				local var_418_16 = arg_415_1:FormatText(var_418_15.content)

				arg_415_1.text_.text = var_418_16

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_17 = 28
				local var_418_18 = utf8.len(var_418_16)
				local var_418_19 = var_418_17 <= 0 and var_418_14 or var_418_14 * (var_418_18 / var_418_17)

				if var_418_19 > 0 and var_418_14 < var_418_19 then
					arg_415_1.talkMaxDuration = var_418_19

					if var_418_19 + var_418_13 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_19 + var_418_13
					end
				end

				arg_415_1.text_.text = var_418_16
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_20 = math.max(var_418_14, arg_415_1.talkMaxDuration)

			if var_418_13 <= arg_415_1.time_ and arg_415_1.time_ < var_418_13 + var_418_20 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_13) / var_418_20

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_13 + var_418_20 and arg_415_1.time_ < var_418_13 + var_418_20 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play1104906103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1104906103
		arg_419_1.duration_ = 3.63

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1104906104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["1049ui_story"].transform
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.var_.moveOldPos1049ui_story = var_422_0.localPosition
			end

			local var_422_2 = 0.001

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2
				local var_422_4 = Vector3.New(0, -1.2, -6)

				var_422_0.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1049ui_story, var_422_4, var_422_3)

				local var_422_5 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_5.x, var_422_5.y, var_422_5.z)

				local var_422_6 = var_422_0.localEulerAngles

				var_422_6.z = 0
				var_422_6.x = 0
				var_422_0.localEulerAngles = var_422_6
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 then
				var_422_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_422_7 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_7.x, var_422_7.y, var_422_7.z)

				local var_422_8 = var_422_0.localEulerAngles

				var_422_8.z = 0
				var_422_8.x = 0
				var_422_0.localEulerAngles = var_422_8
			end

			local var_422_9 = arg_419_1.actors_["1049ui_story"]
			local var_422_10 = 0

			if var_422_10 < arg_419_1.time_ and arg_419_1.time_ <= var_422_10 + arg_422_0 and not isNil(var_422_9) and arg_419_1.var_.characterEffect1049ui_story == nil then
				arg_419_1.var_.characterEffect1049ui_story = var_422_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_11 = 0.200000002980232

			if var_422_10 <= arg_419_1.time_ and arg_419_1.time_ < var_422_10 + var_422_11 and not isNil(var_422_9) then
				local var_422_12 = (arg_419_1.time_ - var_422_10) / var_422_11

				if arg_419_1.var_.characterEffect1049ui_story and not isNil(var_422_9) then
					arg_419_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= var_422_10 + var_422_11 and arg_419_1.time_ < var_422_10 + var_422_11 + arg_422_0 and not isNil(var_422_9) and arg_419_1.var_.characterEffect1049ui_story then
				arg_419_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_422_13 = 0

			if var_422_13 < arg_419_1.time_ and arg_419_1.time_ <= var_422_13 + arg_422_0 then
				arg_419_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action6_2")
			end

			local var_422_14 = 0

			if var_422_14 < arg_419_1.time_ and arg_419_1.time_ <= var_422_14 + arg_422_0 then
				arg_419_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_422_15 = 0
			local var_422_16 = 0.4

			if var_422_15 < arg_419_1.time_ and arg_419_1.time_ <= var_422_15 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_17 = arg_419_1:FormatText(StoryNameCfg[551].name)

				arg_419_1.leftNameTxt_.text = var_422_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_18 = arg_419_1:GetWordFromCfg(1104906103)
				local var_422_19 = arg_419_1:FormatText(var_422_18.content)

				arg_419_1.text_.text = var_422_19

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_20 = 16
				local var_422_21 = utf8.len(var_422_19)
				local var_422_22 = var_422_20 <= 0 and var_422_16 or var_422_16 * (var_422_21 / var_422_20)

				if var_422_22 > 0 and var_422_16 < var_422_22 then
					arg_419_1.talkMaxDuration = var_422_22

					if var_422_22 + var_422_15 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_22 + var_422_15
					end
				end

				arg_419_1.text_.text = var_422_19
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906103", "story_v_side_new_1104906.awb") ~= 0 then
					local var_422_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906103", "story_v_side_new_1104906.awb") / 1000

					if var_422_23 + var_422_15 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_23 + var_422_15
					end

					if var_422_18.prefab_name ~= "" and arg_419_1.actors_[var_422_18.prefab_name] ~= nil then
						local var_422_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_18.prefab_name].transform, "story_v_side_new_1104906", "1104906103", "story_v_side_new_1104906.awb")

						arg_419_1:RecordAudio("1104906103", var_422_24)
						arg_419_1:RecordAudio("1104906103", var_422_24)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906103", "story_v_side_new_1104906.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906103", "story_v_side_new_1104906.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_25 = math.max(var_422_16, arg_419_1.talkMaxDuration)

			if var_422_15 <= arg_419_1.time_ and arg_419_1.time_ < var_422_15 + var_422_25 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_15) / var_422_25

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_15 + var_422_25 and arg_419_1.time_ < var_422_15 + var_422_25 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play1104906104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1104906104
		arg_423_1.duration_ = 8.8

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1104906105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 2

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				local var_426_1 = manager.ui.mainCamera.transform.localPosition
				local var_426_2 = Vector3.New(0, 0, 10) + Vector3.New(var_426_1.x, var_426_1.y, 0)
				local var_426_3 = arg_423_1.bgs_.ST58

				var_426_3.transform.localPosition = var_426_2
				var_426_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_426_4 = var_426_3:GetComponent("SpriteRenderer")

				if var_426_4 and var_426_4.sprite then
					local var_426_5 = (var_426_3.transform.localPosition - var_426_1).z
					local var_426_6 = manager.ui.mainCameraCom_
					local var_426_7 = 2 * var_426_5 * Mathf.Tan(var_426_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_426_8 = var_426_7 * var_426_6.aspect
					local var_426_9 = var_426_4.sprite.bounds.size.x
					local var_426_10 = var_426_4.sprite.bounds.size.y
					local var_426_11 = var_426_8 / var_426_9
					local var_426_12 = var_426_7 / var_426_10
					local var_426_13 = var_426_12 < var_426_11 and var_426_11 or var_426_12

					var_426_3.transform.localScale = Vector3.New(var_426_13, var_426_13, 0)
				end

				for iter_426_0, iter_426_1 in pairs(arg_423_1.bgs_) do
					if iter_426_0 ~= "ST58" then
						iter_426_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_426_14 = 4

			if var_426_14 < arg_423_1.time_ and arg_423_1.time_ <= var_426_14 + arg_426_0 then
				arg_423_1.allBtn_.enabled = false
			end

			local var_426_15 = 0.3

			if arg_423_1.time_ >= var_426_14 + var_426_15 and arg_423_1.time_ < var_426_14 + var_426_15 + arg_426_0 then
				arg_423_1.allBtn_.enabled = true
			end

			local var_426_16 = 0

			if var_426_16 < arg_423_1.time_ and arg_423_1.time_ <= var_426_16 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_17 = 2

			if var_426_16 <= arg_423_1.time_ and arg_423_1.time_ < var_426_16 + var_426_17 then
				local var_426_18 = (arg_423_1.time_ - var_426_16) / var_426_17
				local var_426_19 = Color.New(0, 0, 0)

				var_426_19.a = Mathf.Lerp(0, 1, var_426_18)
				arg_423_1.mask_.color = var_426_19
			end

			if arg_423_1.time_ >= var_426_16 + var_426_17 and arg_423_1.time_ < var_426_16 + var_426_17 + arg_426_0 then
				local var_426_20 = Color.New(0, 0, 0)

				var_426_20.a = 1
				arg_423_1.mask_.color = var_426_20
			end

			local var_426_21 = 2

			if var_426_21 < arg_423_1.time_ and arg_423_1.time_ <= var_426_21 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_22 = 2

			if var_426_21 <= arg_423_1.time_ and arg_423_1.time_ < var_426_21 + var_426_22 then
				local var_426_23 = (arg_423_1.time_ - var_426_21) / var_426_22
				local var_426_24 = Color.New(0, 0, 0)

				var_426_24.a = Mathf.Lerp(1, 0, var_426_23)
				arg_423_1.mask_.color = var_426_24
			end

			if arg_423_1.time_ >= var_426_21 + var_426_22 and arg_423_1.time_ < var_426_21 + var_426_22 + arg_426_0 then
				local var_426_25 = Color.New(0, 0, 0)
				local var_426_26 = 0

				arg_423_1.mask_.enabled = false
				var_426_25.a = var_426_26
				arg_423_1.mask_.color = var_426_25
			end

			local var_426_27 = arg_423_1.actors_["1049ui_story"].transform
			local var_426_28 = 1.96599999815226

			if var_426_28 < arg_423_1.time_ and arg_423_1.time_ <= var_426_28 + arg_426_0 then
				arg_423_1.var_.moveOldPos1049ui_story = var_426_27.localPosition
			end

			local var_426_29 = 0.001

			if var_426_28 <= arg_423_1.time_ and arg_423_1.time_ < var_426_28 + var_426_29 then
				local var_426_30 = (arg_423_1.time_ - var_426_28) / var_426_29
				local var_426_31 = Vector3.New(0, 100, 0)

				var_426_27.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1049ui_story, var_426_31, var_426_30)

				local var_426_32 = manager.ui.mainCamera.transform.position - var_426_27.position

				var_426_27.forward = Vector3.New(var_426_32.x, var_426_32.y, var_426_32.z)

				local var_426_33 = var_426_27.localEulerAngles

				var_426_33.z = 0
				var_426_33.x = 0
				var_426_27.localEulerAngles = var_426_33
			end

			if arg_423_1.time_ >= var_426_28 + var_426_29 and arg_423_1.time_ < var_426_28 + var_426_29 + arg_426_0 then
				var_426_27.localPosition = Vector3.New(0, 100, 0)

				local var_426_34 = manager.ui.mainCamera.transform.position - var_426_27.position

				var_426_27.forward = Vector3.New(var_426_34.x, var_426_34.y, var_426_34.z)

				local var_426_35 = var_426_27.localEulerAngles

				var_426_35.z = 0
				var_426_35.x = 0
				var_426_27.localEulerAngles = var_426_35
			end

			local var_426_36 = arg_423_1.actors_["1049ui_story"]
			local var_426_37 = 1.96599999815226

			if var_426_37 < arg_423_1.time_ and arg_423_1.time_ <= var_426_37 + arg_426_0 and not isNil(var_426_36) and arg_423_1.var_.characterEffect1049ui_story == nil then
				arg_423_1.var_.characterEffect1049ui_story = var_426_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_38 = 0.0166666666666667

			if var_426_37 <= arg_423_1.time_ and arg_423_1.time_ < var_426_37 + var_426_38 and not isNil(var_426_36) then
				local var_426_39 = (arg_423_1.time_ - var_426_37) / var_426_38

				if arg_423_1.var_.characterEffect1049ui_story and not isNil(var_426_36) then
					local var_426_40 = Mathf.Lerp(0, 0.5, var_426_39)

					arg_423_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1049ui_story.fillRatio = var_426_40
				end
			end

			if arg_423_1.time_ >= var_426_37 + var_426_38 and arg_423_1.time_ < var_426_37 + var_426_38 + arg_426_0 and not isNil(var_426_36) and arg_423_1.var_.characterEffect1049ui_story then
				local var_426_41 = 0.5

				arg_423_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1049ui_story.fillRatio = var_426_41
			end

			local var_426_42 = 0.125
			local var_426_43 = 1

			if var_426_42 < arg_423_1.time_ and arg_423_1.time_ <= var_426_42 + arg_426_0 then
				local var_426_44 = "stop"
				local var_426_45 = "effect"

				arg_423_1:AudioAction(var_426_44, var_426_45, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_426_46 = 1.53333333333333
			local var_426_47 = 1

			if var_426_46 < arg_423_1.time_ and arg_423_1.time_ <= var_426_46 + arg_426_0 then
				local var_426_48 = "play"
				local var_426_49 = "effect"

				arg_423_1:AudioAction(var_426_48, var_426_49, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_423_1.frameCnt_ <= 1 then
				arg_423_1.dialog_:SetActive(false)
			end

			local var_426_50 = 3.8
			local var_426_51 = 0.35

			if var_426_50 < arg_423_1.time_ and arg_423_1.time_ <= var_426_50 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0

				arg_423_1.dialog_:SetActive(true)

				arg_423_1.dialogCg_.alpha = 0

				local var_426_52 = LeanTween.value(arg_423_1.dialog_, 0, 1, 0.3)

				var_426_52:setOnUpdate(LuaHelper.FloatAction(function(arg_427_0)
					arg_423_1.dialogCg_.alpha = arg_427_0
				end))
				var_426_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_423_1.dialog_)
					var_426_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_423_1.duration_ = arg_423_1.duration_ + 0.3

				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_53 = arg_423_1:GetWordFromCfg(1104906104)
				local var_426_54 = arg_423_1:FormatText(var_426_53.content)

				arg_423_1.text_.text = var_426_54

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_55 = 14
				local var_426_56 = utf8.len(var_426_54)
				local var_426_57 = var_426_55 <= 0 and var_426_51 or var_426_51 * (var_426_56 / var_426_55)

				if var_426_57 > 0 and var_426_51 < var_426_57 then
					arg_423_1.talkMaxDuration = var_426_57
					var_426_50 = var_426_50 + 0.3

					if var_426_57 + var_426_50 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_57 + var_426_50
					end
				end

				arg_423_1.text_.text = var_426_54
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_58 = var_426_50 + 0.3
			local var_426_59 = math.max(var_426_51, arg_423_1.talkMaxDuration)

			if var_426_58 <= arg_423_1.time_ and arg_423_1.time_ < var_426_58 + var_426_59 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_58) / var_426_59

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_58 + var_426_59 and arg_423_1.time_ < var_426_58 + var_426_59 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play1104906105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1104906105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1104906106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0
			local var_432_1 = 1.65

			if var_432_0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_2 = arg_429_1:GetWordFromCfg(1104906105)
				local var_432_3 = arg_429_1:FormatText(var_432_2.content)

				arg_429_1.text_.text = var_432_3

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_4 = 66
				local var_432_5 = utf8.len(var_432_3)
				local var_432_6 = var_432_4 <= 0 and var_432_1 or var_432_1 * (var_432_5 / var_432_4)

				if var_432_6 > 0 and var_432_1 < var_432_6 then
					arg_429_1.talkMaxDuration = var_432_6

					if var_432_6 + var_432_0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_6 + var_432_0
					end
				end

				arg_429_1.text_.text = var_432_3
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_7 = math.max(var_432_1, arg_429_1.talkMaxDuration)

			if var_432_0 <= arg_429_1.time_ and arg_429_1.time_ < var_432_0 + var_432_7 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_0) / var_432_7

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_0 + var_432_7 and arg_429_1.time_ < var_432_0 + var_432_7 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1104906106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1104906106
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1104906107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0
			local var_436_1 = 1.4

			if var_436_0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_2 = arg_433_1:GetWordFromCfg(1104906106)
				local var_436_3 = arg_433_1:FormatText(var_436_2.content)

				arg_433_1.text_.text = var_436_3

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_4 = 56
				local var_436_5 = utf8.len(var_436_3)
				local var_436_6 = var_436_4 <= 0 and var_436_1 or var_436_1 * (var_436_5 / var_436_4)

				if var_436_6 > 0 and var_436_1 < var_436_6 then
					arg_433_1.talkMaxDuration = var_436_6

					if var_436_6 + var_436_0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_6 + var_436_0
					end
				end

				arg_433_1.text_.text = var_436_3
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_7 = math.max(var_436_1, arg_433_1.talkMaxDuration)

			if var_436_0 <= arg_433_1.time_ and arg_433_1.time_ < var_436_0 + var_436_7 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_0) / var_436_7

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_0 + var_436_7 and arg_433_1.time_ < var_436_0 + var_436_7 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1104906107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1104906107
		arg_437_1.duration_ = 1.8

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1104906108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["1049ui_story"].transform
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.var_.moveOldPos1049ui_story = var_440_0.localPosition
			end

			local var_440_2 = 0.001

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2
				local var_440_4 = Vector3.New(0, -1.2, -6)

				var_440_0.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1049ui_story, var_440_4, var_440_3)

				local var_440_5 = manager.ui.mainCamera.transform.position - var_440_0.position

				var_440_0.forward = Vector3.New(var_440_5.x, var_440_5.y, var_440_5.z)

				local var_440_6 = var_440_0.localEulerAngles

				var_440_6.z = 0
				var_440_6.x = 0
				var_440_0.localEulerAngles = var_440_6
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 then
				var_440_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_440_7 = manager.ui.mainCamera.transform.position - var_440_0.position

				var_440_0.forward = Vector3.New(var_440_7.x, var_440_7.y, var_440_7.z)

				local var_440_8 = var_440_0.localEulerAngles

				var_440_8.z = 0
				var_440_8.x = 0
				var_440_0.localEulerAngles = var_440_8
			end

			local var_440_9 = arg_437_1.actors_["1049ui_story"]
			local var_440_10 = 0

			if var_440_10 < arg_437_1.time_ and arg_437_1.time_ <= var_440_10 + arg_440_0 and not isNil(var_440_9) and arg_437_1.var_.characterEffect1049ui_story == nil then
				arg_437_1.var_.characterEffect1049ui_story = var_440_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_11 = 0.200000002980232

			if var_440_10 <= arg_437_1.time_ and arg_437_1.time_ < var_440_10 + var_440_11 and not isNil(var_440_9) then
				local var_440_12 = (arg_437_1.time_ - var_440_10) / var_440_11

				if arg_437_1.var_.characterEffect1049ui_story and not isNil(var_440_9) then
					arg_437_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= var_440_10 + var_440_11 and arg_437_1.time_ < var_440_10 + var_440_11 + arg_440_0 and not isNil(var_440_9) and arg_437_1.var_.characterEffect1049ui_story then
				arg_437_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_440_13 = 0

			if var_440_13 < arg_437_1.time_ and arg_437_1.time_ <= var_440_13 + arg_440_0 then
				arg_437_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_440_14 = 0

			if var_440_14 < arg_437_1.time_ and arg_437_1.time_ <= var_440_14 + arg_440_0 then
				arg_437_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_440_15 = 0
			local var_440_16 = 0.2

			if var_440_15 < arg_437_1.time_ and arg_437_1.time_ <= var_440_15 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_17 = arg_437_1:FormatText(StoryNameCfg[551].name)

				arg_437_1.leftNameTxt_.text = var_440_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_18 = arg_437_1:GetWordFromCfg(1104906107)
				local var_440_19 = arg_437_1:FormatText(var_440_18.content)

				arg_437_1.text_.text = var_440_19

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_20 = 8
				local var_440_21 = utf8.len(var_440_19)
				local var_440_22 = var_440_20 <= 0 and var_440_16 or var_440_16 * (var_440_21 / var_440_20)

				if var_440_22 > 0 and var_440_16 < var_440_22 then
					arg_437_1.talkMaxDuration = var_440_22

					if var_440_22 + var_440_15 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_22 + var_440_15
					end
				end

				arg_437_1.text_.text = var_440_19
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906107", "story_v_side_new_1104906.awb") ~= 0 then
					local var_440_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906107", "story_v_side_new_1104906.awb") / 1000

					if var_440_23 + var_440_15 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_23 + var_440_15
					end

					if var_440_18.prefab_name ~= "" and arg_437_1.actors_[var_440_18.prefab_name] ~= nil then
						local var_440_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_18.prefab_name].transform, "story_v_side_new_1104906", "1104906107", "story_v_side_new_1104906.awb")

						arg_437_1:RecordAudio("1104906107", var_440_24)
						arg_437_1:RecordAudio("1104906107", var_440_24)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906107", "story_v_side_new_1104906.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906107", "story_v_side_new_1104906.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_25 = math.max(var_440_16, arg_437_1.talkMaxDuration)

			if var_440_15 <= arg_437_1.time_ and arg_437_1.time_ < var_440_15 + var_440_25 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_15) / var_440_25

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_15 + var_440_25 and arg_437_1.time_ < var_440_15 + var_440_25 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play1104906108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1104906108
		arg_441_1.duration_ = 4

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1104906109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_444_2 = 0
			local var_444_3 = 0.4

			if var_444_2 < arg_441_1.time_ and arg_441_1.time_ <= var_444_2 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_4 = arg_441_1:FormatText(StoryNameCfg[551].name)

				arg_441_1.leftNameTxt_.text = var_444_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_5 = arg_441_1:GetWordFromCfg(1104906108)
				local var_444_6 = arg_441_1:FormatText(var_444_5.content)

				arg_441_1.text_.text = var_444_6

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_7 = 16
				local var_444_8 = utf8.len(var_444_6)
				local var_444_9 = var_444_7 <= 0 and var_444_3 or var_444_3 * (var_444_8 / var_444_7)

				if var_444_9 > 0 and var_444_3 < var_444_9 then
					arg_441_1.talkMaxDuration = var_444_9

					if var_444_9 + var_444_2 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_9 + var_444_2
					end
				end

				arg_441_1.text_.text = var_444_6
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906108", "story_v_side_new_1104906.awb") ~= 0 then
					local var_444_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906108", "story_v_side_new_1104906.awb") / 1000

					if var_444_10 + var_444_2 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_10 + var_444_2
					end

					if var_444_5.prefab_name ~= "" and arg_441_1.actors_[var_444_5.prefab_name] ~= nil then
						local var_444_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_5.prefab_name].transform, "story_v_side_new_1104906", "1104906108", "story_v_side_new_1104906.awb")

						arg_441_1:RecordAudio("1104906108", var_444_11)
						arg_441_1:RecordAudio("1104906108", var_444_11)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906108", "story_v_side_new_1104906.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906108", "story_v_side_new_1104906.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_12 = math.max(var_444_3, arg_441_1.talkMaxDuration)

			if var_444_2 <= arg_441_1.time_ and arg_441_1.time_ < var_444_2 + var_444_12 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_2) / var_444_12

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_2 + var_444_12 and arg_441_1.time_ < var_444_2 + var_444_12 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1104906109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1104906109
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1104906110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = arg_445_1.actors_["1049ui_story"]
			local var_448_1 = 0

			if var_448_1 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 and not isNil(var_448_0) and arg_445_1.var_.characterEffect1049ui_story == nil then
				arg_445_1.var_.characterEffect1049ui_story = var_448_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_2 = 0.200000002980232

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_2 and not isNil(var_448_0) then
				local var_448_3 = (arg_445_1.time_ - var_448_1) / var_448_2

				if arg_445_1.var_.characterEffect1049ui_story and not isNil(var_448_0) then
					local var_448_4 = Mathf.Lerp(0, 0.5, var_448_3)

					arg_445_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1049ui_story.fillRatio = var_448_4
				end
			end

			if arg_445_1.time_ >= var_448_1 + var_448_2 and arg_445_1.time_ < var_448_1 + var_448_2 + arg_448_0 and not isNil(var_448_0) and arg_445_1.var_.characterEffect1049ui_story then
				local var_448_5 = 0.5

				arg_445_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1049ui_story.fillRatio = var_448_5
			end

			local var_448_6 = 0
			local var_448_7 = 1.075

			if var_448_6 < arg_445_1.time_ and arg_445_1.time_ <= var_448_6 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_8 = arg_445_1:FormatText(StoryNameCfg[7].name)

				arg_445_1.leftNameTxt_.text = var_448_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_9 = arg_445_1:GetWordFromCfg(1104906109)
				local var_448_10 = arg_445_1:FormatText(var_448_9.content)

				arg_445_1.text_.text = var_448_10

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_11 = 43
				local var_448_12 = utf8.len(var_448_10)
				local var_448_13 = var_448_11 <= 0 and var_448_7 or var_448_7 * (var_448_12 / var_448_11)

				if var_448_13 > 0 and var_448_7 < var_448_13 then
					arg_445_1.talkMaxDuration = var_448_13

					if var_448_13 + var_448_6 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_13 + var_448_6
					end
				end

				arg_445_1.text_.text = var_448_10
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_14 = math.max(var_448_7, arg_445_1.talkMaxDuration)

			if var_448_6 <= arg_445_1.time_ and arg_445_1.time_ < var_448_6 + var_448_14 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_6) / var_448_14

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_6 + var_448_14 and arg_445_1.time_ < var_448_6 + var_448_14 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1104906110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1104906110
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1104906111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0
			local var_452_1 = 1.225

			if var_452_0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_2 = arg_449_1:FormatText(StoryNameCfg[7].name)

				arg_449_1.leftNameTxt_.text = var_452_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_3 = arg_449_1:GetWordFromCfg(1104906110)
				local var_452_4 = arg_449_1:FormatText(var_452_3.content)

				arg_449_1.text_.text = var_452_4

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 49
				local var_452_6 = utf8.len(var_452_4)
				local var_452_7 = var_452_5 <= 0 and var_452_1 or var_452_1 * (var_452_6 / var_452_5)

				if var_452_7 > 0 and var_452_1 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7

					if var_452_7 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_0
					end
				end

				arg_449_1.text_.text = var_452_4
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_8 = math.max(var_452_1, arg_449_1.talkMaxDuration)

			if var_452_0 <= arg_449_1.time_ and arg_449_1.time_ < var_452_0 + var_452_8 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_0) / var_452_8

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_0 + var_452_8 and arg_449_1.time_ < var_452_0 + var_452_8 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1104906111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1104906111
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1104906112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0
			local var_456_1 = 1.1

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_2 = arg_453_1:FormatText(StoryNameCfg[7].name)

				arg_453_1.leftNameTxt_.text = var_456_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_3 = arg_453_1:GetWordFromCfg(1104906111)
				local var_456_4 = arg_453_1:FormatText(var_456_3.content)

				arg_453_1.text_.text = var_456_4

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 44
				local var_456_6 = utf8.len(var_456_4)
				local var_456_7 = var_456_5 <= 0 and var_456_1 or var_456_1 * (var_456_6 / var_456_5)

				if var_456_7 > 0 and var_456_1 < var_456_7 then
					arg_453_1.talkMaxDuration = var_456_7

					if var_456_7 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_4
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_8 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_8 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_8

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_8 and arg_453_1.time_ < var_456_0 + var_456_8 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1104906112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1104906112
		arg_457_1.duration_ = 3.57

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1104906113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = arg_457_1.actors_["1049ui_story"]
			local var_460_1 = 0

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 and not isNil(var_460_0) and arg_457_1.var_.characterEffect1049ui_story == nil then
				arg_457_1.var_.characterEffect1049ui_story = var_460_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_2 = 0.200000002980232

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_2 and not isNil(var_460_0) then
				local var_460_3 = (arg_457_1.time_ - var_460_1) / var_460_2

				if arg_457_1.var_.characterEffect1049ui_story and not isNil(var_460_0) then
					arg_457_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= var_460_1 + var_460_2 and arg_457_1.time_ < var_460_1 + var_460_2 + arg_460_0 and not isNil(var_460_0) and arg_457_1.var_.characterEffect1049ui_story then
				arg_457_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_460_4 = 0

			if var_460_4 < arg_457_1.time_ and arg_457_1.time_ <= var_460_4 + arg_460_0 then
				arg_457_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			local var_460_5 = 0

			if var_460_5 < arg_457_1.time_ and arg_457_1.time_ <= var_460_5 + arg_460_0 then
				arg_457_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_460_6 = 0
			local var_460_7 = 0.35

			if var_460_6 < arg_457_1.time_ and arg_457_1.time_ <= var_460_6 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_8 = arg_457_1:FormatText(StoryNameCfg[551].name)

				arg_457_1.leftNameTxt_.text = var_460_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_9 = arg_457_1:GetWordFromCfg(1104906112)
				local var_460_10 = arg_457_1:FormatText(var_460_9.content)

				arg_457_1.text_.text = var_460_10

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_11 = 14
				local var_460_12 = utf8.len(var_460_10)
				local var_460_13 = var_460_11 <= 0 and var_460_7 or var_460_7 * (var_460_12 / var_460_11)

				if var_460_13 > 0 and var_460_7 < var_460_13 then
					arg_457_1.talkMaxDuration = var_460_13

					if var_460_13 + var_460_6 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_13 + var_460_6
					end
				end

				arg_457_1.text_.text = var_460_10
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906112", "story_v_side_new_1104906.awb") ~= 0 then
					local var_460_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906112", "story_v_side_new_1104906.awb") / 1000

					if var_460_14 + var_460_6 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_14 + var_460_6
					end

					if var_460_9.prefab_name ~= "" and arg_457_1.actors_[var_460_9.prefab_name] ~= nil then
						local var_460_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_9.prefab_name].transform, "story_v_side_new_1104906", "1104906112", "story_v_side_new_1104906.awb")

						arg_457_1:RecordAudio("1104906112", var_460_15)
						arg_457_1:RecordAudio("1104906112", var_460_15)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906112", "story_v_side_new_1104906.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906112", "story_v_side_new_1104906.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_16 = math.max(var_460_7, arg_457_1.talkMaxDuration)

			if var_460_6 <= arg_457_1.time_ and arg_457_1.time_ < var_460_6 + var_460_16 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_6) / var_460_16

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_6 + var_460_16 and arg_457_1.time_ < var_460_6 + var_460_16 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1104906113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1104906113
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1104906114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["1049ui_story"].transform
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.var_.moveOldPos1049ui_story = var_464_0.localPosition
			end

			local var_464_2 = 0.001

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2
				local var_464_4 = Vector3.New(0, 100, 0)

				var_464_0.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1049ui_story, var_464_4, var_464_3)

				local var_464_5 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_5.x, var_464_5.y, var_464_5.z)

				local var_464_6 = var_464_0.localEulerAngles

				var_464_6.z = 0
				var_464_6.x = 0
				var_464_0.localEulerAngles = var_464_6
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 then
				var_464_0.localPosition = Vector3.New(0, 100, 0)

				local var_464_7 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_7.x, var_464_7.y, var_464_7.z)

				local var_464_8 = var_464_0.localEulerAngles

				var_464_8.z = 0
				var_464_8.x = 0
				var_464_0.localEulerAngles = var_464_8
			end

			local var_464_9 = arg_461_1.actors_["1049ui_story"]
			local var_464_10 = 0

			if var_464_10 < arg_461_1.time_ and arg_461_1.time_ <= var_464_10 + arg_464_0 and not isNil(var_464_9) and arg_461_1.var_.characterEffect1049ui_story == nil then
				arg_461_1.var_.characterEffect1049ui_story = var_464_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_11 = 0.200000002980232

			if var_464_10 <= arg_461_1.time_ and arg_461_1.time_ < var_464_10 + var_464_11 and not isNil(var_464_9) then
				local var_464_12 = (arg_461_1.time_ - var_464_10) / var_464_11

				if arg_461_1.var_.characterEffect1049ui_story and not isNil(var_464_9) then
					local var_464_13 = Mathf.Lerp(0, 0.5, var_464_12)

					arg_461_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1049ui_story.fillRatio = var_464_13
				end
			end

			if arg_461_1.time_ >= var_464_10 + var_464_11 and arg_461_1.time_ < var_464_10 + var_464_11 + arg_464_0 and not isNil(var_464_9) and arg_461_1.var_.characterEffect1049ui_story then
				local var_464_14 = 0.5

				arg_461_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1049ui_story.fillRatio = var_464_14
			end

			local var_464_15 = 0
			local var_464_16 = 0.65

			if var_464_15 < arg_461_1.time_ and arg_461_1.time_ <= var_464_15 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_17 = arg_461_1:GetWordFromCfg(1104906113)
				local var_464_18 = arg_461_1:FormatText(var_464_17.content)

				arg_461_1.text_.text = var_464_18

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_19 = 26
				local var_464_20 = utf8.len(var_464_18)
				local var_464_21 = var_464_19 <= 0 and var_464_16 or var_464_16 * (var_464_20 / var_464_19)

				if var_464_21 > 0 and var_464_16 < var_464_21 then
					arg_461_1.talkMaxDuration = var_464_21

					if var_464_21 + var_464_15 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_21 + var_464_15
					end
				end

				arg_461_1.text_.text = var_464_18
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_22 = math.max(var_464_16, arg_461_1.talkMaxDuration)

			if var_464_15 <= arg_461_1.time_ and arg_461_1.time_ < var_464_15 + var_464_22 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_15) / var_464_22

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_15 + var_464_22 and arg_461_1.time_ < var_464_15 + var_464_22 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play1104906114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1104906114
		arg_465_1.duration_ = 4

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1104906115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["1049ui_story"].transform
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.var_.moveOldPos1049ui_story = var_468_0.localPosition
			end

			local var_468_2 = 0.001

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_2 then
				local var_468_3 = (arg_465_1.time_ - var_468_1) / var_468_2
				local var_468_4 = Vector3.New(0, -1.2, -6)

				var_468_0.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1049ui_story, var_468_4, var_468_3)

				local var_468_5 = manager.ui.mainCamera.transform.position - var_468_0.position

				var_468_0.forward = Vector3.New(var_468_5.x, var_468_5.y, var_468_5.z)

				local var_468_6 = var_468_0.localEulerAngles

				var_468_6.z = 0
				var_468_6.x = 0
				var_468_0.localEulerAngles = var_468_6
			end

			if arg_465_1.time_ >= var_468_1 + var_468_2 and arg_465_1.time_ < var_468_1 + var_468_2 + arg_468_0 then
				var_468_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_468_7 = manager.ui.mainCamera.transform.position - var_468_0.position

				var_468_0.forward = Vector3.New(var_468_7.x, var_468_7.y, var_468_7.z)

				local var_468_8 = var_468_0.localEulerAngles

				var_468_8.z = 0
				var_468_8.x = 0
				var_468_0.localEulerAngles = var_468_8
			end

			local var_468_9 = arg_465_1.actors_["1049ui_story"]
			local var_468_10 = 0

			if var_468_10 < arg_465_1.time_ and arg_465_1.time_ <= var_468_10 + arg_468_0 and not isNil(var_468_9) and arg_465_1.var_.characterEffect1049ui_story == nil then
				arg_465_1.var_.characterEffect1049ui_story = var_468_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_11 = 0.200000002980232

			if var_468_10 <= arg_465_1.time_ and arg_465_1.time_ < var_468_10 + var_468_11 and not isNil(var_468_9) then
				local var_468_12 = (arg_465_1.time_ - var_468_10) / var_468_11

				if arg_465_1.var_.characterEffect1049ui_story and not isNil(var_468_9) then
					arg_465_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= var_468_10 + var_468_11 and arg_465_1.time_ < var_468_10 + var_468_11 + arg_468_0 and not isNil(var_468_9) and arg_465_1.var_.characterEffect1049ui_story then
				arg_465_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_468_13 = 0

			if var_468_13 < arg_465_1.time_ and arg_465_1.time_ <= var_468_13 + arg_468_0 then
				arg_465_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action5_1")
			end

			local var_468_14 = 0

			if var_468_14 < arg_465_1.time_ and arg_465_1.time_ <= var_468_14 + arg_468_0 then
				arg_465_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_468_15 = 0
			local var_468_16 = 0.375

			if var_468_15 < arg_465_1.time_ and arg_465_1.time_ <= var_468_15 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_17 = arg_465_1:FormatText(StoryNameCfg[551].name)

				arg_465_1.leftNameTxt_.text = var_468_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_18 = arg_465_1:GetWordFromCfg(1104906114)
				local var_468_19 = arg_465_1:FormatText(var_468_18.content)

				arg_465_1.text_.text = var_468_19

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_20 = 15
				local var_468_21 = utf8.len(var_468_19)
				local var_468_22 = var_468_20 <= 0 and var_468_16 or var_468_16 * (var_468_21 / var_468_20)

				if var_468_22 > 0 and var_468_16 < var_468_22 then
					arg_465_1.talkMaxDuration = var_468_22

					if var_468_22 + var_468_15 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_22 + var_468_15
					end
				end

				arg_465_1.text_.text = var_468_19
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906114", "story_v_side_new_1104906.awb") ~= 0 then
					local var_468_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906114", "story_v_side_new_1104906.awb") / 1000

					if var_468_23 + var_468_15 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_23 + var_468_15
					end

					if var_468_18.prefab_name ~= "" and arg_465_1.actors_[var_468_18.prefab_name] ~= nil then
						local var_468_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_18.prefab_name].transform, "story_v_side_new_1104906", "1104906114", "story_v_side_new_1104906.awb")

						arg_465_1:RecordAudio("1104906114", var_468_24)
						arg_465_1:RecordAudio("1104906114", var_468_24)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906114", "story_v_side_new_1104906.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906114", "story_v_side_new_1104906.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_25 = math.max(var_468_16, arg_465_1.talkMaxDuration)

			if var_468_15 <= arg_465_1.time_ and arg_465_1.time_ < var_468_15 + var_468_25 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_15) / var_468_25

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_15 + var_468_25 and arg_465_1.time_ < var_468_15 + var_468_25 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play1104906115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1104906115
		arg_469_1.duration_ = 4.83

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1104906116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049actionlink/1049action452")
			end

			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_472_2 = 0
			local var_472_3 = 0.4

			if var_472_2 < arg_469_1.time_ and arg_469_1.time_ <= var_472_2 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_4 = arg_469_1:FormatText(StoryNameCfg[551].name)

				arg_469_1.leftNameTxt_.text = var_472_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_5 = arg_469_1:GetWordFromCfg(1104906115)
				local var_472_6 = arg_469_1:FormatText(var_472_5.content)

				arg_469_1.text_.text = var_472_6

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_7 = 16
				local var_472_8 = utf8.len(var_472_6)
				local var_472_9 = var_472_7 <= 0 and var_472_3 or var_472_3 * (var_472_8 / var_472_7)

				if var_472_9 > 0 and var_472_3 < var_472_9 then
					arg_469_1.talkMaxDuration = var_472_9

					if var_472_9 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_9 + var_472_2
					end
				end

				arg_469_1.text_.text = var_472_6
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906115", "story_v_side_new_1104906.awb") ~= 0 then
					local var_472_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906115", "story_v_side_new_1104906.awb") / 1000

					if var_472_10 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_10 + var_472_2
					end

					if var_472_5.prefab_name ~= "" and arg_469_1.actors_[var_472_5.prefab_name] ~= nil then
						local var_472_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_5.prefab_name].transform, "story_v_side_new_1104906", "1104906115", "story_v_side_new_1104906.awb")

						arg_469_1:RecordAudio("1104906115", var_472_11)
						arg_469_1:RecordAudio("1104906115", var_472_11)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906115", "story_v_side_new_1104906.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906115", "story_v_side_new_1104906.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_12 = math.max(var_472_3, arg_469_1.talkMaxDuration)

			if var_472_2 <= arg_469_1.time_ and arg_469_1.time_ < var_472_2 + var_472_12 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_2) / var_472_12

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_2 + var_472_12 and arg_469_1.time_ < var_472_2 + var_472_12 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1104906116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1104906116
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1104906117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["1049ui_story"].transform
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.var_.moveOldPos1049ui_story = var_476_0.localPosition
			end

			local var_476_2 = 0.001

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2
				local var_476_4 = Vector3.New(0, 100, 0)

				var_476_0.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos1049ui_story, var_476_4, var_476_3)

				local var_476_5 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_5.x, var_476_5.y, var_476_5.z)

				local var_476_6 = var_476_0.localEulerAngles

				var_476_6.z = 0
				var_476_6.x = 0
				var_476_0.localEulerAngles = var_476_6
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 then
				var_476_0.localPosition = Vector3.New(0, 100, 0)

				local var_476_7 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_7.x, var_476_7.y, var_476_7.z)

				local var_476_8 = var_476_0.localEulerAngles

				var_476_8.z = 0
				var_476_8.x = 0
				var_476_0.localEulerAngles = var_476_8
			end

			local var_476_9 = arg_473_1.actors_["1049ui_story"]
			local var_476_10 = 0

			if var_476_10 < arg_473_1.time_ and arg_473_1.time_ <= var_476_10 + arg_476_0 and not isNil(var_476_9) and arg_473_1.var_.characterEffect1049ui_story == nil then
				arg_473_1.var_.characterEffect1049ui_story = var_476_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_11 = 0.200000002980232

			if var_476_10 <= arg_473_1.time_ and arg_473_1.time_ < var_476_10 + var_476_11 and not isNil(var_476_9) then
				local var_476_12 = (arg_473_1.time_ - var_476_10) / var_476_11

				if arg_473_1.var_.characterEffect1049ui_story and not isNil(var_476_9) then
					local var_476_13 = Mathf.Lerp(0, 0.5, var_476_12)

					arg_473_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_473_1.var_.characterEffect1049ui_story.fillRatio = var_476_13
				end
			end

			if arg_473_1.time_ >= var_476_10 + var_476_11 and arg_473_1.time_ < var_476_10 + var_476_11 + arg_476_0 and not isNil(var_476_9) and arg_473_1.var_.characterEffect1049ui_story then
				local var_476_14 = 0.5

				arg_473_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_473_1.var_.characterEffect1049ui_story.fillRatio = var_476_14
			end

			local var_476_15 = 0
			local var_476_16 = 1.125

			if var_476_15 < arg_473_1.time_ and arg_473_1.time_ <= var_476_15 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_17 = arg_473_1:FormatText(StoryNameCfg[7].name)

				arg_473_1.leftNameTxt_.text = var_476_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_18 = arg_473_1:GetWordFromCfg(1104906116)
				local var_476_19 = arg_473_1:FormatText(var_476_18.content)

				arg_473_1.text_.text = var_476_19

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_20 = 45
				local var_476_21 = utf8.len(var_476_19)
				local var_476_22 = var_476_20 <= 0 and var_476_16 or var_476_16 * (var_476_21 / var_476_20)

				if var_476_22 > 0 and var_476_16 < var_476_22 then
					arg_473_1.talkMaxDuration = var_476_22

					if var_476_22 + var_476_15 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_22 + var_476_15
					end
				end

				arg_473_1.text_.text = var_476_19
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_23 = math.max(var_476_16, arg_473_1.talkMaxDuration)

			if var_476_15 <= arg_473_1.time_ and arg_473_1.time_ < var_476_15 + var_476_23 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_15) / var_476_23

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_15 + var_476_23 and arg_473_1.time_ < var_476_15 + var_476_23 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play1104906117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1104906117
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1104906118(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0
			local var_480_1 = 0.85

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_2 = arg_477_1:GetWordFromCfg(1104906117)
				local var_480_3 = arg_477_1:FormatText(var_480_2.content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_4 = 34
				local var_480_5 = utf8.len(var_480_3)
				local var_480_6 = var_480_4 <= 0 and var_480_1 or var_480_1 * (var_480_5 / var_480_4)

				if var_480_6 > 0 and var_480_1 < var_480_6 then
					arg_477_1.talkMaxDuration = var_480_6

					if var_480_6 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_6 + var_480_0
					end
				end

				arg_477_1.text_.text = var_480_3
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_7 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_7 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_7

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_7 and arg_477_1.time_ < var_480_0 + var_480_7 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1104906118 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1104906118
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1104906119(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0
			local var_484_1 = 0.475

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_2 = arg_481_1:GetWordFromCfg(1104906118)
				local var_484_3 = arg_481_1:FormatText(var_484_2.content)

				arg_481_1.text_.text = var_484_3

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 19
				local var_484_5 = utf8.len(var_484_3)
				local var_484_6 = var_484_4 <= 0 and var_484_1 or var_484_1 * (var_484_5 / var_484_4)

				if var_484_6 > 0 and var_484_1 < var_484_6 then
					arg_481_1.talkMaxDuration = var_484_6

					if var_484_6 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_6 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_3
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_7 and arg_481_1.time_ < var_484_0 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1104906119 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1104906119
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1104906120(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0
			local var_488_1 = 0.675

			if var_488_0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_2 = arg_485_1:GetWordFromCfg(1104906119)
				local var_488_3 = arg_485_1:FormatText(var_488_2.content)

				arg_485_1.text_.text = var_488_3

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_4 = 27
				local var_488_5 = utf8.len(var_488_3)
				local var_488_6 = var_488_4 <= 0 and var_488_1 or var_488_1 * (var_488_5 / var_488_4)

				if var_488_6 > 0 and var_488_1 < var_488_6 then
					arg_485_1.talkMaxDuration = var_488_6

					if var_488_6 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_6 + var_488_0
					end
				end

				arg_485_1.text_.text = var_488_3
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_7 = math.max(var_488_1, arg_485_1.talkMaxDuration)

			if var_488_0 <= arg_485_1.time_ and arg_485_1.time_ < var_488_0 + var_488_7 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_0) / var_488_7

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_0 + var_488_7 and arg_485_1.time_ < var_488_0 + var_488_7 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1104906120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1104906120
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1104906121(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0
			local var_492_1 = 0.375

			if var_492_0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_2 = arg_489_1:FormatText(StoryNameCfg[7].name)

				arg_489_1.leftNameTxt_.text = var_492_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_3 = arg_489_1:GetWordFromCfg(1104906120)
				local var_492_4 = arg_489_1:FormatText(var_492_3.content)

				arg_489_1.text_.text = var_492_4

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 15
				local var_492_6 = utf8.len(var_492_4)
				local var_492_7 = var_492_5 <= 0 and var_492_1 or var_492_1 * (var_492_6 / var_492_5)

				if var_492_7 > 0 and var_492_1 < var_492_7 then
					arg_489_1.talkMaxDuration = var_492_7

					if var_492_7 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_7 + var_492_0
					end
				end

				arg_489_1.text_.text = var_492_4
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_8 = math.max(var_492_1, arg_489_1.talkMaxDuration)

			if var_492_0 <= arg_489_1.time_ and arg_489_1.time_ < var_492_0 + var_492_8 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_0) / var_492_8

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_0 + var_492_8 and arg_489_1.time_ < var_492_0 + var_492_8 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1104906121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1104906121
		arg_493_1.duration_ = 2

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1104906122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["1049ui_story"].transform
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 then
				arg_493_1.var_.moveOldPos1049ui_story = var_496_0.localPosition
			end

			local var_496_2 = 0.001

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2
				local var_496_4 = Vector3.New(0, -1.2, -6)

				var_496_0.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1049ui_story, var_496_4, var_496_3)

				local var_496_5 = manager.ui.mainCamera.transform.position - var_496_0.position

				var_496_0.forward = Vector3.New(var_496_5.x, var_496_5.y, var_496_5.z)

				local var_496_6 = var_496_0.localEulerAngles

				var_496_6.z = 0
				var_496_6.x = 0
				var_496_0.localEulerAngles = var_496_6
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 then
				var_496_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_496_7 = manager.ui.mainCamera.transform.position - var_496_0.position

				var_496_0.forward = Vector3.New(var_496_7.x, var_496_7.y, var_496_7.z)

				local var_496_8 = var_496_0.localEulerAngles

				var_496_8.z = 0
				var_496_8.x = 0
				var_496_0.localEulerAngles = var_496_8
			end

			local var_496_9 = arg_493_1.actors_["1049ui_story"]
			local var_496_10 = 0

			if var_496_10 < arg_493_1.time_ and arg_493_1.time_ <= var_496_10 + arg_496_0 and not isNil(var_496_9) and arg_493_1.var_.characterEffect1049ui_story == nil then
				arg_493_1.var_.characterEffect1049ui_story = var_496_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_11 = 0.200000002980232

			if var_496_10 <= arg_493_1.time_ and arg_493_1.time_ < var_496_10 + var_496_11 and not isNil(var_496_9) then
				local var_496_12 = (arg_493_1.time_ - var_496_10) / var_496_11

				if arg_493_1.var_.characterEffect1049ui_story and not isNil(var_496_9) then
					arg_493_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= var_496_10 + var_496_11 and arg_493_1.time_ < var_496_10 + var_496_11 + arg_496_0 and not isNil(var_496_9) and arg_493_1.var_.characterEffect1049ui_story then
				arg_493_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_496_13 = 0

			if var_496_13 < arg_493_1.time_ and arg_493_1.time_ <= var_496_13 + arg_496_0 then
				arg_493_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			local var_496_14 = 0

			if var_496_14 < arg_493_1.time_ and arg_493_1.time_ <= var_496_14 + arg_496_0 then
				arg_493_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_496_15 = 0
			local var_496_16 = 0.175

			if var_496_15 < arg_493_1.time_ and arg_493_1.time_ <= var_496_15 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_17 = arg_493_1:FormatText(StoryNameCfg[551].name)

				arg_493_1.leftNameTxt_.text = var_496_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_18 = arg_493_1:GetWordFromCfg(1104906121)
				local var_496_19 = arg_493_1:FormatText(var_496_18.content)

				arg_493_1.text_.text = var_496_19

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_20 = 7
				local var_496_21 = utf8.len(var_496_19)
				local var_496_22 = var_496_20 <= 0 and var_496_16 or var_496_16 * (var_496_21 / var_496_20)

				if var_496_22 > 0 and var_496_16 < var_496_22 then
					arg_493_1.talkMaxDuration = var_496_22

					if var_496_22 + var_496_15 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_22 + var_496_15
					end
				end

				arg_493_1.text_.text = var_496_19
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906121", "story_v_side_new_1104906.awb") ~= 0 then
					local var_496_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906121", "story_v_side_new_1104906.awb") / 1000

					if var_496_23 + var_496_15 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_23 + var_496_15
					end

					if var_496_18.prefab_name ~= "" and arg_493_1.actors_[var_496_18.prefab_name] ~= nil then
						local var_496_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_18.prefab_name].transform, "story_v_side_new_1104906", "1104906121", "story_v_side_new_1104906.awb")

						arg_493_1:RecordAudio("1104906121", var_496_24)
						arg_493_1:RecordAudio("1104906121", var_496_24)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906121", "story_v_side_new_1104906.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906121", "story_v_side_new_1104906.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_25 = math.max(var_496_16, arg_493_1.talkMaxDuration)

			if var_496_15 <= arg_493_1.time_ and arg_493_1.time_ < var_496_15 + var_496_25 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_15) / var_496_25

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_15 + var_496_25 and arg_493_1.time_ < var_496_15 + var_496_25 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play1104906122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1104906122
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1104906123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = arg_497_1.actors_["1049ui_story"]
			local var_500_1 = 0

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1049ui_story == nil then
				arg_497_1.var_.characterEffect1049ui_story = var_500_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_2 = 0.200000002980232

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_2 and not isNil(var_500_0) then
				local var_500_3 = (arg_497_1.time_ - var_500_1) / var_500_2

				if arg_497_1.var_.characterEffect1049ui_story and not isNil(var_500_0) then
					local var_500_4 = Mathf.Lerp(0, 0.5, var_500_3)

					arg_497_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_497_1.var_.characterEffect1049ui_story.fillRatio = var_500_4
				end
			end

			if arg_497_1.time_ >= var_500_1 + var_500_2 and arg_497_1.time_ < var_500_1 + var_500_2 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1049ui_story then
				local var_500_5 = 0.5

				arg_497_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_497_1.var_.characterEffect1049ui_story.fillRatio = var_500_5
			end

			local var_500_6 = 0
			local var_500_7 = 0.425

			if var_500_6 < arg_497_1.time_ and arg_497_1.time_ <= var_500_6 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_8 = arg_497_1:FormatText(StoryNameCfg[7].name)

				arg_497_1.leftNameTxt_.text = var_500_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_9 = arg_497_1:GetWordFromCfg(1104906122)
				local var_500_10 = arg_497_1:FormatText(var_500_9.content)

				arg_497_1.text_.text = var_500_10

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_11 = 17
				local var_500_12 = utf8.len(var_500_10)
				local var_500_13 = var_500_11 <= 0 and var_500_7 or var_500_7 * (var_500_12 / var_500_11)

				if var_500_13 > 0 and var_500_7 < var_500_13 then
					arg_497_1.talkMaxDuration = var_500_13

					if var_500_13 + var_500_6 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_13 + var_500_6
					end
				end

				arg_497_1.text_.text = var_500_10
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_14 = math.max(var_500_7, arg_497_1.talkMaxDuration)

			if var_500_6 <= arg_497_1.time_ and arg_497_1.time_ < var_500_6 + var_500_14 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_6) / var_500_14

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_6 + var_500_14 and arg_497_1.time_ < var_500_6 + var_500_14 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1104906123 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1104906123
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1104906124(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = arg_501_1.actors_["1049ui_story"].transform
			local var_504_1 = 0

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 then
				arg_501_1.var_.moveOldPos1049ui_story = var_504_0.localPosition
			end

			local var_504_2 = 0.001

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_2 then
				local var_504_3 = (arg_501_1.time_ - var_504_1) / var_504_2
				local var_504_4 = Vector3.New(0, 100, 0)

				var_504_0.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1049ui_story, var_504_4, var_504_3)

				local var_504_5 = manager.ui.mainCamera.transform.position - var_504_0.position

				var_504_0.forward = Vector3.New(var_504_5.x, var_504_5.y, var_504_5.z)

				local var_504_6 = var_504_0.localEulerAngles

				var_504_6.z = 0
				var_504_6.x = 0
				var_504_0.localEulerAngles = var_504_6
			end

			if arg_501_1.time_ >= var_504_1 + var_504_2 and arg_501_1.time_ < var_504_1 + var_504_2 + arg_504_0 then
				var_504_0.localPosition = Vector3.New(0, 100, 0)

				local var_504_7 = manager.ui.mainCamera.transform.position - var_504_0.position

				var_504_0.forward = Vector3.New(var_504_7.x, var_504_7.y, var_504_7.z)

				local var_504_8 = var_504_0.localEulerAngles

				var_504_8.z = 0
				var_504_8.x = 0
				var_504_0.localEulerAngles = var_504_8
			end

			local var_504_9 = 0
			local var_504_10 = 1.25

			if var_504_9 < arg_501_1.time_ and arg_501_1.time_ <= var_504_9 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_11 = arg_501_1:GetWordFromCfg(1104906123)
				local var_504_12 = arg_501_1:FormatText(var_504_11.content)

				arg_501_1.text_.text = var_504_12

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_13 = 50
				local var_504_14 = utf8.len(var_504_12)
				local var_504_15 = var_504_13 <= 0 and var_504_10 or var_504_10 * (var_504_14 / var_504_13)

				if var_504_15 > 0 and var_504_10 < var_504_15 then
					arg_501_1.talkMaxDuration = var_504_15

					if var_504_15 + var_504_9 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_15 + var_504_9
					end
				end

				arg_501_1.text_.text = var_504_12
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_16 = math.max(var_504_10, arg_501_1.talkMaxDuration)

			if var_504_9 <= arg_501_1.time_ and arg_501_1.time_ < var_504_9 + var_504_16 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_9) / var_504_16

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_9 + var_504_16 and arg_501_1.time_ < var_504_9 + var_504_16 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play1104906124 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1104906124
		arg_505_1.duration_ = 9

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1104906125(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = "R4902"

			if arg_505_1.bgs_[var_508_0] == nil then
				local var_508_1 = Object.Instantiate(arg_505_1.paintGo_)

				var_508_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_508_0)
				var_508_1.name = var_508_0
				var_508_1.transform.parent = arg_505_1.stage_.transform
				var_508_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_505_1.bgs_[var_508_0] = var_508_1
			end

			local var_508_2 = 2

			if var_508_2 < arg_505_1.time_ and arg_505_1.time_ <= var_508_2 + arg_508_0 then
				local var_508_3 = manager.ui.mainCamera.transform.localPosition
				local var_508_4 = Vector3.New(0, 0, 10) + Vector3.New(var_508_3.x, var_508_3.y, 0)
				local var_508_5 = arg_505_1.bgs_.R4902

				var_508_5.transform.localPosition = var_508_4
				var_508_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_508_6 = var_508_5:GetComponent("SpriteRenderer")

				if var_508_6 and var_508_6.sprite then
					local var_508_7 = (var_508_5.transform.localPosition - var_508_3).z
					local var_508_8 = manager.ui.mainCameraCom_
					local var_508_9 = 2 * var_508_7 * Mathf.Tan(var_508_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_508_10 = var_508_9 * var_508_8.aspect
					local var_508_11 = var_508_6.sprite.bounds.size.x
					local var_508_12 = var_508_6.sprite.bounds.size.y
					local var_508_13 = var_508_10 / var_508_11
					local var_508_14 = var_508_9 / var_508_12
					local var_508_15 = var_508_14 < var_508_13 and var_508_13 or var_508_14

					var_508_5.transform.localScale = Vector3.New(var_508_15, var_508_15, 0)
				end

				for iter_508_0, iter_508_1 in pairs(arg_505_1.bgs_) do
					if iter_508_0 ~= "R4902" then
						iter_508_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_508_16 = 3.999999999999

			if var_508_16 < arg_505_1.time_ and arg_505_1.time_ <= var_508_16 + arg_508_0 then
				arg_505_1.allBtn_.enabled = false
			end

			local var_508_17 = 0.3

			if arg_505_1.time_ >= var_508_16 + var_508_17 and arg_505_1.time_ < var_508_16 + var_508_17 + arg_508_0 then
				arg_505_1.allBtn_.enabled = true
			end

			local var_508_18 = 0

			if var_508_18 < arg_505_1.time_ and arg_505_1.time_ <= var_508_18 + arg_508_0 then
				arg_505_1.mask_.enabled = true
				arg_505_1.mask_.raycastTarget = true

				arg_505_1:SetGaussion(false)
			end

			local var_508_19 = 2

			if var_508_18 <= arg_505_1.time_ and arg_505_1.time_ < var_508_18 + var_508_19 then
				local var_508_20 = (arg_505_1.time_ - var_508_18) / var_508_19
				local var_508_21 = Color.New(0, 0, 0)

				var_508_21.a = Mathf.Lerp(0, 1, var_508_20)
				arg_505_1.mask_.color = var_508_21
			end

			if arg_505_1.time_ >= var_508_18 + var_508_19 and arg_505_1.time_ < var_508_18 + var_508_19 + arg_508_0 then
				local var_508_22 = Color.New(0, 0, 0)

				var_508_22.a = 1
				arg_505_1.mask_.color = var_508_22
			end

			local var_508_23 = 2

			if var_508_23 < arg_505_1.time_ and arg_505_1.time_ <= var_508_23 + arg_508_0 then
				arg_505_1.mask_.enabled = true
				arg_505_1.mask_.raycastTarget = true

				arg_505_1:SetGaussion(false)
			end

			local var_508_24 = 2

			if var_508_23 <= arg_505_1.time_ and arg_505_1.time_ < var_508_23 + var_508_24 then
				local var_508_25 = (arg_505_1.time_ - var_508_23) / var_508_24
				local var_508_26 = Color.New(0, 0, 0)

				var_508_26.a = Mathf.Lerp(1, 0, var_508_25)
				arg_505_1.mask_.color = var_508_26
			end

			if arg_505_1.time_ >= var_508_23 + var_508_24 and arg_505_1.time_ < var_508_23 + var_508_24 + arg_508_0 then
				local var_508_27 = Color.New(0, 0, 0)
				local var_508_28 = 0

				arg_505_1.mask_.enabled = false
				var_508_27.a = var_508_28
				arg_505_1.mask_.color = var_508_27
			end

			local var_508_29 = arg_505_1.bgs_.R4902.transform
			local var_508_30 = 2

			if var_508_30 < arg_505_1.time_ and arg_505_1.time_ <= var_508_30 + arg_508_0 then
				arg_505_1.var_.moveOldPosR4902 = var_508_29.localPosition
			end

			local var_508_31 = 0.001

			if var_508_30 <= arg_505_1.time_ and arg_505_1.time_ < var_508_30 + var_508_31 then
				local var_508_32 = (arg_505_1.time_ - var_508_30) / var_508_31
				local var_508_33 = Vector3.New(0, 0.5, 0)

				var_508_29.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPosR4902, var_508_33, var_508_32)
			end

			if arg_505_1.time_ >= var_508_30 + var_508_31 and arg_505_1.time_ < var_508_30 + var_508_31 + arg_508_0 then
				var_508_29.localPosition = Vector3.New(0, 0.5, 0)
			end

			local var_508_34 = arg_505_1.bgs_.R4902.transform
			local var_508_35 = 2.03333333333333

			if var_508_35 < arg_505_1.time_ and arg_505_1.time_ <= var_508_35 + arg_508_0 then
				arg_505_1.var_.moveOldPosR4902 = var_508_34.localPosition
			end

			local var_508_36 = 3.6

			if var_508_35 <= arg_505_1.time_ and arg_505_1.time_ < var_508_35 + var_508_36 then
				local var_508_37 = (arg_505_1.time_ - var_508_35) / var_508_36
				local var_508_38 = Vector3.New(0, 0, 0)

				var_508_34.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPosR4902, var_508_38, var_508_37)
			end

			if arg_505_1.time_ >= var_508_35 + var_508_36 and arg_505_1.time_ < var_508_35 + var_508_36 + arg_508_0 then
				var_508_34.localPosition = Vector3.New(0, 0, 0)
			end

			local var_508_39 = 4

			if var_508_39 < arg_505_1.time_ and arg_505_1.time_ <= var_508_39 + arg_508_0 then
				arg_505_1.allBtn_.enabled = false
			end

			local var_508_40 = 1.63333333333333

			if arg_505_1.time_ >= var_508_39 + var_508_40 and arg_505_1.time_ < var_508_39 + var_508_40 + arg_508_0 then
				arg_505_1.allBtn_.enabled = true
			end

			if arg_505_1.frameCnt_ <= 1 then
				arg_505_1.dialog_:SetActive(false)
			end

			local var_508_41 = 4
			local var_508_42 = 0.65

			if var_508_41 < arg_505_1.time_ and arg_505_1.time_ <= var_508_41 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0

				arg_505_1.dialog_:SetActive(true)

				arg_505_1.dialogCg_.alpha = 0

				local var_508_43 = LeanTween.value(arg_505_1.dialog_, 0, 1, 0.3)

				var_508_43:setOnUpdate(LuaHelper.FloatAction(function(arg_509_0)
					arg_505_1.dialogCg_.alpha = arg_509_0
				end))
				var_508_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_505_1.dialog_)
					var_508_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_505_1.duration_ = arg_505_1.duration_ + 0.3

				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_44 = arg_505_1:GetWordFromCfg(1104906124)
				local var_508_45 = arg_505_1:FormatText(var_508_44.content)

				arg_505_1.text_.text = var_508_45

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_46 = 26
				local var_508_47 = utf8.len(var_508_45)
				local var_508_48 = var_508_46 <= 0 and var_508_42 or var_508_42 * (var_508_47 / var_508_46)

				if var_508_48 > 0 and var_508_42 < var_508_48 then
					arg_505_1.talkMaxDuration = var_508_48
					var_508_41 = var_508_41 + 0.3

					if var_508_48 + var_508_41 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_48 + var_508_41
					end
				end

				arg_505_1.text_.text = var_508_45
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_49 = var_508_41 + 0.3
			local var_508_50 = math.max(var_508_42, arg_505_1.talkMaxDuration)

			if var_508_49 <= arg_505_1.time_ and arg_505_1.time_ < var_508_49 + var_508_50 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_49) / var_508_50

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_49 + var_508_50 and arg_505_1.time_ < var_508_49 + var_508_50 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R4902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333332,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R4902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.6,
				className = "StoryMoveNode",
				startTime = 2.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_505_1:InitPlayNodeList()
	end,
	Play1104906125 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1104906125
		arg_511_1.duration_ = 3.07

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1104906126(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["1049ui_story"]
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.characterEffect1049ui_story == nil then
				arg_511_1.var_.characterEffect1049ui_story = var_514_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_2 = 0.200000002980232

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 and not isNil(var_514_0) then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2

				if arg_511_1.var_.characterEffect1049ui_story and not isNil(var_514_0) then
					arg_511_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.characterEffect1049ui_story then
				arg_511_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_514_4 = 0
			local var_514_5 = 0.3

			if var_514_4 < arg_511_1.time_ and arg_511_1.time_ <= var_514_4 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_6 = arg_511_1:FormatText(StoryNameCfg[551].name)

				arg_511_1.leftNameTxt_.text = var_514_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_7 = arg_511_1:GetWordFromCfg(1104906125)
				local var_514_8 = arg_511_1:FormatText(var_514_7.content)

				arg_511_1.text_.text = var_514_8

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_9 = 12
				local var_514_10 = utf8.len(var_514_8)
				local var_514_11 = var_514_9 <= 0 and var_514_5 or var_514_5 * (var_514_10 / var_514_9)

				if var_514_11 > 0 and var_514_5 < var_514_11 then
					arg_511_1.talkMaxDuration = var_514_11

					if var_514_11 + var_514_4 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_11 + var_514_4
					end
				end

				arg_511_1.text_.text = var_514_8
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906125", "story_v_side_new_1104906.awb") ~= 0 then
					local var_514_12 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906125", "story_v_side_new_1104906.awb") / 1000

					if var_514_12 + var_514_4 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_12 + var_514_4
					end

					if var_514_7.prefab_name ~= "" and arg_511_1.actors_[var_514_7.prefab_name] ~= nil then
						local var_514_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_7.prefab_name].transform, "story_v_side_new_1104906", "1104906125", "story_v_side_new_1104906.awb")

						arg_511_1:RecordAudio("1104906125", var_514_13)
						arg_511_1:RecordAudio("1104906125", var_514_13)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906125", "story_v_side_new_1104906.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906125", "story_v_side_new_1104906.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_14 = math.max(var_514_5, arg_511_1.talkMaxDuration)

			if var_514_4 <= arg_511_1.time_ and arg_511_1.time_ < var_514_4 + var_514_14 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_4) / var_514_14

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_4 + var_514_14 and arg_511_1.time_ < var_514_4 + var_514_14 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play1104906126 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1104906126
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1104906127(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["1049ui_story"]
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.characterEffect1049ui_story == nil then
				arg_515_1.var_.characterEffect1049ui_story = var_518_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_2 = 0.200000002980232

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 and not isNil(var_518_0) then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2

				if arg_515_1.var_.characterEffect1049ui_story and not isNil(var_518_0) then
					local var_518_4 = Mathf.Lerp(0, 0.5, var_518_3)

					arg_515_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_515_1.var_.characterEffect1049ui_story.fillRatio = var_518_4
				end
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.characterEffect1049ui_story then
				local var_518_5 = 0.5

				arg_515_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_515_1.var_.characterEffect1049ui_story.fillRatio = var_518_5
			end

			local var_518_6 = 0
			local var_518_7 = 0.4

			if var_518_6 < arg_515_1.time_ and arg_515_1.time_ <= var_518_6 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_8 = arg_515_1:FormatText(StoryNameCfg[7].name)

				arg_515_1.leftNameTxt_.text = var_518_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_9 = arg_515_1:GetWordFromCfg(1104906126)
				local var_518_10 = arg_515_1:FormatText(var_518_9.content)

				arg_515_1.text_.text = var_518_10

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_11 = 16
				local var_518_12 = utf8.len(var_518_10)
				local var_518_13 = var_518_11 <= 0 and var_518_7 or var_518_7 * (var_518_12 / var_518_11)

				if var_518_13 > 0 and var_518_7 < var_518_13 then
					arg_515_1.talkMaxDuration = var_518_13

					if var_518_13 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_13 + var_518_6
					end
				end

				arg_515_1.text_.text = var_518_10
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_14 = math.max(var_518_7, arg_515_1.talkMaxDuration)

			if var_518_6 <= arg_515_1.time_ and arg_515_1.time_ < var_518_6 + var_518_14 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_6) / var_518_14

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_6 + var_518_14 and arg_515_1.time_ < var_518_6 + var_518_14 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play1104906127 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1104906127
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1104906128(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0
			local var_522_1 = 0.675

			if var_522_0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_2 = arg_519_1:FormatText(StoryNameCfg[7].name)

				arg_519_1.leftNameTxt_.text = var_522_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_519_1.callingController_:SetSelectedState("normal")

				arg_519_1.keyicon_.color = Color.New(1, 1, 1)
				arg_519_1.icon_.color = Color.New(1, 1, 1)

				local var_522_3 = arg_519_1:GetWordFromCfg(1104906127)
				local var_522_4 = arg_519_1:FormatText(var_522_3.content)

				arg_519_1.text_.text = var_522_4

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_5 = 27
				local var_522_6 = utf8.len(var_522_4)
				local var_522_7 = var_522_5 <= 0 and var_522_1 or var_522_1 * (var_522_6 / var_522_5)

				if var_522_7 > 0 and var_522_1 < var_522_7 then
					arg_519_1.talkMaxDuration = var_522_7

					if var_522_7 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_0
					end
				end

				arg_519_1.text_.text = var_522_4
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_8 = math.max(var_522_1, arg_519_1.talkMaxDuration)

			if var_522_0 <= arg_519_1.time_ and arg_519_1.time_ < var_522_0 + var_522_8 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_0) / var_522_8

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_0 + var_522_8 and arg_519_1.time_ < var_522_0 + var_522_8 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1104906128 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1104906128
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1104906129(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0
			local var_526_1 = 0.625

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

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_3 = arg_523_1:GetWordFromCfg(1104906128)
				local var_526_4 = arg_523_1:FormatText(var_526_3.content)

				arg_523_1.text_.text = var_526_4

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 25
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
	Play1104906129 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1104906129
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1104906130(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0
			local var_530_1 = 0.75

			if var_530_0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, false)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_2 = arg_527_1:GetWordFromCfg(1104906129)
				local var_530_3 = arg_527_1:FormatText(var_530_2.content)

				arg_527_1.text_.text = var_530_3

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_4 = 30
				local var_530_5 = utf8.len(var_530_3)
				local var_530_6 = var_530_4 <= 0 and var_530_1 or var_530_1 * (var_530_5 / var_530_4)

				if var_530_6 > 0 and var_530_1 < var_530_6 then
					arg_527_1.talkMaxDuration = var_530_6

					if var_530_6 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_6 + var_530_0
					end
				end

				arg_527_1.text_.text = var_530_3
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_7 = math.max(var_530_1, arg_527_1.talkMaxDuration)

			if var_530_0 <= arg_527_1.time_ and arg_527_1.time_ < var_530_0 + var_530_7 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_0) / var_530_7

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_0 + var_530_7 and arg_527_1.time_ < var_530_0 + var_530_7 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1104906130 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1104906130
		arg_531_1.duration_ = 4.3

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1104906131(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = arg_531_1.actors_["1049ui_story"]
			local var_534_1 = 0

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 and not isNil(var_534_0) and arg_531_1.var_.characterEffect1049ui_story == nil then
				arg_531_1.var_.characterEffect1049ui_story = var_534_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_2 = 0.200000002980232

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_2 and not isNil(var_534_0) then
				local var_534_3 = (arg_531_1.time_ - var_534_1) / var_534_2

				if arg_531_1.var_.characterEffect1049ui_story and not isNil(var_534_0) then
					arg_531_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_531_1.time_ >= var_534_1 + var_534_2 and arg_531_1.time_ < var_534_1 + var_534_2 + arg_534_0 and not isNil(var_534_0) and arg_531_1.var_.characterEffect1049ui_story then
				arg_531_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_534_4 = 0
			local var_534_5 = 0.475

			if var_534_4 < arg_531_1.time_ and arg_531_1.time_ <= var_534_4 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_6 = arg_531_1:FormatText(StoryNameCfg[551].name)

				arg_531_1.leftNameTxt_.text = var_534_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_7 = arg_531_1:GetWordFromCfg(1104906130)
				local var_534_8 = arg_531_1:FormatText(var_534_7.content)

				arg_531_1.text_.text = var_534_8

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_9 = 19
				local var_534_10 = utf8.len(var_534_8)
				local var_534_11 = var_534_9 <= 0 and var_534_5 or var_534_5 * (var_534_10 / var_534_9)

				if var_534_11 > 0 and var_534_5 < var_534_11 then
					arg_531_1.talkMaxDuration = var_534_11

					if var_534_11 + var_534_4 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_11 + var_534_4
					end
				end

				arg_531_1.text_.text = var_534_8
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906130", "story_v_side_new_1104906.awb") ~= 0 then
					local var_534_12 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906130", "story_v_side_new_1104906.awb") / 1000

					if var_534_12 + var_534_4 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_12 + var_534_4
					end

					if var_534_7.prefab_name ~= "" and arg_531_1.actors_[var_534_7.prefab_name] ~= nil then
						local var_534_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_7.prefab_name].transform, "story_v_side_new_1104906", "1104906130", "story_v_side_new_1104906.awb")

						arg_531_1:RecordAudio("1104906130", var_534_13)
						arg_531_1:RecordAudio("1104906130", var_534_13)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906130", "story_v_side_new_1104906.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906130", "story_v_side_new_1104906.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_14 = math.max(var_534_5, arg_531_1.talkMaxDuration)

			if var_534_4 <= arg_531_1.time_ and arg_531_1.time_ < var_534_4 + var_534_14 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_4) / var_534_14

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_4 + var_534_14 and arg_531_1.time_ < var_534_4 + var_534_14 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1104906131 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1104906131
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1104906132(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = arg_535_1.actors_["1049ui_story"]
			local var_538_1 = 0

			if var_538_1 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 and not isNil(var_538_0) and arg_535_1.var_.characterEffect1049ui_story == nil then
				arg_535_1.var_.characterEffect1049ui_story = var_538_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_2 = 0.200000002980232

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_2 and not isNil(var_538_0) then
				local var_538_3 = (arg_535_1.time_ - var_538_1) / var_538_2

				if arg_535_1.var_.characterEffect1049ui_story and not isNil(var_538_0) then
					local var_538_4 = Mathf.Lerp(0, 0.5, var_538_3)

					arg_535_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1049ui_story.fillRatio = var_538_4
				end
			end

			if arg_535_1.time_ >= var_538_1 + var_538_2 and arg_535_1.time_ < var_538_1 + var_538_2 + arg_538_0 and not isNil(var_538_0) and arg_535_1.var_.characterEffect1049ui_story then
				local var_538_5 = 0.5

				arg_535_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1049ui_story.fillRatio = var_538_5
			end

			local var_538_6 = 0
			local var_538_7 = 0.875

			if var_538_6 < arg_535_1.time_ and arg_535_1.time_ <= var_538_6 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				local var_538_8 = arg_535_1:FormatText(StoryNameCfg[7].name)

				arg_535_1.leftNameTxt_.text = var_538_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_9 = arg_535_1:GetWordFromCfg(1104906131)
				local var_538_10 = arg_535_1:FormatText(var_538_9.content)

				arg_535_1.text_.text = var_538_10

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_11 = 35
				local var_538_12 = utf8.len(var_538_10)
				local var_538_13 = var_538_11 <= 0 and var_538_7 or var_538_7 * (var_538_12 / var_538_11)

				if var_538_13 > 0 and var_538_7 < var_538_13 then
					arg_535_1.talkMaxDuration = var_538_13

					if var_538_13 + var_538_6 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_13 + var_538_6
					end
				end

				arg_535_1.text_.text = var_538_10
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_14 = math.max(var_538_7, arg_535_1.talkMaxDuration)

			if var_538_6 <= arg_535_1.time_ and arg_535_1.time_ < var_538_6 + var_538_14 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_6) / var_538_14

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_6 + var_538_14 and arg_535_1.time_ < var_538_6 + var_538_14 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play1104906132 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1104906132
		arg_539_1.duration_ = 8.23

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1104906133(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = arg_539_1.actors_["1049ui_story"]
			local var_542_1 = 0

			if var_542_1 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 and not isNil(var_542_0) and arg_539_1.var_.characterEffect1049ui_story == nil then
				arg_539_1.var_.characterEffect1049ui_story = var_542_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_2 = 0.200000002980232

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_2 and not isNil(var_542_0) then
				local var_542_3 = (arg_539_1.time_ - var_542_1) / var_542_2

				if arg_539_1.var_.characterEffect1049ui_story and not isNil(var_542_0) then
					arg_539_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_539_1.time_ >= var_542_1 + var_542_2 and arg_539_1.time_ < var_542_1 + var_542_2 + arg_542_0 and not isNil(var_542_0) and arg_539_1.var_.characterEffect1049ui_story then
				arg_539_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_542_4 = 0
			local var_542_5 = 0.7

			if var_542_4 < arg_539_1.time_ and arg_539_1.time_ <= var_542_4 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_6 = arg_539_1:FormatText(StoryNameCfg[551].name)

				arg_539_1.leftNameTxt_.text = var_542_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_7 = arg_539_1:GetWordFromCfg(1104906132)
				local var_542_8 = arg_539_1:FormatText(var_542_7.content)

				arg_539_1.text_.text = var_542_8

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_9 = 28
				local var_542_10 = utf8.len(var_542_8)
				local var_542_11 = var_542_9 <= 0 and var_542_5 or var_542_5 * (var_542_10 / var_542_9)

				if var_542_11 > 0 and var_542_5 < var_542_11 then
					arg_539_1.talkMaxDuration = var_542_11

					if var_542_11 + var_542_4 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_11 + var_542_4
					end
				end

				arg_539_1.text_.text = var_542_8
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906132", "story_v_side_new_1104906.awb") ~= 0 then
					local var_542_12 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906132", "story_v_side_new_1104906.awb") / 1000

					if var_542_12 + var_542_4 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_12 + var_542_4
					end

					if var_542_7.prefab_name ~= "" and arg_539_1.actors_[var_542_7.prefab_name] ~= nil then
						local var_542_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_7.prefab_name].transform, "story_v_side_new_1104906", "1104906132", "story_v_side_new_1104906.awb")

						arg_539_1:RecordAudio("1104906132", var_542_13)
						arg_539_1:RecordAudio("1104906132", var_542_13)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906132", "story_v_side_new_1104906.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906132", "story_v_side_new_1104906.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_14 = math.max(var_542_5, arg_539_1.talkMaxDuration)

			if var_542_4 <= arg_539_1.time_ and arg_539_1.time_ < var_542_4 + var_542_14 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_4) / var_542_14

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_4 + var_542_14 and arg_539_1.time_ < var_542_4 + var_542_14 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1104906133 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1104906133
		arg_543_1.duration_ = 4.17

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1104906134(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0
			local var_546_1 = 0.325

			if var_546_0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_2 = arg_543_1:FormatText(StoryNameCfg[551].name)

				arg_543_1.leftNameTxt_.text = var_546_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_3 = arg_543_1:GetWordFromCfg(1104906133)
				local var_546_4 = arg_543_1:FormatText(var_546_3.content)

				arg_543_1.text_.text = var_546_4

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_5 = 13
				local var_546_6 = utf8.len(var_546_4)
				local var_546_7 = var_546_5 <= 0 and var_546_1 or var_546_1 * (var_546_6 / var_546_5)

				if var_546_7 > 0 and var_546_1 < var_546_7 then
					arg_543_1.talkMaxDuration = var_546_7

					if var_546_7 + var_546_0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_7 + var_546_0
					end
				end

				arg_543_1.text_.text = var_546_4
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906133", "story_v_side_new_1104906.awb") ~= 0 then
					local var_546_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906133", "story_v_side_new_1104906.awb") / 1000

					if var_546_8 + var_546_0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_8 + var_546_0
					end

					if var_546_3.prefab_name ~= "" and arg_543_1.actors_[var_546_3.prefab_name] ~= nil then
						local var_546_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_3.prefab_name].transform, "story_v_side_new_1104906", "1104906133", "story_v_side_new_1104906.awb")

						arg_543_1:RecordAudio("1104906133", var_546_9)
						arg_543_1:RecordAudio("1104906133", var_546_9)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906133", "story_v_side_new_1104906.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906133", "story_v_side_new_1104906.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_10 = math.max(var_546_1, arg_543_1.talkMaxDuration)

			if var_546_0 <= arg_543_1.time_ and arg_543_1.time_ < var_546_0 + var_546_10 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_0) / var_546_10

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_0 + var_546_10 and arg_543_1.time_ < var_546_0 + var_546_10 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play1104906134 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1104906134
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1104906135(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = arg_547_1.actors_["1049ui_story"]
			local var_550_1 = 0

			if var_550_1 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.characterEffect1049ui_story == nil then
				arg_547_1.var_.characterEffect1049ui_story = var_550_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_2 = 0.200000002980232

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_2 and not isNil(var_550_0) then
				local var_550_3 = (arg_547_1.time_ - var_550_1) / var_550_2

				if arg_547_1.var_.characterEffect1049ui_story and not isNil(var_550_0) then
					local var_550_4 = Mathf.Lerp(0, 0.5, var_550_3)

					arg_547_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_547_1.var_.characterEffect1049ui_story.fillRatio = var_550_4
				end
			end

			if arg_547_1.time_ >= var_550_1 + var_550_2 and arg_547_1.time_ < var_550_1 + var_550_2 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.characterEffect1049ui_story then
				local var_550_5 = 0.5

				arg_547_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_547_1.var_.characterEffect1049ui_story.fillRatio = var_550_5
			end

			local var_550_6 = 0
			local var_550_7 = 0.1

			if var_550_6 < arg_547_1.time_ and arg_547_1.time_ <= var_550_6 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				local var_550_8 = arg_547_1:FormatText(StoryNameCfg[7].name)

				arg_547_1.leftNameTxt_.text = var_550_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, true)
				arg_547_1.iconController_:SetSelectedState("hero")

				arg_547_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_547_1.callingController_:SetSelectedState("normal")

				arg_547_1.keyicon_.color = Color.New(1, 1, 1)
				arg_547_1.icon_.color = Color.New(1, 1, 1)

				local var_550_9 = arg_547_1:GetWordFromCfg(1104906134)
				local var_550_10 = arg_547_1:FormatText(var_550_9.content)

				arg_547_1.text_.text = var_550_10

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_11 = 4
				local var_550_12 = utf8.len(var_550_10)
				local var_550_13 = var_550_11 <= 0 and var_550_7 or var_550_7 * (var_550_12 / var_550_11)

				if var_550_13 > 0 and var_550_7 < var_550_13 then
					arg_547_1.talkMaxDuration = var_550_13

					if var_550_13 + var_550_6 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_13 + var_550_6
					end
				end

				arg_547_1.text_.text = var_550_10
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_14 = math.max(var_550_7, arg_547_1.talkMaxDuration)

			if var_550_6 <= arg_547_1.time_ and arg_547_1.time_ < var_550_6 + var_550_14 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_6) / var_550_14

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_6 + var_550_14 and arg_547_1.time_ < var_550_6 + var_550_14 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play1104906135 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1104906135
		arg_551_1.duration_ = 4.5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1104906136(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = arg_551_1.actors_["1049ui_story"]
			local var_554_1 = 0

			if var_554_1 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 and not isNil(var_554_0) and arg_551_1.var_.characterEffect1049ui_story == nil then
				arg_551_1.var_.characterEffect1049ui_story = var_554_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_2 = 0.200000002980232

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_2 and not isNil(var_554_0) then
				local var_554_3 = (arg_551_1.time_ - var_554_1) / var_554_2

				if arg_551_1.var_.characterEffect1049ui_story and not isNil(var_554_0) then
					arg_551_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_551_1.time_ >= var_554_1 + var_554_2 and arg_551_1.time_ < var_554_1 + var_554_2 + arg_554_0 and not isNil(var_554_0) and arg_551_1.var_.characterEffect1049ui_story then
				arg_551_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_554_4 = 0
			local var_554_5 = 0.475

			if var_554_4 < arg_551_1.time_ and arg_551_1.time_ <= var_554_4 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_6 = arg_551_1:FormatText(StoryNameCfg[551].name)

				arg_551_1.leftNameTxt_.text = var_554_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_7 = arg_551_1:GetWordFromCfg(1104906135)
				local var_554_8 = arg_551_1:FormatText(var_554_7.content)

				arg_551_1.text_.text = var_554_8

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_9 = 19
				local var_554_10 = utf8.len(var_554_8)
				local var_554_11 = var_554_9 <= 0 and var_554_5 or var_554_5 * (var_554_10 / var_554_9)

				if var_554_11 > 0 and var_554_5 < var_554_11 then
					arg_551_1.talkMaxDuration = var_554_11

					if var_554_11 + var_554_4 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_11 + var_554_4
					end
				end

				arg_551_1.text_.text = var_554_8
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906135", "story_v_side_new_1104906.awb") ~= 0 then
					local var_554_12 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906135", "story_v_side_new_1104906.awb") / 1000

					if var_554_12 + var_554_4 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_12 + var_554_4
					end

					if var_554_7.prefab_name ~= "" and arg_551_1.actors_[var_554_7.prefab_name] ~= nil then
						local var_554_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_7.prefab_name].transform, "story_v_side_new_1104906", "1104906135", "story_v_side_new_1104906.awb")

						arg_551_1:RecordAudio("1104906135", var_554_13)
						arg_551_1:RecordAudio("1104906135", var_554_13)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906135", "story_v_side_new_1104906.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906135", "story_v_side_new_1104906.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_14 = math.max(var_554_5, arg_551_1.talkMaxDuration)

			if var_554_4 <= arg_551_1.time_ and arg_551_1.time_ < var_554_4 + var_554_14 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_4) / var_554_14

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_4 + var_554_14 and arg_551_1.time_ < var_554_4 + var_554_14 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play1104906136 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1104906136
		arg_555_1.duration_ = 11.9

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1104906137(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 0
			local var_558_1 = 1.125

			if var_558_0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_0 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				local var_558_2 = arg_555_1:FormatText(StoryNameCfg[551].name)

				arg_555_1.leftNameTxt_.text = var_558_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_3 = arg_555_1:GetWordFromCfg(1104906136)
				local var_558_4 = arg_555_1:FormatText(var_558_3.content)

				arg_555_1.text_.text = var_558_4

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_5 = 45
				local var_558_6 = utf8.len(var_558_4)
				local var_558_7 = var_558_5 <= 0 and var_558_1 or var_558_1 * (var_558_6 / var_558_5)

				if var_558_7 > 0 and var_558_1 < var_558_7 then
					arg_555_1.talkMaxDuration = var_558_7

					if var_558_7 + var_558_0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_7 + var_558_0
					end
				end

				arg_555_1.text_.text = var_558_4
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906136", "story_v_side_new_1104906.awb") ~= 0 then
					local var_558_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906136", "story_v_side_new_1104906.awb") / 1000

					if var_558_8 + var_558_0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_8 + var_558_0
					end

					if var_558_3.prefab_name ~= "" and arg_555_1.actors_[var_558_3.prefab_name] ~= nil then
						local var_558_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_3.prefab_name].transform, "story_v_side_new_1104906", "1104906136", "story_v_side_new_1104906.awb")

						arg_555_1:RecordAudio("1104906136", var_558_9)
						arg_555_1:RecordAudio("1104906136", var_558_9)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906136", "story_v_side_new_1104906.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906136", "story_v_side_new_1104906.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_10 = math.max(var_558_1, arg_555_1.talkMaxDuration)

			if var_558_0 <= arg_555_1.time_ and arg_555_1.time_ < var_558_0 + var_558_10 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_0) / var_558_10

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_0 + var_558_10 and arg_555_1.time_ < var_558_0 + var_558_10 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play1104906137 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1104906137
		arg_559_1.duration_ = 5.8

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1104906138(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0
			local var_562_1 = 0.475

			if var_562_0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				local var_562_2 = arg_559_1:FormatText(StoryNameCfg[551].name)

				arg_559_1.leftNameTxt_.text = var_562_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_3 = arg_559_1:GetWordFromCfg(1104906137)
				local var_562_4 = arg_559_1:FormatText(var_562_3.content)

				arg_559_1.text_.text = var_562_4

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_5 = 19
				local var_562_6 = utf8.len(var_562_4)
				local var_562_7 = var_562_5 <= 0 and var_562_1 or var_562_1 * (var_562_6 / var_562_5)

				if var_562_7 > 0 and var_562_1 < var_562_7 then
					arg_559_1.talkMaxDuration = var_562_7

					if var_562_7 + var_562_0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_7 + var_562_0
					end
				end

				arg_559_1.text_.text = var_562_4
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906137", "story_v_side_new_1104906.awb") ~= 0 then
					local var_562_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906137", "story_v_side_new_1104906.awb") / 1000

					if var_562_8 + var_562_0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_8 + var_562_0
					end

					if var_562_3.prefab_name ~= "" and arg_559_1.actors_[var_562_3.prefab_name] ~= nil then
						local var_562_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_3.prefab_name].transform, "story_v_side_new_1104906", "1104906137", "story_v_side_new_1104906.awb")

						arg_559_1:RecordAudio("1104906137", var_562_9)
						arg_559_1:RecordAudio("1104906137", var_562_9)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906137", "story_v_side_new_1104906.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906137", "story_v_side_new_1104906.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_10 = math.max(var_562_1, arg_559_1.talkMaxDuration)

			if var_562_0 <= arg_559_1.time_ and arg_559_1.time_ < var_562_0 + var_562_10 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_0) / var_562_10

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_0 + var_562_10 and arg_559_1.time_ < var_562_0 + var_562_10 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play1104906138 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1104906138
		arg_563_1.duration_ = 11

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play1104906139(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 0
			local var_566_1 = 1.025

			if var_566_0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_2 = arg_563_1:FormatText(StoryNameCfg[551].name)

				arg_563_1.leftNameTxt_.text = var_566_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_3 = arg_563_1:GetWordFromCfg(1104906138)
				local var_566_4 = arg_563_1:FormatText(var_566_3.content)

				arg_563_1.text_.text = var_566_4

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_5 = 41
				local var_566_6 = utf8.len(var_566_4)
				local var_566_7 = var_566_5 <= 0 and var_566_1 or var_566_1 * (var_566_6 / var_566_5)

				if var_566_7 > 0 and var_566_1 < var_566_7 then
					arg_563_1.talkMaxDuration = var_566_7

					if var_566_7 + var_566_0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_7 + var_566_0
					end
				end

				arg_563_1.text_.text = var_566_4
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906138", "story_v_side_new_1104906.awb") ~= 0 then
					local var_566_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906138", "story_v_side_new_1104906.awb") / 1000

					if var_566_8 + var_566_0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_8 + var_566_0
					end

					if var_566_3.prefab_name ~= "" and arg_563_1.actors_[var_566_3.prefab_name] ~= nil then
						local var_566_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_3.prefab_name].transform, "story_v_side_new_1104906", "1104906138", "story_v_side_new_1104906.awb")

						arg_563_1:RecordAudio("1104906138", var_566_9)
						arg_563_1:RecordAudio("1104906138", var_566_9)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906138", "story_v_side_new_1104906.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906138", "story_v_side_new_1104906.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_10 = math.max(var_566_1, arg_563_1.talkMaxDuration)

			if var_566_0 <= arg_563_1.time_ and arg_563_1.time_ < var_566_0 + var_566_10 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_0) / var_566_10

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_0 + var_566_10 and arg_563_1.time_ < var_566_0 + var_566_10 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play1104906139 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1104906139
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1104906140(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = arg_567_1.actors_["1049ui_story"]
			local var_570_1 = 0

			if var_570_1 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 and not isNil(var_570_0) and arg_567_1.var_.characterEffect1049ui_story == nil then
				arg_567_1.var_.characterEffect1049ui_story = var_570_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_2 = 0.200000002980232

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_2 and not isNil(var_570_0) then
				local var_570_3 = (arg_567_1.time_ - var_570_1) / var_570_2

				if arg_567_1.var_.characterEffect1049ui_story and not isNil(var_570_0) then
					local var_570_4 = Mathf.Lerp(0, 0.5, var_570_3)

					arg_567_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_567_1.var_.characterEffect1049ui_story.fillRatio = var_570_4
				end
			end

			if arg_567_1.time_ >= var_570_1 + var_570_2 and arg_567_1.time_ < var_570_1 + var_570_2 + arg_570_0 and not isNil(var_570_0) and arg_567_1.var_.characterEffect1049ui_story then
				local var_570_5 = 0.5

				arg_567_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_567_1.var_.characterEffect1049ui_story.fillRatio = var_570_5
			end

			local var_570_6 = 0
			local var_570_7 = 1.025

			if var_570_6 < arg_567_1.time_ and arg_567_1.time_ <= var_570_6 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_8 = arg_567_1:FormatText(StoryNameCfg[7].name)

				arg_567_1.leftNameTxt_.text = var_570_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_9 = arg_567_1:GetWordFromCfg(1104906139)
				local var_570_10 = arg_567_1:FormatText(var_570_9.content)

				arg_567_1.text_.text = var_570_10

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_11 = 41
				local var_570_12 = utf8.len(var_570_10)
				local var_570_13 = var_570_11 <= 0 and var_570_7 or var_570_7 * (var_570_12 / var_570_11)

				if var_570_13 > 0 and var_570_7 < var_570_13 then
					arg_567_1.talkMaxDuration = var_570_13

					if var_570_13 + var_570_6 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_13 + var_570_6
					end
				end

				arg_567_1.text_.text = var_570_10
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_14 = math.max(var_570_7, arg_567_1.talkMaxDuration)

			if var_570_6 <= arg_567_1.time_ and arg_567_1.time_ < var_570_6 + var_570_14 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_6) / var_570_14

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_6 + var_570_14 and arg_567_1.time_ < var_570_6 + var_570_14 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play1104906140 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 1104906140
		arg_571_1.duration_ = 4.5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play1104906141(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = arg_571_1.actors_["1049ui_story"]
			local var_574_1 = 0

			if var_574_1 < arg_571_1.time_ and arg_571_1.time_ <= var_574_1 + arg_574_0 and not isNil(var_574_0) and arg_571_1.var_.characterEffect1049ui_story == nil then
				arg_571_1.var_.characterEffect1049ui_story = var_574_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_2 = 0.200000002980232

			if var_574_1 <= arg_571_1.time_ and arg_571_1.time_ < var_574_1 + var_574_2 and not isNil(var_574_0) then
				local var_574_3 = (arg_571_1.time_ - var_574_1) / var_574_2

				if arg_571_1.var_.characterEffect1049ui_story and not isNil(var_574_0) then
					arg_571_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= var_574_1 + var_574_2 and arg_571_1.time_ < var_574_1 + var_574_2 + arg_574_0 and not isNil(var_574_0) and arg_571_1.var_.characterEffect1049ui_story then
				arg_571_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_574_4 = 0
			local var_574_5 = 0.475

			if var_574_4 < arg_571_1.time_ and arg_571_1.time_ <= var_574_4 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_6 = arg_571_1:FormatText(StoryNameCfg[551].name)

				arg_571_1.leftNameTxt_.text = var_574_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_7 = arg_571_1:GetWordFromCfg(1104906140)
				local var_574_8 = arg_571_1:FormatText(var_574_7.content)

				arg_571_1.text_.text = var_574_8

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_9 = 19
				local var_574_10 = utf8.len(var_574_8)
				local var_574_11 = var_574_9 <= 0 and var_574_5 or var_574_5 * (var_574_10 / var_574_9)

				if var_574_11 > 0 and var_574_5 < var_574_11 then
					arg_571_1.talkMaxDuration = var_574_11

					if var_574_11 + var_574_4 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_11 + var_574_4
					end
				end

				arg_571_1.text_.text = var_574_8
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906140", "story_v_side_new_1104906.awb") ~= 0 then
					local var_574_12 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906140", "story_v_side_new_1104906.awb") / 1000

					if var_574_12 + var_574_4 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_12 + var_574_4
					end

					if var_574_7.prefab_name ~= "" and arg_571_1.actors_[var_574_7.prefab_name] ~= nil then
						local var_574_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_7.prefab_name].transform, "story_v_side_new_1104906", "1104906140", "story_v_side_new_1104906.awb")

						arg_571_1:RecordAudio("1104906140", var_574_13)
						arg_571_1:RecordAudio("1104906140", var_574_13)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906140", "story_v_side_new_1104906.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906140", "story_v_side_new_1104906.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_14 = math.max(var_574_5, arg_571_1.talkMaxDuration)

			if var_574_4 <= arg_571_1.time_ and arg_571_1.time_ < var_574_4 + var_574_14 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_4) / var_574_14

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_4 + var_574_14 and arg_571_1.time_ < var_574_4 + var_574_14 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play1104906141 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1104906141
		arg_575_1.duration_ = 5.23

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1104906142(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0
			local var_578_1 = 0.4

			if var_578_0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_2 = arg_575_1:FormatText(StoryNameCfg[551].name)

				arg_575_1.leftNameTxt_.text = var_578_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_3 = arg_575_1:GetWordFromCfg(1104906141)
				local var_578_4 = arg_575_1:FormatText(var_578_3.content)

				arg_575_1.text_.text = var_578_4

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_5 = 16
				local var_578_6 = utf8.len(var_578_4)
				local var_578_7 = var_578_5 <= 0 and var_578_1 or var_578_1 * (var_578_6 / var_578_5)

				if var_578_7 > 0 and var_578_1 < var_578_7 then
					arg_575_1.talkMaxDuration = var_578_7

					if var_578_7 + var_578_0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_7 + var_578_0
					end
				end

				arg_575_1.text_.text = var_578_4
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906141", "story_v_side_new_1104906.awb") ~= 0 then
					local var_578_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906141", "story_v_side_new_1104906.awb") / 1000

					if var_578_8 + var_578_0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_8 + var_578_0
					end

					if var_578_3.prefab_name ~= "" and arg_575_1.actors_[var_578_3.prefab_name] ~= nil then
						local var_578_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_3.prefab_name].transform, "story_v_side_new_1104906", "1104906141", "story_v_side_new_1104906.awb")

						arg_575_1:RecordAudio("1104906141", var_578_9)
						arg_575_1:RecordAudio("1104906141", var_578_9)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906141", "story_v_side_new_1104906.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906141", "story_v_side_new_1104906.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_10 = math.max(var_578_1, arg_575_1.talkMaxDuration)

			if var_578_0 <= arg_575_1.time_ and arg_575_1.time_ < var_578_0 + var_578_10 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_0) / var_578_10

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_0 + var_578_10 and arg_575_1.time_ < var_578_0 + var_578_10 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play1104906142 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1104906142
		arg_579_1.duration_ = 7.15

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1104906143(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = "R4902a"

			if arg_579_1.bgs_[var_582_0] == nil then
				local var_582_1 = Object.Instantiate(arg_579_1.paintGo_)

				var_582_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_582_0)
				var_582_1.name = var_582_0
				var_582_1.transform.parent = arg_579_1.stage_.transform
				var_582_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_579_1.bgs_[var_582_0] = var_582_1
			end

			local var_582_2 = 1

			if var_582_2 < arg_579_1.time_ and arg_579_1.time_ <= var_582_2 + arg_582_0 then
				local var_582_3 = manager.ui.mainCamera.transform.localPosition
				local var_582_4 = Vector3.New(0, 0, 10) + Vector3.New(var_582_3.x, var_582_3.y, 0)
				local var_582_5 = arg_579_1.bgs_.R4902a

				var_582_5.transform.localPosition = var_582_4
				var_582_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_582_6 = var_582_5:GetComponent("SpriteRenderer")

				if var_582_6 and var_582_6.sprite then
					local var_582_7 = (var_582_5.transform.localPosition - var_582_3).z
					local var_582_8 = manager.ui.mainCameraCom_
					local var_582_9 = 2 * var_582_7 * Mathf.Tan(var_582_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_582_10 = var_582_9 * var_582_8.aspect
					local var_582_11 = var_582_6.sprite.bounds.size.x
					local var_582_12 = var_582_6.sprite.bounds.size.y
					local var_582_13 = var_582_10 / var_582_11
					local var_582_14 = var_582_9 / var_582_12
					local var_582_15 = var_582_14 < var_582_13 and var_582_13 or var_582_14

					var_582_5.transform.localScale = Vector3.New(var_582_15, var_582_15, 0)
				end

				for iter_582_0, iter_582_1 in pairs(arg_579_1.bgs_) do
					if iter_582_0 ~= "R4902a" then
						iter_582_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_582_16 = 1.999999999999

			if var_582_16 < arg_579_1.time_ and arg_579_1.time_ <= var_582_16 + arg_582_0 then
				arg_579_1.allBtn_.enabled = false
			end

			local var_582_17 = 2.51666666666767

			if arg_579_1.time_ >= var_582_16 + var_582_17 and arg_579_1.time_ < var_582_16 + var_582_17 + arg_582_0 then
				arg_579_1.allBtn_.enabled = true
			end

			local var_582_18 = 0

			if var_582_18 < arg_579_1.time_ and arg_579_1.time_ <= var_582_18 + arg_582_0 then
				arg_579_1.mask_.enabled = true
				arg_579_1.mask_.raycastTarget = true

				arg_579_1:SetGaussion(false)
			end

			local var_582_19 = 1

			if var_582_18 <= arg_579_1.time_ and arg_579_1.time_ < var_582_18 + var_582_19 then
				local var_582_20 = (arg_579_1.time_ - var_582_18) / var_582_19
				local var_582_21 = Color.New(1, 1, 1)

				var_582_21.a = Mathf.Lerp(0, 1, var_582_20)
				arg_579_1.mask_.color = var_582_21
			end

			if arg_579_1.time_ >= var_582_18 + var_582_19 and arg_579_1.time_ < var_582_18 + var_582_19 + arg_582_0 then
				local var_582_22 = Color.New(1, 1, 1)

				var_582_22.a = 1
				arg_579_1.mask_.color = var_582_22
			end

			local var_582_23 = 1

			if var_582_23 < arg_579_1.time_ and arg_579_1.time_ <= var_582_23 + arg_582_0 then
				arg_579_1.mask_.enabled = true
				arg_579_1.mask_.raycastTarget = true

				arg_579_1:SetGaussion(false)
			end

			local var_582_24 = 1

			if var_582_23 <= arg_579_1.time_ and arg_579_1.time_ < var_582_23 + var_582_24 then
				local var_582_25 = (arg_579_1.time_ - var_582_23) / var_582_24
				local var_582_26 = Color.New(1, 1, 1)

				var_582_26.a = Mathf.Lerp(1, 0, var_582_25)
				arg_579_1.mask_.color = var_582_26
			end

			if arg_579_1.time_ >= var_582_23 + var_582_24 and arg_579_1.time_ < var_582_23 + var_582_24 + arg_582_0 then
				local var_582_27 = Color.New(1, 1, 1)
				local var_582_28 = 0

				arg_579_1.mask_.enabled = false
				var_582_27.a = var_582_28
				arg_579_1.mask_.color = var_582_27
			end

			local var_582_29 = arg_579_1.bgs_.R4902a.transform
			local var_582_30 = 1

			if var_582_30 < arg_579_1.time_ and arg_579_1.time_ <= var_582_30 + arg_582_0 then
				arg_579_1.var_.moveOldPosR4902a = var_582_29.localPosition
			end

			local var_582_31 = 0.001

			if var_582_30 <= arg_579_1.time_ and arg_579_1.time_ < var_582_30 + var_582_31 then
				local var_582_32 = (arg_579_1.time_ - var_582_30) / var_582_31
				local var_582_33 = Vector3.New(0, 1, 9.5)

				var_582_29.localPosition = Vector3.Lerp(arg_579_1.var_.moveOldPosR4902a, var_582_33, var_582_32)
			end

			if arg_579_1.time_ >= var_582_30 + var_582_31 and arg_579_1.time_ < var_582_30 + var_582_31 + arg_582_0 then
				var_582_29.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_582_34 = arg_579_1.bgs_.R4902a.transform
			local var_582_35 = 1.01666666666667

			if var_582_35 < arg_579_1.time_ and arg_579_1.time_ <= var_582_35 + arg_582_0 then
				arg_579_1.var_.moveOldPosR4902a = var_582_34.localPosition
			end

			local var_582_36 = 3.5

			if var_582_35 <= arg_579_1.time_ and arg_579_1.time_ < var_582_35 + var_582_36 then
				local var_582_37 = (arg_579_1.time_ - var_582_35) / var_582_36
				local var_582_38 = Vector3.New(0, 1, 10)

				var_582_34.localPosition = Vector3.Lerp(arg_579_1.var_.moveOldPosR4902a, var_582_38, var_582_37)
			end

			if arg_579_1.time_ >= var_582_35 + var_582_36 and arg_579_1.time_ < var_582_35 + var_582_36 + arg_582_0 then
				var_582_34.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_579_1.frameCnt_ <= 1 then
				arg_579_1.dialog_:SetActive(false)
			end

			local var_582_39 = 2.15
			local var_582_40 = 0.85

			if var_582_39 < arg_579_1.time_ and arg_579_1.time_ <= var_582_39 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0

				arg_579_1.dialog_:SetActive(true)

				arg_579_1.dialogCg_.alpha = 0

				local var_582_41 = LeanTween.value(arg_579_1.dialog_, 0, 1, 0.3)

				var_582_41:setOnUpdate(LuaHelper.FloatAction(function(arg_583_0)
					arg_579_1.dialogCg_.alpha = arg_583_0
				end))
				var_582_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_579_1.dialog_)
					var_582_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_579_1.duration_ = arg_579_1.duration_ + 0.3

				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_42 = arg_579_1:GetWordFromCfg(1104906142)
				local var_582_43 = arg_579_1:FormatText(var_582_42.content)

				arg_579_1.text_.text = var_582_43

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_44 = 34
				local var_582_45 = utf8.len(var_582_43)
				local var_582_46 = var_582_44 <= 0 and var_582_40 or var_582_40 * (var_582_45 / var_582_44)

				if var_582_46 > 0 and var_582_40 < var_582_46 then
					arg_579_1.talkMaxDuration = var_582_46
					var_582_39 = var_582_39 + 0.3

					if var_582_46 + var_582_39 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_46 + var_582_39
					end
				end

				arg_579_1.text_.text = var_582_43
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_47 = var_582_39 + 0.3
			local var_582_48 = math.max(var_582_40, arg_579_1.talkMaxDuration)

			if var_582_47 <= arg_579_1.time_ and arg_579_1.time_ < var_582_47 + var_582_48 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_47) / var_582_48

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_47 + var_582_48 and arg_579_1.time_ < var_582_47 + var_582_48 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R4902a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R4902a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 1.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_579_1:InitPlayNodeList()
	end,
	Play1104906143 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1104906143
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1104906144(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0
			local var_588_1 = 0.4

			if var_588_0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, false)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_2 = arg_585_1:GetWordFromCfg(1104906143)
				local var_588_3 = arg_585_1:FormatText(var_588_2.content)

				arg_585_1.text_.text = var_588_3

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_4 = 16
				local var_588_5 = utf8.len(var_588_3)
				local var_588_6 = var_588_4 <= 0 and var_588_1 or var_588_1 * (var_588_5 / var_588_4)

				if var_588_6 > 0 and var_588_1 < var_588_6 then
					arg_585_1.talkMaxDuration = var_588_6

					if var_588_6 + var_588_0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_6 + var_588_0
					end
				end

				arg_585_1.text_.text = var_588_3
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_7 = math.max(var_588_1, arg_585_1.talkMaxDuration)

			if var_588_0 <= arg_585_1.time_ and arg_585_1.time_ < var_588_0 + var_588_7 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_0) / var_588_7

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_0 + var_588_7 and arg_585_1.time_ < var_588_0 + var_588_7 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play1104906144 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1104906144
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1104906145(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0
			local var_592_1 = 0.825

			if var_592_0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				local var_592_2 = arg_589_1:FormatText(StoryNameCfg[7].name)

				arg_589_1.leftNameTxt_.text = var_592_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, true)
				arg_589_1.iconController_:SetSelectedState("hero")

				arg_589_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_589_1.callingController_:SetSelectedState("normal")

				arg_589_1.keyicon_.color = Color.New(1, 1, 1)
				arg_589_1.icon_.color = Color.New(1, 1, 1)

				local var_592_3 = arg_589_1:GetWordFromCfg(1104906144)
				local var_592_4 = arg_589_1:FormatText(var_592_3.content)

				arg_589_1.text_.text = var_592_4

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_5 = 33
				local var_592_6 = utf8.len(var_592_4)
				local var_592_7 = var_592_5 <= 0 and var_592_1 or var_592_1 * (var_592_6 / var_592_5)

				if var_592_7 > 0 and var_592_1 < var_592_7 then
					arg_589_1.talkMaxDuration = var_592_7

					if var_592_7 + var_592_0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_7 + var_592_0
					end
				end

				arg_589_1.text_.text = var_592_4
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_8 = math.max(var_592_1, arg_589_1.talkMaxDuration)

			if var_592_0 <= arg_589_1.time_ and arg_589_1.time_ < var_592_0 + var_592_8 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_0) / var_592_8

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_0 + var_592_8 and arg_589_1.time_ < var_592_0 + var_592_8 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play1104906145 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1104906145
		arg_593_1.duration_ = 1.73

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1104906146(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = arg_593_1.actors_["1049ui_story"]
			local var_596_1 = 0

			if var_596_1 < arg_593_1.time_ and arg_593_1.time_ <= var_596_1 + arg_596_0 and not isNil(var_596_0) and arg_593_1.var_.characterEffect1049ui_story == nil then
				arg_593_1.var_.characterEffect1049ui_story = var_596_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_2 = 0.200000002980232

			if var_596_1 <= arg_593_1.time_ and arg_593_1.time_ < var_596_1 + var_596_2 and not isNil(var_596_0) then
				local var_596_3 = (arg_593_1.time_ - var_596_1) / var_596_2

				if arg_593_1.var_.characterEffect1049ui_story and not isNil(var_596_0) then
					arg_593_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_593_1.time_ >= var_596_1 + var_596_2 and arg_593_1.time_ < var_596_1 + var_596_2 + arg_596_0 and not isNil(var_596_0) and arg_593_1.var_.characterEffect1049ui_story then
				arg_593_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_596_4 = 0
			local var_596_5 = 0.175

			if var_596_4 < arg_593_1.time_ and arg_593_1.time_ <= var_596_4 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_6 = arg_593_1:FormatText(StoryNameCfg[551].name)

				arg_593_1.leftNameTxt_.text = var_596_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_7 = arg_593_1:GetWordFromCfg(1104906145)
				local var_596_8 = arg_593_1:FormatText(var_596_7.content)

				arg_593_1.text_.text = var_596_8

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_9 = 7
				local var_596_10 = utf8.len(var_596_8)
				local var_596_11 = var_596_9 <= 0 and var_596_5 or var_596_5 * (var_596_10 / var_596_9)

				if var_596_11 > 0 and var_596_5 < var_596_11 then
					arg_593_1.talkMaxDuration = var_596_11

					if var_596_11 + var_596_4 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_11 + var_596_4
					end
				end

				arg_593_1.text_.text = var_596_8
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906145", "story_v_side_new_1104906.awb") ~= 0 then
					local var_596_12 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906145", "story_v_side_new_1104906.awb") / 1000

					if var_596_12 + var_596_4 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_12 + var_596_4
					end

					if var_596_7.prefab_name ~= "" and arg_593_1.actors_[var_596_7.prefab_name] ~= nil then
						local var_596_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_7.prefab_name].transform, "story_v_side_new_1104906", "1104906145", "story_v_side_new_1104906.awb")

						arg_593_1:RecordAudio("1104906145", var_596_13)
						arg_593_1:RecordAudio("1104906145", var_596_13)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906145", "story_v_side_new_1104906.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906145", "story_v_side_new_1104906.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_14 = math.max(var_596_5, arg_593_1.talkMaxDuration)

			if var_596_4 <= arg_593_1.time_ and arg_593_1.time_ < var_596_4 + var_596_14 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_4) / var_596_14

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_4 + var_596_14 and arg_593_1.time_ < var_596_4 + var_596_14 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play1104906146 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1104906146
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1104906147(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = arg_597_1.actors_["1049ui_story"]
			local var_600_1 = 0

			if var_600_1 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 and not isNil(var_600_0) and arg_597_1.var_.characterEffect1049ui_story == nil then
				arg_597_1.var_.characterEffect1049ui_story = var_600_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_2 = 0.200000002980232

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_2 and not isNil(var_600_0) then
				local var_600_3 = (arg_597_1.time_ - var_600_1) / var_600_2

				if arg_597_1.var_.characterEffect1049ui_story and not isNil(var_600_0) then
					local var_600_4 = Mathf.Lerp(0, 0.5, var_600_3)

					arg_597_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_597_1.var_.characterEffect1049ui_story.fillRatio = var_600_4
				end
			end

			if arg_597_1.time_ >= var_600_1 + var_600_2 and arg_597_1.time_ < var_600_1 + var_600_2 + arg_600_0 and not isNil(var_600_0) and arg_597_1.var_.characterEffect1049ui_story then
				local var_600_5 = 0.5

				arg_597_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_597_1.var_.characterEffect1049ui_story.fillRatio = var_600_5
			end

			local var_600_6 = 0
			local var_600_7 = 1.075

			if var_600_6 < arg_597_1.time_ and arg_597_1.time_ <= var_600_6 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, false)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_8 = arg_597_1:GetWordFromCfg(1104906146)
				local var_600_9 = arg_597_1:FormatText(var_600_8.content)

				arg_597_1.text_.text = var_600_9

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_10 = 43
				local var_600_11 = utf8.len(var_600_9)
				local var_600_12 = var_600_10 <= 0 and var_600_7 or var_600_7 * (var_600_11 / var_600_10)

				if var_600_12 > 0 and var_600_7 < var_600_12 then
					arg_597_1.talkMaxDuration = var_600_12

					if var_600_12 + var_600_6 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_12 + var_600_6
					end
				end

				arg_597_1.text_.text = var_600_9
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_13 = math.max(var_600_7, arg_597_1.talkMaxDuration)

			if var_600_6 <= arg_597_1.time_ and arg_597_1.time_ < var_600_6 + var_600_13 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_6) / var_600_13

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_6 + var_600_13 and arg_597_1.time_ < var_600_6 + var_600_13 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play1104906147 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 1104906147
		arg_601_1.duration_ = 7.77

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play1104906148(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = arg_601_1.actors_["1049ui_story"]
			local var_604_1 = 0

			if var_604_1 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.characterEffect1049ui_story == nil then
				arg_601_1.var_.characterEffect1049ui_story = var_604_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_2 = 0.200000002980232

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_2 and not isNil(var_604_0) then
				local var_604_3 = (arg_601_1.time_ - var_604_1) / var_604_2

				if arg_601_1.var_.characterEffect1049ui_story and not isNil(var_604_0) then
					arg_601_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_601_1.time_ >= var_604_1 + var_604_2 and arg_601_1.time_ < var_604_1 + var_604_2 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.characterEffect1049ui_story then
				arg_601_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_604_4 = 0
			local var_604_5 = 0.55

			if var_604_4 < arg_601_1.time_ and arg_601_1.time_ <= var_604_4 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				local var_604_6 = arg_601_1:FormatText(StoryNameCfg[551].name)

				arg_601_1.leftNameTxt_.text = var_604_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_7 = arg_601_1:GetWordFromCfg(1104906147)
				local var_604_8 = arg_601_1:FormatText(var_604_7.content)

				arg_601_1.text_.text = var_604_8

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_9 = 22
				local var_604_10 = utf8.len(var_604_8)
				local var_604_11 = var_604_9 <= 0 and var_604_5 or var_604_5 * (var_604_10 / var_604_9)

				if var_604_11 > 0 and var_604_5 < var_604_11 then
					arg_601_1.talkMaxDuration = var_604_11

					if var_604_11 + var_604_4 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_11 + var_604_4
					end
				end

				arg_601_1.text_.text = var_604_8
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906147", "story_v_side_new_1104906.awb") ~= 0 then
					local var_604_12 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906147", "story_v_side_new_1104906.awb") / 1000

					if var_604_12 + var_604_4 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_12 + var_604_4
					end

					if var_604_7.prefab_name ~= "" and arg_601_1.actors_[var_604_7.prefab_name] ~= nil then
						local var_604_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_601_1.actors_[var_604_7.prefab_name].transform, "story_v_side_new_1104906", "1104906147", "story_v_side_new_1104906.awb")

						arg_601_1:RecordAudio("1104906147", var_604_13)
						arg_601_1:RecordAudio("1104906147", var_604_13)
					else
						arg_601_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906147", "story_v_side_new_1104906.awb")
					end

					arg_601_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906147", "story_v_side_new_1104906.awb")
				end

				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_14 = math.max(var_604_5, arg_601_1.talkMaxDuration)

			if var_604_4 <= arg_601_1.time_ and arg_601_1.time_ < var_604_4 + var_604_14 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_4) / var_604_14

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_4 + var_604_14 and arg_601_1.time_ < var_604_4 + var_604_14 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play1104906148 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 1104906148
		arg_605_1.duration_ = 4.4

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play1104906149(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0
			local var_608_1 = 0.225

			if var_608_0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				local var_608_2 = arg_605_1:FormatText(StoryNameCfg[551].name)

				arg_605_1.leftNameTxt_.text = var_608_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_3 = arg_605_1:GetWordFromCfg(1104906148)
				local var_608_4 = arg_605_1:FormatText(var_608_3.content)

				arg_605_1.text_.text = var_608_4

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_5 = 9
				local var_608_6 = utf8.len(var_608_4)
				local var_608_7 = var_608_5 <= 0 and var_608_1 or var_608_1 * (var_608_6 / var_608_5)

				if var_608_7 > 0 and var_608_1 < var_608_7 then
					arg_605_1.talkMaxDuration = var_608_7

					if var_608_7 + var_608_0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_7 + var_608_0
					end
				end

				arg_605_1.text_.text = var_608_4
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906148", "story_v_side_new_1104906.awb") ~= 0 then
					local var_608_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906148", "story_v_side_new_1104906.awb") / 1000

					if var_608_8 + var_608_0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_8 + var_608_0
					end

					if var_608_3.prefab_name ~= "" and arg_605_1.actors_[var_608_3.prefab_name] ~= nil then
						local var_608_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_3.prefab_name].transform, "story_v_side_new_1104906", "1104906148", "story_v_side_new_1104906.awb")

						arg_605_1:RecordAudio("1104906148", var_608_9)
						arg_605_1:RecordAudio("1104906148", var_608_9)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906148", "story_v_side_new_1104906.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906148", "story_v_side_new_1104906.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_10 = math.max(var_608_1, arg_605_1.talkMaxDuration)

			if var_608_0 <= arg_605_1.time_ and arg_605_1.time_ < var_608_0 + var_608_10 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_0) / var_608_10

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_0 + var_608_10 and arg_605_1.time_ < var_608_0 + var_608_10 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play1104906149 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 1104906149
		arg_609_1.duration_ = 8

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play1104906150(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 1.5

			if var_612_0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_0 + arg_612_0 then
				local var_612_1 = manager.ui.mainCamera.transform.localPosition
				local var_612_2 = Vector3.New(0, 0, 10) + Vector3.New(var_612_1.x, var_612_1.y, 0)
				local var_612_3 = arg_609_1.bgs_.STblack

				var_612_3.transform.localPosition = var_612_2
				var_612_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_612_4 = var_612_3:GetComponent("SpriteRenderer")

				if var_612_4 and var_612_4.sprite then
					local var_612_5 = (var_612_3.transform.localPosition - var_612_1).z
					local var_612_6 = manager.ui.mainCameraCom_
					local var_612_7 = 2 * var_612_5 * Mathf.Tan(var_612_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_612_8 = var_612_7 * var_612_6.aspect
					local var_612_9 = var_612_4.sprite.bounds.size.x
					local var_612_10 = var_612_4.sprite.bounds.size.y
					local var_612_11 = var_612_8 / var_612_9
					local var_612_12 = var_612_7 / var_612_10
					local var_612_13 = var_612_12 < var_612_11 and var_612_11 or var_612_12

					var_612_3.transform.localScale = Vector3.New(var_612_13, var_612_13, 0)
				end

				for iter_612_0, iter_612_1 in pairs(arg_609_1.bgs_) do
					if iter_612_0 ~= "STblack" then
						iter_612_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_612_14 = arg_609_1.actors_["1049ui_story"]
			local var_612_15 = 2.999999999999

			if var_612_15 < arg_609_1.time_ and arg_609_1.time_ <= var_612_15 + arg_612_0 and not isNil(var_612_14) and arg_609_1.var_.characterEffect1049ui_story == nil then
				arg_609_1.var_.characterEffect1049ui_story = var_612_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_16 = 0.200000002980232

			if var_612_15 <= arg_609_1.time_ and arg_609_1.time_ < var_612_15 + var_612_16 and not isNil(var_612_14) then
				local var_612_17 = (arg_609_1.time_ - var_612_15) / var_612_16

				if arg_609_1.var_.characterEffect1049ui_story and not isNil(var_612_14) then
					local var_612_18 = Mathf.Lerp(0, 0.5, var_612_17)

					arg_609_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_609_1.var_.characterEffect1049ui_story.fillRatio = var_612_18
				end
			end

			if arg_609_1.time_ >= var_612_15 + var_612_16 and arg_609_1.time_ < var_612_15 + var_612_16 + arg_612_0 and not isNil(var_612_14) and arg_609_1.var_.characterEffect1049ui_story then
				local var_612_19 = 0.5

				arg_609_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_609_1.var_.characterEffect1049ui_story.fillRatio = var_612_19
			end

			local var_612_20 = 0

			if var_612_20 < arg_609_1.time_ and arg_609_1.time_ <= var_612_20 + arg_612_0 then
				arg_609_1.mask_.enabled = true
				arg_609_1.mask_.raycastTarget = true

				arg_609_1:SetGaussion(false)
			end

			local var_612_21 = 1.5

			if var_612_20 <= arg_609_1.time_ and arg_609_1.time_ < var_612_20 + var_612_21 then
				local var_612_22 = (arg_609_1.time_ - var_612_20) / var_612_21
				local var_612_23 = Color.New(0, 0, 0)

				var_612_23.a = Mathf.Lerp(0, 1, var_612_22)
				arg_609_1.mask_.color = var_612_23
			end

			if arg_609_1.time_ >= var_612_20 + var_612_21 and arg_609_1.time_ < var_612_20 + var_612_21 + arg_612_0 then
				local var_612_24 = Color.New(0, 0, 0)

				var_612_24.a = 1
				arg_609_1.mask_.color = var_612_24
			end

			local var_612_25 = 1.5

			if var_612_25 < arg_609_1.time_ and arg_609_1.time_ <= var_612_25 + arg_612_0 then
				arg_609_1.mask_.enabled = true
				arg_609_1.mask_.raycastTarget = true

				arg_609_1:SetGaussion(false)
			end

			local var_612_26 = 1.5

			if var_612_25 <= arg_609_1.time_ and arg_609_1.time_ < var_612_25 + var_612_26 then
				local var_612_27 = (arg_609_1.time_ - var_612_25) / var_612_26
				local var_612_28 = Color.New(0, 0, 0)

				var_612_28.a = Mathf.Lerp(1, 0, var_612_27)
				arg_609_1.mask_.color = var_612_28
			end

			if arg_609_1.time_ >= var_612_25 + var_612_26 and arg_609_1.time_ < var_612_25 + var_612_26 + arg_612_0 then
				local var_612_29 = Color.New(0, 0, 0)
				local var_612_30 = 0

				arg_609_1.mask_.enabled = false
				var_612_29.a = var_612_30
				arg_609_1.mask_.color = var_612_29
			end

			local var_612_31 = 3
			local var_612_32 = 0.5

			if var_612_31 < arg_609_1.time_ and arg_609_1.time_ <= var_612_31 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, false)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_33 = arg_609_1:GetWordFromCfg(1104906149)
				local var_612_34 = arg_609_1:FormatText(var_612_33.content)

				arg_609_1.text_.text = var_612_34

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_35 = 20
				local var_612_36 = utf8.len(var_612_34)
				local var_612_37 = var_612_35 <= 0 and var_612_32 or var_612_32 * (var_612_36 / var_612_35)

				if var_612_37 > 0 and var_612_32 < var_612_37 then
					arg_609_1.talkMaxDuration = var_612_37

					if var_612_37 + var_612_31 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_37 + var_612_31
					end
				end

				arg_609_1.text_.text = var_612_34
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_38 = math.max(var_612_32, arg_609_1.talkMaxDuration)

			if var_612_31 <= arg_609_1.time_ and arg_609_1.time_ < var_612_31 + var_612_38 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_31) / var_612_38

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_31 + var_612_38 and arg_609_1.time_ < var_612_31 + var_612_38 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play1104906150 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1104906150
		arg_613_1.duration_ = 7

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1104906151(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = "K11g"

			if arg_613_1.bgs_[var_616_0] == nil then
				local var_616_1 = Object.Instantiate(arg_613_1.paintGo_)

				var_616_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_616_0)
				var_616_1.name = var_616_0
				var_616_1.transform.parent = arg_613_1.stage_.transform
				var_616_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_613_1.bgs_[var_616_0] = var_616_1
			end

			local var_616_2 = 0

			if var_616_2 < arg_613_1.time_ and arg_613_1.time_ <= var_616_2 + arg_616_0 then
				local var_616_3 = manager.ui.mainCamera.transform.localPosition
				local var_616_4 = Vector3.New(0, 0, 10) + Vector3.New(var_616_3.x, var_616_3.y, 0)
				local var_616_5 = arg_613_1.bgs_.K11g

				var_616_5.transform.localPosition = var_616_4
				var_616_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_616_6 = var_616_5:GetComponent("SpriteRenderer")

				if var_616_6 and var_616_6.sprite then
					local var_616_7 = (var_616_5.transform.localPosition - var_616_3).z
					local var_616_8 = manager.ui.mainCameraCom_
					local var_616_9 = 2 * var_616_7 * Mathf.Tan(var_616_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_616_10 = var_616_9 * var_616_8.aspect
					local var_616_11 = var_616_6.sprite.bounds.size.x
					local var_616_12 = var_616_6.sprite.bounds.size.y
					local var_616_13 = var_616_10 / var_616_11
					local var_616_14 = var_616_9 / var_616_12
					local var_616_15 = var_616_14 < var_616_13 and var_616_13 or var_616_14

					var_616_5.transform.localScale = Vector3.New(var_616_15, var_616_15, 0)
				end

				for iter_616_0, iter_616_1 in pairs(arg_613_1.bgs_) do
					if iter_616_0 ~= "K11g" then
						iter_616_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_616_16 = 2

			if var_616_16 < arg_613_1.time_ and arg_613_1.time_ <= var_616_16 + arg_616_0 then
				arg_613_1.allBtn_.enabled = false
			end

			local var_616_17 = 0.275

			if arg_613_1.time_ >= var_616_16 + var_616_17 and arg_613_1.time_ < var_616_16 + var_616_17 + arg_616_0 then
				arg_613_1.allBtn_.enabled = true
			end

			local var_616_18 = 0

			if var_616_18 < arg_613_1.time_ and arg_613_1.time_ <= var_616_18 + arg_616_0 then
				arg_613_1.mask_.enabled = true
				arg_613_1.mask_.raycastTarget = true

				arg_613_1:SetGaussion(false)
			end

			local var_616_19 = 2

			if var_616_18 <= arg_613_1.time_ and arg_613_1.time_ < var_616_18 + var_616_19 then
				local var_616_20 = (arg_613_1.time_ - var_616_18) / var_616_19
				local var_616_21 = Color.New(0, 0, 0)

				var_616_21.a = Mathf.Lerp(1, 0, var_616_20)
				arg_613_1.mask_.color = var_616_21
			end

			if arg_613_1.time_ >= var_616_18 + var_616_19 and arg_613_1.time_ < var_616_18 + var_616_19 + arg_616_0 then
				local var_616_22 = Color.New(0, 0, 0)
				local var_616_23 = 0

				arg_613_1.mask_.enabled = false
				var_616_22.a = var_616_23
				arg_613_1.mask_.color = var_616_22
			end

			local var_616_24 = 0
			local var_616_25 = 1

			if var_616_24 < arg_613_1.time_ and arg_613_1.time_ <= var_616_24 + arg_616_0 then
				local var_616_26 = "stop"
				local var_616_27 = "effect"

				arg_613_1:AudioAction(var_616_26, var_616_27, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_616_28 = 0
			local var_616_29 = 1

			if var_616_28 < arg_613_1.time_ and arg_613_1.time_ <= var_616_28 + arg_616_0 then
				local var_616_30 = "play"
				local var_616_31 = "effect"

				arg_613_1:AudioAction(var_616_30, var_616_31, "se_story_side_1049", "se_story_side_1049_amb_wind_leaves", "")
			end

			if arg_613_1.frameCnt_ <= 1 then
				arg_613_1.dialog_:SetActive(false)
			end

			local var_616_32 = 1.999999999999
			local var_616_33 = 0.275

			if var_616_32 < arg_613_1.time_ and arg_613_1.time_ <= var_616_32 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0

				arg_613_1.dialog_:SetActive(true)

				arg_613_1.dialogCg_.alpha = 0

				local var_616_34 = LeanTween.value(arg_613_1.dialog_, 0, 1, 0.3)

				var_616_34:setOnUpdate(LuaHelper.FloatAction(function(arg_617_0)
					arg_613_1.dialogCg_.alpha = arg_617_0
				end))
				var_616_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_613_1.dialog_)
					var_616_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_613_1.duration_ = arg_613_1.duration_ + 0.3

				SetActive(arg_613_1.leftNameGo_, false)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_35 = arg_613_1:GetWordFromCfg(1104906150)
				local var_616_36 = arg_613_1:FormatText(var_616_35.content)

				arg_613_1.text_.text = var_616_36

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_37 = 11
				local var_616_38 = utf8.len(var_616_36)
				local var_616_39 = var_616_37 <= 0 and var_616_33 or var_616_33 * (var_616_38 / var_616_37)

				if var_616_39 > 0 and var_616_33 < var_616_39 then
					arg_613_1.talkMaxDuration = var_616_39
					var_616_32 = var_616_32 + 0.3

					if var_616_39 + var_616_32 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_39 + var_616_32
					end
				end

				arg_613_1.text_.text = var_616_36
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_40 = var_616_32 + 0.3
			local var_616_41 = math.max(var_616_33, arg_613_1.talkMaxDuration)

			if var_616_40 <= arg_613_1.time_ and arg_613_1.time_ < var_616_40 + var_616_41 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_40) / var_616_41

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_40 + var_616_41 and arg_613_1.time_ < var_616_40 + var_616_41 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play1104906151 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1104906151
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1104906152(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = 0
			local var_622_1 = 1.475

			if var_622_0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_0 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, false)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_2 = arg_619_1:GetWordFromCfg(1104906151)
				local var_622_3 = arg_619_1:FormatText(var_622_2.content)

				arg_619_1.text_.text = var_622_3

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_4 = 59
				local var_622_5 = utf8.len(var_622_3)
				local var_622_6 = var_622_4 <= 0 and var_622_1 or var_622_1 * (var_622_5 / var_622_4)

				if var_622_6 > 0 and var_622_1 < var_622_6 then
					arg_619_1.talkMaxDuration = var_622_6

					if var_622_6 + var_622_0 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_6 + var_622_0
					end
				end

				arg_619_1.text_.text = var_622_3
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_7 = math.max(var_622_1, arg_619_1.talkMaxDuration)

			if var_622_0 <= arg_619_1.time_ and arg_619_1.time_ < var_622_0 + var_622_7 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_0) / var_622_7

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_0 + var_622_7 and arg_619_1.time_ < var_622_0 + var_622_7 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play1104906152 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1104906152
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1104906153(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = 1
			local var_626_1 = 1

			if var_626_0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_0 + arg_626_0 then
				local var_626_2 = "play"
				local var_626_3 = "effect"

				arg_623_1:AudioAction(var_626_2, var_626_3, "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_626_4 = 0
			local var_626_5 = 1.25

			if var_626_4 < arg_623_1.time_ and arg_623_1.time_ <= var_626_4 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, false)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_6 = arg_623_1:GetWordFromCfg(1104906152)
				local var_626_7 = arg_623_1:FormatText(var_626_6.content)

				arg_623_1.text_.text = var_626_7

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_8 = 50
				local var_626_9 = utf8.len(var_626_7)
				local var_626_10 = var_626_8 <= 0 and var_626_5 or var_626_5 * (var_626_9 / var_626_8)

				if var_626_10 > 0 and var_626_5 < var_626_10 then
					arg_623_1.talkMaxDuration = var_626_10

					if var_626_10 + var_626_4 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_10 + var_626_4
					end
				end

				arg_623_1.text_.text = var_626_7
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_11 = math.max(var_626_5, arg_623_1.talkMaxDuration)

			if var_626_4 <= arg_623_1.time_ and arg_623_1.time_ < var_626_4 + var_626_11 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_4) / var_626_11

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_4 + var_626_11 and arg_623_1.time_ < var_626_4 + var_626_11 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1104906153 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1104906153
		arg_627_1.duration_ = 3

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1104906154(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = arg_627_1.actors_["1049ui_story"].transform
			local var_630_1 = 0

			if var_630_1 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 then
				arg_627_1.var_.moveOldPos1049ui_story = var_630_0.localPosition
			end

			local var_630_2 = 0.001

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_2 then
				local var_630_3 = (arg_627_1.time_ - var_630_1) / var_630_2
				local var_630_4 = Vector3.New(0, -1.2, -6)

				var_630_0.localPosition = Vector3.Lerp(arg_627_1.var_.moveOldPos1049ui_story, var_630_4, var_630_3)

				local var_630_5 = manager.ui.mainCamera.transform.position - var_630_0.position

				var_630_0.forward = Vector3.New(var_630_5.x, var_630_5.y, var_630_5.z)

				local var_630_6 = var_630_0.localEulerAngles

				var_630_6.z = 0
				var_630_6.x = 0
				var_630_0.localEulerAngles = var_630_6
			end

			if arg_627_1.time_ >= var_630_1 + var_630_2 and arg_627_1.time_ < var_630_1 + var_630_2 + arg_630_0 then
				var_630_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_630_7 = manager.ui.mainCamera.transform.position - var_630_0.position

				var_630_0.forward = Vector3.New(var_630_7.x, var_630_7.y, var_630_7.z)

				local var_630_8 = var_630_0.localEulerAngles

				var_630_8.z = 0
				var_630_8.x = 0
				var_630_0.localEulerAngles = var_630_8
			end

			local var_630_9 = arg_627_1.actors_["1049ui_story"]
			local var_630_10 = 0

			if var_630_10 < arg_627_1.time_ and arg_627_1.time_ <= var_630_10 + arg_630_0 and not isNil(var_630_9) and arg_627_1.var_.characterEffect1049ui_story == nil then
				arg_627_1.var_.characterEffect1049ui_story = var_630_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_11 = 0.200000002980232

			if var_630_10 <= arg_627_1.time_ and arg_627_1.time_ < var_630_10 + var_630_11 and not isNil(var_630_9) then
				local var_630_12 = (arg_627_1.time_ - var_630_10) / var_630_11

				if arg_627_1.var_.characterEffect1049ui_story and not isNil(var_630_9) then
					arg_627_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_627_1.time_ >= var_630_10 + var_630_11 and arg_627_1.time_ < var_630_10 + var_630_11 + arg_630_0 and not isNil(var_630_9) and arg_627_1.var_.characterEffect1049ui_story then
				arg_627_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_630_13 = 0

			if var_630_13 < arg_627_1.time_ and arg_627_1.time_ <= var_630_13 + arg_630_0 then
				arg_627_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_630_14 = 0

			if var_630_14 < arg_627_1.time_ and arg_627_1.time_ <= var_630_14 + arg_630_0 then
				arg_627_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_630_15 = 0
			local var_630_16 = 0.325

			if var_630_15 < arg_627_1.time_ and arg_627_1.time_ <= var_630_15 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				local var_630_17 = arg_627_1:FormatText(StoryNameCfg[551].name)

				arg_627_1.leftNameTxt_.text = var_630_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_18 = arg_627_1:GetWordFromCfg(1104906153)
				local var_630_19 = arg_627_1:FormatText(var_630_18.content)

				arg_627_1.text_.text = var_630_19

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_20 = 13
				local var_630_21 = utf8.len(var_630_19)
				local var_630_22 = var_630_20 <= 0 and var_630_16 or var_630_16 * (var_630_21 / var_630_20)

				if var_630_22 > 0 and var_630_16 < var_630_22 then
					arg_627_1.talkMaxDuration = var_630_22

					if var_630_22 + var_630_15 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_22 + var_630_15
					end
				end

				arg_627_1.text_.text = var_630_19
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906153", "story_v_side_new_1104906.awb") ~= 0 then
					local var_630_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906153", "story_v_side_new_1104906.awb") / 1000

					if var_630_23 + var_630_15 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_23 + var_630_15
					end

					if var_630_18.prefab_name ~= "" and arg_627_1.actors_[var_630_18.prefab_name] ~= nil then
						local var_630_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_18.prefab_name].transform, "story_v_side_new_1104906", "1104906153", "story_v_side_new_1104906.awb")

						arg_627_1:RecordAudio("1104906153", var_630_24)
						arg_627_1:RecordAudio("1104906153", var_630_24)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906153", "story_v_side_new_1104906.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906153", "story_v_side_new_1104906.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_25 = math.max(var_630_16, arg_627_1.talkMaxDuration)

			if var_630_15 <= arg_627_1.time_ and arg_627_1.time_ < var_630_15 + var_630_25 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_15) / var_630_25

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_15 + var_630_25 and arg_627_1.time_ < var_630_15 + var_630_25 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_627_1:InitPlayNodeList()
	end,
	Play1104906154 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1104906154
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1104906155(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = arg_631_1.actors_["1049ui_story"]
			local var_634_1 = 0

			if var_634_1 < arg_631_1.time_ and arg_631_1.time_ <= var_634_1 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect1049ui_story == nil then
				arg_631_1.var_.characterEffect1049ui_story = var_634_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_2 = 0.200000002980232

			if var_634_1 <= arg_631_1.time_ and arg_631_1.time_ < var_634_1 + var_634_2 and not isNil(var_634_0) then
				local var_634_3 = (arg_631_1.time_ - var_634_1) / var_634_2

				if arg_631_1.var_.characterEffect1049ui_story and not isNil(var_634_0) then
					local var_634_4 = Mathf.Lerp(0, 0.5, var_634_3)

					arg_631_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_631_1.var_.characterEffect1049ui_story.fillRatio = var_634_4
				end
			end

			if arg_631_1.time_ >= var_634_1 + var_634_2 and arg_631_1.time_ < var_634_1 + var_634_2 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect1049ui_story then
				local var_634_5 = 0.5

				arg_631_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_631_1.var_.characterEffect1049ui_story.fillRatio = var_634_5
			end

			local var_634_6 = 0
			local var_634_7 = 0.15

			if var_634_6 < arg_631_1.time_ and arg_631_1.time_ <= var_634_6 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				local var_634_8 = arg_631_1:FormatText(StoryNameCfg[7].name)

				arg_631_1.leftNameTxt_.text = var_634_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, true)
				arg_631_1.iconController_:SetSelectedState("hero")

				arg_631_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_631_1.callingController_:SetSelectedState("normal")

				arg_631_1.keyicon_.color = Color.New(1, 1, 1)
				arg_631_1.icon_.color = Color.New(1, 1, 1)

				local var_634_9 = arg_631_1:GetWordFromCfg(1104906154)
				local var_634_10 = arg_631_1:FormatText(var_634_9.content)

				arg_631_1.text_.text = var_634_10

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_11 = 6
				local var_634_12 = utf8.len(var_634_10)
				local var_634_13 = var_634_11 <= 0 and var_634_7 or var_634_7 * (var_634_12 / var_634_11)

				if var_634_13 > 0 and var_634_7 < var_634_13 then
					arg_631_1.talkMaxDuration = var_634_13

					if var_634_13 + var_634_6 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_13 + var_634_6
					end
				end

				arg_631_1.text_.text = var_634_10
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_14 = math.max(var_634_7, arg_631_1.talkMaxDuration)

			if var_634_6 <= arg_631_1.time_ and arg_631_1.time_ < var_634_6 + var_634_14 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_6) / var_634_14

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_6 + var_634_14 and arg_631_1.time_ < var_634_6 + var_634_14 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play1104906155 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1104906155
		arg_635_1.duration_ = 2.27

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1104906156(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = arg_635_1.actors_["1049ui_story"]
			local var_638_1 = 0

			if var_638_1 < arg_635_1.time_ and arg_635_1.time_ <= var_638_1 + arg_638_0 and not isNil(var_638_0) and arg_635_1.var_.characterEffect1049ui_story == nil then
				arg_635_1.var_.characterEffect1049ui_story = var_638_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_2 = 0.200000002980232

			if var_638_1 <= arg_635_1.time_ and arg_635_1.time_ < var_638_1 + var_638_2 and not isNil(var_638_0) then
				local var_638_3 = (arg_635_1.time_ - var_638_1) / var_638_2

				if arg_635_1.var_.characterEffect1049ui_story and not isNil(var_638_0) then
					arg_635_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_635_1.time_ >= var_638_1 + var_638_2 and arg_635_1.time_ < var_638_1 + var_638_2 + arg_638_0 and not isNil(var_638_0) and arg_635_1.var_.characterEffect1049ui_story then
				arg_635_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_638_4 = 0

			if var_638_4 < arg_635_1.time_ and arg_635_1.time_ <= var_638_4 + arg_638_0 then
				arg_635_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_638_5 = 0

			if var_638_5 < arg_635_1.time_ and arg_635_1.time_ <= var_638_5 + arg_638_0 then
				arg_635_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_638_6 = 0
			local var_638_7 = 0.225

			if var_638_6 < arg_635_1.time_ and arg_635_1.time_ <= var_638_6 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				local var_638_8 = arg_635_1:FormatText(StoryNameCfg[551].name)

				arg_635_1.leftNameTxt_.text = var_638_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_9 = arg_635_1:GetWordFromCfg(1104906155)
				local var_638_10 = arg_635_1:FormatText(var_638_9.content)

				arg_635_1.text_.text = var_638_10

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_11 = 9
				local var_638_12 = utf8.len(var_638_10)
				local var_638_13 = var_638_11 <= 0 and var_638_7 or var_638_7 * (var_638_12 / var_638_11)

				if var_638_13 > 0 and var_638_7 < var_638_13 then
					arg_635_1.talkMaxDuration = var_638_13

					if var_638_13 + var_638_6 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_13 + var_638_6
					end
				end

				arg_635_1.text_.text = var_638_10
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906155", "story_v_side_new_1104906.awb") ~= 0 then
					local var_638_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906155", "story_v_side_new_1104906.awb") / 1000

					if var_638_14 + var_638_6 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_14 + var_638_6
					end

					if var_638_9.prefab_name ~= "" and arg_635_1.actors_[var_638_9.prefab_name] ~= nil then
						local var_638_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_9.prefab_name].transform, "story_v_side_new_1104906", "1104906155", "story_v_side_new_1104906.awb")

						arg_635_1:RecordAudio("1104906155", var_638_15)
						arg_635_1:RecordAudio("1104906155", var_638_15)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906155", "story_v_side_new_1104906.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906155", "story_v_side_new_1104906.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_16 = math.max(var_638_7, arg_635_1.talkMaxDuration)

			if var_638_6 <= arg_635_1.time_ and arg_635_1.time_ < var_638_6 + var_638_16 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_6) / var_638_16

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_6 + var_638_16 and arg_635_1.time_ < var_638_6 + var_638_16 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play1104906156 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1104906156
		arg_639_1.duration_ = 6.43

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1104906157(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = 0

			if var_642_0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_0 + arg_642_0 then
				arg_639_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_642_1 = 0

			if var_642_1 < arg_639_1.time_ and arg_639_1.time_ <= var_642_1 + arg_642_0 then
				arg_639_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_642_2 = 0
			local var_642_3 = 0.675

			if var_642_2 < arg_639_1.time_ and arg_639_1.time_ <= var_642_2 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				local var_642_4 = arg_639_1:FormatText(StoryNameCfg[551].name)

				arg_639_1.leftNameTxt_.text = var_642_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_5 = arg_639_1:GetWordFromCfg(1104906156)
				local var_642_6 = arg_639_1:FormatText(var_642_5.content)

				arg_639_1.text_.text = var_642_6

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_7 = 27
				local var_642_8 = utf8.len(var_642_6)
				local var_642_9 = var_642_7 <= 0 and var_642_3 or var_642_3 * (var_642_8 / var_642_7)

				if var_642_9 > 0 and var_642_3 < var_642_9 then
					arg_639_1.talkMaxDuration = var_642_9

					if var_642_9 + var_642_2 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_9 + var_642_2
					end
				end

				arg_639_1.text_.text = var_642_6
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906156", "story_v_side_new_1104906.awb") ~= 0 then
					local var_642_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906156", "story_v_side_new_1104906.awb") / 1000

					if var_642_10 + var_642_2 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_10 + var_642_2
					end

					if var_642_5.prefab_name ~= "" and arg_639_1.actors_[var_642_5.prefab_name] ~= nil then
						local var_642_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_5.prefab_name].transform, "story_v_side_new_1104906", "1104906156", "story_v_side_new_1104906.awb")

						arg_639_1:RecordAudio("1104906156", var_642_11)
						arg_639_1:RecordAudio("1104906156", var_642_11)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906156", "story_v_side_new_1104906.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906156", "story_v_side_new_1104906.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_12 = math.max(var_642_3, arg_639_1.talkMaxDuration)

			if var_642_2 <= arg_639_1.time_ and arg_639_1.time_ < var_642_2 + var_642_12 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_2) / var_642_12

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_2 + var_642_12 and arg_639_1.time_ < var_642_2 + var_642_12 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play1104906157 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1104906157
		arg_643_1.duration_ = 9.02

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1104906158(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = "K01h"

			if arg_643_1.bgs_[var_646_0] == nil then
				local var_646_1 = Object.Instantiate(arg_643_1.paintGo_)

				var_646_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_646_0)
				var_646_1.name = var_646_0
				var_646_1.transform.parent = arg_643_1.stage_.transform
				var_646_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_643_1.bgs_[var_646_0] = var_646_1
			end

			local var_646_2 = 2.01733333333333

			if var_646_2 < arg_643_1.time_ and arg_643_1.time_ <= var_646_2 + arg_646_0 then
				local var_646_3 = manager.ui.mainCamera.transform.localPosition
				local var_646_4 = Vector3.New(0, 0, 10) + Vector3.New(var_646_3.x, var_646_3.y, 0)
				local var_646_5 = arg_643_1.bgs_.K01h

				var_646_5.transform.localPosition = var_646_4
				var_646_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_646_6 = var_646_5:GetComponent("SpriteRenderer")

				if var_646_6 and var_646_6.sprite then
					local var_646_7 = (var_646_5.transform.localPosition - var_646_3).z
					local var_646_8 = manager.ui.mainCameraCom_
					local var_646_9 = 2 * var_646_7 * Mathf.Tan(var_646_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_646_10 = var_646_9 * var_646_8.aspect
					local var_646_11 = var_646_6.sprite.bounds.size.x
					local var_646_12 = var_646_6.sprite.bounds.size.y
					local var_646_13 = var_646_10 / var_646_11
					local var_646_14 = var_646_9 / var_646_12
					local var_646_15 = var_646_14 < var_646_13 and var_646_13 or var_646_14

					var_646_5.transform.localScale = Vector3.New(var_646_15, var_646_15, 0)
				end

				for iter_646_0, iter_646_1 in pairs(arg_643_1.bgs_) do
					if iter_646_0 ~= "K01h" then
						iter_646_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_646_16 = 3.999999999999

			if var_646_16 < arg_643_1.time_ and arg_643_1.time_ <= var_646_16 + arg_646_0 then
				arg_643_1.allBtn_.enabled = false
			end

			local var_646_17 = 0.3

			if arg_643_1.time_ >= var_646_16 + var_646_17 and arg_643_1.time_ < var_646_16 + var_646_17 + arg_646_0 then
				arg_643_1.allBtn_.enabled = true
			end

			local var_646_18 = 0

			if var_646_18 < arg_643_1.time_ and arg_643_1.time_ <= var_646_18 + arg_646_0 then
				arg_643_1.mask_.enabled = true
				arg_643_1.mask_.raycastTarget = true

				arg_643_1:SetGaussion(false)
			end

			local var_646_19 = 2

			if var_646_18 <= arg_643_1.time_ and arg_643_1.time_ < var_646_18 + var_646_19 then
				local var_646_20 = (arg_643_1.time_ - var_646_18) / var_646_19
				local var_646_21 = Color.New(0, 0, 0)

				var_646_21.a = Mathf.Lerp(0, 1, var_646_20)
				arg_643_1.mask_.color = var_646_21
			end

			if arg_643_1.time_ >= var_646_18 + var_646_19 and arg_643_1.time_ < var_646_18 + var_646_19 + arg_646_0 then
				local var_646_22 = Color.New(0, 0, 0)

				var_646_22.a = 1
				arg_643_1.mask_.color = var_646_22
			end

			local var_646_23 = 2

			if var_646_23 < arg_643_1.time_ and arg_643_1.time_ <= var_646_23 + arg_646_0 then
				arg_643_1.mask_.enabled = true
				arg_643_1.mask_.raycastTarget = true

				arg_643_1:SetGaussion(false)
			end

			local var_646_24 = 2

			if var_646_23 <= arg_643_1.time_ and arg_643_1.time_ < var_646_23 + var_646_24 then
				local var_646_25 = (arg_643_1.time_ - var_646_23) / var_646_24
				local var_646_26 = Color.New(0, 0, 0)

				var_646_26.a = Mathf.Lerp(1, 0, var_646_25)
				arg_643_1.mask_.color = var_646_26
			end

			if arg_643_1.time_ >= var_646_23 + var_646_24 and arg_643_1.time_ < var_646_23 + var_646_24 + arg_646_0 then
				local var_646_27 = Color.New(0, 0, 0)
				local var_646_28 = 0

				arg_643_1.mask_.enabled = false
				var_646_27.a = var_646_28
				arg_643_1.mask_.color = var_646_27
			end

			local var_646_29 = arg_643_1.actors_["1049ui_story"]
			local var_646_30 = 1.98333333333333

			if var_646_30 < arg_643_1.time_ and arg_643_1.time_ <= var_646_30 + arg_646_0 and not isNil(var_646_29) and arg_643_1.var_.characterEffect1049ui_story == nil then
				arg_643_1.var_.characterEffect1049ui_story = var_646_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_31 = 0.0166666666666666

			if var_646_30 <= arg_643_1.time_ and arg_643_1.time_ < var_646_30 + var_646_31 and not isNil(var_646_29) then
				local var_646_32 = (arg_643_1.time_ - var_646_30) / var_646_31

				if arg_643_1.var_.characterEffect1049ui_story and not isNil(var_646_29) then
					local var_646_33 = Mathf.Lerp(0, 0.5, var_646_32)

					arg_643_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_643_1.var_.characterEffect1049ui_story.fillRatio = var_646_33
				end
			end

			if arg_643_1.time_ >= var_646_30 + var_646_31 and arg_643_1.time_ < var_646_30 + var_646_31 + arg_646_0 and not isNil(var_646_29) and arg_643_1.var_.characterEffect1049ui_story then
				local var_646_34 = 0.5

				arg_643_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_643_1.var_.characterEffect1049ui_story.fillRatio = var_646_34
			end

			local var_646_35 = arg_643_1.actors_["1049ui_story"].transform
			local var_646_36 = 1.98333333333333

			if var_646_36 < arg_643_1.time_ and arg_643_1.time_ <= var_646_36 + arg_646_0 then
				arg_643_1.var_.moveOldPos1049ui_story = var_646_35.localPosition
			end

			local var_646_37 = 0.001

			if var_646_36 <= arg_643_1.time_ and arg_643_1.time_ < var_646_36 + var_646_37 then
				local var_646_38 = (arg_643_1.time_ - var_646_36) / var_646_37
				local var_646_39 = Vector3.New(0, 100, 0)

				var_646_35.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos1049ui_story, var_646_39, var_646_38)

				local var_646_40 = manager.ui.mainCamera.transform.position - var_646_35.position

				var_646_35.forward = Vector3.New(var_646_40.x, var_646_40.y, var_646_40.z)

				local var_646_41 = var_646_35.localEulerAngles

				var_646_41.z = 0
				var_646_41.x = 0
				var_646_35.localEulerAngles = var_646_41
			end

			if arg_643_1.time_ >= var_646_36 + var_646_37 and arg_643_1.time_ < var_646_36 + var_646_37 + arg_646_0 then
				var_646_35.localPosition = Vector3.New(0, 100, 0)

				local var_646_42 = manager.ui.mainCamera.transform.position - var_646_35.position

				var_646_35.forward = Vector3.New(var_646_42.x, var_646_42.y, var_646_42.z)

				local var_646_43 = var_646_35.localEulerAngles

				var_646_43.z = 0
				var_646_43.x = 0
				var_646_35.localEulerAngles = var_646_43
			end

			local var_646_44 = 0.466666666666667
			local var_646_45 = 1

			if var_646_44 < arg_643_1.time_ and arg_643_1.time_ <= var_646_44 + arg_646_0 then
				local var_646_46 = "stop"
				local var_646_47 = "effect"

				arg_643_1:AudioAction(var_646_46, var_646_47, "se_story_side_1049", "se_story_side_1049_amb_wind_leaves", "")
			end

			local var_646_48 = 1.7
			local var_646_49 = 1

			if var_646_48 < arg_643_1.time_ and arg_643_1.time_ <= var_646_48 + arg_646_0 then
				local var_646_50 = "play"
				local var_646_51 = "effect"

				arg_643_1:AudioAction(var_646_50, var_646_51, "se_story_140", "se_story_140_amb_valley", "")
			end

			if arg_643_1.frameCnt_ <= 1 then
				arg_643_1.dialog_:SetActive(false)
			end

			local var_646_52 = 4.01733333333333
			local var_646_53 = 0.875

			if var_646_52 < arg_643_1.time_ and arg_643_1.time_ <= var_646_52 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0

				arg_643_1.dialog_:SetActive(true)

				arg_643_1.dialogCg_.alpha = 0

				local var_646_54 = LeanTween.value(arg_643_1.dialog_, 0, 1, 0.3)

				var_646_54:setOnUpdate(LuaHelper.FloatAction(function(arg_647_0)
					arg_643_1.dialogCg_.alpha = arg_647_0
				end))
				var_646_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_643_1.dialog_)
					var_646_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_643_1.duration_ = arg_643_1.duration_ + 0.3

				SetActive(arg_643_1.leftNameGo_, false)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_55 = arg_643_1:GetWordFromCfg(1104906157)
				local var_646_56 = arg_643_1:FormatText(var_646_55.content)

				arg_643_1.text_.text = var_646_56

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_57 = 35
				local var_646_58 = utf8.len(var_646_56)
				local var_646_59 = var_646_57 <= 0 and var_646_53 or var_646_53 * (var_646_58 / var_646_57)

				if var_646_59 > 0 and var_646_53 < var_646_59 then
					arg_643_1.talkMaxDuration = var_646_59
					var_646_52 = var_646_52 + 0.3

					if var_646_59 + var_646_52 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_59 + var_646_52
					end
				end

				arg_643_1.text_.text = var_646_56
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_60 = var_646_52 + 0.3
			local var_646_61 = math.max(var_646_53, arg_643_1.talkMaxDuration)

			if var_646_60 <= arg_643_1.time_ and arg_643_1.time_ < var_646_60 + var_646_61 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_60) / var_646_61

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_60 + var_646_61 and arg_643_1.time_ < var_646_60 + var_646_61 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_643_1:InitPlayNodeList()
	end,
	Play1104906158 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1104906158
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play1104906159(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0
			local var_652_1 = 0.825

			if var_652_0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, false)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_2 = arg_649_1:GetWordFromCfg(1104906158)
				local var_652_3 = arg_649_1:FormatText(var_652_2.content)

				arg_649_1.text_.text = var_652_3

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_4 = 33
				local var_652_5 = utf8.len(var_652_3)
				local var_652_6 = var_652_4 <= 0 and var_652_1 or var_652_1 * (var_652_5 / var_652_4)

				if var_652_6 > 0 and var_652_1 < var_652_6 then
					arg_649_1.talkMaxDuration = var_652_6

					if var_652_6 + var_652_0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_6 + var_652_0
					end
				end

				arg_649_1.text_.text = var_652_3
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_7 = math.max(var_652_1, arg_649_1.talkMaxDuration)

			if var_652_0 <= arg_649_1.time_ and arg_649_1.time_ < var_652_0 + var_652_7 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_0) / var_652_7

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_0 + var_652_7 and arg_649_1.time_ < var_652_0 + var_652_7 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play1104906159 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1104906159
		arg_653_1.duration_ = 2.77

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play1104906160(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = arg_653_1.actors_["1049ui_story"]
			local var_656_1 = 0

			if var_656_1 < arg_653_1.time_ and arg_653_1.time_ <= var_656_1 + arg_656_0 and not isNil(var_656_0) and arg_653_1.var_.characterEffect1049ui_story == nil then
				arg_653_1.var_.characterEffect1049ui_story = var_656_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_2 = 0.200000002980232

			if var_656_1 <= arg_653_1.time_ and arg_653_1.time_ < var_656_1 + var_656_2 and not isNil(var_656_0) then
				local var_656_3 = (arg_653_1.time_ - var_656_1) / var_656_2

				if arg_653_1.var_.characterEffect1049ui_story and not isNil(var_656_0) then
					arg_653_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_653_1.time_ >= var_656_1 + var_656_2 and arg_653_1.time_ < var_656_1 + var_656_2 + arg_656_0 and not isNil(var_656_0) and arg_653_1.var_.characterEffect1049ui_story then
				arg_653_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_656_4 = 0

			if var_656_4 < arg_653_1.time_ and arg_653_1.time_ <= var_656_4 + arg_656_0 then
				arg_653_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_656_5 = 0

			if var_656_5 < arg_653_1.time_ and arg_653_1.time_ <= var_656_5 + arg_656_0 then
				arg_653_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_656_6 = arg_653_1.actors_["1049ui_story"].transform
			local var_656_7 = 0

			if var_656_7 < arg_653_1.time_ and arg_653_1.time_ <= var_656_7 + arg_656_0 then
				arg_653_1.var_.moveOldPos1049ui_story = var_656_6.localPosition
			end

			local var_656_8 = 0.001

			if var_656_7 <= arg_653_1.time_ and arg_653_1.time_ < var_656_7 + var_656_8 then
				local var_656_9 = (arg_653_1.time_ - var_656_7) / var_656_8
				local var_656_10 = Vector3.New(0, -1.2, -6)

				var_656_6.localPosition = Vector3.Lerp(arg_653_1.var_.moveOldPos1049ui_story, var_656_10, var_656_9)

				local var_656_11 = manager.ui.mainCamera.transform.position - var_656_6.position

				var_656_6.forward = Vector3.New(var_656_11.x, var_656_11.y, var_656_11.z)

				local var_656_12 = var_656_6.localEulerAngles

				var_656_12.z = 0
				var_656_12.x = 0
				var_656_6.localEulerAngles = var_656_12
			end

			if arg_653_1.time_ >= var_656_7 + var_656_8 and arg_653_1.time_ < var_656_7 + var_656_8 + arg_656_0 then
				var_656_6.localPosition = Vector3.New(0, -1.2, -6)

				local var_656_13 = manager.ui.mainCamera.transform.position - var_656_6.position

				var_656_6.forward = Vector3.New(var_656_13.x, var_656_13.y, var_656_13.z)

				local var_656_14 = var_656_6.localEulerAngles

				var_656_14.z = 0
				var_656_14.x = 0
				var_656_6.localEulerAngles = var_656_14
			end

			local var_656_15 = 0
			local var_656_16 = 0.275

			if var_656_15 < arg_653_1.time_ and arg_653_1.time_ <= var_656_15 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				local var_656_17 = arg_653_1:FormatText(StoryNameCfg[551].name)

				arg_653_1.leftNameTxt_.text = var_656_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_18 = arg_653_1:GetWordFromCfg(1104906159)
				local var_656_19 = arg_653_1:FormatText(var_656_18.content)

				arg_653_1.text_.text = var_656_19

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_20 = 11
				local var_656_21 = utf8.len(var_656_19)
				local var_656_22 = var_656_20 <= 0 and var_656_16 or var_656_16 * (var_656_21 / var_656_20)

				if var_656_22 > 0 and var_656_16 < var_656_22 then
					arg_653_1.talkMaxDuration = var_656_22

					if var_656_22 + var_656_15 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_22 + var_656_15
					end
				end

				arg_653_1.text_.text = var_656_19
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906159", "story_v_side_new_1104906.awb") ~= 0 then
					local var_656_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906159", "story_v_side_new_1104906.awb") / 1000

					if var_656_23 + var_656_15 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_23 + var_656_15
					end

					if var_656_18.prefab_name ~= "" and arg_653_1.actors_[var_656_18.prefab_name] ~= nil then
						local var_656_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_653_1.actors_[var_656_18.prefab_name].transform, "story_v_side_new_1104906", "1104906159", "story_v_side_new_1104906.awb")

						arg_653_1:RecordAudio("1104906159", var_656_24)
						arg_653_1:RecordAudio("1104906159", var_656_24)
					else
						arg_653_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906159", "story_v_side_new_1104906.awb")
					end

					arg_653_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906159", "story_v_side_new_1104906.awb")
				end

				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_25 = math.max(var_656_16, arg_653_1.talkMaxDuration)

			if var_656_15 <= arg_653_1.time_ and arg_653_1.time_ < var_656_15 + var_656_25 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_15) / var_656_25

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_15 + var_656_25 and arg_653_1.time_ < var_656_15 + var_656_25 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_653_1:InitPlayNodeList()
	end,
	Play1104906160 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 1104906160
		arg_657_1.duration_ = 5

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play1104906161(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = arg_657_1.actors_["1049ui_story"]
			local var_660_1 = 0

			if var_660_1 < arg_657_1.time_ and arg_657_1.time_ <= var_660_1 + arg_660_0 and not isNil(var_660_0) and arg_657_1.var_.characterEffect1049ui_story == nil then
				arg_657_1.var_.characterEffect1049ui_story = var_660_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_2 = 0.200000002980232

			if var_660_1 <= arg_657_1.time_ and arg_657_1.time_ < var_660_1 + var_660_2 and not isNil(var_660_0) then
				local var_660_3 = (arg_657_1.time_ - var_660_1) / var_660_2

				if arg_657_1.var_.characterEffect1049ui_story and not isNil(var_660_0) then
					local var_660_4 = Mathf.Lerp(0, 0.5, var_660_3)

					arg_657_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_657_1.var_.characterEffect1049ui_story.fillRatio = var_660_4
				end
			end

			if arg_657_1.time_ >= var_660_1 + var_660_2 and arg_657_1.time_ < var_660_1 + var_660_2 + arg_660_0 and not isNil(var_660_0) and arg_657_1.var_.characterEffect1049ui_story then
				local var_660_5 = 0.5

				arg_657_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_657_1.var_.characterEffect1049ui_story.fillRatio = var_660_5
			end

			local var_660_6 = 0
			local var_660_7 = 1.6

			if var_660_6 < arg_657_1.time_ and arg_657_1.time_ <= var_660_6 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, false)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_8 = arg_657_1:GetWordFromCfg(1104906160)
				local var_660_9 = arg_657_1:FormatText(var_660_8.content)

				arg_657_1.text_.text = var_660_9

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_10 = 64
				local var_660_11 = utf8.len(var_660_9)
				local var_660_12 = var_660_10 <= 0 and var_660_7 or var_660_7 * (var_660_11 / var_660_10)

				if var_660_12 > 0 and var_660_7 < var_660_12 then
					arg_657_1.talkMaxDuration = var_660_12

					if var_660_12 + var_660_6 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_12 + var_660_6
					end
				end

				arg_657_1.text_.text = var_660_9
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)
				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_13 = math.max(var_660_7, arg_657_1.talkMaxDuration)

			if var_660_6 <= arg_657_1.time_ and arg_657_1.time_ < var_660_6 + var_660_13 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_6) / var_660_13

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_6 + var_660_13 and arg_657_1.time_ < var_660_6 + var_660_13 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play1104906161 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 1104906161
		arg_661_1.duration_ = 6.67

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play1104906162(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = arg_661_1.actors_["1049ui_story"]
			local var_664_1 = 0

			if var_664_1 < arg_661_1.time_ and arg_661_1.time_ <= var_664_1 + arg_664_0 and not isNil(var_664_0) and arg_661_1.var_.characterEffect1049ui_story == nil then
				arg_661_1.var_.characterEffect1049ui_story = var_664_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_2 = 0.200000002980232

			if var_664_1 <= arg_661_1.time_ and arg_661_1.time_ < var_664_1 + var_664_2 and not isNil(var_664_0) then
				local var_664_3 = (arg_661_1.time_ - var_664_1) / var_664_2

				if arg_661_1.var_.characterEffect1049ui_story and not isNil(var_664_0) then
					arg_661_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_661_1.time_ >= var_664_1 + var_664_2 and arg_661_1.time_ < var_664_1 + var_664_2 + arg_664_0 and not isNil(var_664_0) and arg_661_1.var_.characterEffect1049ui_story then
				arg_661_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_664_4 = 0

			if var_664_4 < arg_661_1.time_ and arg_661_1.time_ <= var_664_4 + arg_664_0 then
				arg_661_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_664_5 = 0

			if var_664_5 < arg_661_1.time_ and arg_661_1.time_ <= var_664_5 + arg_664_0 then
				arg_661_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_664_6 = 0
			local var_664_7 = 0.525

			if var_664_6 < arg_661_1.time_ and arg_661_1.time_ <= var_664_6 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				local var_664_8 = arg_661_1:FormatText(StoryNameCfg[551].name)

				arg_661_1.leftNameTxt_.text = var_664_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_9 = arg_661_1:GetWordFromCfg(1104906161)
				local var_664_10 = arg_661_1:FormatText(var_664_9.content)

				arg_661_1.text_.text = var_664_10

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_11 = 21
				local var_664_12 = utf8.len(var_664_10)
				local var_664_13 = var_664_11 <= 0 and var_664_7 or var_664_7 * (var_664_12 / var_664_11)

				if var_664_13 > 0 and var_664_7 < var_664_13 then
					arg_661_1.talkMaxDuration = var_664_13

					if var_664_13 + var_664_6 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_13 + var_664_6
					end
				end

				arg_661_1.text_.text = var_664_10
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906161", "story_v_side_new_1104906.awb") ~= 0 then
					local var_664_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906161", "story_v_side_new_1104906.awb") / 1000

					if var_664_14 + var_664_6 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_14 + var_664_6
					end

					if var_664_9.prefab_name ~= "" and arg_661_1.actors_[var_664_9.prefab_name] ~= nil then
						local var_664_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_661_1.actors_[var_664_9.prefab_name].transform, "story_v_side_new_1104906", "1104906161", "story_v_side_new_1104906.awb")

						arg_661_1:RecordAudio("1104906161", var_664_15)
						arg_661_1:RecordAudio("1104906161", var_664_15)
					else
						arg_661_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906161", "story_v_side_new_1104906.awb")
					end

					arg_661_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906161", "story_v_side_new_1104906.awb")
				end

				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_16 = math.max(var_664_7, arg_661_1.talkMaxDuration)

			if var_664_6 <= arg_661_1.time_ and arg_661_1.time_ < var_664_6 + var_664_16 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_6) / var_664_16

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_6 + var_664_16 and arg_661_1.time_ < var_664_6 + var_664_16 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play1104906162 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 1104906162
		arg_665_1.duration_ = 5

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play1104906163(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = arg_665_1.actors_["1049ui_story"]
			local var_668_1 = 0

			if var_668_1 < arg_665_1.time_ and arg_665_1.time_ <= var_668_1 + arg_668_0 and not isNil(var_668_0) and arg_665_1.var_.characterEffect1049ui_story == nil then
				arg_665_1.var_.characterEffect1049ui_story = var_668_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_668_2 = 0.200000002980232

			if var_668_1 <= arg_665_1.time_ and arg_665_1.time_ < var_668_1 + var_668_2 and not isNil(var_668_0) then
				local var_668_3 = (arg_665_1.time_ - var_668_1) / var_668_2

				if arg_665_1.var_.characterEffect1049ui_story and not isNil(var_668_0) then
					local var_668_4 = Mathf.Lerp(0, 0.5, var_668_3)

					arg_665_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_665_1.var_.characterEffect1049ui_story.fillRatio = var_668_4
				end
			end

			if arg_665_1.time_ >= var_668_1 + var_668_2 and arg_665_1.time_ < var_668_1 + var_668_2 + arg_668_0 and not isNil(var_668_0) and arg_665_1.var_.characterEffect1049ui_story then
				local var_668_5 = 0.5

				arg_665_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_665_1.var_.characterEffect1049ui_story.fillRatio = var_668_5
			end

			local var_668_6 = 0
			local var_668_7 = 0.8

			if var_668_6 < arg_665_1.time_ and arg_665_1.time_ <= var_668_6 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, false)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_8 = arg_665_1:GetWordFromCfg(1104906162)
				local var_668_9 = arg_665_1:FormatText(var_668_8.content)

				arg_665_1.text_.text = var_668_9

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_10 = 32
				local var_668_11 = utf8.len(var_668_9)
				local var_668_12 = var_668_10 <= 0 and var_668_7 or var_668_7 * (var_668_11 / var_668_10)

				if var_668_12 > 0 and var_668_7 < var_668_12 then
					arg_665_1.talkMaxDuration = var_668_12

					if var_668_12 + var_668_6 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_12 + var_668_6
					end
				end

				arg_665_1.text_.text = var_668_9
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)
				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_13 = math.max(var_668_7, arg_665_1.talkMaxDuration)

			if var_668_6 <= arg_665_1.time_ and arg_665_1.time_ < var_668_6 + var_668_13 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_6) / var_668_13

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_6 + var_668_13 and arg_665_1.time_ < var_668_6 + var_668_13 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play1104906163 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 1104906163
		arg_669_1.duration_ = 9.67

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play1104906164(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = arg_669_1.actors_["1049ui_story"]
			local var_672_1 = 0

			if var_672_1 < arg_669_1.time_ and arg_669_1.time_ <= var_672_1 + arg_672_0 and not isNil(var_672_0) and arg_669_1.var_.characterEffect1049ui_story == nil then
				arg_669_1.var_.characterEffect1049ui_story = var_672_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_672_2 = 0.200000002980232

			if var_672_1 <= arg_669_1.time_ and arg_669_1.time_ < var_672_1 + var_672_2 and not isNil(var_672_0) then
				local var_672_3 = (arg_669_1.time_ - var_672_1) / var_672_2

				if arg_669_1.var_.characterEffect1049ui_story and not isNil(var_672_0) then
					arg_669_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_669_1.time_ >= var_672_1 + var_672_2 and arg_669_1.time_ < var_672_1 + var_672_2 + arg_672_0 and not isNil(var_672_0) and arg_669_1.var_.characterEffect1049ui_story then
				arg_669_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_672_4 = 0

			if var_672_4 < arg_669_1.time_ and arg_669_1.time_ <= var_672_4 + arg_672_0 then
				arg_669_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			local var_672_5 = 0

			if var_672_5 < arg_669_1.time_ and arg_669_1.time_ <= var_672_5 + arg_672_0 then
				arg_669_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_672_6 = 0
			local var_672_7 = 0.7

			if var_672_6 < arg_669_1.time_ and arg_669_1.time_ <= var_672_6 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				local var_672_8 = arg_669_1:FormatText(StoryNameCfg[551].name)

				arg_669_1.leftNameTxt_.text = var_672_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_9 = arg_669_1:GetWordFromCfg(1104906163)
				local var_672_10 = arg_669_1:FormatText(var_672_9.content)

				arg_669_1.text_.text = var_672_10

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_11 = 28
				local var_672_12 = utf8.len(var_672_10)
				local var_672_13 = var_672_11 <= 0 and var_672_7 or var_672_7 * (var_672_12 / var_672_11)

				if var_672_13 > 0 and var_672_7 < var_672_13 then
					arg_669_1.talkMaxDuration = var_672_13

					if var_672_13 + var_672_6 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_13 + var_672_6
					end
				end

				arg_669_1.text_.text = var_672_10
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906163", "story_v_side_new_1104906.awb") ~= 0 then
					local var_672_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906163", "story_v_side_new_1104906.awb") / 1000

					if var_672_14 + var_672_6 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_14 + var_672_6
					end

					if var_672_9.prefab_name ~= "" and arg_669_1.actors_[var_672_9.prefab_name] ~= nil then
						local var_672_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_669_1.actors_[var_672_9.prefab_name].transform, "story_v_side_new_1104906", "1104906163", "story_v_side_new_1104906.awb")

						arg_669_1:RecordAudio("1104906163", var_672_15)
						arg_669_1:RecordAudio("1104906163", var_672_15)
					else
						arg_669_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906163", "story_v_side_new_1104906.awb")
					end

					arg_669_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906163", "story_v_side_new_1104906.awb")
				end

				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_16 = math.max(var_672_7, arg_669_1.talkMaxDuration)

			if var_672_6 <= arg_669_1.time_ and arg_669_1.time_ < var_672_6 + var_672_16 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_6) / var_672_16

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_6 + var_672_16 and arg_669_1.time_ < var_672_6 + var_672_16 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play1104906164 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 1104906164
		arg_673_1.duration_ = 8.13

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play1104906165(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			local var_676_0 = 0

			if var_676_0 < arg_673_1.time_ and arg_673_1.time_ <= var_676_0 + arg_676_0 then
				arg_673_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_676_1 = 0

			if var_676_1 < arg_673_1.time_ and arg_673_1.time_ <= var_676_1 + arg_676_0 then
				arg_673_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_676_2 = 0
			local var_676_3 = 0.8

			if var_676_2 < arg_673_1.time_ and arg_673_1.time_ <= var_676_2 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				local var_676_4 = arg_673_1:FormatText(StoryNameCfg[551].name)

				arg_673_1.leftNameTxt_.text = var_676_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_5 = arg_673_1:GetWordFromCfg(1104906164)
				local var_676_6 = arg_673_1:FormatText(var_676_5.content)

				arg_673_1.text_.text = var_676_6

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_7 = 32
				local var_676_8 = utf8.len(var_676_6)
				local var_676_9 = var_676_7 <= 0 and var_676_3 or var_676_3 * (var_676_8 / var_676_7)

				if var_676_9 > 0 and var_676_3 < var_676_9 then
					arg_673_1.talkMaxDuration = var_676_9

					if var_676_9 + var_676_2 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_9 + var_676_2
					end
				end

				arg_673_1.text_.text = var_676_6
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906164", "story_v_side_new_1104906.awb") ~= 0 then
					local var_676_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906164", "story_v_side_new_1104906.awb") / 1000

					if var_676_10 + var_676_2 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_10 + var_676_2
					end

					if var_676_5.prefab_name ~= "" and arg_673_1.actors_[var_676_5.prefab_name] ~= nil then
						local var_676_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_673_1.actors_[var_676_5.prefab_name].transform, "story_v_side_new_1104906", "1104906164", "story_v_side_new_1104906.awb")

						arg_673_1:RecordAudio("1104906164", var_676_11)
						arg_673_1:RecordAudio("1104906164", var_676_11)
					else
						arg_673_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906164", "story_v_side_new_1104906.awb")
					end

					arg_673_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906164", "story_v_side_new_1104906.awb")
				end

				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_12 = math.max(var_676_3, arg_673_1.talkMaxDuration)

			if var_676_2 <= arg_673_1.time_ and arg_673_1.time_ < var_676_2 + var_676_12 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_2) / var_676_12

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_2 + var_676_12 and arg_673_1.time_ < var_676_2 + var_676_12 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play1104906165 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 1104906165
		arg_677_1.duration_ = 9

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play1104906166(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = "K10g"

			if arg_677_1.bgs_[var_680_0] == nil then
				local var_680_1 = Object.Instantiate(arg_677_1.paintGo_)

				var_680_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_680_0)
				var_680_1.name = var_680_0
				var_680_1.transform.parent = arg_677_1.stage_.transform
				var_680_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_677_1.bgs_[var_680_0] = var_680_1
			end

			local var_680_2 = 2

			if var_680_2 < arg_677_1.time_ and arg_677_1.time_ <= var_680_2 + arg_680_0 then
				local var_680_3 = manager.ui.mainCamera.transform.localPosition
				local var_680_4 = Vector3.New(0, 0, 10) + Vector3.New(var_680_3.x, var_680_3.y, 0)
				local var_680_5 = arg_677_1.bgs_.K10g

				var_680_5.transform.localPosition = var_680_4
				var_680_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_680_6 = var_680_5:GetComponent("SpriteRenderer")

				if var_680_6 and var_680_6.sprite then
					local var_680_7 = (var_680_5.transform.localPosition - var_680_3).z
					local var_680_8 = manager.ui.mainCameraCom_
					local var_680_9 = 2 * var_680_7 * Mathf.Tan(var_680_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_680_10 = var_680_9 * var_680_8.aspect
					local var_680_11 = var_680_6.sprite.bounds.size.x
					local var_680_12 = var_680_6.sprite.bounds.size.y
					local var_680_13 = var_680_10 / var_680_11
					local var_680_14 = var_680_9 / var_680_12
					local var_680_15 = var_680_14 < var_680_13 and var_680_13 or var_680_14

					var_680_5.transform.localScale = Vector3.New(var_680_15, var_680_15, 0)
				end

				for iter_680_0, iter_680_1 in pairs(arg_677_1.bgs_) do
					if iter_680_0 ~= "K10g" then
						iter_680_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_680_16 = 3.999999999999

			if var_680_16 < arg_677_1.time_ and arg_677_1.time_ <= var_680_16 + arg_680_0 then
				arg_677_1.allBtn_.enabled = false
			end

			local var_680_17 = 0.3

			if arg_677_1.time_ >= var_680_16 + var_680_17 and arg_677_1.time_ < var_680_16 + var_680_17 + arg_680_0 then
				arg_677_1.allBtn_.enabled = true
			end

			local var_680_18 = 0

			if var_680_18 < arg_677_1.time_ and arg_677_1.time_ <= var_680_18 + arg_680_0 then
				arg_677_1.mask_.enabled = true
				arg_677_1.mask_.raycastTarget = true

				arg_677_1:SetGaussion(false)
			end

			local var_680_19 = 2

			if var_680_18 <= arg_677_1.time_ and arg_677_1.time_ < var_680_18 + var_680_19 then
				local var_680_20 = (arg_677_1.time_ - var_680_18) / var_680_19
				local var_680_21 = Color.New(0, 0, 0)

				var_680_21.a = Mathf.Lerp(0, 1, var_680_20)
				arg_677_1.mask_.color = var_680_21
			end

			if arg_677_1.time_ >= var_680_18 + var_680_19 and arg_677_1.time_ < var_680_18 + var_680_19 + arg_680_0 then
				local var_680_22 = Color.New(0, 0, 0)

				var_680_22.a = 1
				arg_677_1.mask_.color = var_680_22
			end

			local var_680_23 = 2

			if var_680_23 < arg_677_1.time_ and arg_677_1.time_ <= var_680_23 + arg_680_0 then
				arg_677_1.mask_.enabled = true
				arg_677_1.mask_.raycastTarget = true

				arg_677_1:SetGaussion(false)
			end

			local var_680_24 = 2

			if var_680_23 <= arg_677_1.time_ and arg_677_1.time_ < var_680_23 + var_680_24 then
				local var_680_25 = (arg_677_1.time_ - var_680_23) / var_680_24
				local var_680_26 = Color.New(0, 0, 0)

				var_680_26.a = Mathf.Lerp(1, 0, var_680_25)
				arg_677_1.mask_.color = var_680_26
			end

			if arg_677_1.time_ >= var_680_23 + var_680_24 and arg_677_1.time_ < var_680_23 + var_680_24 + arg_680_0 then
				local var_680_27 = Color.New(0, 0, 0)
				local var_680_28 = 0

				arg_677_1.mask_.enabled = false
				var_680_27.a = var_680_28
				arg_677_1.mask_.color = var_680_27
			end

			local var_680_29 = arg_677_1.actors_["1049ui_story"].transform
			local var_680_30 = 1.96599999815226

			if var_680_30 < arg_677_1.time_ and arg_677_1.time_ <= var_680_30 + arg_680_0 then
				arg_677_1.var_.moveOldPos1049ui_story = var_680_29.localPosition
			end

			local var_680_31 = 0.001

			if var_680_30 <= arg_677_1.time_ and arg_677_1.time_ < var_680_30 + var_680_31 then
				local var_680_32 = (arg_677_1.time_ - var_680_30) / var_680_31
				local var_680_33 = Vector3.New(0, 100, 0)

				var_680_29.localPosition = Vector3.Lerp(arg_677_1.var_.moveOldPos1049ui_story, var_680_33, var_680_32)

				local var_680_34 = manager.ui.mainCamera.transform.position - var_680_29.position

				var_680_29.forward = Vector3.New(var_680_34.x, var_680_34.y, var_680_34.z)

				local var_680_35 = var_680_29.localEulerAngles

				var_680_35.z = 0
				var_680_35.x = 0
				var_680_29.localEulerAngles = var_680_35
			end

			if arg_677_1.time_ >= var_680_30 + var_680_31 and arg_677_1.time_ < var_680_30 + var_680_31 + arg_680_0 then
				var_680_29.localPosition = Vector3.New(0, 100, 0)

				local var_680_36 = manager.ui.mainCamera.transform.position - var_680_29.position

				var_680_29.forward = Vector3.New(var_680_36.x, var_680_36.y, var_680_36.z)

				local var_680_37 = var_680_29.localEulerAngles

				var_680_37.z = 0
				var_680_37.x = 0
				var_680_29.localEulerAngles = var_680_37
			end

			local var_680_38 = arg_677_1.actors_["1049ui_story"]
			local var_680_39 = 1.96599999815226

			if var_680_39 < arg_677_1.time_ and arg_677_1.time_ <= var_680_39 + arg_680_0 and not isNil(var_680_38) and arg_677_1.var_.characterEffect1049ui_story == nil then
				arg_677_1.var_.characterEffect1049ui_story = var_680_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_40 = 0.034000001847744

			if var_680_39 <= arg_677_1.time_ and arg_677_1.time_ < var_680_39 + var_680_40 and not isNil(var_680_38) then
				local var_680_41 = (arg_677_1.time_ - var_680_39) / var_680_40

				if arg_677_1.var_.characterEffect1049ui_story and not isNil(var_680_38) then
					local var_680_42 = Mathf.Lerp(0, 0.5, var_680_41)

					arg_677_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_677_1.var_.characterEffect1049ui_story.fillRatio = var_680_42
				end
			end

			if arg_677_1.time_ >= var_680_39 + var_680_40 and arg_677_1.time_ < var_680_39 + var_680_40 + arg_680_0 and not isNil(var_680_38) and arg_677_1.var_.characterEffect1049ui_story then
				local var_680_43 = 0.5

				arg_677_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_677_1.var_.characterEffect1049ui_story.fillRatio = var_680_43
			end

			local var_680_44 = 0.366666666666667
			local var_680_45 = 1

			if var_680_44 < arg_677_1.time_ and arg_677_1.time_ <= var_680_44 + arg_680_0 then
				local var_680_46 = "stop"
				local var_680_47 = "effect"

				arg_677_1:AudioAction(var_680_46, var_680_47, "se_story_140", "se_story_140_amb_valley", "")
			end

			local var_680_48 = 1.53333333333333
			local var_680_49 = 1

			if var_680_48 < arg_677_1.time_ and arg_677_1.time_ <= var_680_48 + arg_680_0 then
				local var_680_50 = "play"
				local var_680_51 = "effect"

				arg_677_1:AudioAction(var_680_50, var_680_51, "se_story_side_1049", "se_story_side_1049_amb_wind_leaves", "")
			end

			if arg_677_1.frameCnt_ <= 1 then
				arg_677_1.dialog_:SetActive(false)
			end

			local var_680_52 = 3.999999999999
			local var_680_53 = 0.5

			if var_680_52 < arg_677_1.time_ and arg_677_1.time_ <= var_680_52 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0

				arg_677_1.dialog_:SetActive(true)

				arg_677_1.dialogCg_.alpha = 0

				local var_680_54 = LeanTween.value(arg_677_1.dialog_, 0, 1, 0.3)

				var_680_54:setOnUpdate(LuaHelper.FloatAction(function(arg_681_0)
					arg_677_1.dialogCg_.alpha = arg_681_0
				end))
				var_680_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_677_1.dialog_)
					var_680_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_677_1.duration_ = arg_677_1.duration_ + 0.3

				SetActive(arg_677_1.leftNameGo_, false)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_55 = arg_677_1:GetWordFromCfg(1104906165)
				local var_680_56 = arg_677_1:FormatText(var_680_55.content)

				arg_677_1.text_.text = var_680_56

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_57 = 20
				local var_680_58 = utf8.len(var_680_56)
				local var_680_59 = var_680_57 <= 0 and var_680_53 or var_680_53 * (var_680_58 / var_680_57)

				if var_680_59 > 0 and var_680_53 < var_680_59 then
					arg_677_1.talkMaxDuration = var_680_59
					var_680_52 = var_680_52 + 0.3

					if var_680_59 + var_680_52 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_59 + var_680_52
					end
				end

				arg_677_1.text_.text = var_680_56
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)
				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_60 = var_680_52 + 0.3
			local var_680_61 = math.max(var_680_53, arg_677_1.talkMaxDuration)

			if var_680_60 <= arg_677_1.time_ and arg_677_1.time_ < var_680_60 + var_680_61 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_60) / var_680_61

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_60 + var_680_61 and arg_677_1.time_ < var_680_60 + var_680_61 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_677_1:InitPlayNodeList()
	end,
	Play1104906166 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1104906166
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1104906167(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = 0
			local var_686_1 = 0.775

			if var_686_0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_0 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, false)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_2 = arg_683_1:GetWordFromCfg(1104906166)
				local var_686_3 = arg_683_1:FormatText(var_686_2.content)

				arg_683_1.text_.text = var_686_3

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_4 = 31
				local var_686_5 = utf8.len(var_686_3)
				local var_686_6 = var_686_4 <= 0 and var_686_1 or var_686_1 * (var_686_5 / var_686_4)

				if var_686_6 > 0 and var_686_1 < var_686_6 then
					arg_683_1.talkMaxDuration = var_686_6

					if var_686_6 + var_686_0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_6 + var_686_0
					end
				end

				arg_683_1.text_.text = var_686_3
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_7 = math.max(var_686_1, arg_683_1.talkMaxDuration)

			if var_686_0 <= arg_683_1.time_ and arg_683_1.time_ < var_686_0 + var_686_7 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_0) / var_686_7

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_0 + var_686_7 and arg_683_1.time_ < var_686_0 + var_686_7 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play1104906167 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1104906167
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play1104906168(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = 0
			local var_690_1 = 0.525

			if var_690_0 < arg_687_1.time_ and arg_687_1.time_ <= var_690_0 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				local var_690_2 = arg_687_1:FormatText(StoryNameCfg[7].name)

				arg_687_1.leftNameTxt_.text = var_690_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, true)
				arg_687_1.iconController_:SetSelectedState("hero")

				arg_687_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_687_1.callingController_:SetSelectedState("normal")

				arg_687_1.keyicon_.color = Color.New(1, 1, 1)
				arg_687_1.icon_.color = Color.New(1, 1, 1)

				local var_690_3 = arg_687_1:GetWordFromCfg(1104906167)
				local var_690_4 = arg_687_1:FormatText(var_690_3.content)

				arg_687_1.text_.text = var_690_4

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_5 = 21
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
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_8 = math.max(var_690_1, arg_687_1.talkMaxDuration)

			if var_690_0 <= arg_687_1.time_ and arg_687_1.time_ < var_690_0 + var_690_8 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_0) / var_690_8

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_0 + var_690_8 and arg_687_1.time_ < var_690_0 + var_690_8 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play1104906168 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1104906168
		arg_691_1.duration_ = 2

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1104906169(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = arg_691_1.actors_["1049ui_story"].transform
			local var_694_1 = 0

			if var_694_1 < arg_691_1.time_ and arg_691_1.time_ <= var_694_1 + arg_694_0 then
				arg_691_1.var_.moveOldPos1049ui_story = var_694_0.localPosition
			end

			local var_694_2 = 0.001

			if var_694_1 <= arg_691_1.time_ and arg_691_1.time_ < var_694_1 + var_694_2 then
				local var_694_3 = (arg_691_1.time_ - var_694_1) / var_694_2
				local var_694_4 = Vector3.New(0, -1.2, -6)

				var_694_0.localPosition = Vector3.Lerp(arg_691_1.var_.moveOldPos1049ui_story, var_694_4, var_694_3)

				local var_694_5 = manager.ui.mainCamera.transform.position - var_694_0.position

				var_694_0.forward = Vector3.New(var_694_5.x, var_694_5.y, var_694_5.z)

				local var_694_6 = var_694_0.localEulerAngles

				var_694_6.z = 0
				var_694_6.x = 0
				var_694_0.localEulerAngles = var_694_6
			end

			if arg_691_1.time_ >= var_694_1 + var_694_2 and arg_691_1.time_ < var_694_1 + var_694_2 + arg_694_0 then
				var_694_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_694_7 = manager.ui.mainCamera.transform.position - var_694_0.position

				var_694_0.forward = Vector3.New(var_694_7.x, var_694_7.y, var_694_7.z)

				local var_694_8 = var_694_0.localEulerAngles

				var_694_8.z = 0
				var_694_8.x = 0
				var_694_0.localEulerAngles = var_694_8
			end

			local var_694_9 = arg_691_1.actors_["1049ui_story"]
			local var_694_10 = 0

			if var_694_10 < arg_691_1.time_ and arg_691_1.time_ <= var_694_10 + arg_694_0 and not isNil(var_694_9) and arg_691_1.var_.characterEffect1049ui_story == nil then
				arg_691_1.var_.characterEffect1049ui_story = var_694_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_694_11 = 0.200000002980232

			if var_694_10 <= arg_691_1.time_ and arg_691_1.time_ < var_694_10 + var_694_11 and not isNil(var_694_9) then
				local var_694_12 = (arg_691_1.time_ - var_694_10) / var_694_11

				if arg_691_1.var_.characterEffect1049ui_story and not isNil(var_694_9) then
					arg_691_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_691_1.time_ >= var_694_10 + var_694_11 and arg_691_1.time_ < var_694_10 + var_694_11 + arg_694_0 and not isNil(var_694_9) and arg_691_1.var_.characterEffect1049ui_story then
				arg_691_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_694_13 = 0

			if var_694_13 < arg_691_1.time_ and arg_691_1.time_ <= var_694_13 + arg_694_0 then
				arg_691_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_694_14 = 0

			if var_694_14 < arg_691_1.time_ and arg_691_1.time_ <= var_694_14 + arg_694_0 then
				arg_691_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_694_15 = 0
			local var_694_16 = 0.2

			if var_694_15 < arg_691_1.time_ and arg_691_1.time_ <= var_694_15 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				local var_694_17 = arg_691_1:FormatText(StoryNameCfg[551].name)

				arg_691_1.leftNameTxt_.text = var_694_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_18 = arg_691_1:GetWordFromCfg(1104906168)
				local var_694_19 = arg_691_1:FormatText(var_694_18.content)

				arg_691_1.text_.text = var_694_19

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_20 = 8
				local var_694_21 = utf8.len(var_694_19)
				local var_694_22 = var_694_20 <= 0 and var_694_16 or var_694_16 * (var_694_21 / var_694_20)

				if var_694_22 > 0 and var_694_16 < var_694_22 then
					arg_691_1.talkMaxDuration = var_694_22

					if var_694_22 + var_694_15 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_22 + var_694_15
					end
				end

				arg_691_1.text_.text = var_694_19
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906168", "story_v_side_new_1104906.awb") ~= 0 then
					local var_694_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906168", "story_v_side_new_1104906.awb") / 1000

					if var_694_23 + var_694_15 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_23 + var_694_15
					end

					if var_694_18.prefab_name ~= "" and arg_691_1.actors_[var_694_18.prefab_name] ~= nil then
						local var_694_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_18.prefab_name].transform, "story_v_side_new_1104906", "1104906168", "story_v_side_new_1104906.awb")

						arg_691_1:RecordAudio("1104906168", var_694_24)
						arg_691_1:RecordAudio("1104906168", var_694_24)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906168", "story_v_side_new_1104906.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906168", "story_v_side_new_1104906.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_25 = math.max(var_694_16, arg_691_1.talkMaxDuration)

			if var_694_15 <= arg_691_1.time_ and arg_691_1.time_ < var_694_15 + var_694_25 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_15) / var_694_25

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_15 + var_694_25 and arg_691_1.time_ < var_694_15 + var_694_25 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_691_1:InitPlayNodeList()
	end,
	Play1104906169 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 1104906169
		arg_695_1.duration_ = 5

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play1104906170(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = arg_695_1.actors_["1049ui_story"]
			local var_698_1 = 0

			if var_698_1 < arg_695_1.time_ and arg_695_1.time_ <= var_698_1 + arg_698_0 and not isNil(var_698_0) and arg_695_1.var_.characterEffect1049ui_story == nil then
				arg_695_1.var_.characterEffect1049ui_story = var_698_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_698_2 = 0.200000002980232

			if var_698_1 <= arg_695_1.time_ and arg_695_1.time_ < var_698_1 + var_698_2 and not isNil(var_698_0) then
				local var_698_3 = (arg_695_1.time_ - var_698_1) / var_698_2

				if arg_695_1.var_.characterEffect1049ui_story and not isNil(var_698_0) then
					local var_698_4 = Mathf.Lerp(0, 0.5, var_698_3)

					arg_695_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_695_1.var_.characterEffect1049ui_story.fillRatio = var_698_4
				end
			end

			if arg_695_1.time_ >= var_698_1 + var_698_2 and arg_695_1.time_ < var_698_1 + var_698_2 + arg_698_0 and not isNil(var_698_0) and arg_695_1.var_.characterEffect1049ui_story then
				local var_698_5 = 0.5

				arg_695_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_695_1.var_.characterEffect1049ui_story.fillRatio = var_698_5
			end

			local var_698_6 = 0
			local var_698_7 = 0.35

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

				arg_695_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_695_1.callingController_:SetSelectedState("normal")

				arg_695_1.keyicon_.color = Color.New(1, 1, 1)
				arg_695_1.icon_.color = Color.New(1, 1, 1)

				local var_698_9 = arg_695_1:GetWordFromCfg(1104906169)
				local var_698_10 = arg_695_1:FormatText(var_698_9.content)

				arg_695_1.text_.text = var_698_10

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_11 = 14
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
	Play1104906170 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 1104906170
		arg_699_1.duration_ = 4.93

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play1104906171(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = arg_699_1.actors_["1049ui_story"]
			local var_702_1 = 0

			if var_702_1 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 and not isNil(var_702_0) and arg_699_1.var_.characterEffect1049ui_story == nil then
				arg_699_1.var_.characterEffect1049ui_story = var_702_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_702_2 = 0.200000002980232

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_2 and not isNil(var_702_0) then
				local var_702_3 = (arg_699_1.time_ - var_702_1) / var_702_2

				if arg_699_1.var_.characterEffect1049ui_story and not isNil(var_702_0) then
					arg_699_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_699_1.time_ >= var_702_1 + var_702_2 and arg_699_1.time_ < var_702_1 + var_702_2 + arg_702_0 and not isNil(var_702_0) and arg_699_1.var_.characterEffect1049ui_story then
				arg_699_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_702_4 = 0

			if var_702_4 < arg_699_1.time_ and arg_699_1.time_ <= var_702_4 + arg_702_0 then
				arg_699_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action4_1")
			end

			local var_702_5 = 0

			if var_702_5 < arg_699_1.time_ and arg_699_1.time_ <= var_702_5 + arg_702_0 then
				arg_699_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_702_6 = 0
			local var_702_7 = 0.375

			if var_702_6 < arg_699_1.time_ and arg_699_1.time_ <= var_702_6 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				local var_702_8 = arg_699_1:FormatText(StoryNameCfg[551].name)

				arg_699_1.leftNameTxt_.text = var_702_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_9 = arg_699_1:GetWordFromCfg(1104906170)
				local var_702_10 = arg_699_1:FormatText(var_702_9.content)

				arg_699_1.text_.text = var_702_10

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_11 = 15
				local var_702_12 = utf8.len(var_702_10)
				local var_702_13 = var_702_11 <= 0 and var_702_7 or var_702_7 * (var_702_12 / var_702_11)

				if var_702_13 > 0 and var_702_7 < var_702_13 then
					arg_699_1.talkMaxDuration = var_702_13

					if var_702_13 + var_702_6 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_13 + var_702_6
					end
				end

				arg_699_1.text_.text = var_702_10
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906170", "story_v_side_new_1104906.awb") ~= 0 then
					local var_702_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906170", "story_v_side_new_1104906.awb") / 1000

					if var_702_14 + var_702_6 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_14 + var_702_6
					end

					if var_702_9.prefab_name ~= "" and arg_699_1.actors_[var_702_9.prefab_name] ~= nil then
						local var_702_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_9.prefab_name].transform, "story_v_side_new_1104906", "1104906170", "story_v_side_new_1104906.awb")

						arg_699_1:RecordAudio("1104906170", var_702_15)
						arg_699_1:RecordAudio("1104906170", var_702_15)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906170", "story_v_side_new_1104906.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906170", "story_v_side_new_1104906.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_16 = math.max(var_702_7, arg_699_1.talkMaxDuration)

			if var_702_6 <= arg_699_1.time_ and arg_699_1.time_ < var_702_6 + var_702_16 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_6) / var_702_16

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_6 + var_702_16 and arg_699_1.time_ < var_702_6 + var_702_16 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {}

		arg_699_1:InitPlayNodeList()
	end,
	Play1104906171 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 1104906171
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play1104906172(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = arg_703_1.actors_["1049ui_story"].transform
			local var_706_1 = 0

			if var_706_1 < arg_703_1.time_ and arg_703_1.time_ <= var_706_1 + arg_706_0 then
				arg_703_1.var_.moveOldPos1049ui_story = var_706_0.localPosition
			end

			local var_706_2 = 0.001

			if var_706_1 <= arg_703_1.time_ and arg_703_1.time_ < var_706_1 + var_706_2 then
				local var_706_3 = (arg_703_1.time_ - var_706_1) / var_706_2
				local var_706_4 = Vector3.New(0, 100, 0)

				var_706_0.localPosition = Vector3.Lerp(arg_703_1.var_.moveOldPos1049ui_story, var_706_4, var_706_3)

				local var_706_5 = manager.ui.mainCamera.transform.position - var_706_0.position

				var_706_0.forward = Vector3.New(var_706_5.x, var_706_5.y, var_706_5.z)

				local var_706_6 = var_706_0.localEulerAngles

				var_706_6.z = 0
				var_706_6.x = 0
				var_706_0.localEulerAngles = var_706_6
			end

			if arg_703_1.time_ >= var_706_1 + var_706_2 and arg_703_1.time_ < var_706_1 + var_706_2 + arg_706_0 then
				var_706_0.localPosition = Vector3.New(0, 100, 0)

				local var_706_7 = manager.ui.mainCamera.transform.position - var_706_0.position

				var_706_0.forward = Vector3.New(var_706_7.x, var_706_7.y, var_706_7.z)

				local var_706_8 = var_706_0.localEulerAngles

				var_706_8.z = 0
				var_706_8.x = 0
				var_706_0.localEulerAngles = var_706_8
			end

			local var_706_9 = arg_703_1.actors_["1049ui_story"]
			local var_706_10 = 0

			if var_706_10 < arg_703_1.time_ and arg_703_1.time_ <= var_706_10 + arg_706_0 and not isNil(var_706_9) and arg_703_1.var_.characterEffect1049ui_story == nil then
				arg_703_1.var_.characterEffect1049ui_story = var_706_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_11 = 0.200000002980232

			if var_706_10 <= arg_703_1.time_ and arg_703_1.time_ < var_706_10 + var_706_11 and not isNil(var_706_9) then
				local var_706_12 = (arg_703_1.time_ - var_706_10) / var_706_11

				if arg_703_1.var_.characterEffect1049ui_story and not isNil(var_706_9) then
					local var_706_13 = Mathf.Lerp(0, 0.5, var_706_12)

					arg_703_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_703_1.var_.characterEffect1049ui_story.fillRatio = var_706_13
				end
			end

			if arg_703_1.time_ >= var_706_10 + var_706_11 and arg_703_1.time_ < var_706_10 + var_706_11 + arg_706_0 and not isNil(var_706_9) and arg_703_1.var_.characterEffect1049ui_story then
				local var_706_14 = 0.5

				arg_703_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_703_1.var_.characterEffect1049ui_story.fillRatio = var_706_14
			end

			local var_706_15 = 0
			local var_706_16 = 1.025

			if var_706_15 < arg_703_1.time_ and arg_703_1.time_ <= var_706_15 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, false)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_17 = arg_703_1:GetWordFromCfg(1104906171)
				local var_706_18 = arg_703_1:FormatText(var_706_17.content)

				arg_703_1.text_.text = var_706_18

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_19 = 41
				local var_706_20 = utf8.len(var_706_18)
				local var_706_21 = var_706_19 <= 0 and var_706_16 or var_706_16 * (var_706_20 / var_706_19)

				if var_706_21 > 0 and var_706_16 < var_706_21 then
					arg_703_1.talkMaxDuration = var_706_21

					if var_706_21 + var_706_15 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_21 + var_706_15
					end
				end

				arg_703_1.text_.text = var_706_18
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_22 = math.max(var_706_16, arg_703_1.talkMaxDuration)

			if var_706_15 <= arg_703_1.time_ and arg_703_1.time_ < var_706_15 + var_706_22 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_15) / var_706_22

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_15 + var_706_22 and arg_703_1.time_ < var_706_15 + var_706_22 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104906172 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 1104906172
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play1104906173(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = 0
			local var_710_1 = 0.15

			if var_710_0 < arg_707_1.time_ and arg_707_1.time_ <= var_710_0 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				local var_710_2 = arg_707_1:FormatText(StoryNameCfg[7].name)

				arg_707_1.leftNameTxt_.text = var_710_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, true)
				arg_707_1.iconController_:SetSelectedState("hero")

				arg_707_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_707_1.callingController_:SetSelectedState("normal")

				arg_707_1.keyicon_.color = Color.New(1, 1, 1)
				arg_707_1.icon_.color = Color.New(1, 1, 1)

				local var_710_3 = arg_707_1:GetWordFromCfg(1104906172)
				local var_710_4 = arg_707_1:FormatText(var_710_3.content)

				arg_707_1.text_.text = var_710_4

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_5 = 6
				local var_710_6 = utf8.len(var_710_4)
				local var_710_7 = var_710_5 <= 0 and var_710_1 or var_710_1 * (var_710_6 / var_710_5)

				if var_710_7 > 0 and var_710_1 < var_710_7 then
					arg_707_1.talkMaxDuration = var_710_7

					if var_710_7 + var_710_0 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_7 + var_710_0
					end
				end

				arg_707_1.text_.text = var_710_4
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_8 = math.max(var_710_1, arg_707_1.talkMaxDuration)

			if var_710_0 <= arg_707_1.time_ and arg_707_1.time_ < var_710_0 + var_710_8 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_0) / var_710_8

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_0 + var_710_8 and arg_707_1.time_ < var_710_0 + var_710_8 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play1104906173 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 1104906173
		arg_711_1.duration_ = 2

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play1104906174(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = arg_711_1.actors_["1049ui_story"].transform
			local var_714_1 = 0

			if var_714_1 < arg_711_1.time_ and arg_711_1.time_ <= var_714_1 + arg_714_0 then
				arg_711_1.var_.moveOldPos1049ui_story = var_714_0.localPosition
			end

			local var_714_2 = 0.001

			if var_714_1 <= arg_711_1.time_ and arg_711_1.time_ < var_714_1 + var_714_2 then
				local var_714_3 = (arg_711_1.time_ - var_714_1) / var_714_2
				local var_714_4 = Vector3.New(0, -1.2, -6)

				var_714_0.localPosition = Vector3.Lerp(arg_711_1.var_.moveOldPos1049ui_story, var_714_4, var_714_3)

				local var_714_5 = manager.ui.mainCamera.transform.position - var_714_0.position

				var_714_0.forward = Vector3.New(var_714_5.x, var_714_5.y, var_714_5.z)

				local var_714_6 = var_714_0.localEulerAngles

				var_714_6.z = 0
				var_714_6.x = 0
				var_714_0.localEulerAngles = var_714_6
			end

			if arg_711_1.time_ >= var_714_1 + var_714_2 and arg_711_1.time_ < var_714_1 + var_714_2 + arg_714_0 then
				var_714_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_714_7 = manager.ui.mainCamera.transform.position - var_714_0.position

				var_714_0.forward = Vector3.New(var_714_7.x, var_714_7.y, var_714_7.z)

				local var_714_8 = var_714_0.localEulerAngles

				var_714_8.z = 0
				var_714_8.x = 0
				var_714_0.localEulerAngles = var_714_8
			end

			local var_714_9 = arg_711_1.actors_["1049ui_story"]
			local var_714_10 = 0

			if var_714_10 < arg_711_1.time_ and arg_711_1.time_ <= var_714_10 + arg_714_0 and not isNil(var_714_9) and arg_711_1.var_.characterEffect1049ui_story == nil then
				arg_711_1.var_.characterEffect1049ui_story = var_714_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_714_11 = 0.200000002980232

			if var_714_10 <= arg_711_1.time_ and arg_711_1.time_ < var_714_10 + var_714_11 and not isNil(var_714_9) then
				local var_714_12 = (arg_711_1.time_ - var_714_10) / var_714_11

				if arg_711_1.var_.characterEffect1049ui_story and not isNil(var_714_9) then
					arg_711_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_711_1.time_ >= var_714_10 + var_714_11 and arg_711_1.time_ < var_714_10 + var_714_11 + arg_714_0 and not isNil(var_714_9) and arg_711_1.var_.characterEffect1049ui_story then
				arg_711_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_714_13 = 0

			if var_714_13 < arg_711_1.time_ and arg_711_1.time_ <= var_714_13 + arg_714_0 then
				arg_711_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_714_14 = 0

			if var_714_14 < arg_711_1.time_ and arg_711_1.time_ <= var_714_14 + arg_714_0 then
				arg_711_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_714_15 = 0
			local var_714_16 = 0.225

			if var_714_15 < arg_711_1.time_ and arg_711_1.time_ <= var_714_15 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				local var_714_17 = arg_711_1:FormatText(StoryNameCfg[551].name)

				arg_711_1.leftNameTxt_.text = var_714_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_18 = arg_711_1:GetWordFromCfg(1104906173)
				local var_714_19 = arg_711_1:FormatText(var_714_18.content)

				arg_711_1.text_.text = var_714_19

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_20 = 9
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906173", "story_v_side_new_1104906.awb") ~= 0 then
					local var_714_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906173", "story_v_side_new_1104906.awb") / 1000

					if var_714_23 + var_714_15 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_23 + var_714_15
					end

					if var_714_18.prefab_name ~= "" and arg_711_1.actors_[var_714_18.prefab_name] ~= nil then
						local var_714_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_711_1.actors_[var_714_18.prefab_name].transform, "story_v_side_new_1104906", "1104906173", "story_v_side_new_1104906.awb")

						arg_711_1:RecordAudio("1104906173", var_714_24)
						arg_711_1:RecordAudio("1104906173", var_714_24)
					else
						arg_711_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906173", "story_v_side_new_1104906.awb")
					end

					arg_711_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906173", "story_v_side_new_1104906.awb")
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
				actorName = "1049ui_story",
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
	Play1104906174 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 1104906174
		arg_715_1.duration_ = 5

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play1104906175(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = arg_715_1.actors_["1049ui_story"]
			local var_718_1 = 0

			if var_718_1 < arg_715_1.time_ and arg_715_1.time_ <= var_718_1 + arg_718_0 and not isNil(var_718_0) and arg_715_1.var_.characterEffect1049ui_story == nil then
				arg_715_1.var_.characterEffect1049ui_story = var_718_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_2 = 0.200000002980232

			if var_718_1 <= arg_715_1.time_ and arg_715_1.time_ < var_718_1 + var_718_2 and not isNil(var_718_0) then
				local var_718_3 = (arg_715_1.time_ - var_718_1) / var_718_2

				if arg_715_1.var_.characterEffect1049ui_story and not isNil(var_718_0) then
					local var_718_4 = Mathf.Lerp(0, 0.5, var_718_3)

					arg_715_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_715_1.var_.characterEffect1049ui_story.fillRatio = var_718_4
				end
			end

			if arg_715_1.time_ >= var_718_1 + var_718_2 and arg_715_1.time_ < var_718_1 + var_718_2 + arg_718_0 and not isNil(var_718_0) and arg_715_1.var_.characterEffect1049ui_story then
				local var_718_5 = 0.5

				arg_715_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_715_1.var_.characterEffect1049ui_story.fillRatio = var_718_5
			end

			local var_718_6 = 0
			local var_718_7 = 0.7

			if var_718_6 < arg_715_1.time_ and arg_715_1.time_ <= var_718_6 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, false)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_8 = arg_715_1:GetWordFromCfg(1104906174)
				local var_718_9 = arg_715_1:FormatText(var_718_8.content)

				arg_715_1.text_.text = var_718_9

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_10 = 28
				local var_718_11 = utf8.len(var_718_9)
				local var_718_12 = var_718_10 <= 0 and var_718_7 or var_718_7 * (var_718_11 / var_718_10)

				if var_718_12 > 0 and var_718_7 < var_718_12 then
					arg_715_1.talkMaxDuration = var_718_12

					if var_718_12 + var_718_6 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_12 + var_718_6
					end
				end

				arg_715_1.text_.text = var_718_9
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)
				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_13 = math.max(var_718_7, arg_715_1.talkMaxDuration)

			if var_718_6 <= arg_715_1.time_ and arg_715_1.time_ < var_718_6 + var_718_13 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_6) / var_718_13

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_6 + var_718_13 and arg_715_1.time_ < var_718_6 + var_718_13 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {}

		arg_715_1:InitPlayNodeList()
	end,
	Play1104906175 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 1104906175
		arg_719_1.duration_ = 5

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play1104906176(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = 0
			local var_722_1 = 0.175

			if var_722_0 < arg_719_1.time_ and arg_719_1.time_ <= var_722_0 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				local var_722_2 = arg_719_1:FormatText(StoryNameCfg[7].name)

				arg_719_1.leftNameTxt_.text = var_722_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, true)
				arg_719_1.iconController_:SetSelectedState("hero")

				arg_719_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_719_1.callingController_:SetSelectedState("normal")

				arg_719_1.keyicon_.color = Color.New(1, 1, 1)
				arg_719_1.icon_.color = Color.New(1, 1, 1)

				local var_722_3 = arg_719_1:GetWordFromCfg(1104906175)
				local var_722_4 = arg_719_1:FormatText(var_722_3.content)

				arg_719_1.text_.text = var_722_4

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_5 = 7
				local var_722_6 = utf8.len(var_722_4)
				local var_722_7 = var_722_5 <= 0 and var_722_1 or var_722_1 * (var_722_6 / var_722_5)

				if var_722_7 > 0 and var_722_1 < var_722_7 then
					arg_719_1.talkMaxDuration = var_722_7

					if var_722_7 + var_722_0 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_7 + var_722_0
					end
				end

				arg_719_1.text_.text = var_722_4
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)
				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_8 = math.max(var_722_1, arg_719_1.talkMaxDuration)

			if var_722_0 <= arg_719_1.time_ and arg_719_1.time_ < var_722_0 + var_722_8 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_0) / var_722_8

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_0 + var_722_8 and arg_719_1.time_ < var_722_0 + var_722_8 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	Play1104906176 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 1104906176
		arg_723_1.duration_ = 11.9

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play1104906177(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = "K12h"

			if arg_723_1.bgs_[var_726_0] == nil then
				local var_726_1 = Object.Instantiate(arg_723_1.paintGo_)

				var_726_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_726_0)
				var_726_1.name = var_726_0
				var_726_1.transform.parent = arg_723_1.stage_.transform
				var_726_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_723_1.bgs_[var_726_0] = var_726_1
			end

			local var_726_2 = 2.00000000298023

			if var_726_2 < arg_723_1.time_ and arg_723_1.time_ <= var_726_2 + arg_726_0 then
				local var_726_3 = manager.ui.mainCamera.transform.localPosition
				local var_726_4 = Vector3.New(0, 0, 10) + Vector3.New(var_726_3.x, var_726_3.y, 0)
				local var_726_5 = arg_723_1.bgs_.K12h

				var_726_5.transform.localPosition = var_726_4
				var_726_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_726_6 = var_726_5:GetComponent("SpriteRenderer")

				if var_726_6 and var_726_6.sprite then
					local var_726_7 = (var_726_5.transform.localPosition - var_726_3).z
					local var_726_8 = manager.ui.mainCameraCom_
					local var_726_9 = 2 * var_726_7 * Mathf.Tan(var_726_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_726_10 = var_726_9 * var_726_8.aspect
					local var_726_11 = var_726_6.sprite.bounds.size.x
					local var_726_12 = var_726_6.sprite.bounds.size.y
					local var_726_13 = var_726_10 / var_726_11
					local var_726_14 = var_726_9 / var_726_12
					local var_726_15 = var_726_14 < var_726_13 and var_726_13 or var_726_14

					var_726_5.transform.localScale = Vector3.New(var_726_15, var_726_15, 0)
				end

				for iter_726_0, iter_726_1 in pairs(arg_723_1.bgs_) do
					if iter_726_0 ~= "K12h" then
						iter_726_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_726_16 = 4

			if var_726_16 < arg_723_1.time_ and arg_723_1.time_ <= var_726_16 + arg_726_0 then
				arg_723_1.allBtn_.enabled = false
			end

			local var_726_17 = 0.3

			if arg_723_1.time_ >= var_726_16 + var_726_17 and arg_723_1.time_ < var_726_16 + var_726_17 + arg_726_0 then
				arg_723_1.allBtn_.enabled = true
			end

			local var_726_18 = 0

			if var_726_18 < arg_723_1.time_ and arg_723_1.time_ <= var_726_18 + arg_726_0 then
				arg_723_1.mask_.enabled = true
				arg_723_1.mask_.raycastTarget = true

				arg_723_1:SetGaussion(false)
			end

			local var_726_19 = 2

			if var_726_18 <= arg_723_1.time_ and arg_723_1.time_ < var_726_18 + var_726_19 then
				local var_726_20 = (arg_723_1.time_ - var_726_18) / var_726_19
				local var_726_21 = Color.New(0, 0, 0)

				var_726_21.a = Mathf.Lerp(0, 1, var_726_20)
				arg_723_1.mask_.color = var_726_21
			end

			if arg_723_1.time_ >= var_726_18 + var_726_19 and arg_723_1.time_ < var_726_18 + var_726_19 + arg_726_0 then
				local var_726_22 = Color.New(0, 0, 0)

				var_726_22.a = 1
				arg_723_1.mask_.color = var_726_22
			end

			local var_726_23 = 2

			if var_726_23 < arg_723_1.time_ and arg_723_1.time_ <= var_726_23 + arg_726_0 then
				arg_723_1.mask_.enabled = true
				arg_723_1.mask_.raycastTarget = true

				arg_723_1:SetGaussion(false)
			end

			local var_726_24 = 2

			if var_726_23 <= arg_723_1.time_ and arg_723_1.time_ < var_726_23 + var_726_24 then
				local var_726_25 = (arg_723_1.time_ - var_726_23) / var_726_24
				local var_726_26 = Color.New(0, 0, 0)

				var_726_26.a = Mathf.Lerp(1, 0, var_726_25)
				arg_723_1.mask_.color = var_726_26
			end

			if arg_723_1.time_ >= var_726_23 + var_726_24 and arg_723_1.time_ < var_726_23 + var_726_24 + arg_726_0 then
				local var_726_27 = Color.New(0, 0, 0)
				local var_726_28 = 0

				arg_723_1.mask_.enabled = false
				var_726_27.a = var_726_28
				arg_723_1.mask_.color = var_726_27
			end

			local var_726_29 = arg_723_1.actors_["1049ui_story"]
			local var_726_30 = 3.8

			if var_726_30 < arg_723_1.time_ and arg_723_1.time_ <= var_726_30 + arg_726_0 and not isNil(var_726_29) and arg_723_1.var_.characterEffect1049ui_story == nil then
				arg_723_1.var_.characterEffect1049ui_story = var_726_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_726_31 = 0.200000002980232

			if var_726_30 <= arg_723_1.time_ and arg_723_1.time_ < var_726_30 + var_726_31 and not isNil(var_726_29) then
				local var_726_32 = (arg_723_1.time_ - var_726_30) / var_726_31

				if arg_723_1.var_.characterEffect1049ui_story and not isNil(var_726_29) then
					arg_723_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_723_1.time_ >= var_726_30 + var_726_31 and arg_723_1.time_ < var_726_30 + var_726_31 + arg_726_0 and not isNil(var_726_29) and arg_723_1.var_.characterEffect1049ui_story then
				arg_723_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_726_33 = 3.8

			if var_726_33 < arg_723_1.time_ and arg_723_1.time_ <= var_726_33 + arg_726_0 then
				arg_723_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_726_34 = 3.8

			if var_726_34 < arg_723_1.time_ and arg_723_1.time_ <= var_726_34 + arg_726_0 then
				arg_723_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_726_35 = arg_723_1.actors_["1049ui_story"].transform
			local var_726_36 = 1.98333333333333

			if var_726_36 < arg_723_1.time_ and arg_723_1.time_ <= var_726_36 + arg_726_0 then
				arg_723_1.var_.moveOldPos1049ui_story = var_726_35.localPosition
			end

			local var_726_37 = 0.001

			if var_726_36 <= arg_723_1.time_ and arg_723_1.time_ < var_726_36 + var_726_37 then
				local var_726_38 = (arg_723_1.time_ - var_726_36) / var_726_37
				local var_726_39 = Vector3.New(0, 100, 0)

				var_726_35.localPosition = Vector3.Lerp(arg_723_1.var_.moveOldPos1049ui_story, var_726_39, var_726_38)

				local var_726_40 = manager.ui.mainCamera.transform.position - var_726_35.position

				var_726_35.forward = Vector3.New(var_726_40.x, var_726_40.y, var_726_40.z)

				local var_726_41 = var_726_35.localEulerAngles

				var_726_41.z = 0
				var_726_41.x = 0
				var_726_35.localEulerAngles = var_726_41
			end

			if arg_723_1.time_ >= var_726_36 + var_726_37 and arg_723_1.time_ < var_726_36 + var_726_37 + arg_726_0 then
				var_726_35.localPosition = Vector3.New(0, 100, 0)

				local var_726_42 = manager.ui.mainCamera.transform.position - var_726_35.position

				var_726_35.forward = Vector3.New(var_726_42.x, var_726_42.y, var_726_42.z)

				local var_726_43 = var_726_35.localEulerAngles

				var_726_43.z = 0
				var_726_43.x = 0
				var_726_35.localEulerAngles = var_726_43
			end

			local var_726_44 = arg_723_1.actors_["1049ui_story"].transform
			local var_726_45 = 3.8

			if var_726_45 < arg_723_1.time_ and arg_723_1.time_ <= var_726_45 + arg_726_0 then
				arg_723_1.var_.moveOldPos1049ui_story = var_726_44.localPosition
			end

			local var_726_46 = 0.001

			if var_726_45 <= arg_723_1.time_ and arg_723_1.time_ < var_726_45 + var_726_46 then
				local var_726_47 = (arg_723_1.time_ - var_726_45) / var_726_46
				local var_726_48 = Vector3.New(0, -1.2, -6)

				var_726_44.localPosition = Vector3.Lerp(arg_723_1.var_.moveOldPos1049ui_story, var_726_48, var_726_47)

				local var_726_49 = manager.ui.mainCamera.transform.position - var_726_44.position

				var_726_44.forward = Vector3.New(var_726_49.x, var_726_49.y, var_726_49.z)

				local var_726_50 = var_726_44.localEulerAngles

				var_726_50.z = 0
				var_726_50.x = 0
				var_726_44.localEulerAngles = var_726_50
			end

			if arg_723_1.time_ >= var_726_45 + var_726_46 and arg_723_1.time_ < var_726_45 + var_726_46 + arg_726_0 then
				var_726_44.localPosition = Vector3.New(0, -1.2, -6)

				local var_726_51 = manager.ui.mainCamera.transform.position - var_726_44.position

				var_726_44.forward = Vector3.New(var_726_51.x, var_726_51.y, var_726_51.z)

				local var_726_52 = var_726_44.localEulerAngles

				var_726_52.z = 0
				var_726_52.x = 0
				var_726_44.localEulerAngles = var_726_52
			end

			local var_726_53 = 1.98333333333333

			arg_723_1.isInRecall_ = false

			if var_726_53 < arg_723_1.time_ and arg_723_1.time_ <= var_726_53 + arg_726_0 then
				arg_723_1.screenFilterGo_:SetActive(true)

				arg_723_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_726_2, iter_726_3 in pairs(arg_723_1.actors_) do
					local var_726_54 = iter_726_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_726_4, iter_726_5 in ipairs(var_726_54) do
						if iter_726_5.color.r > 0.51 then
							iter_726_5.color = Color.New(1, 1, 1)
						else
							iter_726_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_726_55 = 0.2

			if var_726_53 <= arg_723_1.time_ and arg_723_1.time_ < var_726_53 + var_726_55 then
				local var_726_56 = (arg_723_1.time_ - var_726_53) / var_726_55

				arg_723_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_726_56)
			end

			if arg_723_1.time_ >= var_726_53 + var_726_55 and arg_723_1.time_ < var_726_53 + var_726_55 + arg_726_0 then
				arg_723_1.screenFilterEffect_.weight = 1
			end

			local var_726_57 = 0.6
			local var_726_58 = 1

			if var_726_57 < arg_723_1.time_ and arg_723_1.time_ <= var_726_57 + arg_726_0 then
				local var_726_59 = "stop"
				local var_726_60 = "effect"

				arg_723_1:AudioAction(var_726_59, var_726_60, "se_story_side_1049", "se_story_side_1049_amb_wind_leaves", "")
			end

			local var_726_61 = 2.36666666666667
			local var_726_62 = 1

			if var_726_61 < arg_723_1.time_ and arg_723_1.time_ <= var_726_61 + arg_726_0 then
				local var_726_63 = "play"
				local var_726_64 = "effect"

				arg_723_1:AudioAction(var_726_63, var_726_64, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_723_1.frameCnt_ <= 1 then
				arg_723_1.dialog_:SetActive(false)
			end

			local var_726_65 = 4.00000000298023
			local var_726_66 = 0.85

			if var_726_65 < arg_723_1.time_ and arg_723_1.time_ <= var_726_65 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0

				arg_723_1.dialog_:SetActive(true)

				arg_723_1.dialogCg_.alpha = 0

				local var_726_67 = LeanTween.value(arg_723_1.dialog_, 0, 1, 0.3)

				var_726_67:setOnUpdate(LuaHelper.FloatAction(function(arg_727_0)
					arg_723_1.dialogCg_.alpha = arg_727_0
				end))
				var_726_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_723_1.dialog_)
					var_726_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_723_1.duration_ = arg_723_1.duration_ + 0.3

				SetActive(arg_723_1.leftNameGo_, true)

				local var_726_68 = arg_723_1:FormatText(StoryNameCfg[551].name)

				arg_723_1.leftNameTxt_.text = var_726_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_723_1.leftNameTxt_.transform)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1.leftNameTxt_.text)
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_69 = arg_723_1:GetWordFromCfg(1104906176)
				local var_726_70 = arg_723_1:FormatText(var_726_69.content)

				arg_723_1.text_.text = var_726_70

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_71 = 34
				local var_726_72 = utf8.len(var_726_70)
				local var_726_73 = var_726_71 <= 0 and var_726_66 or var_726_66 * (var_726_72 / var_726_71)

				if var_726_73 > 0 and var_726_66 < var_726_73 then
					arg_723_1.talkMaxDuration = var_726_73
					var_726_65 = var_726_65 + 0.3

					if var_726_73 + var_726_65 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_73 + var_726_65
					end
				end

				arg_723_1.text_.text = var_726_70
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906176", "story_v_side_new_1104906.awb") ~= 0 then
					local var_726_74 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906176", "story_v_side_new_1104906.awb") / 1000

					if var_726_74 + var_726_65 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_74 + var_726_65
					end

					if var_726_69.prefab_name ~= "" and arg_723_1.actors_[var_726_69.prefab_name] ~= nil then
						local var_726_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_723_1.actors_[var_726_69.prefab_name].transform, "story_v_side_new_1104906", "1104906176", "story_v_side_new_1104906.awb")

						arg_723_1:RecordAudio("1104906176", var_726_75)
						arg_723_1:RecordAudio("1104906176", var_726_75)
					else
						arg_723_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906176", "story_v_side_new_1104906.awb")
					end

					arg_723_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906176", "story_v_side_new_1104906.awb")
				end

				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_76 = var_726_65 + 0.3
			local var_726_77 = math.max(var_726_66, arg_723_1.talkMaxDuration)

			if var_726_76 <= arg_723_1.time_ and arg_723_1.time_ < var_726_76 + var_726_77 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_76) / var_726_77

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_76 + var_726_77 and arg_723_1.time_ < var_726_76 + var_726_77 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_723_1:InitPlayNodeList()
	end,
	Play1104906177 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 1104906177
		arg_729_1.duration_ = 17.47

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play1104906178(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			local var_732_0 = 0

			if var_732_0 < arg_729_1.time_ and arg_729_1.time_ <= var_732_0 + arg_732_0 then
				arg_729_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_732_1 = 0

			if var_732_1 < arg_729_1.time_ and arg_729_1.time_ <= var_732_1 + arg_732_0 then
				arg_729_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_732_2 = 0
			local var_732_3 = 1.525

			if var_732_2 < arg_729_1.time_ and arg_729_1.time_ <= var_732_2 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				local var_732_4 = arg_729_1:FormatText(StoryNameCfg[551].name)

				arg_729_1.leftNameTxt_.text = var_732_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, false)
				arg_729_1.callingController_:SetSelectedState("normal")

				local var_732_5 = arg_729_1:GetWordFromCfg(1104906177)
				local var_732_6 = arg_729_1:FormatText(var_732_5.content)

				arg_729_1.text_.text = var_732_6

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_7 = 61
				local var_732_8 = utf8.len(var_732_6)
				local var_732_9 = var_732_7 <= 0 and var_732_3 or var_732_3 * (var_732_8 / var_732_7)

				if var_732_9 > 0 and var_732_3 < var_732_9 then
					arg_729_1.talkMaxDuration = var_732_9

					if var_732_9 + var_732_2 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_9 + var_732_2
					end
				end

				arg_729_1.text_.text = var_732_6
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906177", "story_v_side_new_1104906.awb") ~= 0 then
					local var_732_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906177", "story_v_side_new_1104906.awb") / 1000

					if var_732_10 + var_732_2 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_10 + var_732_2
					end

					if var_732_5.prefab_name ~= "" and arg_729_1.actors_[var_732_5.prefab_name] ~= nil then
						local var_732_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_729_1.actors_[var_732_5.prefab_name].transform, "story_v_side_new_1104906", "1104906177", "story_v_side_new_1104906.awb")

						arg_729_1:RecordAudio("1104906177", var_732_11)
						arg_729_1:RecordAudio("1104906177", var_732_11)
					else
						arg_729_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906177", "story_v_side_new_1104906.awb")
					end

					arg_729_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906177", "story_v_side_new_1104906.awb")
				end

				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_12 = math.max(var_732_3, arg_729_1.talkMaxDuration)

			if var_732_2 <= arg_729_1.time_ and arg_729_1.time_ < var_732_2 + var_732_12 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - var_732_2) / var_732_12

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= var_732_2 + var_732_12 and arg_729_1.time_ < var_732_2 + var_732_12 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play1104906178 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 1104906178
		arg_733_1.duration_ = 9

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play1104906179(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			local var_736_0 = 2

			if var_736_0 < arg_733_1.time_ and arg_733_1.time_ <= var_736_0 + arg_736_0 then
				local var_736_1 = manager.ui.mainCamera.transform.localPosition
				local var_736_2 = Vector3.New(0, 0, 10) + Vector3.New(var_736_1.x, var_736_1.y, 0)
				local var_736_3 = arg_733_1.bgs_.K10g

				var_736_3.transform.localPosition = var_736_2
				var_736_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_736_4 = var_736_3:GetComponent("SpriteRenderer")

				if var_736_4 and var_736_4.sprite then
					local var_736_5 = (var_736_3.transform.localPosition - var_736_1).z
					local var_736_6 = manager.ui.mainCameraCom_
					local var_736_7 = 2 * var_736_5 * Mathf.Tan(var_736_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_736_8 = var_736_7 * var_736_6.aspect
					local var_736_9 = var_736_4.sprite.bounds.size.x
					local var_736_10 = var_736_4.sprite.bounds.size.y
					local var_736_11 = var_736_8 / var_736_9
					local var_736_12 = var_736_7 / var_736_10
					local var_736_13 = var_736_12 < var_736_11 and var_736_11 or var_736_12

					var_736_3.transform.localScale = Vector3.New(var_736_13, var_736_13, 0)
				end

				for iter_736_0, iter_736_1 in pairs(arg_733_1.bgs_) do
					if iter_736_0 ~= "K10g" then
						iter_736_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_736_14 = 4

			if var_736_14 < arg_733_1.time_ and arg_733_1.time_ <= var_736_14 + arg_736_0 then
				arg_733_1.allBtn_.enabled = false
			end

			local var_736_15 = 0.3

			if arg_733_1.time_ >= var_736_14 + var_736_15 and arg_733_1.time_ < var_736_14 + var_736_15 + arg_736_0 then
				arg_733_1.allBtn_.enabled = true
			end

			local var_736_16 = 0

			if var_736_16 < arg_733_1.time_ and arg_733_1.time_ <= var_736_16 + arg_736_0 then
				arg_733_1.mask_.enabled = true
				arg_733_1.mask_.raycastTarget = true

				arg_733_1:SetGaussion(false)
			end

			local var_736_17 = 2

			if var_736_16 <= arg_733_1.time_ and arg_733_1.time_ < var_736_16 + var_736_17 then
				local var_736_18 = (arg_733_1.time_ - var_736_16) / var_736_17
				local var_736_19 = Color.New(0, 0, 0)

				var_736_19.a = Mathf.Lerp(0, 1, var_736_18)
				arg_733_1.mask_.color = var_736_19
			end

			if arg_733_1.time_ >= var_736_16 + var_736_17 and arg_733_1.time_ < var_736_16 + var_736_17 + arg_736_0 then
				local var_736_20 = Color.New(0, 0, 0)

				var_736_20.a = 1
				arg_733_1.mask_.color = var_736_20
			end

			local var_736_21 = 2

			if var_736_21 < arg_733_1.time_ and arg_733_1.time_ <= var_736_21 + arg_736_0 then
				arg_733_1.mask_.enabled = true
				arg_733_1.mask_.raycastTarget = true

				arg_733_1:SetGaussion(false)
			end

			local var_736_22 = 2

			if var_736_21 <= arg_733_1.time_ and arg_733_1.time_ < var_736_21 + var_736_22 then
				local var_736_23 = (arg_733_1.time_ - var_736_21) / var_736_22
				local var_736_24 = Color.New(0, 0, 0)

				var_736_24.a = Mathf.Lerp(1, 0, var_736_23)
				arg_733_1.mask_.color = var_736_24
			end

			if arg_733_1.time_ >= var_736_21 + var_736_22 and arg_733_1.time_ < var_736_21 + var_736_22 + arg_736_0 then
				local var_736_25 = Color.New(0, 0, 0)
				local var_736_26 = 0

				arg_733_1.mask_.enabled = false
				var_736_25.a = var_736_26
				arg_733_1.mask_.color = var_736_25
			end

			local var_736_27 = arg_733_1.actors_["1049ui_story"]
			local var_736_28 = 2

			if var_736_28 < arg_733_1.time_ and arg_733_1.time_ <= var_736_28 + arg_736_0 and not isNil(var_736_27) and arg_733_1.var_.characterEffect1049ui_story == nil then
				arg_733_1.var_.characterEffect1049ui_story = var_736_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_736_29 = 0.0166666666666666

			if var_736_28 <= arg_733_1.time_ and arg_733_1.time_ < var_736_28 + var_736_29 and not isNil(var_736_27) then
				local var_736_30 = (arg_733_1.time_ - var_736_28) / var_736_29

				if arg_733_1.var_.characterEffect1049ui_story and not isNil(var_736_27) then
					local var_736_31 = Mathf.Lerp(0, 0.5, var_736_30)

					arg_733_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_733_1.var_.characterEffect1049ui_story.fillRatio = var_736_31
				end
			end

			if arg_733_1.time_ >= var_736_28 + var_736_29 and arg_733_1.time_ < var_736_28 + var_736_29 + arg_736_0 and not isNil(var_736_27) and arg_733_1.var_.characterEffect1049ui_story then
				local var_736_32 = 0.5

				arg_733_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_733_1.var_.characterEffect1049ui_story.fillRatio = var_736_32
			end

			local var_736_33 = 2

			arg_733_1.isInRecall_ = false

			if var_736_33 < arg_733_1.time_ and arg_733_1.time_ <= var_736_33 + arg_736_0 then
				arg_733_1.screenFilterGo_:SetActive(false)

				for iter_736_2, iter_736_3 in pairs(arg_733_1.actors_) do
					local var_736_34 = iter_736_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_736_4, iter_736_5 in ipairs(var_736_34) do
						if iter_736_5.color.r > 0.51 then
							iter_736_5.color = Color.New(1, 1, 1)
						else
							iter_736_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_736_35 = 0.0166666666666667

			if var_736_33 <= arg_733_1.time_ and arg_733_1.time_ < var_736_33 + var_736_35 then
				local var_736_36 = (arg_733_1.time_ - var_736_33) / var_736_35

				arg_733_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_736_36)
			end

			if arg_733_1.time_ >= var_736_33 + var_736_35 and arg_733_1.time_ < var_736_33 + var_736_35 + arg_736_0 then
				arg_733_1.screenFilterEffect_.weight = 0
			end

			local var_736_37 = arg_733_1.actors_["1049ui_story"].transform
			local var_736_38 = 2

			if var_736_38 < arg_733_1.time_ and arg_733_1.time_ <= var_736_38 + arg_736_0 then
				arg_733_1.var_.moveOldPos1049ui_story = var_736_37.localPosition
			end

			local var_736_39 = 0.0666666666666669

			if var_736_38 <= arg_733_1.time_ and arg_733_1.time_ < var_736_38 + var_736_39 then
				local var_736_40 = (arg_733_1.time_ - var_736_38) / var_736_39
				local var_736_41 = Vector3.New(0, 100, 0)

				var_736_37.localPosition = Vector3.Lerp(arg_733_1.var_.moveOldPos1049ui_story, var_736_41, var_736_40)

				local var_736_42 = manager.ui.mainCamera.transform.position - var_736_37.position

				var_736_37.forward = Vector3.New(var_736_42.x, var_736_42.y, var_736_42.z)

				local var_736_43 = var_736_37.localEulerAngles

				var_736_43.z = 0
				var_736_43.x = 0
				var_736_37.localEulerAngles = var_736_43
			end

			if arg_733_1.time_ >= var_736_38 + var_736_39 and arg_733_1.time_ < var_736_38 + var_736_39 + arg_736_0 then
				var_736_37.localPosition = Vector3.New(0, 100, 0)

				local var_736_44 = manager.ui.mainCamera.transform.position - var_736_37.position

				var_736_37.forward = Vector3.New(var_736_44.x, var_736_44.y, var_736_44.z)

				local var_736_45 = var_736_37.localEulerAngles

				var_736_45.z = 0
				var_736_45.x = 0
				var_736_37.localEulerAngles = var_736_45
			end

			local var_736_46 = 0.4
			local var_736_47 = 1

			if var_736_46 < arg_733_1.time_ and arg_733_1.time_ <= var_736_46 + arg_736_0 then
				local var_736_48 = "stop"
				local var_736_49 = "effect"

				arg_733_1:AudioAction(var_736_48, var_736_49, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_736_50 = 1.63333333333333
			local var_736_51 = 1

			if var_736_50 < arg_733_1.time_ and arg_733_1.time_ <= var_736_50 + arg_736_0 then
				local var_736_52 = "play"
				local var_736_53 = "effect"

				arg_733_1:AudioAction(var_736_52, var_736_53, "se_story_side_1049", "se_story_side_1049_amb_wind_leaves", "")
			end

			if arg_733_1.frameCnt_ <= 1 then
				arg_733_1.dialog_:SetActive(false)
			end

			local var_736_54 = 4
			local var_736_55 = 0.975

			if var_736_54 < arg_733_1.time_ and arg_733_1.time_ <= var_736_54 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0

				arg_733_1.dialog_:SetActive(true)

				arg_733_1.dialogCg_.alpha = 0

				local var_736_56 = LeanTween.value(arg_733_1.dialog_, 0, 1, 0.3)

				var_736_56:setOnUpdate(LuaHelper.FloatAction(function(arg_737_0)
					arg_733_1.dialogCg_.alpha = arg_737_0
				end))
				var_736_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_733_1.dialog_)
					var_736_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_733_1.duration_ = arg_733_1.duration_ + 0.3

				SetActive(arg_733_1.leftNameGo_, false)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_733_1.iconTrs_.gameObject, false)
				arg_733_1.callingController_:SetSelectedState("normal")

				local var_736_57 = arg_733_1:GetWordFromCfg(1104906178)
				local var_736_58 = arg_733_1:FormatText(var_736_57.content)

				arg_733_1.text_.text = var_736_58

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_59 = 39
				local var_736_60 = utf8.len(var_736_58)
				local var_736_61 = var_736_59 <= 0 and var_736_55 or var_736_55 * (var_736_60 / var_736_59)

				if var_736_61 > 0 and var_736_55 < var_736_61 then
					arg_733_1.talkMaxDuration = var_736_61
					var_736_54 = var_736_54 + 0.3

					if var_736_61 + var_736_54 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_61 + var_736_54
					end
				end

				arg_733_1.text_.text = var_736_58
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)
				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_62 = var_736_54 + 0.3
			local var_736_63 = math.max(var_736_55, arg_733_1.talkMaxDuration)

			if var_736_62 <= arg_733_1.time_ and arg_733_1.time_ < var_736_62 + var_736_63 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - var_736_62) / var_736_63

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= var_736_62 + var_736_63 and arg_733_1.time_ < var_736_62 + var_736_63 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0666666666666669,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_733_1:InitPlayNodeList()
	end,
	Play1104906179 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 1104906179
		arg_739_1.duration_ = 6.73

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
			arg_739_1.auto_ = false
		end

		function arg_739_1.playNext_(arg_741_0)
			arg_739_1.onStoryFinished_()
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			local var_742_0 = arg_739_1.actors_["1049ui_story"]
			local var_742_1 = 0

			if var_742_1 < arg_739_1.time_ and arg_739_1.time_ <= var_742_1 + arg_742_0 and not isNil(var_742_0) and arg_739_1.var_.characterEffect1049ui_story == nil then
				arg_739_1.var_.characterEffect1049ui_story = var_742_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_742_2 = 0.200000002980232

			if var_742_1 <= arg_739_1.time_ and arg_739_1.time_ < var_742_1 + var_742_2 and not isNil(var_742_0) then
				local var_742_3 = (arg_739_1.time_ - var_742_1) / var_742_2

				if arg_739_1.var_.characterEffect1049ui_story and not isNil(var_742_0) then
					arg_739_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_739_1.time_ >= var_742_1 + var_742_2 and arg_739_1.time_ < var_742_1 + var_742_2 + arg_742_0 and not isNil(var_742_0) and arg_739_1.var_.characterEffect1049ui_story then
				arg_739_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_742_4 = 0

			if var_742_4 < arg_739_1.time_ and arg_739_1.time_ <= var_742_4 + arg_742_0 then
				arg_739_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_742_5 = 0

			if var_742_5 < arg_739_1.time_ and arg_739_1.time_ <= var_742_5 + arg_742_0 then
				arg_739_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_742_6 = arg_739_1.actors_["1049ui_story"].transform
			local var_742_7 = 0

			if var_742_7 < arg_739_1.time_ and arg_739_1.time_ <= var_742_7 + arg_742_0 then
				arg_739_1.var_.moveOldPos1049ui_story = var_742_6.localPosition
			end

			local var_742_8 = 0.001

			if var_742_7 <= arg_739_1.time_ and arg_739_1.time_ < var_742_7 + var_742_8 then
				local var_742_9 = (arg_739_1.time_ - var_742_7) / var_742_8
				local var_742_10 = Vector3.New(0, -1.2, -6)

				var_742_6.localPosition = Vector3.Lerp(arg_739_1.var_.moveOldPos1049ui_story, var_742_10, var_742_9)

				local var_742_11 = manager.ui.mainCamera.transform.position - var_742_6.position

				var_742_6.forward = Vector3.New(var_742_11.x, var_742_11.y, var_742_11.z)

				local var_742_12 = var_742_6.localEulerAngles

				var_742_12.z = 0
				var_742_12.x = 0
				var_742_6.localEulerAngles = var_742_12
			end

			if arg_739_1.time_ >= var_742_7 + var_742_8 and arg_739_1.time_ < var_742_7 + var_742_8 + arg_742_0 then
				var_742_6.localPosition = Vector3.New(0, -1.2, -6)

				local var_742_13 = manager.ui.mainCamera.transform.position - var_742_6.position

				var_742_6.forward = Vector3.New(var_742_13.x, var_742_13.y, var_742_13.z)

				local var_742_14 = var_742_6.localEulerAngles

				var_742_14.z = 0
				var_742_14.x = 0
				var_742_6.localEulerAngles = var_742_14
			end

			local var_742_15 = 0
			local var_742_16 = 0.475

			if var_742_15 < arg_739_1.time_ and arg_739_1.time_ <= var_742_15 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0
				arg_739_1.dialogCg_.alpha = 1

				arg_739_1.dialog_:SetActive(true)
				SetActive(arg_739_1.leftNameGo_, true)

				local var_742_17 = arg_739_1:FormatText(StoryNameCfg[551].name)

				arg_739_1.leftNameTxt_.text = var_742_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_739_1.leftNameTxt_.transform)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1.leftNameTxt_.text)
				SetActive(arg_739_1.iconTrs_.gameObject, false)
				arg_739_1.callingController_:SetSelectedState("normal")

				local var_742_18 = arg_739_1:GetWordFromCfg(1104906179)
				local var_742_19 = arg_739_1:FormatText(var_742_18.content)

				arg_739_1.text_.text = var_742_19

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_20 = 20
				local var_742_21 = utf8.len(var_742_19)
				local var_742_22 = var_742_20 <= 0 and var_742_16 or var_742_16 * (var_742_21 / var_742_20)

				if var_742_22 > 0 and var_742_16 < var_742_22 then
					arg_739_1.talkMaxDuration = var_742_22

					if var_742_22 + var_742_15 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_22 + var_742_15
					end
				end

				arg_739_1.text_.text = var_742_19
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906179", "story_v_side_new_1104906.awb") ~= 0 then
					local var_742_23 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906179", "story_v_side_new_1104906.awb") / 1000

					if var_742_23 + var_742_15 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_23 + var_742_15
					end

					if var_742_18.prefab_name ~= "" and arg_739_1.actors_[var_742_18.prefab_name] ~= nil then
						local var_742_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_739_1.actors_[var_742_18.prefab_name].transform, "story_v_side_new_1104906", "1104906179", "story_v_side_new_1104906.awb")

						arg_739_1:RecordAudio("1104906179", var_742_24)
						arg_739_1:RecordAudio("1104906179", var_742_24)
					else
						arg_739_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906179", "story_v_side_new_1104906.awb")
					end

					arg_739_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906179", "story_v_side_new_1104906.awb")
				end

				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_25 = math.max(var_742_16, arg_739_1.talkMaxDuration)

			if var_742_15 <= arg_739_1.time_ and arg_739_1.time_ < var_742_15 + var_742_25 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - var_742_15) / var_742_25

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= var_742_15 + var_742_25 and arg_739_1.time_ < var_742_15 + var_742_25 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end

		arg_739_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_739_1:InitPlayNodeList()
	end,
	Play1104906069 = function(arg_743_0, arg_743_1)
		arg_743_1.time_ = 0
		arg_743_1.frameCnt_ = 0
		arg_743_1.state_ = "playing"
		arg_743_1.curTalkId_ = 1104906069
		arg_743_1.duration_ = 5

		SetActive(arg_743_1.tipsGo_, false)

		function arg_743_1.onSingleLineFinish_()
			arg_743_1.onSingleLineUpdate_ = nil
			arg_743_1.onSingleLineFinish_ = nil
			arg_743_1.state_ = "waiting"
		end

		function arg_743_1.playNext_(arg_745_0)
			if arg_745_0 == 1 then
				arg_743_0:Play1104906070(arg_743_1)
			end
		end

		function arg_743_1.onSingleLineUpdate_(arg_746_0)
			local var_746_0 = 0
			local var_746_1 = 0.65

			if var_746_0 < arg_743_1.time_ and arg_743_1.time_ <= var_746_0 + arg_746_0 then
				arg_743_1.talkMaxDuration = 0
				arg_743_1.dialogCg_.alpha = 1

				arg_743_1.dialog_:SetActive(true)
				SetActive(arg_743_1.leftNameGo_, true)

				local var_746_2 = arg_743_1:FormatText(StoryNameCfg[7].name)

				arg_743_1.leftNameTxt_.text = var_746_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_743_1.leftNameTxt_.transform)

				arg_743_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_743_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_743_1:RecordName(arg_743_1.leftNameTxt_.text)
				SetActive(arg_743_1.iconTrs_.gameObject, true)
				arg_743_1.iconController_:SetSelectedState("hero")

				arg_743_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_743_1.callingController_:SetSelectedState("normal")

				arg_743_1.keyicon_.color = Color.New(1, 1, 1)
				arg_743_1.icon_.color = Color.New(1, 1, 1)

				local var_746_3 = arg_743_1:GetWordFromCfg(1104906069)
				local var_746_4 = arg_743_1:FormatText(var_746_3.content)

				arg_743_1.text_.text = var_746_4

				LuaForUtil.ClearLinePrefixSymbol(arg_743_1.text_)

				local var_746_5 = 26
				local var_746_6 = utf8.len(var_746_4)
				local var_746_7 = var_746_5 <= 0 and var_746_1 or var_746_1 * (var_746_6 / var_746_5)

				if var_746_7 > 0 and var_746_1 < var_746_7 then
					arg_743_1.talkMaxDuration = var_746_7

					if var_746_7 + var_746_0 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_7 + var_746_0
					end
				end

				arg_743_1.text_.text = var_746_4
				arg_743_1.typewritter.percent = 0

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(false)
				arg_743_1:RecordContent(arg_743_1.text_.text)
			end

			local var_746_8 = math.max(var_746_1, arg_743_1.talkMaxDuration)

			if var_746_0 <= arg_743_1.time_ and arg_743_1.time_ < var_746_0 + var_746_8 then
				arg_743_1.typewritter.percent = (arg_743_1.time_ - var_746_0) / var_746_8

				arg_743_1.typewritter:SetDirty()
			end

			if arg_743_1.time_ >= var_746_0 + var_746_8 and arg_743_1.time_ < var_746_0 + var_746_8 + arg_746_0 then
				arg_743_1.typewritter.percent = 1

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(true)
			end
		end

		arg_743_1.nodeConfigList_ = {}

		arg_743_1:InitPlayNodeList()
	end,
	Play1104906053 = function(arg_747_0, arg_747_1)
		arg_747_1.time_ = 0
		arg_747_1.frameCnt_ = 0
		arg_747_1.state_ = "playing"
		arg_747_1.curTalkId_ = 1104906053
		arg_747_1.duration_ = 5

		SetActive(arg_747_1.tipsGo_, false)

		function arg_747_1.onSingleLineFinish_()
			arg_747_1.onSingleLineUpdate_ = nil
			arg_747_1.onSingleLineFinish_ = nil
			arg_747_1.state_ = "waiting"
		end

		function arg_747_1.playNext_(arg_749_0)
			if arg_749_0 == 1 then
				arg_747_0:Play1104906054(arg_747_1)
			end
		end

		function arg_747_1.onSingleLineUpdate_(arg_750_0)
			local var_750_0 = 0
			local var_750_1 = 0.975

			if var_750_0 < arg_747_1.time_ and arg_747_1.time_ <= var_750_0 + arg_750_0 then
				arg_747_1.talkMaxDuration = 0
				arg_747_1.dialogCg_.alpha = 1

				arg_747_1.dialog_:SetActive(true)
				SetActive(arg_747_1.leftNameGo_, true)

				local var_750_2 = arg_747_1:FormatText(StoryNameCfg[7].name)

				arg_747_1.leftNameTxt_.text = var_750_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_747_1.leftNameTxt_.transform)

				arg_747_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_747_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_747_1:RecordName(arg_747_1.leftNameTxt_.text)
				SetActive(arg_747_1.iconTrs_.gameObject, true)
				arg_747_1.iconController_:SetSelectedState("hero")

				arg_747_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_747_1.callingController_:SetSelectedState("normal")

				arg_747_1.keyicon_.color = Color.New(1, 1, 1)
				arg_747_1.icon_.color = Color.New(1, 1, 1)

				local var_750_3 = arg_747_1:GetWordFromCfg(1104906053)
				local var_750_4 = arg_747_1:FormatText(var_750_3.content)

				arg_747_1.text_.text = var_750_4

				LuaForUtil.ClearLinePrefixSymbol(arg_747_1.text_)

				local var_750_5 = 39
				local var_750_6 = utf8.len(var_750_4)
				local var_750_7 = var_750_5 <= 0 and var_750_1 or var_750_1 * (var_750_6 / var_750_5)

				if var_750_7 > 0 and var_750_1 < var_750_7 then
					arg_747_1.talkMaxDuration = var_750_7

					if var_750_7 + var_750_0 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_7 + var_750_0
					end
				end

				arg_747_1.text_.text = var_750_4
				arg_747_1.typewritter.percent = 0

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(false)
				arg_747_1:RecordContent(arg_747_1.text_.text)
			end

			local var_750_8 = math.max(var_750_1, arg_747_1.talkMaxDuration)

			if var_750_0 <= arg_747_1.time_ and arg_747_1.time_ < var_750_0 + var_750_8 then
				arg_747_1.typewritter.percent = (arg_747_1.time_ - var_750_0) / var_750_8

				arg_747_1.typewritter:SetDirty()
			end

			if arg_747_1.time_ >= var_750_0 + var_750_8 and arg_747_1.time_ < var_750_0 + var_750_8 + arg_750_0 then
				arg_747_1.typewritter.percent = 1

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(true)
			end
		end

		arg_747_1.nodeConfigList_ = {}

		arg_747_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST06",
		"TextureConfig/Background/ST58",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/K11f",
		"TextureConfig/Background/R4902",
		"TextureConfig/Background/R4902a",
		"TextureConfig/Background/K11g",
		"TextureConfig/Background/K01h",
		"TextureConfig/Background/K10g",
		"TextureConfig/Background/K12h"
	},
	voices = {
		"story_v_side_new_1104906.awb"
	}
}
