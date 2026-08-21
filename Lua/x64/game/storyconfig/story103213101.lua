return {
	Play321311001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321311001
		arg_1_1.duration_ = 2

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play321311002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

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
				local var_4_5 = arg_1_1.bgs_.STblack

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
					if iter_4_0 ~= "STblack" then
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

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(false)
				arg_1_1.dialog_:SetActive(false)
				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_23 = 0
			local var_4_24 = 0.2

			if var_4_23 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				local var_4_25 = "play"
				local var_4_26 = "music"

				arg_1_1:AudioAction(var_4_25, var_4_26, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_27 = ""
				local var_4_28 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_28 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_28 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_28

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_28
						arg_1_1.bgmTxt2_.text = var_4_28
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

			local var_4_29 = 0.4
			local var_4_30 = 1

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				local var_4_31 = "play"
				local var_4_32 = "music"

				arg_1_1:AudioAction(var_4_31, var_4_32, "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_4_33 = ""
				local var_4_34 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

				if var_4_34 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_34 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_34

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_34
						arg_1_1.bgmTxt2_.text = var_4_34
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

			local var_4_35 = 0.3
			local var_4_36 = 1

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				local var_4_37 = "play"
				local var_4_38 = "effect"

				arg_1_1:AudioAction(var_4_37, var_4_38, "se_story", "se_story_communication", "")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play321311002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 321311002
		arg_7_1.duration_ = 7

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play321311003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = "L10g"

			if arg_7_1.bgs_[var_10_0] == nil then
				local var_10_1 = Object.Instantiate(arg_7_1.paintGo_)

				var_10_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_10_0)
				var_10_1.name = var_10_0
				var_10_1.transform.parent = arg_7_1.stage_.transform
				var_10_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.bgs_[var_10_0] = var_10_1
			end

			local var_10_2 = 0

			if var_10_2 < arg_7_1.time_ and arg_7_1.time_ <= var_10_2 + arg_10_0 then
				local var_10_3 = manager.ui.mainCamera.transform.localPosition
				local var_10_4 = Vector3.New(0, 0, 10) + Vector3.New(var_10_3.x, var_10_3.y, 0)
				local var_10_5 = arg_7_1.bgs_.L10g

				var_10_5.transform.localPosition = var_10_4
				var_10_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_10_6 = var_10_5:GetComponent("SpriteRenderer")

				if var_10_6 and var_10_6.sprite then
					local var_10_7 = (var_10_5.transform.localPosition - var_10_3).z
					local var_10_8 = manager.ui.mainCameraCom_
					local var_10_9 = 2 * var_10_7 * Mathf.Tan(var_10_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_10_10 = var_10_9 * var_10_8.aspect
					local var_10_11 = var_10_6.sprite.bounds.size.x
					local var_10_12 = var_10_6.sprite.bounds.size.y
					local var_10_13 = var_10_10 / var_10_11
					local var_10_14 = var_10_9 / var_10_12
					local var_10_15 = var_10_14 < var_10_13 and var_10_13 or var_10_14

					var_10_5.transform.localScale = Vector3.New(var_10_15, var_10_15, 0)
				end

				for iter_10_0, iter_10_1 in pairs(arg_7_1.bgs_) do
					if iter_10_0 ~= "L10g" then
						iter_10_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_10_16 = 2

			if var_10_16 < arg_7_1.time_ and arg_7_1.time_ <= var_10_16 + arg_10_0 then
				arg_7_1.allBtn_.enabled = false
			end

			local var_10_17 = 0.0666666666666669

			if arg_7_1.time_ >= var_10_16 + var_10_17 and arg_7_1.time_ < var_10_16 + var_10_17 + arg_10_0 then
				arg_7_1.allBtn_.enabled = true
			end

			local var_10_18 = 0

			if var_10_18 < arg_7_1.time_ and arg_7_1.time_ <= var_10_18 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_19 = 2

			if var_10_18 <= arg_7_1.time_ and arg_7_1.time_ < var_10_18 + var_10_19 then
				local var_10_20 = (arg_7_1.time_ - var_10_18) / var_10_19
				local var_10_21 = Color.New(0, 0, 0)

				var_10_21.a = Mathf.Lerp(1, 0, var_10_20)
				arg_7_1.mask_.color = var_10_21
			end

			if arg_7_1.time_ >= var_10_18 + var_10_19 and arg_7_1.time_ < var_10_18 + var_10_19 + arg_10_0 then
				local var_10_22 = Color.New(0, 0, 0)
				local var_10_23 = 0

				arg_7_1.mask_.enabled = false
				var_10_22.a = var_10_23
				arg_7_1.mask_.color = var_10_22
			end

			local var_10_24 = 0

			if var_10_24 < arg_7_1.time_ and arg_7_1.time_ <= var_10_24 + arg_10_0 then
				arg_7_1.fswbg_:SetActive(false)
				arg_7_1.dialog_:SetActive(false)
				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_25 = 0.05
			local var_10_26 = 1

			if var_10_25 < arg_7_1.time_ and arg_7_1.time_ <= var_10_25 + arg_10_0 then
				local var_10_27 = "play"
				local var_10_28 = "effect"

				arg_7_1:AudioAction(var_10_27, var_10_28, "se_story_138", "se_story_138_carloop", "")
			end

			local var_10_29 = 0.05
			local var_10_30 = 1

			if var_10_29 < arg_7_1.time_ and arg_7_1.time_ <= var_10_29 + arg_10_0 then
				local var_10_31 = "play"
				local var_10_32 = "effect"

				arg_7_1:AudioAction(var_10_31, var_10_32, "se_story", "se_story_communication", "")
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_33 = 2
			local var_10_34 = 0.1

			if var_10_33 < arg_7_1.time_ and arg_7_1.time_ <= var_10_33 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_35 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_35:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
					arg_7_1.dialogCg_.alpha = arg_11_0
				end))
				var_10_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_36 = arg_7_1:FormatText(StoryNameCfg[7].name)

				arg_7_1.leftNameTxt_.text = var_10_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_37 = arg_7_1:GetWordFromCfg(321311002)
				local var_10_38 = arg_7_1:FormatText(var_10_37.content)

				arg_7_1.text_.text = var_10_38

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_39 = 4
				local var_10_40 = utf8.len(var_10_38)
				local var_10_41 = var_10_39 <= 0 and var_10_34 or var_10_34 * (var_10_40 / var_10_39)

				if var_10_41 > 0 and var_10_34 < var_10_41 then
					arg_7_1.talkMaxDuration = var_10_41
					var_10_33 = var_10_33 + 0.3

					if var_10_41 + var_10_33 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_41 + var_10_33
					end
				end

				arg_7_1.text_.text = var_10_38
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_42 = var_10_33 + 0.3
			local var_10_43 = math.max(var_10_34, arg_7_1.talkMaxDuration)

			if var_10_42 <= arg_7_1.time_ and arg_7_1.time_ < var_10_42 + var_10_43 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_42) / var_10_43

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_42 + var_10_43 and arg_7_1.time_ < var_10_42 + var_10_43 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play321311003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321311003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play321311004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.5

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

				local var_16_2 = arg_13_1:GetWordFromCfg(321311003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 60
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
	Play321311004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321311004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321311005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.15

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(321311004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 6
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_8 and arg_17_1.time_ < var_20_0 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play321311005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321311005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play321311006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.35

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(321311005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 54
				local var_24_5 = utf8.len(var_24_3)
				local var_24_6 = var_24_4 <= 0 and var_24_1 or var_24_1 * (var_24_5 / var_24_4)

				if var_24_6 > 0 and var_24_1 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_7 and arg_21_1.time_ < var_24_0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play321311006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321311006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play321311007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.8

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(321311006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 32
				local var_28_5 = utf8.len(var_28_3)
				local var_28_6 = var_28_4 <= 0 and var_28_1 or var_28_1 * (var_28_5 / var_28_4)

				if var_28_6 > 0 and var_28_1 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_7 and arg_25_1.time_ < var_28_0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play321311007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321311007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play321311008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.15

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_2

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

				local var_32_3 = arg_29_1:GetWordFromCfg(321311007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 6
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play321311008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321311008
		arg_33_1.duration_ = 3.73

		local var_33_0 = {
			zh = 1.999999999999,
			ja = 3.733
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
				arg_33_0:Play321311009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "10104ui_story"

			if arg_33_1.actors_[var_36_0] == nil then
				local var_36_1 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_36_1) then
					local var_36_2 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_33_1.stage_.transform)

					var_36_2.name = var_36_0
					var_36_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_33_1.actors_[var_36_0] = var_36_2

					local var_36_3 = var_36_2:GetComponentInChildren(typeof(CharacterEffect))

					var_36_3.enabled = true

					local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_2, typeof(DynamicBoneHelper))

					if var_36_4 then
						var_36_4:EnableDynamicBone(false)
					end

					arg_33_1:ShowWeapon(var_36_3.transform, false)

					arg_33_1.var_[var_36_0 .. "Animator"] = var_36_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_33_1.var_[var_36_0 .. "Animator"].applyRootMotion = true
					arg_33_1.var_[var_36_0 .. "LipSync"] = var_36_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_36_5 = arg_33_1.actors_["10104ui_story"].transform
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.var_.moveOldPos10104ui_story = var_36_5.localPosition
			end

			local var_36_7 = 0.001

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_7 then
				local var_36_8 = (arg_33_1.time_ - var_36_6) / var_36_7
				local var_36_9 = Vector3.New(0.02, -1.12, -5.99)

				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10104ui_story, var_36_9, var_36_8)

				local var_36_10 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_10.x, var_36_10.y, var_36_10.z)

				local var_36_11 = var_36_5.localEulerAngles

				var_36_11.z = 0
				var_36_11.x = 0
				var_36_5.localEulerAngles = var_36_11
			end

			if arg_33_1.time_ >= var_36_6 + var_36_7 and arg_33_1.time_ < var_36_6 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_36_12 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_12.x, var_36_12.y, var_36_12.z)

				local var_36_13 = var_36_5.localEulerAngles

				var_36_13.z = 0
				var_36_13.x = 0
				var_36_5.localEulerAngles = var_36_13
			end

			local var_36_14 = arg_33_1.actors_["10104ui_story"]
			local var_36_15 = 0

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect10104ui_story == nil then
				arg_33_1.var_.characterEffect10104ui_story = var_36_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_16 = 0.200000002980232

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_16 and not isNil(var_36_14) then
				local var_36_17 = (arg_33_1.time_ - var_36_15) / var_36_16

				if arg_33_1.var_.characterEffect10104ui_story and not isNil(var_36_14) then
					arg_33_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_15 + var_36_16 and arg_33_1.time_ < var_36_15 + var_36_16 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect10104ui_story then
				arg_33_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_36_18 = 0

			if var_36_18 < arg_33_1.time_ and arg_33_1.time_ <= var_36_18 + arg_36_0 then
				arg_33_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_36_19 = 0

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 then
				arg_33_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_36_20 = 0
			local var_36_21 = 0.25

			if var_36_20 < arg_33_1.time_ and arg_33_1.time_ <= var_36_20 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_22 = arg_33_1:FormatText(StoryNameCfg[1030].name)

				arg_33_1.leftNameTxt_.text = var_36_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_23 = arg_33_1:GetWordFromCfg(321311008)
				local var_36_24 = arg_33_1:FormatText(var_36_23.content)

				arg_33_1.text_.text = var_36_24

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_25 = 10
				local var_36_26 = utf8.len(var_36_24)
				local var_36_27 = var_36_25 <= 0 and var_36_21 or var_36_21 * (var_36_26 / var_36_25)

				if var_36_27 > 0 and var_36_21 < var_36_27 then
					arg_33_1.talkMaxDuration = var_36_27

					if var_36_27 + var_36_20 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_27 + var_36_20
					end
				end

				arg_33_1.text_.text = var_36_24
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311008", "story_v_out_321311.awb") ~= 0 then
					local var_36_28 = manager.audio:GetVoiceLength("story_v_out_321311", "321311008", "story_v_out_321311.awb") / 1000

					if var_36_28 + var_36_20 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_28 + var_36_20
					end

					if var_36_23.prefab_name ~= "" and arg_33_1.actors_[var_36_23.prefab_name] ~= nil then
						local var_36_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_23.prefab_name].transform, "story_v_out_321311", "321311008", "story_v_out_321311.awb")

						arg_33_1:RecordAudio("321311008", var_36_29)
						arg_33_1:RecordAudio("321311008", var_36_29)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321311", "321311008", "story_v_out_321311.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321311", "321311008", "story_v_out_321311.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_30 = math.max(var_36_21, arg_33_1.talkMaxDuration)

			if var_36_20 <= arg_33_1.time_ and arg_33_1.time_ < var_36_20 + var_36_30 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_20) / var_36_30

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_20 + var_36_30 and arg_33_1.time_ < var_36_20 + var_36_30 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321311009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321311009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play321311010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10104ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10104ui_story == nil then
				arg_37_1.var_.characterEffect10104ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect10104ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10104ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10104ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10104ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 1.05

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

				local var_40_9 = arg_37_1:GetWordFromCfg(321311009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 42
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
	Play321311010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321311010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play321311011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.925

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(321311010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 37
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_8 and arg_41_1.time_ < var_44_0 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play321311011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321311011
		arg_45_1.duration_ = 9.2

		local var_45_0 = {
			zh = 5.3,
			ja = 9.2
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
				arg_45_0:Play321311012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10104ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10104ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0.02, -1.12, -5.99)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10104ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["10104ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect10104ui_story == nil then
				arg_45_1.var_.characterEffect10104ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect10104ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect10104ui_story then
				arg_45_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_48_15 = 0
			local var_48_16 = 0.475

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[1030].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(321311011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 19
				local var_48_21 = utf8.len(var_48_19)
				local var_48_22 = var_48_20 <= 0 and var_48_16 or var_48_16 * (var_48_21 / var_48_20)

				if var_48_22 > 0 and var_48_16 < var_48_22 then
					arg_45_1.talkMaxDuration = var_48_22

					if var_48_22 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311011", "story_v_out_321311.awb") ~= 0 then
					local var_48_23 = manager.audio:GetVoiceLength("story_v_out_321311", "321311011", "story_v_out_321311.awb") / 1000

					if var_48_23 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_out_321311", "321311011", "story_v_out_321311.awb")

						arg_45_1:RecordAudio("321311011", var_48_24)
						arg_45_1:RecordAudio("321311011", var_48_24)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321311", "321311011", "story_v_out_321311.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321311", "321311011", "story_v_out_321311.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_25 and arg_45_1.time_ < var_48_15 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321311012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321311012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play321311013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10104ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10104ui_story == nil then
				arg_49_1.var_.characterEffect10104ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect10104ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10104ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10104ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10104ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.425

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[7].name)

				arg_49_1.leftNameTxt_.text = var_52_8

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

				local var_52_9 = arg_49_1:GetWordFromCfg(321311012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 17
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play321311013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321311013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play321311014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10104ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10104ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10104ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, 100, 0)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = 0.05
			local var_56_10 = 1

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				local var_56_11 = "play"
				local var_56_12 = "effect"

				arg_53_1:AudioAction(var_56_11, var_56_12, "se_story_141", "se_story_141_knock_car", "")
			end

			local var_56_13 = 0.05
			local var_56_14 = 1

			if var_56_13 < arg_53_1.time_ and arg_53_1.time_ <= var_56_13 + arg_56_0 then
				local var_56_15 = "play"
				local var_56_16 = "effect"

				arg_53_1:AudioAction(var_56_15, var_56_16, "se_story_138", "se_story_138_carloop_stop", "")
			end

			local var_56_17 = 0
			local var_56_18 = 1

			if var_56_17 < arg_53_1.time_ and arg_53_1.time_ <= var_56_17 + arg_56_0 then
				local var_56_19 = "stop"
				local var_56_20 = "effect"

				arg_53_1:AudioAction(var_56_19, var_56_20, "se_story_138", "se_story_138_carloop", "")
			end

			local var_56_21 = 0
			local var_56_22 = 1.05

			if var_56_21 < arg_53_1.time_ and arg_53_1.time_ <= var_56_21 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_23 = arg_53_1:GetWordFromCfg(321311013)
				local var_56_24 = arg_53_1:FormatText(var_56_23.content)

				arg_53_1.text_.text = var_56_24

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_25 = 42
				local var_56_26 = utf8.len(var_56_24)
				local var_56_27 = var_56_25 <= 0 and var_56_22 or var_56_22 * (var_56_26 / var_56_25)

				if var_56_27 > 0 and var_56_22 < var_56_27 then
					arg_53_1.talkMaxDuration = var_56_27

					if var_56_27 + var_56_21 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_27 + var_56_21
					end
				end

				arg_53_1.text_.text = var_56_24
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_28 = math.max(var_56_22, arg_53_1.talkMaxDuration)

			if var_56_21 <= arg_53_1.time_ and arg_53_1.time_ < var_56_21 + var_56_28 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_21) / var_56_28

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_21 + var_56_28 and arg_53_1.time_ < var_56_21 + var_56_28 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play321311014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321311014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play321311015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(321311014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 40
				local var_60_5 = utf8.len(var_60_3)
				local var_60_6 = var_60_4 <= 0 and var_60_1 or var_60_1 * (var_60_5 / var_60_4)

				if var_60_6 > 0 and var_60_1 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_7 and arg_57_1.time_ < var_60_0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play321311015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321311015
		arg_61_1.duration_ = 8.2

		local var_61_0 = {
			zh = 5.933,
			ja = 8.2
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
				arg_61_0:Play321311016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = "1211ui_story"

			if arg_61_1.actors_[var_64_0] == nil then
				local var_64_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_64_1) then
					local var_64_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_61_1.stage_.transform)

					var_64_2.name = var_64_0
					var_64_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_61_1.actors_[var_64_0] = var_64_2

					local var_64_3 = var_64_2:GetComponentInChildren(typeof(CharacterEffect))

					var_64_3.enabled = true

					local var_64_4 = GameObjectTools.GetOrAddComponent(var_64_2, typeof(DynamicBoneHelper))

					if var_64_4 then
						var_64_4:EnableDynamicBone(false)
					end

					arg_61_1:ShowWeapon(var_64_3.transform, false)

					arg_61_1.var_[var_64_0 .. "Animator"] = var_64_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_61_1.var_[var_64_0 .. "Animator"].applyRootMotion = true
					arg_61_1.var_[var_64_0 .. "LipSync"] = var_64_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_64_5 = arg_61_1.actors_["1211ui_story"].transform
			local var_64_6 = 0

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.var_.moveOldPos1211ui_story = var_64_5.localPosition
			end

			local var_64_7 = 0.001

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_7 then
				local var_64_8 = (arg_61_1.time_ - var_64_6) / var_64_7
				local var_64_9 = Vector3.New(0, -0.67, -6.07)

				var_64_5.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1211ui_story, var_64_9, var_64_8)

				local var_64_10 = manager.ui.mainCamera.transform.position - var_64_5.position

				var_64_5.forward = Vector3.New(var_64_10.x, var_64_10.y, var_64_10.z)

				local var_64_11 = var_64_5.localEulerAngles

				var_64_11.z = 0
				var_64_11.x = 0
				var_64_5.localEulerAngles = var_64_11
			end

			if arg_61_1.time_ >= var_64_6 + var_64_7 and arg_61_1.time_ < var_64_6 + var_64_7 + arg_64_0 then
				var_64_5.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_64_12 = manager.ui.mainCamera.transform.position - var_64_5.position

				var_64_5.forward = Vector3.New(var_64_12.x, var_64_12.y, var_64_12.z)

				local var_64_13 = var_64_5.localEulerAngles

				var_64_13.z = 0
				var_64_13.x = 0
				var_64_5.localEulerAngles = var_64_13
			end

			local var_64_14 = arg_61_1.actors_["1211ui_story"]
			local var_64_15 = 0

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 and not isNil(var_64_14) and arg_61_1.var_.characterEffect1211ui_story == nil then
				arg_61_1.var_.characterEffect1211ui_story = var_64_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_16 = 0.200000002980232

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_16 and not isNil(var_64_14) then
				local var_64_17 = (arg_61_1.time_ - var_64_15) / var_64_16

				if arg_61_1.var_.characterEffect1211ui_story and not isNil(var_64_14) then
					arg_61_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_15 + var_64_16 and arg_61_1.time_ < var_64_15 + var_64_16 + arg_64_0 and not isNil(var_64_14) and arg_61_1.var_.characterEffect1211ui_story then
				arg_61_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_64_18 = 0

			if var_64_18 < arg_61_1.time_ and arg_61_1.time_ <= var_64_18 + arg_64_0 then
				arg_61_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_64_19 = 0

			if var_64_19 < arg_61_1.time_ and arg_61_1.time_ <= var_64_19 + arg_64_0 then
				arg_61_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_64_20 = 0
			local var_64_21 = 0.725

			if var_64_20 < arg_61_1.time_ and arg_61_1.time_ <= var_64_20 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_22 = arg_61_1:FormatText(StoryNameCfg[37].name)

				arg_61_1.leftNameTxt_.text = var_64_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_23 = arg_61_1:GetWordFromCfg(321311015)
				local var_64_24 = arg_61_1:FormatText(var_64_23.content)

				arg_61_1.text_.text = var_64_24

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_25 = 29
				local var_64_26 = utf8.len(var_64_24)
				local var_64_27 = var_64_25 <= 0 and var_64_21 or var_64_21 * (var_64_26 / var_64_25)

				if var_64_27 > 0 and var_64_21 < var_64_27 then
					arg_61_1.talkMaxDuration = var_64_27

					if var_64_27 + var_64_20 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_27 + var_64_20
					end
				end

				arg_61_1.text_.text = var_64_24
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311015", "story_v_out_321311.awb") ~= 0 then
					local var_64_28 = manager.audio:GetVoiceLength("story_v_out_321311", "321311015", "story_v_out_321311.awb") / 1000

					if var_64_28 + var_64_20 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_28 + var_64_20
					end

					if var_64_23.prefab_name ~= "" and arg_61_1.actors_[var_64_23.prefab_name] ~= nil then
						local var_64_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_23.prefab_name].transform, "story_v_out_321311", "321311015", "story_v_out_321311.awb")

						arg_61_1:RecordAudio("321311015", var_64_29)
						arg_61_1:RecordAudio("321311015", var_64_29)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_321311", "321311015", "story_v_out_321311.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_321311", "321311015", "story_v_out_321311.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_30 = math.max(var_64_21, arg_61_1.talkMaxDuration)

			if var_64_20 <= arg_61_1.time_ and arg_61_1.time_ < var_64_20 + var_64_30 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_20) / var_64_30

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_20 + var_64_30 and arg_61_1.time_ < var_64_20 + var_64_30 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play321311016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 321311016
		arg_65_1.duration_ = 8.2

		local var_65_0 = {
			zh = 7.1,
			ja = 8.2
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
				arg_65_0:Play321311017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.8

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[37].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(321311016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311016", "story_v_out_321311.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_321311", "321311016", "story_v_out_321311.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_321311", "321311016", "story_v_out_321311.awb")

						arg_65_1:RecordAudio("321311016", var_68_9)
						arg_65_1:RecordAudio("321311016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_321311", "321311016", "story_v_out_321311.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_321311", "321311016", "story_v_out_321311.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_10 and arg_65_1.time_ < var_68_0 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play321311017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321311017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play321311018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1211ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1211ui_story == nil then
				arg_69_1.var_.characterEffect1211ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1211ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1211ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1211ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1211ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.225

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[7].name)

				arg_69_1.leftNameTxt_.text = var_72_8

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

				local var_72_9 = arg_69_1:GetWordFromCfg(321311017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 9
				local var_72_12 = utf8.len(var_72_10)
				local var_72_13 = var_72_11 <= 0 and var_72_7 or var_72_7 * (var_72_12 / var_72_11)

				if var_72_13 > 0 and var_72_7 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play321311018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321311018
		arg_73_1.duration_ = 6.5

		local var_73_0 = {
			zh = 3.866,
			ja = 6.5
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
				arg_73_0:Play321311019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1211ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1211ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, -0.67, -6.07)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1211ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["1211ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1211ui_story == nil then
				arg_73_1.var_.characterEffect1211ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect1211ui_story and not isNil(var_76_9) then
					arg_73_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1211ui_story then
				arg_73_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_76_13 = 0

			if var_76_13 < arg_73_1.time_ and arg_73_1.time_ <= var_76_13 + arg_76_0 then
				arg_73_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211actionlink/1211action434")
			end

			local var_76_14 = 0

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_76_15 = 0
			local var_76_16 = 0.425

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_17 = arg_73_1:FormatText(StoryNameCfg[37].name)

				arg_73_1.leftNameTxt_.text = var_76_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_18 = arg_73_1:GetWordFromCfg(321311018)
				local var_76_19 = arg_73_1:FormatText(var_76_18.content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_20 = 17
				local var_76_21 = utf8.len(var_76_19)
				local var_76_22 = var_76_20 <= 0 and var_76_16 or var_76_16 * (var_76_21 / var_76_20)

				if var_76_22 > 0 and var_76_16 < var_76_22 then
					arg_73_1.talkMaxDuration = var_76_22

					if var_76_22 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_22 + var_76_15
					end
				end

				arg_73_1.text_.text = var_76_19
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311018", "story_v_out_321311.awb") ~= 0 then
					local var_76_23 = manager.audio:GetVoiceLength("story_v_out_321311", "321311018", "story_v_out_321311.awb") / 1000

					if var_76_23 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_15
					end

					if var_76_18.prefab_name ~= "" and arg_73_1.actors_[var_76_18.prefab_name] ~= nil then
						local var_76_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_18.prefab_name].transform, "story_v_out_321311", "321311018", "story_v_out_321311.awb")

						arg_73_1:RecordAudio("321311018", var_76_24)
						arg_73_1:RecordAudio("321311018", var_76_24)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_321311", "321311018", "story_v_out_321311.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_321311", "321311018", "story_v_out_321311.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_25 = math.max(var_76_16, arg_73_1.talkMaxDuration)

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_25 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_15) / var_76_25

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_15 + var_76_25 and arg_73_1.time_ < var_76_15 + var_76_25 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play321311019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321311019
		arg_77_1.duration_ = 8.33

		local var_77_0 = {
			zh = 7.366,
			ja = 8.333
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
				arg_77_0:Play321311020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_2")
			end

			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_80_2 = 0
			local var_80_3 = 0.925

			if var_80_2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_4 = arg_77_1:FormatText(StoryNameCfg[37].name)

				arg_77_1.leftNameTxt_.text = var_80_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_5 = arg_77_1:GetWordFromCfg(321311019)
				local var_80_6 = arg_77_1:FormatText(var_80_5.content)

				arg_77_1.text_.text = var_80_6

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 37
				local var_80_8 = utf8.len(var_80_6)
				local var_80_9 = var_80_7 <= 0 and var_80_3 or var_80_3 * (var_80_8 / var_80_7)

				if var_80_9 > 0 and var_80_3 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_6
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311019", "story_v_out_321311.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_321311", "321311019", "story_v_out_321311.awb") / 1000

					if var_80_10 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_2
					end

					if var_80_5.prefab_name ~= "" and arg_77_1.actors_[var_80_5.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_5.prefab_name].transform, "story_v_out_321311", "321311019", "story_v_out_321311.awb")

						arg_77_1:RecordAudio("321311019", var_80_11)
						arg_77_1:RecordAudio("321311019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_321311", "321311019", "story_v_out_321311.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_321311", "321311019", "story_v_out_321311.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_12 and arg_77_1.time_ < var_80_2 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play321311020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 321311020
		arg_81_1.duration_ = 9

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play321311021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 2

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				local var_84_1 = manager.ui.mainCamera.transform.localPosition
				local var_84_2 = Vector3.New(0, 0, 10) + Vector3.New(var_84_1.x, var_84_1.y, 0)
				local var_84_3 = arg_81_1.bgs_.L10g

				var_84_3.transform.localPosition = var_84_2
				var_84_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_4 = var_84_3:GetComponent("SpriteRenderer")

				if var_84_4 and var_84_4.sprite then
					local var_84_5 = (var_84_3.transform.localPosition - var_84_1).z
					local var_84_6 = manager.ui.mainCameraCom_
					local var_84_7 = 2 * var_84_5 * Mathf.Tan(var_84_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_84_8 = var_84_7 * var_84_6.aspect
					local var_84_9 = var_84_4.sprite.bounds.size.x
					local var_84_10 = var_84_4.sprite.bounds.size.y
					local var_84_11 = var_84_8 / var_84_9
					local var_84_12 = var_84_7 / var_84_10
					local var_84_13 = var_84_12 < var_84_11 and var_84_11 or var_84_12

					var_84_3.transform.localScale = Vector3.New(var_84_13, var_84_13, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "L10g" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_14 = 3.999999999999

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1.allBtn_.enabled = false
			end

			local var_84_15 = 0.3

			if arg_81_1.time_ >= var_84_14 + var_84_15 and arg_81_1.time_ < var_84_14 + var_84_15 + arg_84_0 then
				arg_81_1.allBtn_.enabled = true
			end

			local var_84_16 = 0

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_17 = 2

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_17 then
				local var_84_18 = (arg_81_1.time_ - var_84_16) / var_84_17
				local var_84_19 = Color.New(0, 0, 0)

				var_84_19.a = Mathf.Lerp(0, 1, var_84_18)
				arg_81_1.mask_.color = var_84_19
			end

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 then
				local var_84_20 = Color.New(0, 0, 0)

				var_84_20.a = 1
				arg_81_1.mask_.color = var_84_20
			end

			local var_84_21 = 2

			if var_84_21 < arg_81_1.time_ and arg_81_1.time_ <= var_84_21 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_22 = 2

			if var_84_21 <= arg_81_1.time_ and arg_81_1.time_ < var_84_21 + var_84_22 then
				local var_84_23 = (arg_81_1.time_ - var_84_21) / var_84_22
				local var_84_24 = Color.New(0, 0, 0)

				var_84_24.a = Mathf.Lerp(1, 0, var_84_23)
				arg_81_1.mask_.color = var_84_24
			end

			if arg_81_1.time_ >= var_84_21 + var_84_22 and arg_81_1.time_ < var_84_21 + var_84_22 + arg_84_0 then
				local var_84_25 = Color.New(0, 0, 0)
				local var_84_26 = 0

				arg_81_1.mask_.enabled = false
				var_84_25.a = var_84_26
				arg_81_1.mask_.color = var_84_25
			end

			local var_84_27 = arg_81_1.actors_["1211ui_story"].transform
			local var_84_28 = 1.96599999815226

			if var_84_28 < arg_81_1.time_ and arg_81_1.time_ <= var_84_28 + arg_84_0 then
				arg_81_1.var_.moveOldPos1211ui_story = var_84_27.localPosition
			end

			local var_84_29 = 0.001

			if var_84_28 <= arg_81_1.time_ and arg_81_1.time_ < var_84_28 + var_84_29 then
				local var_84_30 = (arg_81_1.time_ - var_84_28) / var_84_29
				local var_84_31 = Vector3.New(0, 100, 0)

				var_84_27.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1211ui_story, var_84_31, var_84_30)

				local var_84_32 = manager.ui.mainCamera.transform.position - var_84_27.position

				var_84_27.forward = Vector3.New(var_84_32.x, var_84_32.y, var_84_32.z)

				local var_84_33 = var_84_27.localEulerAngles

				var_84_33.z = 0
				var_84_33.x = 0
				var_84_27.localEulerAngles = var_84_33
			end

			if arg_81_1.time_ >= var_84_28 + var_84_29 and arg_81_1.time_ < var_84_28 + var_84_29 + arg_84_0 then
				var_84_27.localPosition = Vector3.New(0, 100, 0)

				local var_84_34 = manager.ui.mainCamera.transform.position - var_84_27.position

				var_84_27.forward = Vector3.New(var_84_34.x, var_84_34.y, var_84_34.z)

				local var_84_35 = var_84_27.localEulerAngles

				var_84_35.z = 0
				var_84_35.x = 0
				var_84_27.localEulerAngles = var_84_35
			end

			local var_84_36 = arg_81_1.actors_["1211ui_story"]
			local var_84_37 = 1.96599999815226

			if var_84_37 < arg_81_1.time_ and arg_81_1.time_ <= var_84_37 + arg_84_0 and not isNil(var_84_36) and arg_81_1.var_.characterEffect1211ui_story == nil then
				arg_81_1.var_.characterEffect1211ui_story = var_84_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_38 = 0.034000001847744

			if var_84_37 <= arg_81_1.time_ and arg_81_1.time_ < var_84_37 + var_84_38 and not isNil(var_84_36) then
				local var_84_39 = (arg_81_1.time_ - var_84_37) / var_84_38

				if arg_81_1.var_.characterEffect1211ui_story and not isNil(var_84_36) then
					local var_84_40 = Mathf.Lerp(0, 0.5, var_84_39)

					arg_81_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1211ui_story.fillRatio = var_84_40
				end
			end

			if arg_81_1.time_ >= var_84_37 + var_84_38 and arg_81_1.time_ < var_84_37 + var_84_38 + arg_84_0 and not isNil(var_84_36) and arg_81_1.var_.characterEffect1211ui_story then
				local var_84_41 = 0.5

				arg_81_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1211ui_story.fillRatio = var_84_41
			end

			local var_84_42 = 4.299999999999
			local var_84_43 = 1

			if var_84_42 < arg_81_1.time_ and arg_81_1.time_ <= var_84_42 + arg_84_0 then
				local var_84_44 = "play"
				local var_84_45 = "effect"

				arg_81_1:AudioAction(var_84_44, var_84_45, "se_story_140", "se_story_140_car04", "")
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_46 = 3.999999999999
			local var_84_47 = 1.1

			if var_84_46 < arg_81_1.time_ and arg_81_1.time_ <= var_84_46 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_48 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_48:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_49 = arg_81_1:GetWordFromCfg(321311020)
				local var_84_50 = arg_81_1:FormatText(var_84_49.content)

				arg_81_1.text_.text = var_84_50

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_51 = 44
				local var_84_52 = utf8.len(var_84_50)
				local var_84_53 = var_84_51 <= 0 and var_84_47 or var_84_47 * (var_84_52 / var_84_51)

				if var_84_53 > 0 and var_84_47 < var_84_53 then
					arg_81_1.talkMaxDuration = var_84_53
					var_84_46 = var_84_46 + 0.3

					if var_84_53 + var_84_46 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_53 + var_84_46
					end
				end

				arg_81_1.text_.text = var_84_50
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_54 = var_84_46 + 0.3
			local var_84_55 = math.max(var_84_47, arg_81_1.talkMaxDuration)

			if var_84_54 <= arg_81_1.time_ and arg_81_1.time_ < var_84_54 + var_84_55 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_54) / var_84_55

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_54 + var_84_55 and arg_81_1.time_ < var_84_54 + var_84_55 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play321311021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 321311021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play321311022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.05
			local var_90_1 = 1

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				local var_90_2 = "play"
				local var_90_3 = "effect"

				arg_87_1:AudioAction(var_90_2, var_90_3, "se_story_1310", "se_story_1310_cardoor03", "")
			end

			local var_90_4 = 0
			local var_90_5 = 0.9

			if var_90_4 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(321311021)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_8 = 36
				local var_90_9 = utf8.len(var_90_7)
				local var_90_10 = var_90_8 <= 0 and var_90_5 or var_90_5 * (var_90_9 / var_90_8)

				if var_90_10 > 0 and var_90_5 < var_90_10 then
					arg_87_1.talkMaxDuration = var_90_10

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_11 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_11 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_11

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_11 and arg_87_1.time_ < var_90_4 + var_90_11 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play321311022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 321311022
		arg_91_1.duration_ = 2

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play321311023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1211ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1211ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(-0.7, -0.67, -6.07)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1211ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = arg_91_1.actors_["10104ui_story"].transform
			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 then
				arg_91_1.var_.moveOldPos10104ui_story = var_94_9.localPosition
			end

			local var_94_11 = 0.001

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_11 then
				local var_94_12 = (arg_91_1.time_ - var_94_10) / var_94_11
				local var_94_13 = Vector3.New(0.99, -1.12, -5.99)

				var_94_9.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10104ui_story, var_94_13, var_94_12)

				local var_94_14 = manager.ui.mainCamera.transform.position - var_94_9.position

				var_94_9.forward = Vector3.New(var_94_14.x, var_94_14.y, var_94_14.z)

				local var_94_15 = var_94_9.localEulerAngles

				var_94_15.z = 0
				var_94_15.x = 0
				var_94_9.localEulerAngles = var_94_15
			end

			if arg_91_1.time_ >= var_94_10 + var_94_11 and arg_91_1.time_ < var_94_10 + var_94_11 + arg_94_0 then
				var_94_9.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_94_16 = manager.ui.mainCamera.transform.position - var_94_9.position

				var_94_9.forward = Vector3.New(var_94_16.x, var_94_16.y, var_94_16.z)

				local var_94_17 = var_94_9.localEulerAngles

				var_94_17.z = 0
				var_94_17.x = 0
				var_94_9.localEulerAngles = var_94_17
			end

			local var_94_18 = arg_91_1.actors_["1211ui_story"]
			local var_94_19 = 0

			if var_94_19 < arg_91_1.time_ and arg_91_1.time_ <= var_94_19 + arg_94_0 and not isNil(var_94_18) and arg_91_1.var_.characterEffect1211ui_story == nil then
				arg_91_1.var_.characterEffect1211ui_story = var_94_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_20 = 0.200000002980232

			if var_94_19 <= arg_91_1.time_ and arg_91_1.time_ < var_94_19 + var_94_20 and not isNil(var_94_18) then
				local var_94_21 = (arg_91_1.time_ - var_94_19) / var_94_20

				if arg_91_1.var_.characterEffect1211ui_story and not isNil(var_94_18) then
					arg_91_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_19 + var_94_20 and arg_91_1.time_ < var_94_19 + var_94_20 + arg_94_0 and not isNil(var_94_18) and arg_91_1.var_.characterEffect1211ui_story then
				arg_91_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_94_22 = 0

			if var_94_22 < arg_91_1.time_ and arg_91_1.time_ <= var_94_22 + arg_94_0 then
				arg_91_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action1_1")
			end

			local var_94_23 = 0

			if var_94_23 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 then
				arg_91_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_94_24 = 0

			if var_94_24 < arg_91_1.time_ and arg_91_1.time_ <= var_94_24 + arg_94_0 then
				arg_91_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_94_25 = 0
			local var_94_26 = 0.175

			if var_94_25 < arg_91_1.time_ and arg_91_1.time_ <= var_94_25 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_27 = arg_91_1:FormatText(StoryNameCfg[37].name)

				arg_91_1.leftNameTxt_.text = var_94_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_28 = arg_91_1:GetWordFromCfg(321311022)
				local var_94_29 = arg_91_1:FormatText(var_94_28.content)

				arg_91_1.text_.text = var_94_29

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_30 = 7
				local var_94_31 = utf8.len(var_94_29)
				local var_94_32 = var_94_30 <= 0 and var_94_26 or var_94_26 * (var_94_31 / var_94_30)

				if var_94_32 > 0 and var_94_26 < var_94_32 then
					arg_91_1.talkMaxDuration = var_94_32

					if var_94_32 + var_94_25 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_32 + var_94_25
					end
				end

				arg_91_1.text_.text = var_94_29
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311022", "story_v_out_321311.awb") ~= 0 then
					local var_94_33 = manager.audio:GetVoiceLength("story_v_out_321311", "321311022", "story_v_out_321311.awb") / 1000

					if var_94_33 + var_94_25 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_33 + var_94_25
					end

					if var_94_28.prefab_name ~= "" and arg_91_1.actors_[var_94_28.prefab_name] ~= nil then
						local var_94_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_28.prefab_name].transform, "story_v_out_321311", "321311022", "story_v_out_321311.awb")

						arg_91_1:RecordAudio("321311022", var_94_34)
						arg_91_1:RecordAudio("321311022", var_94_34)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_321311", "321311022", "story_v_out_321311.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_321311", "321311022", "story_v_out_321311.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_35 = math.max(var_94_26, arg_91_1.talkMaxDuration)

			if var_94_25 <= arg_91_1.time_ and arg_91_1.time_ < var_94_25 + var_94_35 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_25) / var_94_35

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_25 + var_94_35 and arg_91_1.time_ < var_94_25 + var_94_35 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321311023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 321311023
		arg_95_1.duration_ = 6.1

		local var_95_0 = {
			zh = 4.2,
			ja = 6.1
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
				arg_95_0:Play321311024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10104ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect10104ui_story == nil then
				arg_95_1.var_.characterEffect10104ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect10104ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect10104ui_story then
				arg_95_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_98_4 = arg_95_1.actors_["1211ui_story"]
			local var_98_5 = 0

			if var_98_5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 and not isNil(var_98_4) and arg_95_1.var_.characterEffect1211ui_story == nil then
				arg_95_1.var_.characterEffect1211ui_story = var_98_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_6 = 0.200000002980232

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_6 and not isNil(var_98_4) then
				local var_98_7 = (arg_95_1.time_ - var_98_5) / var_98_6

				if arg_95_1.var_.characterEffect1211ui_story and not isNil(var_98_4) then
					local var_98_8 = Mathf.Lerp(0, 0.5, var_98_7)

					arg_95_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1211ui_story.fillRatio = var_98_8
				end
			end

			if arg_95_1.time_ >= var_98_5 + var_98_6 and arg_95_1.time_ < var_98_5 + var_98_6 + arg_98_0 and not isNil(var_98_4) and arg_95_1.var_.characterEffect1211ui_story then
				local var_98_9 = 0.5

				arg_95_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1211ui_story.fillRatio = var_98_9
			end

			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 then
				arg_95_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_98_11 = 0

			if var_98_11 < arg_95_1.time_ and arg_95_1.time_ <= var_98_11 + arg_98_0 then
				arg_95_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_98_12 = 0
			local var_98_13 = 0.525

			if var_98_12 < arg_95_1.time_ and arg_95_1.time_ <= var_98_12 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_14 = arg_95_1:FormatText(StoryNameCfg[1030].name)

				arg_95_1.leftNameTxt_.text = var_98_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_15 = arg_95_1:GetWordFromCfg(321311023)
				local var_98_16 = arg_95_1:FormatText(var_98_15.content)

				arg_95_1.text_.text = var_98_16

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_17 = 21
				local var_98_18 = utf8.len(var_98_16)
				local var_98_19 = var_98_17 <= 0 and var_98_13 or var_98_13 * (var_98_18 / var_98_17)

				if var_98_19 > 0 and var_98_13 < var_98_19 then
					arg_95_1.talkMaxDuration = var_98_19

					if var_98_19 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_19 + var_98_12
					end
				end

				arg_95_1.text_.text = var_98_16
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311023", "story_v_out_321311.awb") ~= 0 then
					local var_98_20 = manager.audio:GetVoiceLength("story_v_out_321311", "321311023", "story_v_out_321311.awb") / 1000

					if var_98_20 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_20 + var_98_12
					end

					if var_98_15.prefab_name ~= "" and arg_95_1.actors_[var_98_15.prefab_name] ~= nil then
						local var_98_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_15.prefab_name].transform, "story_v_out_321311", "321311023", "story_v_out_321311.awb")

						arg_95_1:RecordAudio("321311023", var_98_21)
						arg_95_1:RecordAudio("321311023", var_98_21)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_321311", "321311023", "story_v_out_321311.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_321311", "321311023", "story_v_out_321311.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_22 = math.max(var_98_13, arg_95_1.talkMaxDuration)

			if var_98_12 <= arg_95_1.time_ and arg_95_1.time_ < var_98_12 + var_98_22 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_12) / var_98_22

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_12 + var_98_22 and arg_95_1.time_ < var_98_12 + var_98_22 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play321311024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321311024
		arg_99_1.duration_ = 1.97

		local var_99_0 = {
			zh = 1.2,
			ja = 1.966
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
				arg_99_0:Play321311025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1211ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1211ui_story == nil then
				arg_99_1.var_.characterEffect1211ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect1211ui_story and not isNil(var_102_0) then
					arg_99_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1211ui_story then
				arg_99_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_102_4 = arg_99_1.actors_["10104ui_story"]
			local var_102_5 = 0

			if var_102_5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.characterEffect10104ui_story == nil then
				arg_99_1.var_.characterEffect10104ui_story = var_102_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_6 = 0.200000002980232

			if var_102_5 <= arg_99_1.time_ and arg_99_1.time_ < var_102_5 + var_102_6 and not isNil(var_102_4) then
				local var_102_7 = (arg_99_1.time_ - var_102_5) / var_102_6

				if arg_99_1.var_.characterEffect10104ui_story and not isNil(var_102_4) then
					local var_102_8 = Mathf.Lerp(0, 0.5, var_102_7)

					arg_99_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_99_1.var_.characterEffect10104ui_story.fillRatio = var_102_8
				end
			end

			if arg_99_1.time_ >= var_102_5 + var_102_6 and arg_99_1.time_ < var_102_5 + var_102_6 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.characterEffect10104ui_story then
				local var_102_9 = 0.5

				arg_99_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_99_1.var_.characterEffect10104ui_story.fillRatio = var_102_9
			end

			local var_102_10 = 0
			local var_102_11 = 0.125

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_12 = arg_99_1:FormatText(StoryNameCfg[37].name)

				arg_99_1.leftNameTxt_.text = var_102_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_13 = arg_99_1:GetWordFromCfg(321311024)
				local var_102_14 = arg_99_1:FormatText(var_102_13.content)

				arg_99_1.text_.text = var_102_14

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_15 = 5
				local var_102_16 = utf8.len(var_102_14)
				local var_102_17 = var_102_15 <= 0 and var_102_11 or var_102_11 * (var_102_16 / var_102_15)

				if var_102_17 > 0 and var_102_11 < var_102_17 then
					arg_99_1.talkMaxDuration = var_102_17

					if var_102_17 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_17 + var_102_10
					end
				end

				arg_99_1.text_.text = var_102_14
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311024", "story_v_out_321311.awb") ~= 0 then
					local var_102_18 = manager.audio:GetVoiceLength("story_v_out_321311", "321311024", "story_v_out_321311.awb") / 1000

					if var_102_18 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_18 + var_102_10
					end

					if var_102_13.prefab_name ~= "" and arg_99_1.actors_[var_102_13.prefab_name] ~= nil then
						local var_102_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_13.prefab_name].transform, "story_v_out_321311", "321311024", "story_v_out_321311.awb")

						arg_99_1:RecordAudio("321311024", var_102_19)
						arg_99_1:RecordAudio("321311024", var_102_19)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_321311", "321311024", "story_v_out_321311.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_321311", "321311024", "story_v_out_321311.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_20 = math.max(var_102_11, arg_99_1.talkMaxDuration)

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_20 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_10) / var_102_20

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_10 + var_102_20 and arg_99_1.time_ < var_102_10 + var_102_20 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play321311025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 321311025
		arg_103_1.duration_ = 3.83

		local var_103_0 = {
			zh = 3.833,
			ja = 3.7
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play321311026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10104ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10104ui_story == nil then
				arg_103_1.var_.characterEffect10104ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect10104ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10104ui_story then
				arg_103_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_106_4 = arg_103_1.actors_["1211ui_story"]
			local var_106_5 = 0

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 and not isNil(var_106_4) and arg_103_1.var_.characterEffect1211ui_story == nil then
				arg_103_1.var_.characterEffect1211ui_story = var_106_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_6 = 0.200000002980232

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_6 and not isNil(var_106_4) then
				local var_106_7 = (arg_103_1.time_ - var_106_5) / var_106_6

				if arg_103_1.var_.characterEffect1211ui_story and not isNil(var_106_4) then
					local var_106_8 = Mathf.Lerp(0, 0.5, var_106_7)

					arg_103_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1211ui_story.fillRatio = var_106_8
				end
			end

			if arg_103_1.time_ >= var_106_5 + var_106_6 and arg_103_1.time_ < var_106_5 + var_106_6 + arg_106_0 and not isNil(var_106_4) and arg_103_1.var_.characterEffect1211ui_story then
				local var_106_9 = 0.5

				arg_103_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1211ui_story.fillRatio = var_106_9
			end

			local var_106_10 = 0
			local var_106_11 = 0.475

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_12 = arg_103_1:FormatText(StoryNameCfg[1030].name)

				arg_103_1.leftNameTxt_.text = var_106_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_13 = arg_103_1:GetWordFromCfg(321311025)
				local var_106_14 = arg_103_1:FormatText(var_106_13.content)

				arg_103_1.text_.text = var_106_14

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_15 = 19
				local var_106_16 = utf8.len(var_106_14)
				local var_106_17 = var_106_15 <= 0 and var_106_11 or var_106_11 * (var_106_16 / var_106_15)

				if var_106_17 > 0 and var_106_11 < var_106_17 then
					arg_103_1.talkMaxDuration = var_106_17

					if var_106_17 + var_106_10 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_17 + var_106_10
					end
				end

				arg_103_1.text_.text = var_106_14
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311025", "story_v_out_321311.awb") ~= 0 then
					local var_106_18 = manager.audio:GetVoiceLength("story_v_out_321311", "321311025", "story_v_out_321311.awb") / 1000

					if var_106_18 + var_106_10 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_18 + var_106_10
					end

					if var_106_13.prefab_name ~= "" and arg_103_1.actors_[var_106_13.prefab_name] ~= nil then
						local var_106_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_13.prefab_name].transform, "story_v_out_321311", "321311025", "story_v_out_321311.awb")

						arg_103_1:RecordAudio("321311025", var_106_19)
						arg_103_1:RecordAudio("321311025", var_106_19)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_321311", "321311025", "story_v_out_321311.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_321311", "321311025", "story_v_out_321311.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_20 = math.max(var_106_11, arg_103_1.talkMaxDuration)

			if var_106_10 <= arg_103_1.time_ and arg_103_1.time_ < var_106_10 + var_106_20 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_10) / var_106_20

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_10 + var_106_20 and arg_103_1.time_ < var_106_10 + var_106_20 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play321311026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 321311026
		arg_107_1.duration_ = 7.87

		local var_107_0 = {
			zh = 6.8,
			ja = 7.866
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play321311027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_110_2 = 0
			local var_110_3 = 0.8

			if var_110_2 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_4 = arg_107_1:FormatText(StoryNameCfg[1030].name)

				arg_107_1.leftNameTxt_.text = var_110_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_5 = arg_107_1:GetWordFromCfg(321311026)
				local var_110_6 = arg_107_1:FormatText(var_110_5.content)

				arg_107_1.text_.text = var_110_6

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_7 = 32
				local var_110_8 = utf8.len(var_110_6)
				local var_110_9 = var_110_7 <= 0 and var_110_3 or var_110_3 * (var_110_8 / var_110_7)

				if var_110_9 > 0 and var_110_3 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_2
					end
				end

				arg_107_1.text_.text = var_110_6
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311026", "story_v_out_321311.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_out_321311", "321311026", "story_v_out_321311.awb") / 1000

					if var_110_10 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_2
					end

					if var_110_5.prefab_name ~= "" and arg_107_1.actors_[var_110_5.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_5.prefab_name].transform, "story_v_out_321311", "321311026", "story_v_out_321311.awb")

						arg_107_1:RecordAudio("321311026", var_110_11)
						arg_107_1:RecordAudio("321311026", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_321311", "321311026", "story_v_out_321311.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_321311", "321311026", "story_v_out_321311.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_3, arg_107_1.talkMaxDuration)

			if var_110_2 <= arg_107_1.time_ and arg_107_1.time_ < var_110_2 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_2) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_2 + var_110_12 and arg_107_1.time_ < var_110_2 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play321311027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 321311027
		arg_111_1.duration_ = 10.97

		local var_111_0 = {
			zh = 7.2,
			ja = 10.966
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
				arg_111_0:Play321311028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.85

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[1030].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(321311027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 34
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311027", "story_v_out_321311.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_321311", "321311027", "story_v_out_321311.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_321311", "321311027", "story_v_out_321311.awb")

						arg_111_1:RecordAudio("321311027", var_114_9)
						arg_111_1:RecordAudio("321311027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_321311", "321311027", "story_v_out_321311.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_321311", "321311027", "story_v_out_321311.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play321311028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 321311028
		arg_115_1.duration_ = 5.53

		local var_115_0 = {
			zh = 3.666,
			ja = 5.533
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play321311029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1211ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1211ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(-0.7, -0.67, -6.07)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1211ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = arg_115_1.actors_["10104ui_story"].transform
			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 then
				arg_115_1.var_.moveOldPos10104ui_story = var_118_9.localPosition
			end

			local var_118_11 = 0.001

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_11 then
				local var_118_12 = (arg_115_1.time_ - var_118_10) / var_118_11
				local var_118_13 = Vector3.New(0.99, -1.12, -5.99)

				var_118_9.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10104ui_story, var_118_13, var_118_12)

				local var_118_14 = manager.ui.mainCamera.transform.position - var_118_9.position

				var_118_9.forward = Vector3.New(var_118_14.x, var_118_14.y, var_118_14.z)

				local var_118_15 = var_118_9.localEulerAngles

				var_118_15.z = 0
				var_118_15.x = 0
				var_118_9.localEulerAngles = var_118_15
			end

			if arg_115_1.time_ >= var_118_10 + var_118_11 and arg_115_1.time_ < var_118_10 + var_118_11 + arg_118_0 then
				var_118_9.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_118_16 = manager.ui.mainCamera.transform.position - var_118_9.position

				var_118_9.forward = Vector3.New(var_118_16.x, var_118_16.y, var_118_16.z)

				local var_118_17 = var_118_9.localEulerAngles

				var_118_17.z = 0
				var_118_17.x = 0
				var_118_9.localEulerAngles = var_118_17
			end

			local var_118_18 = arg_115_1.actors_["1211ui_story"]
			local var_118_19 = 0

			if var_118_19 < arg_115_1.time_ and arg_115_1.time_ <= var_118_19 + arg_118_0 and not isNil(var_118_18) and arg_115_1.var_.characterEffect1211ui_story == nil then
				arg_115_1.var_.characterEffect1211ui_story = var_118_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_20 = 0.200000002980232

			if var_118_19 <= arg_115_1.time_ and arg_115_1.time_ < var_118_19 + var_118_20 and not isNil(var_118_18) then
				local var_118_21 = (arg_115_1.time_ - var_118_19) / var_118_20

				if arg_115_1.var_.characterEffect1211ui_story and not isNil(var_118_18) then
					arg_115_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_19 + var_118_20 and arg_115_1.time_ < var_118_19 + var_118_20 + arg_118_0 and not isNil(var_118_18) and arg_115_1.var_.characterEffect1211ui_story then
				arg_115_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_118_22 = arg_115_1.actors_["10104ui_story"]
			local var_118_23 = 0

			if var_118_23 < arg_115_1.time_ and arg_115_1.time_ <= var_118_23 + arg_118_0 and not isNil(var_118_22) and arg_115_1.var_.characterEffect10104ui_story == nil then
				arg_115_1.var_.characterEffect10104ui_story = var_118_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_24 = 0.200000002980232

			if var_118_23 <= arg_115_1.time_ and arg_115_1.time_ < var_118_23 + var_118_24 and not isNil(var_118_22) then
				local var_118_25 = (arg_115_1.time_ - var_118_23) / var_118_24

				if arg_115_1.var_.characterEffect10104ui_story and not isNil(var_118_22) then
					local var_118_26 = Mathf.Lerp(0, 0.5, var_118_25)

					arg_115_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10104ui_story.fillRatio = var_118_26
				end
			end

			if arg_115_1.time_ >= var_118_23 + var_118_24 and arg_115_1.time_ < var_118_23 + var_118_24 + arg_118_0 and not isNil(var_118_22) and arg_115_1.var_.characterEffect10104ui_story then
				local var_118_27 = 0.5

				arg_115_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10104ui_story.fillRatio = var_118_27
			end

			local var_118_28 = 0

			if var_118_28 < arg_115_1.time_ and arg_115_1.time_ <= var_118_28 + arg_118_0 then
				arg_115_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_118_29 = 0

			if var_118_29 < arg_115_1.time_ and arg_115_1.time_ <= var_118_29 + arg_118_0 then
				arg_115_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_118_30 = 0
			local var_118_31 = 0.525

			if var_118_30 < arg_115_1.time_ and arg_115_1.time_ <= var_118_30 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_32 = arg_115_1:FormatText(StoryNameCfg[37].name)

				arg_115_1.leftNameTxt_.text = var_118_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_33 = arg_115_1:GetWordFromCfg(321311028)
				local var_118_34 = arg_115_1:FormatText(var_118_33.content)

				arg_115_1.text_.text = var_118_34

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_35 = 21
				local var_118_36 = utf8.len(var_118_34)
				local var_118_37 = var_118_35 <= 0 and var_118_31 or var_118_31 * (var_118_36 / var_118_35)

				if var_118_37 > 0 and var_118_31 < var_118_37 then
					arg_115_1.talkMaxDuration = var_118_37

					if var_118_37 + var_118_30 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_37 + var_118_30
					end
				end

				arg_115_1.text_.text = var_118_34
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311028", "story_v_out_321311.awb") ~= 0 then
					local var_118_38 = manager.audio:GetVoiceLength("story_v_out_321311", "321311028", "story_v_out_321311.awb") / 1000

					if var_118_38 + var_118_30 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_38 + var_118_30
					end

					if var_118_33.prefab_name ~= "" and arg_115_1.actors_[var_118_33.prefab_name] ~= nil then
						local var_118_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_33.prefab_name].transform, "story_v_out_321311", "321311028", "story_v_out_321311.awb")

						arg_115_1:RecordAudio("321311028", var_118_39)
						arg_115_1:RecordAudio("321311028", var_118_39)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_321311", "321311028", "story_v_out_321311.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_321311", "321311028", "story_v_out_321311.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_40 = math.max(var_118_31, arg_115_1.talkMaxDuration)

			if var_118_30 <= arg_115_1.time_ and arg_115_1.time_ < var_118_30 + var_118_40 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_30) / var_118_40

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_30 + var_118_40 and arg_115_1.time_ < var_118_30 + var_118_40 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321311029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 321311029
		arg_119_1.duration_ = 10.03

		local var_119_0 = {
			zh = 5.366,
			ja = 10.033
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play321311030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10104ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10104ui_story == nil then
				arg_119_1.var_.characterEffect10104ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect10104ui_story and not isNil(var_122_0) then
					arg_119_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10104ui_story then
				arg_119_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_122_4 = arg_119_1.actors_["1211ui_story"]
			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect1211ui_story == nil then
				arg_119_1.var_.characterEffect1211ui_story = var_122_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_6 = 0.200000002980232

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_6 and not isNil(var_122_4) then
				local var_122_7 = (arg_119_1.time_ - var_122_5) / var_122_6

				if arg_119_1.var_.characterEffect1211ui_story and not isNil(var_122_4) then
					local var_122_8 = Mathf.Lerp(0, 0.5, var_122_7)

					arg_119_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1211ui_story.fillRatio = var_122_8
				end
			end

			if arg_119_1.time_ >= var_122_5 + var_122_6 and arg_119_1.time_ < var_122_5 + var_122_6 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect1211ui_story then
				local var_122_9 = 0.5

				arg_119_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1211ui_story.fillRatio = var_122_9
			end

			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_2")
			end

			local var_122_11 = 0
			local var_122_12 = 0.625

			if var_122_11 < arg_119_1.time_ and arg_119_1.time_ <= var_122_11 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_13 = arg_119_1:FormatText(StoryNameCfg[1030].name)

				arg_119_1.leftNameTxt_.text = var_122_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_14 = arg_119_1:GetWordFromCfg(321311029)
				local var_122_15 = arg_119_1:FormatText(var_122_14.content)

				arg_119_1.text_.text = var_122_15

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_16 = 25
				local var_122_17 = utf8.len(var_122_15)
				local var_122_18 = var_122_16 <= 0 and var_122_12 or var_122_12 * (var_122_17 / var_122_16)

				if var_122_18 > 0 and var_122_12 < var_122_18 then
					arg_119_1.talkMaxDuration = var_122_18

					if var_122_18 + var_122_11 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_18 + var_122_11
					end
				end

				arg_119_1.text_.text = var_122_15
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311029", "story_v_out_321311.awb") ~= 0 then
					local var_122_19 = manager.audio:GetVoiceLength("story_v_out_321311", "321311029", "story_v_out_321311.awb") / 1000

					if var_122_19 + var_122_11 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_19 + var_122_11
					end

					if var_122_14.prefab_name ~= "" and arg_119_1.actors_[var_122_14.prefab_name] ~= nil then
						local var_122_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_14.prefab_name].transform, "story_v_out_321311", "321311029", "story_v_out_321311.awb")

						arg_119_1:RecordAudio("321311029", var_122_20)
						arg_119_1:RecordAudio("321311029", var_122_20)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_321311", "321311029", "story_v_out_321311.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_321311", "321311029", "story_v_out_321311.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_21 = math.max(var_122_12, arg_119_1.talkMaxDuration)

			if var_122_11 <= arg_119_1.time_ and arg_119_1.time_ < var_122_11 + var_122_21 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_11) / var_122_21

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_11 + var_122_21 and arg_119_1.time_ < var_122_11 + var_122_21 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play321311030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321311030
		arg_123_1.duration_ = 7.53

		local var_123_0 = {
			zh = 3.4,
			ja = 7.533
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
				arg_123_0:Play321311031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.475

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[1030].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:GetWordFromCfg(321311030)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 19
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311030", "story_v_out_321311.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_321311", "321311030", "story_v_out_321311.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_321311", "321311030", "story_v_out_321311.awb")

						arg_123_1:RecordAudio("321311030", var_126_9)
						arg_123_1:RecordAudio("321311030", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_321311", "321311030", "story_v_out_321311.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_321311", "321311030", "story_v_out_321311.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play321311031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 321311031
		arg_127_1.duration_ = 10.1

		local var_127_0 = {
			zh = 10.066,
			ja = 10.1
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play321311032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "ST0502"

			if arg_127_1.bgs_[var_130_0] == nil then
				local var_130_1 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_130_0)
				var_130_1.name = var_130_0
				var_130_1.transform.parent = arg_127_1.stage_.transform
				var_130_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_[var_130_0] = var_130_1
			end

			local var_130_2 = 2

			if var_130_2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				local var_130_3 = manager.ui.mainCamera.transform.localPosition
				local var_130_4 = Vector3.New(0, 0, 10) + Vector3.New(var_130_3.x, var_130_3.y, 0)
				local var_130_5 = arg_127_1.bgs_.ST0502

				var_130_5.transform.localPosition = var_130_4
				var_130_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_6 = var_130_5:GetComponent("SpriteRenderer")

				if var_130_6 and var_130_6.sprite then
					local var_130_7 = (var_130_5.transform.localPosition - var_130_3).z
					local var_130_8 = manager.ui.mainCameraCom_
					local var_130_9 = 2 * var_130_7 * Mathf.Tan(var_130_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_130_10 = var_130_9 * var_130_8.aspect
					local var_130_11 = var_130_6.sprite.bounds.size.x
					local var_130_12 = var_130_6.sprite.bounds.size.y
					local var_130_13 = var_130_10 / var_130_11
					local var_130_14 = var_130_9 / var_130_12
					local var_130_15 = var_130_14 < var_130_13 and var_130_13 or var_130_14

					var_130_5.transform.localScale = Vector3.New(var_130_15, var_130_15, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "ST0502" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_16 = 4

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			local var_130_17 = 0.3

			if arg_127_1.time_ >= var_130_16 + var_130_17 and arg_127_1.time_ < var_130_16 + var_130_17 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end

			local var_130_18 = 0

			if var_130_18 < arg_127_1.time_ and arg_127_1.time_ <= var_130_18 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_19 = 2

			if var_130_18 <= arg_127_1.time_ and arg_127_1.time_ < var_130_18 + var_130_19 then
				local var_130_20 = (arg_127_1.time_ - var_130_18) / var_130_19
				local var_130_21 = Color.New(0, 0, 0)

				var_130_21.a = Mathf.Lerp(0, 1, var_130_20)
				arg_127_1.mask_.color = var_130_21
			end

			if arg_127_1.time_ >= var_130_18 + var_130_19 and arg_127_1.time_ < var_130_18 + var_130_19 + arg_130_0 then
				local var_130_22 = Color.New(0, 0, 0)

				var_130_22.a = 1
				arg_127_1.mask_.color = var_130_22
			end

			local var_130_23 = 2

			if var_130_23 < arg_127_1.time_ and arg_127_1.time_ <= var_130_23 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_24 = 2

			if var_130_23 <= arg_127_1.time_ and arg_127_1.time_ < var_130_23 + var_130_24 then
				local var_130_25 = (arg_127_1.time_ - var_130_23) / var_130_24
				local var_130_26 = Color.New(0, 0, 0)

				var_130_26.a = Mathf.Lerp(1, 0, var_130_25)
				arg_127_1.mask_.color = var_130_26
			end

			if arg_127_1.time_ >= var_130_23 + var_130_24 and arg_127_1.time_ < var_130_23 + var_130_24 + arg_130_0 then
				local var_130_27 = Color.New(0, 0, 0)
				local var_130_28 = 0

				arg_127_1.mask_.enabled = false
				var_130_27.a = var_130_28
				arg_127_1.mask_.color = var_130_27
			end

			local var_130_29 = arg_127_1.actors_["1211ui_story"].transform
			local var_130_30 = 1.96599999815226

			if var_130_30 < arg_127_1.time_ and arg_127_1.time_ <= var_130_30 + arg_130_0 then
				arg_127_1.var_.moveOldPos1211ui_story = var_130_29.localPosition
			end

			local var_130_31 = 0.001

			if var_130_30 <= arg_127_1.time_ and arg_127_1.time_ < var_130_30 + var_130_31 then
				local var_130_32 = (arg_127_1.time_ - var_130_30) / var_130_31
				local var_130_33 = Vector3.New(0, 100, 0)

				var_130_29.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1211ui_story, var_130_33, var_130_32)

				local var_130_34 = manager.ui.mainCamera.transform.position - var_130_29.position

				var_130_29.forward = Vector3.New(var_130_34.x, var_130_34.y, var_130_34.z)

				local var_130_35 = var_130_29.localEulerAngles

				var_130_35.z = 0
				var_130_35.x = 0
				var_130_29.localEulerAngles = var_130_35
			end

			if arg_127_1.time_ >= var_130_30 + var_130_31 and arg_127_1.time_ < var_130_30 + var_130_31 + arg_130_0 then
				var_130_29.localPosition = Vector3.New(0, 100, 0)

				local var_130_36 = manager.ui.mainCamera.transform.position - var_130_29.position

				var_130_29.forward = Vector3.New(var_130_36.x, var_130_36.y, var_130_36.z)

				local var_130_37 = var_130_29.localEulerAngles

				var_130_37.z = 0
				var_130_37.x = 0
				var_130_29.localEulerAngles = var_130_37
			end

			local var_130_38 = arg_127_1.actors_["10104ui_story"].transform
			local var_130_39 = 1.96599999815226

			if var_130_39 < arg_127_1.time_ and arg_127_1.time_ <= var_130_39 + arg_130_0 then
				arg_127_1.var_.moveOldPos10104ui_story = var_130_38.localPosition
			end

			local var_130_40 = 0.001

			if var_130_39 <= arg_127_1.time_ and arg_127_1.time_ < var_130_39 + var_130_40 then
				local var_130_41 = (arg_127_1.time_ - var_130_39) / var_130_40
				local var_130_42 = Vector3.New(0, 100, 0)

				var_130_38.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10104ui_story, var_130_42, var_130_41)

				local var_130_43 = manager.ui.mainCamera.transform.position - var_130_38.position

				var_130_38.forward = Vector3.New(var_130_43.x, var_130_43.y, var_130_43.z)

				local var_130_44 = var_130_38.localEulerAngles

				var_130_44.z = 0
				var_130_44.x = 0
				var_130_38.localEulerAngles = var_130_44
			end

			if arg_127_1.time_ >= var_130_39 + var_130_40 and arg_127_1.time_ < var_130_39 + var_130_40 + arg_130_0 then
				var_130_38.localPosition = Vector3.New(0, 100, 0)

				local var_130_45 = manager.ui.mainCamera.transform.position - var_130_38.position

				var_130_38.forward = Vector3.New(var_130_45.x, var_130_45.y, var_130_45.z)

				local var_130_46 = var_130_38.localEulerAngles

				var_130_46.z = 0
				var_130_46.x = 0
				var_130_38.localEulerAngles = var_130_46
			end

			local var_130_47 = arg_127_1.actors_["10104ui_story"]
			local var_130_48 = 1.96599999815226

			if var_130_48 < arg_127_1.time_ and arg_127_1.time_ <= var_130_48 + arg_130_0 and not isNil(var_130_47) and arg_127_1.var_.characterEffect10104ui_story == nil then
				arg_127_1.var_.characterEffect10104ui_story = var_130_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_49 = 0.034000001847744

			if var_130_48 <= arg_127_1.time_ and arg_127_1.time_ < var_130_48 + var_130_49 and not isNil(var_130_47) then
				local var_130_50 = (arg_127_1.time_ - var_130_48) / var_130_49

				if arg_127_1.var_.characterEffect10104ui_story and not isNil(var_130_47) then
					local var_130_51 = Mathf.Lerp(0, 0.5, var_130_50)

					arg_127_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10104ui_story.fillRatio = var_130_51
				end
			end

			if arg_127_1.time_ >= var_130_48 + var_130_49 and arg_127_1.time_ < var_130_48 + var_130_49 + arg_130_0 and not isNil(var_130_47) and arg_127_1.var_.characterEffect10104ui_story then
				local var_130_52 = 0.5

				arg_127_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10104ui_story.fillRatio = var_130_52
			end

			local var_130_53 = 0
			local var_130_54 = 0.2

			if var_130_53 < arg_127_1.time_ and arg_127_1.time_ <= var_130_53 + arg_130_0 then
				local var_130_55 = "play"
				local var_130_56 = "music"

				arg_127_1:AudioAction(var_130_55, var_130_56, "ui_battle", "ui_battle_stopbgm", "")

				local var_130_57 = ""
				local var_130_58 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_130_58 ~= "" then
					if arg_127_1.bgmTxt_.text ~= var_130_58 and arg_127_1.bgmTxt_.text ~= "" then
						if arg_127_1.bgmTxt2_.text ~= "" then
							arg_127_1.bgmTxt_.text = arg_127_1.bgmTxt2_.text
						end

						arg_127_1.bgmTxt2_.text = var_130_58

						arg_127_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_127_1.bgmTxt_.text = var_130_58
						arg_127_1.bgmTxt2_.text = var_130_58
					end

					if arg_127_1.bgmTimer then
						arg_127_1.bgmTimer:Stop()

						arg_127_1.bgmTimer = nil
					end

					if arg_127_1.settingData.show_music_name == 1 then
						arg_127_1.musicController:SetSelectedState("show")
						arg_127_1.musicAnimator_:Play("open", 0, 0)

						if arg_127_1.settingData.music_time ~= 0 then
							arg_127_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_127_1.settingData.music_time), function()
								if arg_127_1 == nil or isNil(arg_127_1.bgmTxt_) then
									return
								end

								arg_127_1.musicController:SetSelectedState("hide")
								arg_127_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_130_59 = 1.53333333333333
			local var_130_60 = 1

			if var_130_59 < arg_127_1.time_ and arg_127_1.time_ <= var_130_59 + arg_130_0 then
				local var_130_61 = "play"
				local var_130_62 = "music"

				arg_127_1:AudioAction(var_130_61, var_130_62, "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled.awb")

				local var_130_63 = ""
				local var_130_64 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

				if var_130_64 ~= "" then
					if arg_127_1.bgmTxt_.text ~= var_130_64 and arg_127_1.bgmTxt_.text ~= "" then
						if arg_127_1.bgmTxt2_.text ~= "" then
							arg_127_1.bgmTxt_.text = arg_127_1.bgmTxt2_.text
						end

						arg_127_1.bgmTxt2_.text = var_130_64

						arg_127_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_127_1.bgmTxt_.text = var_130_64
						arg_127_1.bgmTxt2_.text = var_130_64
					end

					if arg_127_1.bgmTimer then
						arg_127_1.bgmTimer:Stop()

						arg_127_1.bgmTimer = nil
					end

					if arg_127_1.settingData.show_music_name == 1 then
						arg_127_1.musicController:SetSelectedState("show")
						arg_127_1.musicAnimator_:Play("open", 0, 0)

						if arg_127_1.settingData.music_time ~= 0 then
							arg_127_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_127_1.settingData.music_time), function()
								if arg_127_1 == nil or isNil(arg_127_1.bgmTxt_) then
									return
								end

								arg_127_1.musicController:SetSelectedState("hide")
								arg_127_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_65 = 4
			local var_130_66 = 0.55

			if var_130_65 < arg_127_1.time_ and arg_127_1.time_ <= var_130_65 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_67 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_67:setOnUpdate(LuaHelper.FloatAction(function(arg_133_0)
					arg_127_1.dialogCg_.alpha = arg_133_0
				end))
				var_130_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_68 = arg_127_1:FormatText(StoryNameCfg[1041].name)

				arg_127_1.leftNameTxt_.text = var_130_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_69 = arg_127_1:GetWordFromCfg(321311031)
				local var_130_70 = arg_127_1:FormatText(var_130_69.content)

				arg_127_1.text_.text = var_130_70

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_71 = 22
				local var_130_72 = utf8.len(var_130_70)
				local var_130_73 = var_130_71 <= 0 and var_130_66 or var_130_66 * (var_130_72 / var_130_71)

				if var_130_73 > 0 and var_130_66 < var_130_73 then
					arg_127_1.talkMaxDuration = var_130_73
					var_130_65 = var_130_65 + 0.3

					if var_130_73 + var_130_65 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_73 + var_130_65
					end
				end

				arg_127_1.text_.text = var_130_70
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311031", "story_v_out_321311.awb") ~= 0 then
					local var_130_74 = manager.audio:GetVoiceLength("story_v_out_321311", "321311031", "story_v_out_321311.awb") / 1000

					if var_130_74 + var_130_65 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_74 + var_130_65
					end

					if var_130_69.prefab_name ~= "" and arg_127_1.actors_[var_130_69.prefab_name] ~= nil then
						local var_130_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_69.prefab_name].transform, "story_v_out_321311", "321311031", "story_v_out_321311.awb")

						arg_127_1:RecordAudio("321311031", var_130_75)
						arg_127_1:RecordAudio("321311031", var_130_75)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_321311", "321311031", "story_v_out_321311.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_321311", "321311031", "story_v_out_321311.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_76 = var_130_65 + 0.3
			local var_130_77 = math.max(var_130_66, arg_127_1.talkMaxDuration)

			if var_130_76 <= arg_127_1.time_ and arg_127_1.time_ < var_130_76 + var_130_77 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_76) / var_130_77

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_76 + var_130_77 and arg_127_1.time_ < var_130_76 + var_130_77 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play321311032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 321311032
		arg_135_1.duration_ = 12.5

		local var_135_0 = {
			zh = 6.5,
			ja = 12.5
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play321311033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = "10053ui_story"

			if arg_135_1.actors_[var_138_0] == nil then
				local var_138_1 = Asset.Load("Char/" .. "10053ui_story")

				if not isNil(var_138_1) then
					local var_138_2 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_135_1.stage_.transform)

					var_138_2.name = var_138_0
					var_138_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_135_1.actors_[var_138_0] = var_138_2

					local var_138_3 = var_138_2:GetComponentInChildren(typeof(CharacterEffect))

					var_138_3.enabled = true

					local var_138_4 = GameObjectTools.GetOrAddComponent(var_138_2, typeof(DynamicBoneHelper))

					if var_138_4 then
						var_138_4:EnableDynamicBone(false)
					end

					arg_135_1:ShowWeapon(var_138_3.transform, false)

					arg_135_1.var_[var_138_0 .. "Animator"] = var_138_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_135_1.var_[var_138_0 .. "Animator"].applyRootMotion = true
					arg_135_1.var_[var_138_0 .. "LipSync"] = var_138_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_138_5 = arg_135_1.actors_["10053ui_story"]
			local var_138_6 = 0

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.characterEffect10053ui_story == nil then
				arg_135_1.var_.characterEffect10053ui_story = var_138_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_7 = 0.200000002980232

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_7 and not isNil(var_138_5) then
				local var_138_8 = (arg_135_1.time_ - var_138_6) / var_138_7

				if arg_135_1.var_.characterEffect10053ui_story and not isNil(var_138_5) then
					arg_135_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_6 + var_138_7 and arg_135_1.time_ < var_138_6 + var_138_7 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.characterEffect10053ui_story then
				arg_135_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_138_9 = 0
			local var_138_10 = 0.525

			if var_138_9 < arg_135_1.time_ and arg_135_1.time_ <= var_138_9 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_11 = arg_135_1:FormatText(StoryNameCfg[36].name)

				arg_135_1.leftNameTxt_.text = var_138_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_12 = arg_135_1:GetWordFromCfg(321311032)
				local var_138_13 = arg_135_1:FormatText(var_138_12.content)

				arg_135_1.text_.text = var_138_13

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_14 = 21
				local var_138_15 = utf8.len(var_138_13)
				local var_138_16 = var_138_14 <= 0 and var_138_10 or var_138_10 * (var_138_15 / var_138_14)

				if var_138_16 > 0 and var_138_10 < var_138_16 then
					arg_135_1.talkMaxDuration = var_138_16

					if var_138_16 + var_138_9 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_9
					end
				end

				arg_135_1.text_.text = var_138_13
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311032", "story_v_out_321311.awb") ~= 0 then
					local var_138_17 = manager.audio:GetVoiceLength("story_v_out_321311", "321311032", "story_v_out_321311.awb") / 1000

					if var_138_17 + var_138_9 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_17 + var_138_9
					end

					if var_138_12.prefab_name ~= "" and arg_135_1.actors_[var_138_12.prefab_name] ~= nil then
						local var_138_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_12.prefab_name].transform, "story_v_out_321311", "321311032", "story_v_out_321311.awb")

						arg_135_1:RecordAudio("321311032", var_138_18)
						arg_135_1:RecordAudio("321311032", var_138_18)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_321311", "321311032", "story_v_out_321311.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_321311", "321311032", "story_v_out_321311.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_19 = math.max(var_138_10, arg_135_1.talkMaxDuration)

			if var_138_9 <= arg_135_1.time_ and arg_135_1.time_ < var_138_9 + var_138_19 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_9) / var_138_19

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_9 + var_138_19 and arg_135_1.time_ < var_138_9 + var_138_19 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play321311033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 321311033
		arg_139_1.duration_ = 15.8

		local var_139_0 = {
			zh = 8.833,
			ja = 15.8
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
				arg_139_0:Play321311034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10053ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10053ui_story == nil then
				arg_139_1.var_.characterEffect10053ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect10053ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10053ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10053ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10053ui_story.fillRatio = var_142_5
			end

			local var_142_6 = 0
			local var_142_7 = 1

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_8 = arg_139_1:FormatText(StoryNameCfg[1041].name)

				arg_139_1.leftNameTxt_.text = var_142_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_9 = arg_139_1:GetWordFromCfg(321311033)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 40
				local var_142_12 = utf8.len(var_142_10)
				local var_142_13 = var_142_11 <= 0 and var_142_7 or var_142_7 * (var_142_12 / var_142_11)

				if var_142_13 > 0 and var_142_7 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_10
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311033", "story_v_out_321311.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_321311", "321311033", "story_v_out_321311.awb") / 1000

					if var_142_14 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_6
					end

					if var_142_9.prefab_name ~= "" and arg_139_1.actors_[var_142_9.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_9.prefab_name].transform, "story_v_out_321311", "321311033", "story_v_out_321311.awb")

						arg_139_1:RecordAudio("321311033", var_142_15)
						arg_139_1:RecordAudio("321311033", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_321311", "321311033", "story_v_out_321311.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_321311", "321311033", "story_v_out_321311.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_16 and arg_139_1.time_ < var_142_6 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play321311034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321311034
		arg_143_1.duration_ = 6.17

		local var_143_0 = {
			zh = 3.366,
			ja = 6.166
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play321311035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10053ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect10053ui_story == nil then
				arg_143_1.var_.characterEffect10053ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect10053ui_story and not isNil(var_146_0) then
					arg_143_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect10053ui_story then
				arg_143_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_146_4 = 0
			local var_146_5 = 0.325

			if var_146_4 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_6 = arg_143_1:FormatText(StoryNameCfg[36].name)

				arg_143_1.leftNameTxt_.text = var_146_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_7 = arg_143_1:GetWordFromCfg(321311034)
				local var_146_8 = arg_143_1:FormatText(var_146_7.content)

				arg_143_1.text_.text = var_146_8

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 13
				local var_146_10 = utf8.len(var_146_8)
				local var_146_11 = var_146_9 <= 0 and var_146_5 or var_146_5 * (var_146_10 / var_146_9)

				if var_146_11 > 0 and var_146_5 < var_146_11 then
					arg_143_1.talkMaxDuration = var_146_11

					if var_146_11 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_8
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311034", "story_v_out_321311.awb") ~= 0 then
					local var_146_12 = manager.audio:GetVoiceLength("story_v_out_321311", "321311034", "story_v_out_321311.awb") / 1000

					if var_146_12 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_4
					end

					if var_146_7.prefab_name ~= "" and arg_143_1.actors_[var_146_7.prefab_name] ~= nil then
						local var_146_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_7.prefab_name].transform, "story_v_out_321311", "321311034", "story_v_out_321311.awb")

						arg_143_1:RecordAudio("321311034", var_146_13)
						arg_143_1:RecordAudio("321311034", var_146_13)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_321311", "321311034", "story_v_out_321311.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_321311", "321311034", "story_v_out_321311.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_14 and arg_143_1.time_ < var_146_4 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play321311035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321311035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play321311036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10053ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10053ui_story == nil then
				arg_147_1.var_.characterEffect10053ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect10053ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10053ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10053ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10053ui_story.fillRatio = var_150_5
			end

			local var_150_6 = 0
			local var_150_7 = 1.375

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_8 = arg_147_1:GetWordFromCfg(321311035)
				local var_150_9 = arg_147_1:FormatText(var_150_8.content)

				arg_147_1.text_.text = var_150_9

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 55
				local var_150_11 = utf8.len(var_150_9)
				local var_150_12 = var_150_10 <= 0 and var_150_7 or var_150_7 * (var_150_11 / var_150_10)

				if var_150_12 > 0 and var_150_7 < var_150_12 then
					arg_147_1.talkMaxDuration = var_150_12

					if var_150_12 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_9
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_13 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_13 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_13

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_13 and arg_147_1.time_ < var_150_6 + var_150_13 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play321311036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321311036
		arg_151_1.duration_ = 8.07

		local var_151_0 = {
			zh = 6.033,
			ja = 8.066
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play321311037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.35

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[1041].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:GetWordFromCfg(321311036)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 14
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311036", "story_v_out_321311.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_321311", "321311036", "story_v_out_321311.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_321311", "321311036", "story_v_out_321311.awb")

						arg_151_1:RecordAudio("321311036", var_154_9)
						arg_151_1:RecordAudio("321311036", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_321311", "321311036", "story_v_out_321311.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_321311", "321311036", "story_v_out_321311.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_10 and arg_151_1.time_ < var_154_0 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play321311037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 321311037
		arg_155_1.duration_ = 9.27

		local var_155_0 = {
			zh = 6.8,
			ja = 9.266
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play321311038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.575

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[1041].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(321311037)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 23
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311037", "story_v_out_321311.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_321311", "321311037", "story_v_out_321311.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_321311", "321311037", "story_v_out_321311.awb")

						arg_155_1:RecordAudio("321311037", var_158_9)
						arg_155_1:RecordAudio("321311037", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_321311", "321311037", "story_v_out_321311.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_321311", "321311037", "story_v_out_321311.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play321311038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 321311038
		arg_159_1.duration_ = 11.8

		local var_159_0 = {
			zh = 9.6,
			ja = 11.8
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play321311039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.9

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[1041].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:GetWordFromCfg(321311038)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 36
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311038", "story_v_out_321311.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_321311", "321311038", "story_v_out_321311.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_321311", "321311038", "story_v_out_321311.awb")

						arg_159_1:RecordAudio("321311038", var_162_9)
						arg_159_1:RecordAudio("321311038", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_321311", "321311038", "story_v_out_321311.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_321311", "321311038", "story_v_out_321311.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_10 and arg_159_1.time_ < var_162_0 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play321311039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 321311039
		arg_163_1.duration_ = 9.27

		local var_163_0 = {
			zh = 9.266,
			ja = 8.533
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play321311040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.8

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[1041].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:GetWordFromCfg(321311039)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 32
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311039", "story_v_out_321311.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_321311", "321311039", "story_v_out_321311.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_321311", "321311039", "story_v_out_321311.awb")

						arg_163_1:RecordAudio("321311039", var_166_9)
						arg_163_1:RecordAudio("321311039", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_321311", "321311039", "story_v_out_321311.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_321311", "321311039", "story_v_out_321311.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_10 and arg_163_1.time_ < var_166_0 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play321311040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 321311040
		arg_167_1.duration_ = 16.37

		local var_167_0 = {
			zh = 16.366,
			ja = 15.233
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play321311041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 1.225

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[1041].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(321311040)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 49
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311040", "story_v_out_321311.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_321311", "321311040", "story_v_out_321311.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_321311", "321311040", "story_v_out_321311.awb")

						arg_167_1:RecordAudio("321311040", var_170_9)
						arg_167_1:RecordAudio("321311040", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_321311", "321311040", "story_v_out_321311.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_321311", "321311040", "story_v_out_321311.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play321311041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 321311041
		arg_171_1.duration_ = 8.97

		local var_171_0 = {
			zh = 4.366,
			ja = 8.966
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play321311042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10053ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect10053ui_story == nil then
				arg_171_1.var_.characterEffect10053ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect10053ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect10053ui_story then
				arg_171_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_174_4 = 0
			local var_174_5 = 0.475

			if var_174_4 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_6 = arg_171_1:FormatText(StoryNameCfg[36].name)

				arg_171_1.leftNameTxt_.text = var_174_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_7 = arg_171_1:GetWordFromCfg(321311041)
				local var_174_8 = arg_171_1:FormatText(var_174_7.content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 19
				local var_174_10 = utf8.len(var_174_8)
				local var_174_11 = var_174_9 <= 0 and var_174_5 or var_174_5 * (var_174_10 / var_174_9)

				if var_174_11 > 0 and var_174_5 < var_174_11 then
					arg_171_1.talkMaxDuration = var_174_11

					if var_174_11 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311041", "story_v_out_321311.awb") ~= 0 then
					local var_174_12 = manager.audio:GetVoiceLength("story_v_out_321311", "321311041", "story_v_out_321311.awb") / 1000

					if var_174_12 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_12 + var_174_4
					end

					if var_174_7.prefab_name ~= "" and arg_171_1.actors_[var_174_7.prefab_name] ~= nil then
						local var_174_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_7.prefab_name].transform, "story_v_out_321311", "321311041", "story_v_out_321311.awb")

						arg_171_1:RecordAudio("321311041", var_174_13)
						arg_171_1:RecordAudio("321311041", var_174_13)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_321311", "321311041", "story_v_out_321311.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_321311", "321311041", "story_v_out_321311.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_14 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_14 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_14

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_14 and arg_171_1.time_ < var_174_4 + var_174_14 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play321311042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 321311042
		arg_175_1.duration_ = 8.8

		local var_175_0 = {
			zh = 4.3,
			ja = 8.8
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play321311043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.45

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[36].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(321311042)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 18
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311042", "story_v_out_321311.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_321311", "321311042", "story_v_out_321311.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_321311", "321311042", "story_v_out_321311.awb")

						arg_175_1:RecordAudio("321311042", var_178_9)
						arg_175_1:RecordAudio("321311042", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_321311", "321311042", "story_v_out_321311.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_321311", "321311042", "story_v_out_321311.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_10 and arg_175_1.time_ < var_178_0 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play321311043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 321311043
		arg_179_1.duration_ = 9.1

		local var_179_0 = {
			zh = 7.3,
			ja = 9.1
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play321311044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10053ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect10053ui_story == nil then
				arg_179_1.var_.characterEffect10053ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect10053ui_story and not isNil(var_182_0) then
					local var_182_4 = Mathf.Lerp(0, 0.5, var_182_3)

					arg_179_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10053ui_story.fillRatio = var_182_4
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect10053ui_story then
				local var_182_5 = 0.5

				arg_179_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10053ui_story.fillRatio = var_182_5
			end

			local var_182_6 = 0
			local var_182_7 = 0.7

			if var_182_6 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_8 = arg_179_1:FormatText(StoryNameCfg[1041].name)

				arg_179_1.leftNameTxt_.text = var_182_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_9 = arg_179_1:GetWordFromCfg(321311043)
				local var_182_10 = arg_179_1:FormatText(var_182_9.content)

				arg_179_1.text_.text = var_182_10

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 28
				local var_182_12 = utf8.len(var_182_10)
				local var_182_13 = var_182_11 <= 0 and var_182_7 or var_182_7 * (var_182_12 / var_182_11)

				if var_182_13 > 0 and var_182_7 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_10
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311043", "story_v_out_321311.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_321311", "321311043", "story_v_out_321311.awb") / 1000

					if var_182_14 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_6
					end

					if var_182_9.prefab_name ~= "" and arg_179_1.actors_[var_182_9.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_9.prefab_name].transform, "story_v_out_321311", "321311043", "story_v_out_321311.awb")

						arg_179_1:RecordAudio("321311043", var_182_15)
						arg_179_1:RecordAudio("321311043", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_321311", "321311043", "story_v_out_321311.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_321311", "321311043", "story_v_out_321311.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_16 and arg_179_1.time_ < var_182_6 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play321311044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 321311044
		arg_183_1.duration_ = 7.37

		local var_183_0 = {
			zh = 5.033,
			ja = 7.366
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play321311045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.4

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[1041].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(321311044)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 16
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311044", "story_v_out_321311.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_321311", "321311044", "story_v_out_321311.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_321311", "321311044", "story_v_out_321311.awb")

						arg_183_1:RecordAudio("321311044", var_186_9)
						arg_183_1:RecordAudio("321311044", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_321311", "321311044", "story_v_out_321311.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_321311", "321311044", "story_v_out_321311.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play321311045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 321311045
		arg_187_1.duration_ = 5.5

		local var_187_0 = {
			zh = 4.6,
			ja = 5.5
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play321311046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10053ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect10053ui_story == nil then
				arg_187_1.var_.characterEffect10053ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect10053ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect10053ui_story then
				arg_187_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_190_4 = 0
			local var_190_5 = 0.475

			if var_190_4 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_6 = arg_187_1:FormatText(StoryNameCfg[36].name)

				arg_187_1.leftNameTxt_.text = var_190_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_7 = arg_187_1:GetWordFromCfg(321311045)
				local var_190_8 = arg_187_1:FormatText(var_190_7.content)

				arg_187_1.text_.text = var_190_8

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 19
				local var_190_10 = utf8.len(var_190_8)
				local var_190_11 = var_190_9 <= 0 and var_190_5 or var_190_5 * (var_190_10 / var_190_9)

				if var_190_11 > 0 and var_190_5 < var_190_11 then
					arg_187_1.talkMaxDuration = var_190_11

					if var_190_11 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_11 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_8
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311045", "story_v_out_321311.awb") ~= 0 then
					local var_190_12 = manager.audio:GetVoiceLength("story_v_out_321311", "321311045", "story_v_out_321311.awb") / 1000

					if var_190_12 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_12 + var_190_4
					end

					if var_190_7.prefab_name ~= "" and arg_187_1.actors_[var_190_7.prefab_name] ~= nil then
						local var_190_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_7.prefab_name].transform, "story_v_out_321311", "321311045", "story_v_out_321311.awb")

						arg_187_1:RecordAudio("321311045", var_190_13)
						arg_187_1:RecordAudio("321311045", var_190_13)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_321311", "321311045", "story_v_out_321311.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_321311", "321311045", "story_v_out_321311.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_14 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_14 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_14

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_14 and arg_187_1.time_ < var_190_4 + var_190_14 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play321311046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 321311046
		arg_191_1.duration_ = 10.8

		local var_191_0 = {
			zh = 7.466,
			ja = 10.8
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play321311047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10053ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect10053ui_story == nil then
				arg_191_1.var_.characterEffect10053ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect10053ui_story and not isNil(var_194_0) then
					local var_194_4 = Mathf.Lerp(0, 0.5, var_194_3)

					arg_191_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10053ui_story.fillRatio = var_194_4
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect10053ui_story then
				local var_194_5 = 0.5

				arg_191_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10053ui_story.fillRatio = var_194_5
			end

			local var_194_6 = 0
			local var_194_7 = 0.75

			if var_194_6 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_8 = arg_191_1:FormatText(StoryNameCfg[1041].name)

				arg_191_1.leftNameTxt_.text = var_194_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_9 = arg_191_1:GetWordFromCfg(321311046)
				local var_194_10 = arg_191_1:FormatText(var_194_9.content)

				arg_191_1.text_.text = var_194_10

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 30
				local var_194_12 = utf8.len(var_194_10)
				local var_194_13 = var_194_11 <= 0 and var_194_7 or var_194_7 * (var_194_12 / var_194_11)

				if var_194_13 > 0 and var_194_7 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_10
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311046", "story_v_out_321311.awb") ~= 0 then
					local var_194_14 = manager.audio:GetVoiceLength("story_v_out_321311", "321311046", "story_v_out_321311.awb") / 1000

					if var_194_14 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_6
					end

					if var_194_9.prefab_name ~= "" and arg_191_1.actors_[var_194_9.prefab_name] ~= nil then
						local var_194_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_9.prefab_name].transform, "story_v_out_321311", "321311046", "story_v_out_321311.awb")

						arg_191_1:RecordAudio("321311046", var_194_15)
						arg_191_1:RecordAudio("321311046", var_194_15)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_321311", "321311046", "story_v_out_321311.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_321311", "321311046", "story_v_out_321311.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_16 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_16 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_16

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_16 and arg_191_1.time_ < var_194_6 + var_194_16 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play321311047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 321311047
		arg_195_1.duration_ = 20

		local var_195_0 = {
			zh = 10.333,
			ja = 20
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
				arg_195_0:Play321311048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10053ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect10053ui_story == nil then
				arg_195_1.var_.characterEffect10053ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect10053ui_story and not isNil(var_198_0) then
					arg_195_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect10053ui_story then
				arg_195_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_198_4 = 0
			local var_198_5 = 0.95

			if var_198_4 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_6 = arg_195_1:FormatText(StoryNameCfg[36].name)

				arg_195_1.leftNameTxt_.text = var_198_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_7 = arg_195_1:GetWordFromCfg(321311047)
				local var_198_8 = arg_195_1:FormatText(var_198_7.content)

				arg_195_1.text_.text = var_198_8

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 38
				local var_198_10 = utf8.len(var_198_8)
				local var_198_11 = var_198_9 <= 0 and var_198_5 or var_198_5 * (var_198_10 / var_198_9)

				if var_198_11 > 0 and var_198_5 < var_198_11 then
					arg_195_1.talkMaxDuration = var_198_11

					if var_198_11 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_11 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_8
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311047", "story_v_out_321311.awb") ~= 0 then
					local var_198_12 = manager.audio:GetVoiceLength("story_v_out_321311", "321311047", "story_v_out_321311.awb") / 1000

					if var_198_12 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_4
					end

					if var_198_7.prefab_name ~= "" and arg_195_1.actors_[var_198_7.prefab_name] ~= nil then
						local var_198_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_7.prefab_name].transform, "story_v_out_321311", "321311047", "story_v_out_321311.awb")

						arg_195_1:RecordAudio("321311047", var_198_13)
						arg_195_1:RecordAudio("321311047", var_198_13)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_321311", "321311047", "story_v_out_321311.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_321311", "321311047", "story_v_out_321311.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_14 and arg_195_1.time_ < var_198_4 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play321311048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 321311048
		arg_199_1.duration_ = 5.9

		local var_199_0 = {
			zh = 3.533,
			ja = 5.9
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
				arg_199_0:Play321311049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10053ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect10053ui_story == nil then
				arg_199_1.var_.characterEffect10053ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect10053ui_story and not isNil(var_202_0) then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_199_1.var_.characterEffect10053ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect10053ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_199_1.var_.characterEffect10053ui_story.fillRatio = var_202_5
			end

			local var_202_6 = 0
			local var_202_7 = 0.425

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_8 = arg_199_1:FormatText(StoryNameCfg[1041].name)

				arg_199_1.leftNameTxt_.text = var_202_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_9 = arg_199_1:GetWordFromCfg(321311048)
				local var_202_10 = arg_199_1:FormatText(var_202_9.content)

				arg_199_1.text_.text = var_202_10

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 17
				local var_202_12 = utf8.len(var_202_10)
				local var_202_13 = var_202_11 <= 0 and var_202_7 or var_202_7 * (var_202_12 / var_202_11)

				if var_202_13 > 0 and var_202_7 < var_202_13 then
					arg_199_1.talkMaxDuration = var_202_13

					if var_202_13 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_10
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311048", "story_v_out_321311.awb") ~= 0 then
					local var_202_14 = manager.audio:GetVoiceLength("story_v_out_321311", "321311048", "story_v_out_321311.awb") / 1000

					if var_202_14 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_14 + var_202_6
					end

					if var_202_9.prefab_name ~= "" and arg_199_1.actors_[var_202_9.prefab_name] ~= nil then
						local var_202_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_9.prefab_name].transform, "story_v_out_321311", "321311048", "story_v_out_321311.awb")

						arg_199_1:RecordAudio("321311048", var_202_15)
						arg_199_1:RecordAudio("321311048", var_202_15)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_321311", "321311048", "story_v_out_321311.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_321311", "321311048", "story_v_out_321311.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_16 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_16

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_16 and arg_199_1.time_ < var_202_6 + var_202_16 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play321311049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 321311049
		arg_203_1.duration_ = 11.2

		local var_203_0 = {
			zh = 6.5,
			ja = 11.2
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
			arg_203_1.auto_ = false
		end

		function arg_203_1.playNext_(arg_205_0)
			arg_203_1.onStoryFinished_()
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.675

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[1041].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:GetWordFromCfg(321311049)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_321311", "321311049", "story_v_out_321311.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_321311", "321311049", "story_v_out_321311.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_321311", "321311049", "story_v_out_321311.awb")

						arg_203_1:RecordAudio("321311049", var_206_9)
						arg_203_1:RecordAudio("321311049", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_321311", "321311049", "story_v_out_321311.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_321311", "321311049", "story_v_out_321311.awb")
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
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L10g",
		"TextureConfig/Background/ST0502"
	},
	voices = {
		"story_v_out_321311.awb"
	}
}
